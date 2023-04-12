//
//  WaterView.swift
//  75Hard
//
//  Created by Christine Luu on 3/21/23.
//

import CoreData
import SwiftUI

struct WaterView: View {
//    @Binding var userInput: Int
    
    
    init(dayID: String) {
        self.dayID = dayID
        _waterObjects = FetchRequest<Water>(sortDescriptors: [
            SortDescriptor(\.createdAt, order: .reverse)
        ], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
    }
    

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var waterObjects: FetchedResults<Water>
    @FetchRequest var dailySummaries: FetchedResults<DailySummary>
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    let targetOz: Double = 128.0
    var currentOz: Int {
        return waterObjects.map {Int($0.intake)}.reduce(0, +)
    }

    let dayID: String
    
    var body: some View {

        VStack {
            Text("Total oz of water: \(currentOz) oz")
                .padding(1)
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    .frame(width: 300, height: 300)
                    .padding(30)
                Circle()
                    .trim(from: 0, to: Double(currentOz) / targetOz)
                    .rotation(.degrees(-90))
                    .stroke(Color.blue, lineWidth: 20)
                    .frame(width: 300, height: 300)
                    .padding(30)
                Text("Hi")
            }
            Button(action: {
                withAnimation {
                    addNewWater(intakeOz: 24)
                }
            },
                   label: {
                Text("Add 24 oz")
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: 500)
                    .background(Color.accentColor)
                    .cornerRadius(40)
            }
            )
            Button(action: {
                withAnimation {
                    addNewWater(intakeOz: 32)
                }
            },
                   label: {
                Text("Add 32 oz")
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: 500)
                    .background(Color.accentColor)
                    .cornerRadius(40)
            }
            )
            NavigationLink(destination: CustomWaterView(), label: {
                Text("Custom Water Amount")
            })

            List {
                ForEach(waterObjects) { water in
                    if let createdAt = water.createdAt {
                        Text("\(water.intake)oz, \(dateFormatter.string(from: createdAt))")
                    } else {
                        Text("\(water.intake)oz")
                    }
                    
                }
                .onDelete(perform: deleteItem)
                    
            }
            
            .listStyle(PlainListStyle())
        }
        .padding()
        .navigationTitle("Water Intake")
    }
    
    func addNewWater(intakeOz: Int16) {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
        
        let newWater = Water(context: moc)
        newWater.id = UUID()
        newWater.dayID = dayID
        newWater.intake = intakeOz
        newWater.createdAt = Date.now
        try? moc.save()

        updateSummaryItem()
    }
    
    func deleteItem(at offsets: IndexSet){
        for offset in offsets {
            let water = waterObjects[offset]
            moc.delete(water)
        }
        try? moc.save()

        updateSummaryItem()
    }

    func updateSummaryItem(){
        guard let summary = dailySummaries.first else {
            return
        }

        summary.isWaterGood = Double(currentOz) >= targetOz
        try? moc.save()

    }


    
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WaterView(dayID: Date.now.localDayID)
        }
    }
}

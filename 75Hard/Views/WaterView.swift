//
//  WaterView.swift
//  75Hard
//
//  Created by Christine Luu on 3/21/23.
//

import CoreData
import SwiftUI

struct WaterView: View {

    init(dayID: String) {
        self.dayID = dayID
        _waterObjects = FetchRequest<Water>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
    }

    @Environment(\.presentationMode) var presentationMode
    @State var dailyWater: Int = 0;
    @State var totalWater: Int = 90;
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var waterObjects: FetchedResults<Water>

    let dayID: String
    
    var body: some View {
        VStack {
            Text("Total oz of water: \(waterObjects.map {$0.intake}.reduce(0, +)) oz")
                .padding(1)
            Circle()
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: 300, height: 300)
                .padding(30)
            Button(action: {
                addNewWater(intakeOz: 24)
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
                addNewWater(intakeOz: 32)
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
            List {
                ForEach(waterObjects) { water in
                    Text("\(water.intake)oz")
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
        try? moc.save()
    }
    
    func deleteItem(at offsets: IndexSet){
        for offset in offsets {
            let water = waterObjects[offset]
            moc.delete(water)
        }
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

//
//  Water.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct PageView: View {
    
    @State var userInput: String = ""
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var nuggetObjects: FetchedResults<Read>
    @FetchRequest var dailySummaries: FetchedResults<DailySummary>

    let dayID: String

    init(dayID: String) {
        self.dayID = dayID
        _nuggetObjects = FetchRequest<Read>(sortDescriptors: [
            SortDescriptor(\.createdAt, order: .reverse)
        ], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
            VStack{
                TextField("Type insight!", text: $userInput)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Button(action: {
                    saveButtonTapped()
                }, label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                )
                List {
                    ForEach(nuggetObjects) { nugget in
                        if let createdAt = nugget.createdAt {
                            Text("\(nugget.nugget ?? "Unknown"), \(dateFormatter.string(from: createdAt))")
                        } else {
                            Text("\(nugget.nugget ?? "Unknown")")
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .listStyle(PlainListStyle())
            }


        .navigationTitle("Nugget from reading")
        .padding()
    }

    func saveButtonTapped() {
        saveNugget(userInput: userInput)
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
        userInput = ""
    }

    func saveNugget(userInput: String){
        let newNugget = Read(context: moc)
        newNugget.id = UUID()
        newNugget.nugget = userInput
        newNugget.createdAt = Date.now
        newNugget.dayID = dayID
        try? moc.save()
        
        updateSummaryItem()
    }
    
    func deleteItem(at offsets: IndexSet){
        for offset in offsets {
            let nugget = nuggetObjects[offset]
            moc.delete(nugget)
        }
        try? moc.save()
        
        updateSummaryItem()
    }
    
    func updateSummaryItem(){
        guard let summary = dailySummaries.first else {
            return
        }
        summary.isReadGood = !nuggetObjects.isEmpty
       
        try? moc.save()

    }
}

struct Water_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PageView(dayID: Date.now.localDayID)
        }
    }
}

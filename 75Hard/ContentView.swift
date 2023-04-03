//
//  ContentView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    let dayOne = "2023-03-26"
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var dailySummaries: FetchedResults<DailySummary>
    
    @State var dayID: String
    
    init(dayID: String) {
        self.dayID = dayID
        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", self.dayID), animation: nil)
    }
    
    func createDailySummaryIfNeeded() {
        if !dailySummaries.isEmpty {
            return
        }
        let newSummary = DailySummary(context: moc)
        newSummary.id = UUID()
        newSummary.dayID = dayID
//        newSummary.createdAt = Date.now
        try? moc.save()
    }

    func moveCurrentDateForward() {
         dayID = Date.fromDayID(dayID).adjusting(days: 1).dayID
//        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
        createDailySummaryIfNeeded()
    }

    func moveCurrentDateBackward() {
        dayID = Date.fromDayID(dayID).adjusting(days: -1).dayID
//        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
        createDailySummaryIfNeeded()
    }
    
    var body: some View {
        // TODO: Make this a DailySummaryListView(dayID: dayID)
            List {
                ForEach(PageType.all) { pageType in
                    LineItemView(pageType: pageType, dayID: dayID)
                }
            }
            .listStyle(PlainListStyle())
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("75 Hard - Day 1")
                        Text(dayID)
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
              leading: Button(action: {
                  moveCurrentDateBackward()
              }, label: {
                Image(systemName: "arrow.left")
              }),
                trailing:
                Button(action: {
                    moveCurrentDateForward()
                }, label: {
                  Image(systemName: "arrow.right")
                })
            )
            .onAppear {
                // TODO: Move this a DailySummaryListView(dayID: dayID) still onAppear
                createDailySummaryIfNeeded()
            }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(dayID: Date.now.localDayID)
        }
    }
}


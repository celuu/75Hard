//
//  ContentView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    let dayOne = "2023-04-4"
    
    
    
    @State var dayID: String
    
    init(dayID: String) {

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


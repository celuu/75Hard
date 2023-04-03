//
//  DailySummaryListView.swift
//  75Hard
//
//  Created by Christine Luu on 4/3/23.
//

import SwiftUI
import CoreData

struct DailySummaryListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var dailySummaries: FetchedResults<DailySummary>
    
    let dayID:String
    
    init(dayID: String) {
        self.dayID = dayID
        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
    }
    
    func createDailySummaryIfNeeded() {
        if !dailySummaries.isEmpty {
            return
        }
        let newSummary = DailySummary(context: moc)
        newSummary.id = UUID()
        newSummary.dayID = dayID
        try? moc.save()
    }

    
    var body: some View {
        List {
            ForEach(PageType.all) { pageType in
                LineItemView(pageType: pageType, dayID: dayID)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct DailySummaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DailySummaryListView(dayID: Date.now.localDayID)
    }
}

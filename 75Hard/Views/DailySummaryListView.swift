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
    
    let dayID: String

    
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
                LineItemView(pageType: pageType, isCompleted: getIsCompleted(pageType: pageType), dayID: dayID )

            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            createDailySummaryIfNeeded()
        }
    }

    func getIsCompleted(pageType: PageType) -> Bool {
        guard let summary = dailySummaries.first else {
            return false
        }
        switch pageType {
        case .water:
            return summary.isWaterGood
        case .reading:
            return summary.isReadGood
        case .workout:
            return summary.isWorkoutOutsideGood
        case .outsideWorkout:
            return summary.isWorkoutInsideGood
        case .macros:
            return summary.isMacrosGood
        case .photo:
            return summary.isPhotoGood
        }
    }
}


struct DailySummaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DailySummaryListView(dayID: Date.now.localDayID)
    }
}

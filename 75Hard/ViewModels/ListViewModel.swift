//
//  ListViewModel.swift
//  75Hard
//
//  Created by Christine Luu on 3/20/23.
//

import Foundation
import SwiftUI
import CoreData

class ListViewModel: ObservableObject {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var dailySummaries: FetchedResults<DailySummary>
    
    var dayID: String
    
    init(dayID: String) {
        self.dayID = dayID
        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
        createDailySummaryIfNeeded()
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
        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
        createDailySummaryIfNeeded()
    }

    func moveCurrentDateBackward() {
        dayID = Date.fromDayID(dayID).adjusting(days: -1).dayID
        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
        createDailySummaryIfNeeded()
    }
}

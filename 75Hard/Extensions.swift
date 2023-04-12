//
//  Extensions.swift
//  75Hard
//
//  Created by Jacob Rice on 3/26/23.
//

import CoreData
import Foundation
import SwiftUI

extension NSManagedObjectContext {
    
    func deleteAndSave(from fetchedResults: FetchedResults<NSManagedObject>, at offsets: IndexSet) {
        for offset in offsets   {
            let object = fetchedResults[offset]
            delete(object)
        }
        
        try? save()
    }
}

extension Date {

    var localDayID: String {
        return localFormattedYMD
    }

    var localFormattedYMD: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }

    static func fromDayID(_ dayID: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: dayID)!
    }

    var dayID: String {
        return formattedYMD
    }

    var formattedYMD: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    func inSameDayAs(_ date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }

    func adjusting(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! + 1 // <1>
    }
}

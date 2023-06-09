//
//  ContentView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    let dayOne = "2023-04-04"
    var dayLength: Int = 1

    @State var dayID: String = Date.now.localDayID

    func moveCurrentDateForward() {
         dayID = Date.fromDayID(dayID).adjusting(days: 1).dayID
    }

    func moveCurrentDateBackward() {
        dayID = Date.fromDayID(dayID).adjusting(days: -1).dayID
    }
    
    func dateFromString(string: String) -> Date {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withFullDate] // Added format options
            let date = dateFormatter.date(from: string) ?? Date.now
            return date
    }
    

    
    func getDayLength() -> Int {
        let dateDayOne = dateFromString(string: dayOne)
        guard let diffInDays = Calendar.current.dateComponents([.day], from: dateDayOne, to: dateFromString(string: dayID)).day else {
            return 1
        }
        return diffInDays
    }
    
    var body: some View {
        VStack {
            Text("75 Hard - Day \(getDayLength())")
            Text(dayID)
            DailySummaryListView(dayID: dayID)
        }


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

    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(dayID: Date.now.localDayID)
        }
    }
}


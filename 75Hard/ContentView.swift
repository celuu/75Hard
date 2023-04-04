//
//  ContentView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    let dayOne = "2023-04-4"
    
    @State var dayID: String = Date.now.localDayID

    func moveCurrentDateForward() {
         dayID = Date.fromDayID(dayID).adjusting(days: 1).dayID
    }

    func moveCurrentDateBackward() {
        dayID = Date.fromDayID(dayID).adjusting(days: -1).dayID
    }
    
    var body: some View {
        VStack {
            Text("75 Hard - Day 1")
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


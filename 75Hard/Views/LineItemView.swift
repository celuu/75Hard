//
//  LineItemView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct LineItemView: View {
    
    let pageType: PageType
    let isCompleted: Bool
    
    let dayID: String
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        HStack{

                NavigationLink(destination: pageType.getDestination(dayID: dayID), label:{
                    Text(pageType.getInformation())
                })
        
            


            Image(systemName: isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(isCompleted ? .green : .red)
                
        }
        .font(.title2)
        .padding()
    }
}


struct LineItemView_Previews: PreviewProvider {
        
    static var previews: some View {
        LineItemView(pageType: .outsideWorkout, isCompleted: false, dayID: Date.now.localDayID )
    }
    
}

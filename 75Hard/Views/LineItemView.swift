//
//  LineItemView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct LineItemView: View {
    
    let pageType: PageType
    
    let dayID: String
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        HStack{
            if pageType != .drink {
                NavigationLink(destination: pageType.getDestination(dayID: dayID), label:{
                    Text(pageType.getInformation())
                })
            } else {
                Text(pageType.getInformation())
                Spacer()
            }


            Image(systemName: false ? "checkmark.circle" : "circle")
                .foregroundColor(false ? .green : .red)
                .onTapGesture {
                    withAnimation(.linear){
//                        listViewModel.updateItem(item: item)
                    }
                }
                
        }
        .font(.title2)
        .padding()
    }
}


struct LineItemView_Previews: PreviewProvider {
        
    static var previews: some View {
        LineItemView(pageType: .outsideWorkout, dayID: Date.now.localDayID)
    }
    
}

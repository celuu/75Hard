//
//  LineItemView.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct LineItemView: View {
    
    let title: String
    
    var body: some View {
        HStack{
            NavigationLink(destination: Text("Detail 1"), label:{
                Text (title)
            })
            Image(systemName: "checkmark.circle")
        }
    }
}


struct LineItemView_Previews: PreviewProvider {
    static var previews: some View {
        LineItemView(title: "")
    }
}

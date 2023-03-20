//
//  Water.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct Page: View {
    
    @State var userInput: String = ""
    
    var body: some View {
        ScrollView {
            VStack{
                TextField("Type insight!", text: $userInput)
                    .frame(height: 55)
                Button(action: {
                    
                }, label: {
                    Text("Save")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                }
                )
            }
            
        }
        .navigationTitle("Nugget from reading")
        .padding()
    }
}

struct Water_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Page()
        }
    }
}

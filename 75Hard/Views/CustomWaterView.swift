//
//  CustomWaterView.swift
//  75Hard
//
//  Created by Christine Luu on 4/11/23.
//

import SwiftUI

struct CustomWaterView: View {
    
    @State var userInput: Int = 20
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    decreaseWater()
            }, label: {
              Image(systemName: "arrow.down")
            })
                Text("\(userInput)")
              Button(action: {
                  increaseWater()
              }, label: {
                Image(systemName: "arrow.up")
              })
            }
            
            
            Button(action: {
                
            },
            label: {
                Text("Ok")
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            )
        }
        
    }
    func increaseWater() {
        userInput += 1
    }
    
    func decreaseWater() {
        userInput -= 1
    }
    
    
    
}

struct CustomWaterView_Previews: PreviewProvider {
    static var previews: some View {
        CustomWaterView()
    }
}

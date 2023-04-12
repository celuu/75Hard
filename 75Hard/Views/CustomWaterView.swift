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
    
//    func addNewWater(intakeOz: Int16) {
//        let impactMed = UIImpactFeedbackGenerator(style: .medium)
//        impactMed.impactOccurred()
//        
//        let newWater = Water(context: moc)
//        newWater.id = UUID()
//        newWater.dayID = dayID
//        newWater.intake = intakeOz
//        newWater.createdAt = Date.now
//        try? moc.save()
//    }
    
}

struct CustomWaterView_Previews: PreviewProvider {
    static var previews: some View {
        CustomWaterView()
    }
}

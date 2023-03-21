//
//  AddHabit.swift
//  75Hard
//
//  Created by Christine Luu on 3/20/23.
//

import SwiftUI

struct AddHabitView: View {
    
    @State var userInput:String = "";
    
    var body: some View {
        ScrollView {
            VStack{
                TextField("Type item here...", text: $userInput)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Button(action: {
                    
                }, label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                )
            }
            
        }
        .navigationTitle("Add an Item")
        .padding()
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddHabitView()
        }
    }
}

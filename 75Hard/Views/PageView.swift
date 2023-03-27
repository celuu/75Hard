//
//  Water.swift
//  75Hard
//
//  Created by Christine Luu on 3/17/23.
//

import SwiftUI

struct PageView: View {
    
    @State var userInput: String = ""
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var nuggetObjects: FetchedResults<Read>
    
    var body: some View {
        ScrollView {
            VStack{
                TextField("Type insight!", text: $userInput)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Button(action: {
                    saveNugget(userInput: userInput)
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

        .navigationTitle("Nugget from reading")
        .padding()
    }

    func saveNugget(userInput:String){
        let newNugget = Read(context: moc)
        newNugget.id = UUID()
        newNugget.nugget = userInput
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
}

struct Water_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PageView()
        }
    }
}

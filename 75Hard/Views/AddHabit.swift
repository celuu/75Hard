//
//  AddHabit.swift
//  75Hard
//
//  Created by Christine Luu on 3/20/23.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var userInput:String = ""
    @EnvironmentObject var listViewModel: ListViewModel
    @State var alertTitle:String = ""
    @State var showAlert:Bool = false
    
    var body: some View {
        ScrollView {
            VStack{
                TextField("Type item here...", text: $userInput)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Button(action: saveButtonPressed,
                       label: {
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
        .alert(isPresented: $showAlert, content: getAlert)
        .padding()
    }
    
    func saveButtonPressed(){
        if textIsGood(){
            listViewModel.addItem(title: userInput)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsGood() -> Bool{
        if(userInput.count < 3){
            alertTitle = "Item must be at least 3 characters long"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddHabitView()
        }
        .environmentObject(ListViewModel())
    }
}

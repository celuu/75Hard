//
//  WorkoutView.swift
//  75Hard
//
//  Created by Christine Luu on 3/21/23.
//

import SwiftUI

struct WorkoutView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var userInput:String = ""
    @EnvironmentObject var listViewModel: ListViewModel
    @State var alertTitle:String = ""
    @State var showAlert:Bool = false
    let dayID: String
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var workoutObjects: FetchedResults<Workout>


    init(dayID: String) {
        self.dayID = dayID
        _workoutObjects = FetchRequest<Workout>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
    }
    
    var body: some View {
        VStack{
            TextField("Type workout...", text: $userInput)
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
            List(workoutObjects) { workout in
                Text(workout.activity ?? "Unknown")
            }
            .listStyle(PlainListStyle())

        }
        .navigationTitle("What workout did you do")
        .alert(isPresented: $showAlert, content: getAlert)
        .padding()
    }
    
    func saveButtonPressed(){
        if textIsGood(){
            listViewModel.addItem(title: userInput)
            presentationMode.wrappedValue.dismiss()
        }
        saveWorkout()
    }

    func saveWorkout(){
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.dayID = dayID
        newWorkout.isOutdoor = false
        newWorkout.activity = userInput
        try? moc.save()
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

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutView(dayID: Date.now.localDayID)
        }
        
    }
}

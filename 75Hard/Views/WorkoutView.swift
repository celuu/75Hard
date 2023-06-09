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
    let isOutdoor: Bool
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.createdAt, order: .reverse)
    ]) var workoutObjects: FetchedResults<Workout>
    @FetchRequest var dailySummaries: FetchedResults<DailySummary>
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()


    init(dayID: String, isOutdoor: Bool) {
        self.dayID = dayID
        self.isOutdoor = isOutdoor
        _workoutObjects = FetchRequest<Workout>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@ AND isOutdoor == %@", dayID, NSNumber(value: isOutdoor)), animation: nil)
        _dailySummaries = FetchRequest<DailySummary>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
    }
    
    var body: some View {
        VStack{
            TextField("Type workout...", text: $userInput)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            Button(action: saveButtonTapped,
                   label: {
                Text("Save")
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            )
            List {
                ForEach(workoutObjects) { workout in
                    if let createdAt = workout.createdAt {
                        Text("\(workout.activity ?? "Unknown"), \(dateFormatter.string(from: createdAt))")
                    } else {
                        Text("\(workout.activity ?? "Unknown")")
                    }
                }
                    .onDelete(perform: deleteItem)
            }
            .listStyle(PlainListStyle())

        }
        .navigationTitle("What \(isOutdoor ? "outdoor" : "indoor") workout did you do")
        .alert(isPresented: $showAlert, content: getAlert)
        .padding()
    }

    func saveButtonTapped() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()

        if textIsGood() {
            saveWorkout()
            userInput = ""
        }
    }

    func saveWorkout(){
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.dayID = dayID
        newWorkout.isOutdoor = isOutdoor
        newWorkout.activity = userInput
        newWorkout.createdAt = Date.now
        try? moc.save()
        
        updateSummaryItem(isOutdoor: isOutdoor)
    }
    
    func textIsGood() -> Bool {
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
    
    func deleteItem(at offsets: IndexSet){
        for offset in offsets {
            let workout = workoutObjects[offset]
            moc.delete(workout)
        }
        try? moc.save()
        
        updateSummaryItem(isOutdoor: isOutdoor)
    }
    
    func updateSummaryItem(isOutdoor: Bool){
        guard let summary = dailySummaries.first else {
            return
        }
        if isOutdoor {
            summary.isWorkoutInsideGood = !workoutObjects.isEmpty
        } else {
            summary.isWorkoutOutsideGood = !workoutObjects.isEmpty
        }
        
       
        try? moc.save()

    }
    
    
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutView(dayID: Date.now.localDayID, isOutdoor: true)
        }
        
    }
}

//
//  MacroView.swift
//  75Hard
//
//  Created by Christine Luu on 3/21/23.
//

import SwiftUI

struct MacroView: View {
    
    @State var proteinInput: Int16 = 0
    @State var carbInput: Int16 = 0
    @State var fatInput: Int16 = 0
    var proteinTarget: Int = 146
    var carbTarget: Int = 194
    var fatTarget: Int = 44
    let dayID: String
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var macroObjects: FetchedResults<Macro>

    init(dayID: String) {
        self.dayID = dayID
        _macroObjects = FetchRequest<Macro>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
    }

    var isProteinGood: Bool {
        let intProtein: Int = Int(proteinInput)
        return abs(intProtein - proteinTarget) <= 5
    }

    var isCarbGood: Bool {
        let intCarb: Int = Int(carbInput)
        return abs(intCarb - carbTarget) <= 5
    }

    var isFatGood: Bool {
        let intFat: Int = Int(fatInput)
        return abs(intFat - fatTarget) <= 5
    }
    

    var totalCalories: Int {
        let protein = Int(proteinInput)
        let carbs = Int(carbInput)
        let fat = Int(fatInput)
        return (protein * 4) + (carbs * 4) + (fat * 9)
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack{
            Text("Target")
                .padding(1)
            HStack{
                Spacer()
                Text("P: \(proteinTarget)g")
                Spacer()
                Text("C: \(carbTarget)g")
                Spacer()
                Text("F: \(fatTarget)g")
                Spacer()
                Text("Total: 1594")
                Spacer()
            }
            .padding()
            
            HStack{
                VStack{
                    Text("Protein")
                    TextField("Protein", value: $proteinInput, formatter: NumberFormatter())
                        .padding()
                    Image(systemName: isProteinGood ? "checkmark.circle" : "x.circle")
                }
                VStack{
                    Text("Carbs")
                    TextField("Carbs", value: $carbInput, formatter: NumberFormatter())
                        .padding()
                    Image(systemName: isCarbGood ? "checkmark.circle" : "x.circle")
                }
                
                VStack{
                    Text("Fat")
                    TextField("Fat", value: $fatInput, formatter: NumberFormatter())
                        .padding()
                    Image(systemName: isFatGood ? "checkmark.circle" : "x.circle")
                }
                
                VStack{
                    Text("Total Cals")
                    Text("\(totalCalories)")
                        .padding()

                }
            }
            .frame(width: 350, height: 300, alignment: .top)

            VStack{
                if fatInput != 0 && carbInput != 0 && proteinInput != 0 {
                    Button(action: saveMacros,
                           label: {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                    ).disabled(false)

                } else {
                    Button(action: saveButtonTapped,
                           label: {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                    ).disabled(true)

                }

                List {
                    ForEach(macroObjects) { macro in
                        
                            VStack {
                                if let createdAt = macro.createdAt {
                                Text("Protein: \(macro.protein), Carbs: \(macro.carbs), Fat:\(macro.fat)")
                                Text("\(dateFormatter.string(from: createdAt))")

                                } else {
                                    Text(
                                        "Protein: \(macro.protein), Carbs: \(macro.carbs), Fat:\(macro.fat)"
                                    )
                                }
                            }
                    }
                    .onDelete(perform: deleteItem)
                   
                }
                .listStyle(PlainListStyle())

            }

            
        }
        .navigationTitle("Macros")
    }

    func saveButtonTapped() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()

        saveMacros()
    }

    func saveMacros(){
        let newMacros = Macro(context: moc)
        newMacros.id = UUID()
        newMacros.dayID = dayID
        newMacros.fat = fatInput
        newMacros.protein = proteinInput
        newMacros.carbs = carbInput
        newMacros.createdAt = Date.now
        try? moc.save()
    }
    
    func deleteItem(at offsets: IndexSet){
        for offset in offsets {
            let macro = macroObjects[offset]
            moc.delete(macro)
        }
        try? moc.save()
    }





}

struct MacroView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MacroView(dayID: Date.now.localDayID)
        }
    }
        
}

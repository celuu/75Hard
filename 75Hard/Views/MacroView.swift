//
//  MacroView.swift
//  75Hard
//
//  Created by Christine Luu on 3/21/23.
//

import SwiftUI

struct MacroView: View {
    
    @State var proteinInput: String = ""
    @State var carbInput: String = ""
    @State var fatInput: String = ""
    var proteinTarget: Int = 136
    var carbTarget: Int = 181
    var fatTarget: Int = 41
    let dayID: String
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var macroObjects: FetchedResults<Macro>

    var isProteinGood: Bool {
        let intProtein: Int = Int(proteinInput) ?? 0
        return abs(intProtein - proteinTarget) <= 5
    }

    var isCarbGood: Bool {
        let intCarb: Int = Int(carbInput) ?? 0
        return abs(intCarb - carbTarget) <= 5
    }

    var isFatGood: Bool {
        let intFat: Int = Int(fatInput) ?? 0
        return abs(intFat - fatTarget) <= 5
    }
    

    var totalCalories: Int {
        let protein = Int(proteinInput) ?? 0
        let carbs = Int(carbInput) ?? 0
        let fat = Int(fatInput) ?? 0
        return (protein * 4) + (carbs * 4) + (fat * 9)
    }
    
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
                    TextField("Protein", text: $proteinInput)
                        .padding()
                    Image(systemName: isProteinGood ? "checkmark.circle" : "x.circle")
                }
                VStack{
                    Text("Carbs")
                    TextField("Carbs", text: $carbInput)
                        .padding()
                    Image(systemName: isCarbGood ? "checkmark.circle" : "x.circle")
                }
                
                VStack{
                    Text("Fat")
                    TextField("Fat", text: $fatInput)
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
            Spacer()

            
        }
        .navigationTitle("Macros")
    }

    func saveMacros(){
        
    }





}

struct MacroView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MacroView(dayID: Date.now.localDayID)
        }
    }
        
}

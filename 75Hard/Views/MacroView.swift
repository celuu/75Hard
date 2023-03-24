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
                Text("P: 136g")
                Text("C: 181g")
                Text("F: 41g")
                Text("Total: 1594")
            }
            .padding()
            
            HStack{
                VStack{
                    Text("Protein")
                    TextField("Protein", text: $proteinInput)
                        .padding()
                }
                VStack{
                    Text("Carbs")
                    TextField("Carbs", text: $carbInput)
                        .padding()
                }
                
                VStack{
                    Text("Fat")
                    TextField("Fat", text: $fatInput)
                        .padding()
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
    
}

struct MacroView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MacroView()
        }
    }
        
}

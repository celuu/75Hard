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
        HStack{
            VStack{
                Text("Protein")
                TextField("Protein", text: $proteinInput)
            }
            VStack{
                Text("Carbs")
                TextField("Carbs", text: $carbInput)
            }
            
            VStack{
                Text("Fat")
                TextField("Fat", text: $fatInput)
            }
            
            VStack{
                Text("Total Cals")
                Text("\(totalCalories)")
            }
        }
        
    }
    

}

struct MacroView_Previews: PreviewProvider {
    static var previews: some View {
        MacroView()
    }
}

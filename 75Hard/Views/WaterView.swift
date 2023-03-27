//
//  WaterView.swift
//  75Hard
//
//  Created by Christine Luu on 3/21/23.
//

import SwiftUI

struct WaterView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var dailyWater: Int = 0;
    @State var totalWater: Int = 90;
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var waterObjects: FetchedResults<Water>

    
    var body: some View {
        VStack {
            Text("Total oz of water: \(waterObjects.map {$0.intake}.reduce(0, +)) oz")
                .padding(1)
            Circle()
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: 300, height: 300)
                .padding(30)
            Spacer()
            Button(action: {
                addNewWater(intakeOz: 24)
            },
                   label: {
                Text("Add 24 oz")
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: 500)
                    .background(Color.accentColor)
                    .cornerRadius(40)
            }
            )
            Button(action: {
                addNewWater(intakeOz: 32)
            },
                   label: {
                Text("Add 32 oz")
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: 500)
                    .background(Color.accentColor)
                    .cornerRadius(40)
            }
            )
        }
        .padding()
        .navigationTitle("Water Intake")
    }
    
    func addNewWater(intakeOz: Int16){
        let newWater = Water(context: moc)
        newWater.id = UUID()
        newWater.date = Date.now
        newWater.intake = intakeOz
        try? moc.save()
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WaterView()
        }
    }
}

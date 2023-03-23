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
    
    var body: some View {
        VStack {
            Text("Total oz of water: \(dailyWater) oz")
                .padding(1)
            Circle()
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: 300, height: 300)
                .padding(30)
                Spacer()
            Button(action: add24oz,
                   label: {
                Text("Add 24 oz")
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: 500)
                    .background(Color.accentColor)
                    .cornerRadius(40)
            }
            )
            Button(action: add32oz,
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
    
    func add24oz(){
        return dailyWater += 24
    }
    
    func add32oz(){
        return dailyWater += 32
    }
    
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WaterView()
        }
    }
}

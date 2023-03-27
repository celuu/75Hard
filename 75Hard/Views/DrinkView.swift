//
//  DrinkView.swift
//  75Hard
//
//  Created by Christine Luu on 3/22/23.
//

import SwiftUI

struct DrinkView: View {

    @State var isOn: Bool = false

    var body: some View {
        Toggle(isOn: $isOn) {
            Text("I did not drink alcohol today")
        }
        .toggleStyle(iOSCheckboxToggleStyle())
    }

    struct iOSCheckboxToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            Button(action: {
                configuration.isOn.toggle()

            }, label: {
                HStack {
                    Image(systemName: configuration.isOn ? "checkmark.square" : "square")

                    configuration.label
                }
            })
        }
    }
}

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DrinkView()
        }
    }
}

//
//  DrinkView.swift
//  75Hard
//
//  Created by Christine Luu on 3/22/23.
//

import SwiftUI

struct DrinkView: View {

    @State var isOn: Bool = false

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var drinkObjects: FetchedResults<Drink>

    let dayID: String

    init(dayID: String) {
        self.dayID = dayID
        _drinkObjects = FetchRequest<Drink>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
    }

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

    func saveCheckmark(){
        let newCheck = Drink(context: moc)
        newCheck.id = UUID()
        newCheck.dayID = dayID
        newCheck.isChecked = true
        try? moc.save()
    }
}

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DrinkView(dayID: Date.now.localDayID)
        }
    }
}

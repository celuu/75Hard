//
//  DrinkView.swift
//  75Hard
//
//  Created by Christine Luu on 3/22/23.
//

import SwiftUI

struct DrinkView: View {

    @State var isOn: Bool = false

    let dayID: String

    init(dayID: String) {
        self.dayID = dayID
    }

    var body: some View {
        Toggle(isOn: $isOn) {
            Text("I did nooday")
        }
    }


}

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DrinkView(dayID: Date.now.localDayID)
        }
    }
}

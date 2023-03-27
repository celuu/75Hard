//
//  CameraView.swift
//  75Hard
//
//  Created by Jacob Rice on 3/26/23.
//

import SwiftUI
import PhotosUI

struct CameraView: View {

    @State var selectedItems: [PhotosPickerItem] = []
    @State var data:Data?

    var body: some View {
        VStack{
            if let data = data, let uiimage = UIImage(data: data){
                Image(uiImage: uiimage)
                    .resizable()

            }
            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 1,
                matching: .images
            ){
                Text("Pick a photo")
            }
            .onChange(of: selectedItems){ newValue in
                guard let item = selectedItems.first else {
                    return
                }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            self.data = data
                        } else {
                            print("Data is nil")
                        }
                    case .failure(let error):
                        fatalError("it didnt work \(error)")
                    }
                }
            }
        }
        .frame(width: 500, height: 500)
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}

//
//  PhotoView.swift
//  75Hard
//
//  Created by Jacob Rice on 3/27/23.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    @State private var isShowingImagePicker = false
    @State var selectedItems: [PhotosPickerItem] = []
    
    let dayID: String
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var photoObjects: FetchedResults<Photo>
    
    init(dayID: String) {
        self.dayID = dayID
        _photoObjects = FetchRequest<Photo>(sortDescriptors: [], predicate: NSPredicate(format: "dayID BEGINSWITH %@", dayID), animation: nil)
    }


    var body: some View {
        
        VStack {
            if let firstPhotoObject = photoObjects.first,
               let data = firstPhotoObject.data,
               let uiimage = UIImage(data: data) {
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
                            saveImage(data: data)
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
        
        VStack {
            Button("Take Photo") {
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
                isShowingImagePicker = true
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(saveImage: saveImage)
            }
        }
    }
    
    func saveImage(data: Data) {
        let newImage = Photo(context: moc)
        newImage.id = UUID()
        newImage.dayID = dayID
        newImage.data = data
        try? moc.save()
    }
    
    
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    let saveImage: ((Data) -> Void)

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                if let data = image.jpegData(compressionQuality: 1) {
                    parent.saveImage(data)
                }
            }
            

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // Nothing to do here
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(dayID: Date.now.localDayID)
    }
}

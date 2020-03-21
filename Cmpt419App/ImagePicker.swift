//
//  ImagePicker.swift
//  Cmpt419App
//
//  Created by beibei cai on 2020-03-14.
//  Copyright © 2020 Jerrick Cai. All rights reserved.
//

import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var useCamera: Bool
    @Binding var image_uiImage: UIImage?
    
    init(isShown: Binding<Bool>, image: Binding<Image?>, useCamera: Binding<Bool>, image_uiImage: Binding<UIImage?>) {
        _isShown = isShown
        _image = image
        _useCamera = useCamera
        _image_uiImage = image_uiImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image_uiImage = uiImage
        image = Image(uiImage: uiImage)
        isShown = false
        useCamera = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
        useCamera = false
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var useCamera: Bool
    @Binding var image_uiImage: UIImage?
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShown: $isShown, image: $image, useCamera: $useCamera, image_uiImage: $image_uiImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        if !useCamera{
            picker.sourceType = .photoLibrary
        } else {
            picker.sourceType = .camera
        }
        return picker
    }
    
}

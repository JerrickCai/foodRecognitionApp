//
//  SwiftUIView.swift
//  Cmpt419App
//
//  Created by beibei cai on 2020-03-14.
//  Copyright © 2020 Jerrick Cai. All rights reserved.
//

import SwiftUI

struct PhotoCaptureView: View {
    
    @Binding var showImagePicker: Bool
    @Binding var image: Image?
    @Binding var useCamera: Bool
    @Binding var image_uiImage: UIImage?
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image, useCamera: $useCamera, image_uiImage: $image_uiImage)
    }
}

struct PhotoCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCaptureView(showImagePicker: .constant(false), image: .constant(Image("")), useCamera: .constant(false), image_uiImage: .constant(UIImage(contentsOfFile: "")))
    }
}

//
//  ContentView.swift
//  Cmpt419App
//
//  Created by beibei cai on 2020-03-14.
//  Copyright © 2020 Jerrick Cai. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var useCamera: Bool = false
    
    var body: some View {
        VStack {
            
            image?.resizable()
            .scaledToFit()
                .frame(width: 200, height: 200)
                .border(Color.black, width: 1)
                .clipped()
            
            Text("Hello, Welcome!")
                .font(.title).foregroundColor(Color.red)
                
            Button(action: {
                self.showImagePicker = true
                self.useCamera = true
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "camera.fill")
                    Text("Take a photo of ur food")
                }.padding()
                    .background(Color.pink)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                
            }.sheet(isPresented: self.$showImagePicker) {
                PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image, useCamera: self.$useCamera)
            }
            
            Button(action: {
                self.showImagePicker = true
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    Text("Import a photo from library")
                }.padding()
                    .background(Color.orange)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }.sheet(isPresented: self.$showImagePicker) {
                PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image, useCamera: self.$useCamera)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

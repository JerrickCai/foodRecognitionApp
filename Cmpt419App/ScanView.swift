//
//  ScanView.swift
//  Cmpt419App
//
//  Created by beibei cai on 2020-03-19.
//  Copyright © 2020 Jerrick Cai. All rights reserved.
//

import SwiftUI

struct ScanView: View {
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var useCamera: Bool = false
    
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    @State private var index: Int = 0
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView{
            
            VStack {
                image?.resizable().scaledToFit().cornerRadius(10).padding(10)
                
                VStack{
                    HStack{
                        //take photo
                        Button(action: {
                            self.showImagePicker = true
                            self.useCamera = true
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "camera.fill")
                                Text("Take Photo")
                            }.padding()
                                .background(Color.pink)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }.sheet(isPresented: self.$showImagePicker) {
                            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image, useCamera: self.$useCamera)
                        }
                        
                        //import photo
                        Button(action: {
                            self.showImagePicker = true
                            self.index = 1
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                Text("Import Photo")
                            }.padding()
                                .background(Color.orange)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }.sheet(isPresented: self.$showImagePicker) {
                            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image, useCamera: self.$useCamera)
                        }
                    }
                    
                    if (index == 0){
                        Text("Import or Take a Photo")
                    }else{
                        VStack{
                            Text(menu[index].items[2].name)
                            
                            NavigationLink(destination: ItemDetail(item: menu[index].items[2])) {
                                Text("Place Order")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        ScanView().environmentObject(order)
    }
}

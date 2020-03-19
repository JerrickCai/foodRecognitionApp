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
    
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        VStack {
            
            NavigationView {
                List {
                    ForEach(menu) { section in
                        Section(header: Text(section.name)) {
                            ForEach(section.items) { item in
                                ItemRow(item: item)
                            }
                        }
                    }
                }
                .navigationBarTitle("Shopping Cart")
                .listStyle(GroupedListStyle())
                .navigationBarItems( trailing:
                    HStack {
                        
                        Button(action: {
                            self.showImagePicker = true
                            self.useCamera = true
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "camera.fill")
                                //Text("Take Photo")
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
                            HStack(spacing: 5) {
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                //Text("Import Photo")
                            }.padding()
                                .background(Color.orange)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }.sheet(isPresented: self.$showImagePicker) {
                            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image, useCamera: self.$useCamera)
                        }
                            
                        
                    }
                )
            }
                        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

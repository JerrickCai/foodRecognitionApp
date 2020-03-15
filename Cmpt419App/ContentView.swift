//
//  ContentView.swift
//  Cmpt419App
//
//  Created by beibei cai on 2020-03-14.
//  Copyright © 2020 Jerrick Cai. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, Welcome!")
                .font(.title).foregroundColor(Color.red)
                
            Button(action: {
                
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "camera.fill")
                    Text("Take a photo of ur food")
                }.padding()
                    .background(Color.pink)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                
            }
            
            Button(action: {
                
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    Text("Import a photo of ur food")
                }.padding()
                    .background(Color.orange)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
        
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

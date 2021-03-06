//
//  AppView.swift
//  Cmpt419App
//
//  Created by beibei cai on 2020-03-18.
//  Copyright © 2020 Jerrick Cai. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
                }

            ScanView()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Scan")
                }
            
            OrderView()
            .tabItem {
                Image(systemName: "square.and.pencil")
                Text("Order")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static let order = Order()

    static var previews: some View {
        AppView().environmentObject(order)
    }
}

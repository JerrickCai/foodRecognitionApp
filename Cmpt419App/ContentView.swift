//
//  ContentView.swift
//  Cmpt419App
//
//  Created by beibei cai on 2020-03-14.
//  Copyright © 2020 Jerrick Cai. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
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
                .navigationBarTitle("Welcome")
                .listStyle(GroupedListStyle())
            }
                        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

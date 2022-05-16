//
//  MealView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/16.
//

import SwiftUI

struct MealView: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            Text("Tab Content 1").tabItem { Text("조식") }.tag(1)
            Text("Tab Content 2").tabItem { Text("중식") }.tag(2)
            Text("Tab Content 2").tabItem { Text("석식") }.tag(3)
        }.navigationTitle("식단표")
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}

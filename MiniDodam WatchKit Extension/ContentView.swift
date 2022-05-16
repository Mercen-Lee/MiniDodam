//
//  ContentView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/16.
//

import SwiftUI
import CoreData

extension Color {
    static let primaryColor = Color(red: 43/255, green: 101/255, blue: 182/255)
    static let secondaryColor = Color(red: 137/255, green: 177/255, blue: 217/255)
}

struct ContentView: View {
    var body: some View {
        VStack{
            Text("미니도담").font(.system(size: 25).bold())
            HStack{
                VStack{ NavigationLink(destination: MealView()) {
                    Image(systemName: "fork.knife") }
                .background(Color.primaryColor.cornerRadius(100))
                    Text("식단표") }
                VStack{ NavigationLink(destination: ClassView()) {
                    Image(systemName: "book.fill") }
                .background(Color.secondaryColor.cornerRadius(100))
                    Text("자습실") } }
            HStack{
                VStack{ NavigationLink(destination: PointView()) {
                    Image(systemName: "heart.fill") }
                .background(Color.secondaryColor.cornerRadius(100))
                    Text("상벌점") }
                VStack{ NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill") }
                .background(Color.primaryColor.cornerRadius(100))
                    Text("설정") } }
        }.padding([.top], 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

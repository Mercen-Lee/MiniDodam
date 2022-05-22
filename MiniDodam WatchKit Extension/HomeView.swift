//
//  HomeView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/16.
//

import SwiftUI

struct HomeView: View {
    var token: String?
    var body: some View {
        VStack{
            Text("미니도담").font(.system(size: 25).bold())
            HStack{
                VStack{ NavigationLink(destination: MealView()) {
                    Image(systemName: "fork.knife") }
                .background(Color.primaryColor.cornerRadius(21))
                    Text("식단표") }
                VStack{ NavigationLink(destination: ClassView()) {
                    Image(systemName: "book.fill") }
                .background(Color.secondaryColor.cornerRadius(21))
                    Text("자습실") } }
            HStack{
                VStack{ NavigationLink(destination: PointView()) {
                    Image(systemName: "heart.fill") }
                .background(Color.secondaryColor.cornerRadius(21))
                    Text("상벌점") }
                VStack{ NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill") }
                .background(Color.primaryColor.cornerRadius(21))
                    Text("설정") } }
        }.padding([.top], 10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

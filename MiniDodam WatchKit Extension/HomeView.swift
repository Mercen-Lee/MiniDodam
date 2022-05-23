//
//  HomeView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/16.
//

import SwiftUI

struct HomeView: View {
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
                VStack{ NavigationLink(destination: EscapeView()) {
                    Image(systemName: "heart.fill") }
                .background(Color.secondaryColor.cornerRadius(21))
                    Text("외출∙외박") }
                VStack{ NavigationLink(destination: SettingsView()) {
                    Image(systemName: "ellipsis") }
                .background(Color.primaryColor.cornerRadius(21))
                    Text("더보기") } }
        }.padding([.top], 10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

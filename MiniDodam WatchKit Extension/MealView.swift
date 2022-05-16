//
//  MealView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/16.
//

import SwiftUI

struct MealView: View {
    var body: some View {
        TabView() {
            BreakfastView()
            LunchView()
            DinnerView()
        }.navigationTitle("식단표")
    }
}

struct BreakfastView: View {
    var body: some View {
        Text("조식")
    }
}

struct LunchView: View {
    var body: some View {
        Text("중식")
    }
}

struct DinnerView: View {
    var body: some View {
        Text("석식")
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}

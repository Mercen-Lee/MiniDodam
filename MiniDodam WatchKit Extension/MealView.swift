//
//  MealView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/16.
//

import SwiftUI
import Alamofire
import SwiftyJSON

func reg(str: String) -> String {
    return str.replacingOccurrences(of: "<br/>", with: "\n").components(separatedBy: CharacterSet.decimalDigits).joined().replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "*", with: "").replacingOccurrences(of: " ", with: "") }

struct MealView: View {
    @State public var breakfast = ""
    @State public var lunch = ""
    @State public var dinner = ""
    var body: some View {
        TabView() {
            BreakfastView(breakfast: breakfast)
            LunchView(lunch: lunch)
            DinnerView(dinner: dinner)
        }.onAppear {
            let format = DateFormatter()
            format.dateFormat = "yyyyMMdd"
            let date = format.string(from: Date())
            let mealLink = "https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=85d56b3110fa4a2bbb700a1106bb58bf&Type=json&ATPT_OFCDC_SC_CODE=D10&SD_SCHUL_CODE=7240454&MLSV_YMD=\(date)&MMEAL_SC_CODE="
            AF.request(mealLink+"1", method: .get, encoding: URLEncoding.default).responseData { response in
                breakfast = reg(str: JSON(response.data!)["mealServiceDietInfo"][1]["row"][0]["DDISH_NM"].string!) }
            AF.request(mealLink+"2", method: .get, encoding: URLEncoding.default).responseData { response in
                lunch = reg(str: JSON(response.data!)["mealServiceDietInfo"][1]["row"][0]["DDISH_NM"].string!) }
            AF.request(mealLink+"3", method: .get, encoding: URLEncoding.default).responseData { response in
                dinner = reg(str: JSON(response.data!)["mealServiceDietInfo"][1]["row"][0]["DDISH_NM"].string!) }
        }
    }
}

struct BreakfastView: View {
    var breakfast: String
    var body: some View {
        Text(breakfast).navigationTitle("조식").onAppear {
            
        }
    }
}

struct LunchView: View {
    var lunch: String
    var body: some View {
        Text(lunch).navigationTitle("중식")
    }
}

struct DinnerView: View {
    var dinner: String
    var body: some View {
        Text(dinner).navigationTitle("석식")
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}

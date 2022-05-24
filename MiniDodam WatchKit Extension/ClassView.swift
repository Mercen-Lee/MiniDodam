//
//  ClassView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/16.
//

import SwiftUI
import Alamofire
import SwiftyJSON

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}

struct ClassView: View {
    @State var selectedClass1: String = "1-1 교실"
    @State var selectedClass2: String = "1-1 교실"
    @State var selectedClass3: String = "1-1 교실"
    @State var selectedClass4: String = "1-1 교실"
    @State private var typeHTTP = false
    @State private var success = false
    let token = UserDefaults.standard.string(forKey: "token")
    let classes = ["1-1교실": 1, "1-2교실": 2, "1-3교실": 3, "1-4교실": 124, "2-1교실": 4, "2-2교실": 5, "2-3교실": 6, "3-1교실": 7, "3-2교실": 8, "3-3교실": 9, "DB네트워크실습실": 115, "공작실": 53, "국어전용실": 41, "기숙사": 114, "도서관": 51, "랩1": 10, "랩10": 20, "랩11": 21, "랩12": 22, "랩13": 23, "랩14": 24, "랩15": 25, "랩16": 26, "랩2": 11, "랩3": 12, "랩4": 14, "랩5": 15, "랩6": 16, "랩7": 17, "랩8": 18, "랩9": 19, "면접실": 113, "모둠학습실": 60, "모바일로보틱스실습실": 59, "모바일프로그래밍실": 54, "미술실": 119, "방송실": 116, "사회/역사전용실": 43, "산학겸임교사실": 118, "상담실(Wee)": 117, "수학전용실": 42, "시청각실": 58, "오케스트라실": 52, "운동장": 110, "웹프로그래밍실습실": 57, "윈도우프로그래밍실": 55, "음악실": 111, "체육관": 56, "프로그래밍1": 31, "프로그래밍2": 32, "프로그래밍3": 33, "프로그래밍4": 34, "학생자치실": 112, "회의실1": 120, "회의실2": 122]
    var body: some View {
        List {
            Picker("8교시", selection: $selectedClass1) { ForEach(classes.keys.sorted(), id: \.self) { Text($0) } }
            Picker("9교시", selection: $selectedClass2) { ForEach(classes.keys.sorted(), id: \.self) { Text($0) } }
            Picker("10교시", selection: $selectedClass3) { ForEach(classes.keys.sorted(), id: \.self) { Text($0) } }
            Picker("11교시", selection: $selectedClass4) { ForEach(classes.keys.sorted(), id: \.self) { Text($0) } }
            Button("신청하기") {
                let class1 = ["timeTableIdx": 1, "placeIdx": classes[selectedClass1]!] as [String : Int]
                let class2 = ["timeTableIdx": 2, "placeIdx": classes[selectedClass2]!] as [String : Int]
                let class3 = ["timeTableIdx": 3, "placeIdx": classes[selectedClass3]!] as [String : Int]
                let class4 = ["timeTableIdx": 4, "placeIdx": classes[selectedClass4]!] as [String : Int]
                let classList = [class1, class2, class3, class4]
                AF.request("http://dodam.b1nd.com/api/v2//location", method: .put, encoding: URLEncoding.default, headers: ["x-access-token": token!]).responseData { response in
                    print(JSON(response.data!))
                    if JSON(response.data!)["status"].int == 200 { success.toggle() } }
                print(classList)
            }
        }.navigationTitle("자습실")
            .alert(isPresented: $success) {
                Alert(title: Text("위치신청 성공"), message: Text("자습실 위치 신청에 성공했습니다!"), dismissButton: .default(Text("확인"))) }
            .onAppear {
                var arr = [1, 1, 1, 1]
                if let token = UserDefaults.standard.string(forKey: "token") {
                    let format = DateFormatter()
                    format.dateFormat = "yyyy-MM-dd"
                    let date = format.string(from: Date())
                    let week = Calendar.current.component(.weekday, from: Date())
                    AF.request("http://dodam.b1nd.com/api/v2//location/my?date=" + date, method: .get, encoding: URLEncoding.default, headers: ["x-access-token": token]).responseData { response in
                        print(JSON(response.data!))
                        if(JSON(response.data!)["data"]["locations"][0]["placeIdx"].int == nil) {
                            AF.request("http://dodam.b1nd.com/api/v2//location/default/\(week)", method: .get, encoding: URLEncoding.default, headers: ["x-access-token": token]).responseData { response in
                                for i in 0..<4 {
                                    arr[i] = JSON(response.data!)["data"]["defaultLocations"][i]["placeIdx"].int! }
                                selectedClass1 = classes.someKey(forValue: arr[0])!
                                selectedClass2 = classes.someKey(forValue: arr[1])!
                                selectedClass3 = classes.someKey(forValue: arr[2])!
                                selectedClass4 = classes.someKey(forValue: arr[3])!
                                typeHTTP = false
                            }
                        }
                        else { for i in 0..<4 {
                            arr[i] = JSON(response.data!)["data"]["locations"][i]["placeIdx"].int! }
                            selectedClass1 = classes.someKey(forValue: arr[0])!
                            selectedClass2 = classes.someKey(forValue: arr[1])!
                            selectedClass3 = classes.someKey(forValue: arr[2])!
                            selectedClass4 = classes.someKey(forValue: arr[3])!
                            typeHTTP = true
                        }
                    }
                }
            }
    }
}

struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView()
    }
}


/*.onAppear {
    if let token = UserDefaults.standard.string(forKey: "token") {
        var urlindex = "1"; if Calendar.current.isDateInWeekend(Date()) { var urlindex = "2" }
        AF.request("http://dodam.b1nd.com/api/v2//time-table/type/" + urlindex, method: .get, encoding: URLEncoding.default, headers: ["x-access-token": token]).responseData { response in
            if JSON(response.data!)["status"].int == 200 { let classes = JSON(response.data!)["data"]["timeTables"][0]["name"].string }
        }
    }
}*/

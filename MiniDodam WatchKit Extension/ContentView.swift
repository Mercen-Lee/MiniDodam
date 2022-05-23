//
//  ContentView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/18.
//

import SwiftUI
import CryptoKit
import Alamofire
import SwiftyJSON

extension Color {
    static let primaryColor = Color(red: 0, green: 80/255, blue: 182/255)
    static let secondaryColor = Color(red: 100/255, green: 160/255, blue: 217/255)
}

struct ContentView: View {
    
    @State var id: String = ""
    @State var pw: String = ""
    @State private var serverAlert = false
    @State private var loginAlert = false
    @State private var homeScreen = false
    
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: HomeView().navigationBarHidden(true), isActive: $homeScreen) { }.hidden()
            TextField("아이디 입력", text: $id)
            SecureField("비밀번호 입력", text: $pw)
            
            Button("로그인") {
                let pw = SHA512.hash(data: pw.data(using: .utf8)!)
                    .compactMap{String(format: "%02x", $0)}.joined()
                let url = "http://auth.dodam.b1nd.com/auth/login"
                let params = ["id": id, "pw": pw] as Dictionary
                var request = URLRequest(url: URL(string: url)!)
                
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.timeoutInterval = 10
                
                do { try request.httpBody = JSONSerialization.data(withJSONObject: params, options: []) } catch { }
                
                AF.request(request).validate().responseData { response in
                    let token = JSON(response.data!)["data"]["token"].string
                    UserDefaults.standard.set(token, forKey: "token")
                    if JSON(response.data!)["status"].int == 200 { homeScreen.toggle() }
                    else { loginAlert.toggle() }
                }
             
        }.background(Color.primaryColor.cornerRadius(21))
            .alert(isPresented: $serverAlert) {
                Alert(title: Text("로그인 실패"), message: Text("서버에 연결할 수 없습니다!"), dismissButton: .default(Text("확인"))) }
            .alert(isPresented: $loginAlert) {
                Alert(title: Text("로그인 실패"), message: Text("아이디 또는 비밀번호가 일치하지 않습니다!"), dismissButton: .default(Text("확인"))) }
        }
        .navigationTitle("로그인")
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
        .onAppear {
            
            if let token = UserDefaults.standard.string(forKey: "token") {
                do { try AF.request("http://dodam.b1nd.com/api/v2//members/my", method: .get, encoding: URLEncoding.default, headers: ["x-access-token": token]).responseData { response in
                    if JSON(response.data!)["status"].int == 200 { homeScreen.toggle() } else { UserDefaults.standard.removeObject(forKey: "token")}} } catch { }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

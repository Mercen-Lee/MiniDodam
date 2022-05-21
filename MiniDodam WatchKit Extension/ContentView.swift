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
import RealmSwift

extension Color {
    static let primaryColor = Color(red: 0, green: 80/255, blue: 182/255)
    static let secondaryColor = Color(red: 100/255, green: 160/255, blue: 217/255)
}

struct ContentView: View {
    
    @State var id: String = ""
    @State var pw: String = ""
    
    var body: some View {
        
        VStack{
            
            Text("미니도담").font(.system(size: 25).bold())
            
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
                }
                
            }.background(Color.primaryColor.cornerRadius(21))
        }
        .navigationTitle("로그인")
        
        .onAppear {
            
            if let token = UserDefaults.standard.string(forKey: "token") {
                
                AF.request("http://dodam.b1nd.com/api/v2//members/my", method: .get, encoding: URLEncoding.default, headers: ["x-access-token": token]).responseData { response in
                    
                    if JSON(response.data!)["response"] == 200 {
                        
                        let name = JSON(response.data!)["data"]["memberData"]["name"].string
                        HomeView(token: token, name: name) } }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

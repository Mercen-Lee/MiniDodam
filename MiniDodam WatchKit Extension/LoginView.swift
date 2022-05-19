//
//  LoginView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/18.
//

import SwiftUI
import CryptoKit
import Alamofire

struct LoginView: View {
    @State var id: String = ""
    @State var pw: String = ""
    var body: some View {
        VStack{
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
            do { try request.httpBody = JSONSerialization.data(withJSONObject: params, options: []) } catch { print("Error") }
            AF.request(request)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let asJSON = try JSONSerialization.jsonObject(with: data)
                            print(asJSON)
                        } catch { print("Error") }
                    case .failure(_): break
                    }
                }
        }.background(Color.primaryColor.cornerRadius(21))
        }
        .navigationTitle("로그인")
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

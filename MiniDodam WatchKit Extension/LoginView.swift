//
//  LoginView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/18.
//

import SwiftUI
import CryptoKit
import Alamofire

struct Post: Codable {
  let id: String
  let pw: String
}

struct LoginView: View {
    @State var id: String = ""
    @State var pw: String = ""
    var body: some View {
        VStack{
        TextField("아이디 입력", text: $id)
        SecureField("비밀번호 입력", text: $pw)
        Button("로그인") {
            let original = pw
            let data = original.data(using: .utf8)
            let sha512 = SHA512.hash(data: data!)
            let shaData = sha512.compactMap{String(format: "%02x", $0)}.joined()
            guard let uploadData = try? JSONEncoder().encode(Post(id: id, pw: shaData))
            else {return}
            
            let url = URL(string: "http://auth.dodam.b1nd.com/auth/login")
            
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"

            let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in

                if let e = error {
                    NSLog("An error has occured: \(e.localizedDescription)")
                    return
                }
                DispatchQueue.main.async() {
                    let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                    print("result: \(outputStr!)")
                }
            }
            task.resume()

        }.background(Color.primaryColor.cornerRadius(100))
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

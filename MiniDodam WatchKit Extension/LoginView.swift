//
//  LoginView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/18.
//

import SwiftUI

func Login(id: String, pw: String) {
    guard let uploadData = try? JSONEncoder().encode(id)
    else {return}

    let url = URL(string: "http://auth.dodam.b1nd.com/auth/login")

    var request = URLRequest(url: url!)
    request.httpMethod = "POST"

    let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in

        if let e = error {
            NSLog("An error has occured: \(e.localizedDescription)")
            return
        }
    }
    task.resume()
}

struct LoginView: View {
    @State var id: String = ""
    @State var pw: String = ""
    var body: some View {
        VStack{
        Text("도담도담").font(.system(size: 25).bold())
        TextField("아이디 입력", text: $id)
        SecureField("비밀번호 입력", text: $pw)
        Button("로그인") { Login(id: id, pw: pw) }.background(Color.primaryColor.cornerRadius(100))
        }.navigationTitle("로그인")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

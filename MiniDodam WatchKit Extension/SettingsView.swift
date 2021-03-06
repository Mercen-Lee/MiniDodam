//
//  SettingsView.swift
//  MiniDodam WatchKit Extension
//
//  Created by Mercen on 2022/05/16.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Button("로그아웃") {
                UserDefaults.standard.removeObject(forKey: "token")
                exit(0) }
            NavigationLink("상벌점 확인", destination: PointView())
            NavigationLink("기본위치 변경", destination: LocationView())
            NavigationLink("앱 정보", destination: InformationView())
        }.navigationTitle("설정")
    }
}
struct PointView: View {
    var body: some View {
        VStack{
            
        }
    }
}
struct LocationView: View {
    var body: some View {
        VStack{
            
        }
    }
}
struct InformationView: View {
    var body: some View {
        VStack{
            Text("MiniDodam v0.1").font(.system(size: 20).bold())
            Text("Developed by Mercen Lee").font(.system(size: 10))
        }
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

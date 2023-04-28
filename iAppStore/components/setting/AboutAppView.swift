//
//  AboutAppView.swift
//  iAppStore
//
//  Created by HTC on 2022/1/1.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct AboutAppView: View {
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let appSubVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    
    var body: some View {
        ScrollView {
            Spacer().frame(height: 50)
            Image("iAppStore_icon")
                .resizable()
                .frame(maxWidth: 90)
                .frame(maxHeight: 90)
                .cornerRadius(15)
                .padding(.bottom, 10)
            Text("iAppStore").fontWeight(.bold).padding(.bottom, 5)
            Text("v \(appVersion ?? "") (\(appSubVersion ?? ""))").font(.footnote).foregroundColor(.gray).padding(.bottom, 10)
            Text("iAppStore 是一款使用 SwiftUI 打造的苹果商店工具类 App。").padding([.leading, .trailing], 20).padding(.bottom, 5)
            Text("1、提供苹果实时榜单查询，包含 iOS 和 iPad 的热门免费榜、热门付费榜、畅销榜，还有新上架榜、新上架免费榜、新上架付费榜等。\n2、提供查询 app 详细页面内容、搜索 app、订阅 app 状态等功能。\n3、支持苹果所有国家和地区的商店，无需切换 Apple Id，即可查看！")
                .font(.footnote)
                .padding([.leading, .trailing], 20).padding(.bottom, 10)
            
            Spacer()
            Text("由 **37手游iOS‮术技‬运营团队** 发起的开源项目。")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .padding(.top, 30)
            
            Text(.init("GitHub: https://github.com/37iOS/iAppStore-SwiftUI"))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .font(.footnote)
                .padding(.top, 10)
                .padding(.bottom, 30)
        }
        .navigationTitle("关于 iAppStore")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}

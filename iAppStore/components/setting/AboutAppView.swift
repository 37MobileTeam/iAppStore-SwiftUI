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
            Image("iAppStroe_icon").cornerRadius(15).padding(.bottom, 10)
            Text("iAppStroe").fontWeight(.bold).padding(.bottom, 5)
            Text("v \(appVersion ?? "") (\(appSubVersion ?? ""))").font(.footnote).foregroundColor(.gray).padding(.bottom, 10)
            Text("iAppStroe 是一款使用 SwiftUI 打造的苹果商店工具类 App。").padding([.leading, .trailing], 20).padding(.bottom, 10)
            Text("1、提供苹果实时榜单查询，包含 iOS 和 iPad 的热门免费榜、热门付费榜、畅销榜，还有新上架榜、新上架免费榜、新上架付费榜等。\n2、提供查询 app 详细页面内容、搜索 app、订阅 app 状态等功能。\n3、支持苹果所有国家和地区的商店，无需切换 Apple Id，即可查看！")
                .font(.footnote)
                .padding([.leading, .trailing], 20).padding(.bottom, 10)
            
            Spacer()
        }
        .navigationTitle("关于 iAppStroe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}

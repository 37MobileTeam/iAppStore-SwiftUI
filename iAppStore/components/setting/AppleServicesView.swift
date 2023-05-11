//
//  AppleServicesView.swift
//  iAppStore
//
//  Created by HTC on 2023/4/28.
//  Copyright © 2023 37 Mobile Games. All rights reserved.
//

import SwiftUI
import SafariServices

struct AppleServicesView: View {
    
    @State private var linkPage: LinkItem? = nil
    private let apples: [String: String] = [
        "Apple 中国大陆官网": "https://www.apple.com.cn",
        "Apple Newsroom": "https://www.apple.com.cn/newsroom/",
        "App Store Connect": "https://appstoreconnect.apple.com/",
        "Apple Developer": "https://developer.apple.com/",
        "Apple News and Updates": "https://www.apple.com/news/",
        "Apple 新闻及更新": "https://www.apple.com/cn/news/",
        "App Store Review Guidelines": "https://developer.apple.com/app-store/review/guidelines/",
        "App Store 审核指南": "https://developer.apple.com/cn/app-store/review/guidelines/",
        "Apple Services Status - US": "https://www.apple.com/support/systemstatus/",
        "Apple Services Status - CN": "https://www.apple.com/cn/support/systemstatus/",
        "Apple System Status - Developer": "https://developer.apple.com/system-status/",
        "Apple 安全性更新": "https://support.apple.com/zh-cn/HT201222",
        "iOS & iPadOS Release Notes": "https://developer.apple.com/documentation/ios-ipados-release-notes",
        "Xcode Release": "https://developer.apple.com/documentation/xcode-release-notes",
        "iOS & iPadOS 普及率": "https://developer.apple.com/support/app-store/",
        "Software Downloads": "https://developer.apple.com/download/",
        "App Store Connect 帮助": "https://help.apple.com/app-store-connect/",
        "iOS 16 更新": "https://www.apple.com/ios/ios-16/",
        "iPadOS 16 更新": "https://www.apple.com/ipados/ipados-16/",
        "macOS 13 更新": "https://www.apple.com/macos/macos-13/",
        "识别你的 iPhone 机型": "https://support.apple.com/zh-cn/HT201296",
        "识别你的 iPad 机型": "https://support.apple.com/zh-cn/HT201471",
        "识别 iPod 机型": "https://support.apple.com/zh-cn/HT204217",
        "识别 MacBook 机型": "https://support.apple.com/zh-cn/HT201608",
        "识别 MacBook Air 机型": "https://support.apple.com/zh-cn/HT201862",
        "识别 MacBook Pro 机型": "https://support.apple.com/zh-cn/HT201300",
        "识别 Mac mini 机型": "https://support.apple.com/zh-cn/HT201894",
        "识别 Mac Studio 机型": "https://support.apple.com/zh-cn/HT212366",
        "识别 Mac Pro 机型": "https://support.apple.com/zh-cn/HT201805",
        "识别你的 iMac 机型": "https://support.apple.com/zh-cn/HT201634",
        "识别你的 Apple Watch": "https://support.apple.com/zh-cn/HT204507",
        "识别你的 AirPods": "https://support.apple.com/zh-cn/HT207010",
        "识别你的 HomePod": "https://support.apple.com/zh-cn/HT208244",
        "识别你的 Apple TV": "https://support.apple.com/zh-cn/HT200008"
    ]

    var body: some View {
        List(apples.keys.sorted(), id: \.self) { title in
            
            Button(action: {
                linkPage = LinkItem(url: apples[title]!)
            }) {
                HStack {
                    Text(title).foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right").imageScale(.small).foregroundColor(Color.tsmg_placeholderText)
                }
                .padding([.top, .bottom], 10)
            }
        }
        .sheet(item: $linkPage) { link in
            SafariView(url: URL(string: link.url)!)
        }
        .navigationTitle("苹果常用网站")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct LinkItem: Identifiable {
    let id = UUID()
    let url: String
}

struct AppleServicesView_Previews: PreviewProvider {
    static var previews: some View {
        AppleServicesView()
    }
}

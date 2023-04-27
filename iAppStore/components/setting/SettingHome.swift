//
//  SettingHome.swift
//  iAppStore
//
//  Created by HTC on 2021/12/15.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import SwiftUI
import SafariServices


struct LinkString: Identifiable {
    let url: String
    var id: String { url } // or let id = UUID()
}

struct SettingHome: View {
    
    private let items = ["切换图标", "AppStore", "蝉应用", "点点数据", "七麦数据"]
    private let apples = ["Apple 中国大陆官网", "Apple Newsroom", "App Store Connect", "Apple Developer", "Apple News and Updates", "Apple 新闻及更新", "App Store Review Guidelines", "App Store 审核指南", "Apple Services Status - US", "Apple Services Status - CN", "Apple System Status", "Apple 安全性更新", "iOS & iPadOS Release Notes", "Xcode Release", "iOS & iPadOS 普及率", "Software Downloads", "App Store Connect 帮助", "iOS 16 更新", "iPadOS 16 更新", "macOS 13 更新", "识别你的 iPhone 机型", "识别你的 iPad 机型", "识别 iPod 机型", "识别 MacBook 机型", "识别 MacBook Air 机型", "识别 MacBook Pro 机型", "识别 Mac mini 机型", "识别 Mac Studio 机型", "识别 Mac Pro 机型", "识别你的 iMac 机型", "识别你的 Apple Watch", "识别你的 AirPods", "识别你的 HomePod", "识别你的 Apple TV"]
    
    @State private var linkPage: LinkString? = nil
    
    var body: some View {
        NavigationView {
            Group {
                List {
                    Section(header: Text("功能")) {
                        ForEach(items, id: \.self) { title in
                            SettingItemCell(linkPage: $linkPage, title: title, index: items.firstIndex(of: title)!)
                        }
                    }
                    
                    Section(header: Text("关于")) {
                        NavigationLink(destination: AboutAppView()) {
                            Text("关于应用").frame(height: 50)
                        }
                        SettingItemCell(linkPage: $linkPage, title: "GitHub 开源", index: items.count)
                        SettingItemCell(linkPage: $linkPage, title: "37手游iOS技术运营团队", index: items.count + 1)
                    }
                    
                    Section(header: Text("苹果服务")) {
                        ForEach(apples, id: \.self) { title in
                            let index = items.count + 2 + apples.firstIndex(of: title)!
                            SettingItemCell(linkPage: $linkPage, title: title, index: index)
                        }
                    }
                }
            }
            .navigationBarTitle("设置")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .sheet(item: $linkPage, content: { linkPage in
            SafariView(url: URL(string: linkPage.url)!)
        })
    }
}


struct SettingItemCell: View {
    
    @Binding var linkPage: LinkString?
    var title: String
    var index: Int
    @State private var iconViewIsExpanded: Bool = false
    @State private var icons: [String] = ["iAppStore", "AppStore", "AppStoreNew", "AppStoreWhite", "37", "37iOS", "37AppStore", "Apple", "AppleRainbow"]
    
    var body: some View {
    
        if index == 0 {
            DisclosureGroup(title, isExpanded: $iconViewIsExpanded) {
                ForEach(0..<icons.count, id: \.self) { index in
                    let type = icons[index]
                    VStack{
                        HStack {
                            Image(type + "_icon")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .cornerRadius(15)
                                .padding(.leading, 5)
                            
                            Text((index == 0 ? "默认" : type) + "图标").padding(.leading, 15)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right").imageScale(.small).foregroundColor(Color.tsmg_placeholderText).padding(.trailing, 10)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                        UIApplication.shared.setAlternateIconName(index == 0 ? nil : type)
                        
                        withAnimation{
                            iconViewIsExpanded = false
                        }
                    }
                }
            }
            .padding([.top, .bottom], 10)
            .accentColor(Color.tsmg_placeholderText)
        } else {
            
            HStack {
                Button(action: {
                    switch index {
                    case 0:
                        break
                    case 1:
                        let url = URL(string: "itms-apps://itunes.apple.com")
                        UIApplication.shared.open(url!)
                    case 2:
                        linkPage = LinkString(url: "https://app.chandashi.com")
                    case 3:
                        linkPage = LinkString(url: "https://app.diandian.com")
                    case 4:
                        linkPage = LinkString(url: "https://www.qimai.cn")
                    case 5:
                        linkPage = LinkString(url: "https://github.com/37iOS/iAppStore-SwiftUI")
                    case 6:
                        linkPage = LinkString(url: "https://juejin.cn/user/1002387318511214")
                    case 7:
                        linkPage = LinkString(url: "https://www.apple.com.cn")
                    case 8:
                        linkPage = LinkString(url: "https://www.apple.com.cn/newsroom/")
                    case 9:
                        linkPage = LinkString(url: "https://appstoreconnect.apple.com")
                    case 10:
                        linkPage = LinkString(url: "https://developer.apple.com")
                    case 11:
                        linkPage = LinkString(url: "https://developer.apple.com/news/")
                    case 12:
                        linkPage = LinkString(url: "https://developer.apple.com/cn/news/")
                    case 13:
                        linkPage = LinkString(url: "https://developer.apple.com/app-store/review/guidelines/")
                    case 14:
                        linkPage = LinkString(url: "https://developer.apple.com/cn/app-store/review/guidelines/")
                    case 15:
                        linkPage = LinkString(url: "https://www.apple.com/support/systemstatus/")
                    case 16:
                        linkPage = LinkString(url: "https://www.apple.com/cn/support/systemstatus/")
                    case 17:
                        linkPage = LinkString(url: "https://developer.apple.com/system-status/")
                    case 18:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT201222")
                    case 19:
                        linkPage = LinkString(url: "https://developer.apple.com/documentation/ios-ipados-release-notes")
                    case 20:
                        linkPage = LinkString(url: "https://developer.apple.com/cn/support/xcode/")
                    case 21:
                        linkPage = LinkString(url: "https://developer.apple.com/cn/support/app-store/")
                    case 22:
                        linkPage = LinkString(url: "https://developer.apple.com/download/")
                    case 23:
                        linkPage = LinkString(url: "https://developer.apple.com/cn/help/app-store-connect/")
                    case 24:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT213407")
                    case 25:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT213408")
                    case 26:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT213268")
                    case 27:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT201296")
                    case 28:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT201471")
                    case 29:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT204217")
                    case 30:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT201608")
                    case 31:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT201862")
                    case 32:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT201300")
                    case 33:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT201894")
                    case 34:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT213073")
                    case 35:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT202888")
                    case 36:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT201634")
                    case 37:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT204507")
                    case 38:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT209580")
                    case 39:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT211109")
                    case 40:
                        linkPage = LinkString(url: "https://support.apple.com/zh-cn/HT200008")
                    default: break
                    }
                }) {
                    Text(title).foregroundColor(Color.tsmg_label)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right").imageScale(.small).foregroundColor(Color.tsmg_placeholderText)
            }
            .padding([.top, .bottom], 10)
        }
    }
}



// MARK: -  SafariView
struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let sf = SFSafariViewController(url: url)
        sf.dismissButtonStyle = .close
        return sf
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}


struct SettingHome_Previews: PreviewProvider {
    static var previews: some View {
        SettingHome()
    }
}

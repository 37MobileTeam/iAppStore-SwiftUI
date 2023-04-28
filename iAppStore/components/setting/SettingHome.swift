//
//  SettingHome.swift
//  iAppStore
//
//  Created by HTC on 2021/12/15.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import SwiftUI
import StoreKit

struct LinkString: Identifiable {
    let url: String
    var id: String { url } // or let id = UUID()
}

struct SettingHome: View {
    
    @State private var linkPage: LinkString? = nil
    private let items = ["切换图标", "AppStore", "蝉应用", "点点数据", "七麦数据"]
    
    var body: some View {
        NavigationView {
            Group {
                List {
                    Section(header: Text("功能")) {
                        ForEach(items, id: \.self) { title in
                            SettingItemCell(linkPage: $linkPage, title: title, index: items.firstIndex(of: title)!)
                        }
                    }
                    
                    Section(header: Text("苹果服务")) {
                        NavigationLink(destination: AppleServicesView()) {
                            HStack {
                                Text("苹果常用网站")
                                Spacer()
                            }
                            .padding([.top, .bottom], 10)
                        }
                        AppleSubscriptionManagerView(linkPage: $linkPage)
                    }
                    
                    Section(header: Text("关于")) {
                        NavigationLink(destination: AboutAppView()) {
                            Text("关于应用").frame(height: 50)
                        }
                        SettingItemCell(linkPage: $linkPage, title: "GitHub 开源", index: items.count)
                        SettingItemCell(linkPage: $linkPage, title: "37手游iOS技术运营团队", index: items.count + 1)
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

struct AppleSubscriptionManagerView: View {
    
    @Binding var linkPage: LinkString?
    private let subscriptionsURL = "https://apps.apple.com/account/subscriptions"
    
    var body: some View {
        HStack {
            Button(action: {
//                if #available(iOS 15.0, *) {
//                    Task {
//                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                            do {
//
//                                try await AppStore.showManageSubscriptions(in: windowScene)
//
//                            } catch {
//                                linkPage = LinkString(url: subscriptionsURL)
//                            }
//                        }
//                    }
//                } else {
                    linkPage = LinkString(url: subscriptionsURL)
//                }
            }) {
                Text("苹果订阅管理").foregroundColor(Color.primary)
            }
            Spacer()
            Image(systemName: "chevron.right").imageScale(.small).foregroundColor(Color.secondary)
        }
        .padding([.top, .bottom], 10)
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

struct SettingHome_Previews: PreviewProvider {
    static var previews: some View {
        SettingHome()
    }
}

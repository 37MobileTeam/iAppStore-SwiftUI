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
    
    private let items = ["切换图标", "AppStore", "蝉大师", "点点数据", "七麦数据"]
    
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
    @State private var icons: [String] = ["", "37", "37iOS", "37AppStore", "Apple", "AppleRainbow"]
    
    var body: some View {
    
        if index == 0 {
            DisclosureGroup(title, isExpanded: $iconViewIsExpanded) {
                ForEach(0..<icons.count){ index in
                    let type = icons[index]
                    VStack{
                        HStack {
                            Image(type.count > 0 ? type + "_icon" : "iAppStroe_icon")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 65, height: 65)
                                .cornerRadius(15)
                                .padding(.bottom, 10)
                                .padding(.leading, 5)
                            
                            Text((type.count > 0 ? type : "默认") + "图标").padding(.leading, 15)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right").imageScale(.small).foregroundColor(Color.tsmg_placeholderText).padding(.trailing, 10)
                        }
                    }
                    .background(Color.tsmg_systemBackground)
                    .onTapGesture {
                        
                        UIApplication.shared.setAlternateIconName(type.count > 0 ? type : nil)
                        
                        withAnimation{
                            iconViewIsExpanded = false
                        }
                    }
                }
            }.accentColor(Color.tsmg_placeholderText)
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
                        linkPage = LinkString(url: "https://www.chandashi.com")
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

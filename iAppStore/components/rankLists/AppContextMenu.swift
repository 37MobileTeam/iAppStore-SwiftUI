//
//  AppContextMenu.swift
//  iAppStore
//
//  Created by iHTCboy on 2022/1/9.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct AppContextMenu: View {
    
    let appleID: String?
    let bundleID: String?
    let appUrl: String?
    
    var body: some View {
        VStack {
            if appleID != nil {
                CreateMenuItem(text: "复制 App ID", imgName: "doc.on.doc") {
                    appleID!.copyToClipboard()
                }
            }
            
            if bundleID != nil {
                CreateMenuItem(text: "复制 App 包名", imgName: "doc.on.doc.fill") {
                    bundleID!.copyToClipboard()
                }
            }
            
            if appUrl != nil {
                CreateMenuItem(text: "复制 App 商店链接", imgName: "link") {
                    appUrl!.copyToClipboard()
                }
                
                CreateMenuItem(text: "从 App Store 打开", imgName: "square.and.arrow.up") {
                    if let url = URL(string: appUrl!) {
                        UIApplication.shared.open(url)
                    }
                }
            }
        }
    }
    
    
    func CreateMenuItem(text: String, imgName: String, onAction: (() -> Void)?) -> some View {
        Button(action: {
            onAction?()
        }) {
            HStack {
                Text(text)
                Image(systemName: imgName)
                    .imageScale(.small)
                    .foregroundColor(.primary)
            }
        }
    }
}




struct AppContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        AppContextMenu(appleID: "123456", bundleID: "iAppStore", appUrl: "https://juejin.cn/user/1002387318511214")
    }
}

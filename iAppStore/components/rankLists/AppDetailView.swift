//
//  AppDetailView.swift
//  iAppStore
//
//  Created by HTC on 2021/12/17.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct AppDetailView: View {
    
    var appId: String
    var regionName: String
    var item: AppRank?
    
    @StateObject private var appModel = AppDetailModel()
    @State private var isShowingQRCode = false
    @State private var isAppFavorites = false
    
    var body: some View {
        
        Group {
            AppDetailContentView(appModel: appModel)
        }
        .navigationBarTitle(item?.imName.label ?? appModel.app?.trackName ?? "", displayMode: .large)
        .navigationBarBackButtonHidden(false)
        .navigationBarItems(trailing: HStack(spacing: 5) {
            Button(action: handleFavoriteButton) {
                if isAppFavorites {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                }
            }
            Button(action: {
                isShowingQRCode = true
            }) {
                Image(systemName: "qrcode")
            }
            Link(destination: URL(string: appModel.app?.trackViewUrl ?? item?.id.label ?? "https://apple.com")!) {
                Image(systemName: "icloud.and.arrow.down").font(.subheadline)
            }
        })
        .sheet(isPresented: $isShowingQRCode) {
            QRCodeView(title: "扫一扫下载", subTitle: "App Store 上的“\(item?.imName.label ?? "")”", qrCodeContent: item?.id.label ?? "error", isShowingQRCode: $isShowingQRCode)
        }
        .onAppear {
            isAppFavorites = AppFavoritesModel.shared.search(appId) != nil
            if appModel.app == nil {
                appModel.searchAppData(appId, nil, regionName)
            }
        }
    }
    
    // 处理收藏按钮的动作
    func handleFavoriteButton() {
        if isAppFavorites {
            AppFavoritesModel.shared.remove(appId: appId)
        } else {
            AppFavoritesModel.shared.add(AppFavorite(appId: appId, regionName: regionName))
        }
        isAppFavorites.toggle()
    }
}


struct AppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AppDetailView(appId: "1669437212", regionName: "中国")
        }
    }
}

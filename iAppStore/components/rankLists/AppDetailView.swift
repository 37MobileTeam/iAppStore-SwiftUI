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
    
    var body: some View {
        
        Group {
            AppDetailContentView(appModel: appModel)
        }
        .navigationBarTitle(item?.imName.label ?? appModel.app?.trackName ?? "", displayMode: .large)
        .navigationBarBackButtonHidden(false)
        .navigationBarItems(trailing:
            Link(destination: URL(string: appModel.app?.trackViewUrl ?? item?.id.label ?? "https://apple.com")!) {
                Image(systemName: "icloud.and.arrow.down").font(.subheadline)
            Button(action: {
                        isShowingQRCode = true
                    }) {
                        Image(systemName: "qrcode")
                            .font(.subheadline)
                    }
        })
        .sheet(isPresented: $isShowingQRCode) {
            QRCodeView(title: "扫一扫下载", subTitle: "App Store 上的“\(item?.imName.label ?? "")”", qrCodeContent: item?.id.label ?? "error", isShowingQRCode: $isShowingQRCode)
        }
        .onAppear {
            if appModel.app == nil {
                appModel.searchAppData(appId, nil, regionName)
            }
        }
    }
}


struct AppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailView(appId: "1669437212", regionName: "中国")
    }
}

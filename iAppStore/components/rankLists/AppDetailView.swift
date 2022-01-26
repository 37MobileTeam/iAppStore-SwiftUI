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
    
//    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Group {
            AppDetailContentView(appModel: appModel)
        }
        .navigationBarTitle(item?.imName.label ?? appModel.app?.trackName ?? "", displayMode: .large)
        .navigationBarBackButtonHidden(false)
//        .navigationBarItems(leading:
//            Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                    HStack {
//                        Image(systemName: "chevron.backward")
//                    }
//            })
        .navigationBarItems(trailing:
            Link(destination: URL(string: appModel.app?.trackViewUrl ?? item?.id.label ?? "https://apple.com")!) {
                Image(systemName: "paperplane").font(.subheadline)
        })
        .onAppear {
            if appModel.app == nil {
                appModel.searchAppData(appId, nil, regionName)
            }
        }
    }
}




//struct AppDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppDetailView()
//    }
//}

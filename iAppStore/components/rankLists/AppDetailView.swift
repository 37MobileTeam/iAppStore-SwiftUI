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
        NavigationView {
            Group {
                AppDetailContentView(appModel: appModel)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Link(destination: URL(string: appModel.app?.trackViewUrl ?? item?.id.label ?? "https://apple.com")!) {
                        Image(systemName: "link.circle.fill").font(.subheadline)
                        Text("App Store")
                    }
                }
            }
        }
        .navigationBarTitle(item?.imName.label ?? appModel.app?.trackName ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
//        .navigationBarItems(leading:
//            Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                    HStack {
//                        Image(systemName: "chevron.backward")
//                    }
//            })
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

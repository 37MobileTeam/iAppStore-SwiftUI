//
//  RankHome.swift
//  iAppStore
//
//  Created by HTC on 2021/12/15.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct RankHome: View {
    
    @AppStorage("kRankTypeName") private var rankName: String = "热门免费榜"
    @AppStorage("kRankCategoryName") private var categoryName: String = "所有 App"
    @AppStorage("kRankRegionName") private var regionName: String = "中国"
    @StateObject private var appRankModel = AppRankModel()
    
    //@State private var isSettingPresented = false
    
    var body: some View {
        NavigationView {
            Group {
                Text(appRankModel.rankUpdated).font(.footnote)
                
                RankSortView(rankName: $rankName, categoryName: $categoryName, regionName: $regionName) { rankName, categoryName, regionName in
                    appRankModel.fetchRankData(rankName, categoryName, regionName)
                }
                
                
                if appRankModel.results.count == 0 {
                    VStack() {
                        Spacer()
                        Image(systemName: "tray.and.arrow.down")
                            .font(Font.system(size: 60))
                            .foregroundColor(Color.tsmg_tertiaryLabel)
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(appRankModel.results, id: \.imName.label) { item in
                            let index = appRankModel.results.firstIndex { $0.imName.label == item.imName.label }
                            NavigationLink(destination: AppDetailView(appId: item.id.attributes.imID, regionName: regionName, item: item)) {
                                RankCellView(index: index ?? 0, item: item).frame(height: 110)
                            }
                        }
                    }
                }
                
            }
            .navigationBarTitle(appRankModel.rankTitle, displayMode: .inline)
            .navigationBarItems(trailing:
                                    HStack {
//                                        filterButton
                                    })
            //.sheet(isPresented: $isSettingPresented, content: { RankFilterForm() })
        }.onAppear {
            
            if appRankModel.results.count == 0 {
                appRankModel.fetchRankData(rankName, categoryName, regionName)
            }
        }
    }
    
//    private var filterButton: some View {
//        Button(action: {
//            self.isSettingPresented = true
//        }) {
//            HStack {
//                Image(systemName: "line.3.horizontal.decrease.circle").imageScale(.medium)
//            }.frame(width: 30, height: 30)
//        }
//    }
}


//struct RankHome_Previews: PreviewProvider {
//    static var previews: some View {
//        RankHome()
//    }
//}

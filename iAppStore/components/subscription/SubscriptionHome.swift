//
//  SubscriptionHome.swift
//  iAppStore
//
//  Created by HTC on 2021/12/15.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct SubscriptionHome: View {
    
    @State private var isAddPresented: Bool = false
    @StateObject private var subModel = AppSubscripeModel.shared
    
    var body: some View {
        NavigationView {
            Group {
                if subModel.subscripes.count == 0 {
                    Spacer()
                    Image(systemName: "tray")
                        .font(Font.system(size: 60))
                        .foregroundColor(Color.tsmg_tertiaryLabel)
                } else {
                    List {
                        ForEach(subModel.subscripes, id: \.startTimeStamp) { item in
                            
                            let index = subModel.subscripes.firstIndex { $0.startTimeStamp == item.startTimeStamp }
                            NavigationLink(destination: AppDetailView(appId: String(item.appId), regionName: item.regionName, item: nil)) {
                                
                                SubscripteCellView(index: index ?? 0, item: item, app: subModel.apps[item.appId])
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle("订阅 App 状态")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing:
                                    HStack {
                                        addButton
                                    })
            .sheet(isPresented: $isAddPresented, content: {
                SubscriptionAddView(isAddPresented: $isAddPresented, subModel: subModel)
            })
        }
    }
    
    private var addButton: some View {
        Button(action: {
            isAddPresented = true
        }) {
            HStack {
                Image(systemName: "plus.circle").imageScale(.large)
            }.frame(height: 40)
        }
    }
}



struct SubscripteCellView: View {
    var index: Int
    var item: AppSubscripe
    var app: AppDetail?
    
    var body: some View {
        HStack {
            ImageLoaderView(
                url: app?.artworkUrl100 ?? "http://itunes.apple.com/favicon.ico",
                placeholder: {
                    Image("icon_placeholder")
                        .resizable()
                        .renderingMode(.original)
                        .cornerRadius(15)
                        .frame(width: 75, height: 75)
                },
                image: {
                    $0.resizable()
                        .renderingMode(.original)
                        .cornerRadius(15)
                        .frame(width: 75, height: 75)
                }
            )
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        
                        Text(app?.trackName ?? "")
                            .foregroundColor(.tsmg_secondaryLabel)
                            .font(.headline)
                            .lineLimit(2)
                            .truncationMode(.tail)
                        
                        Group {
                        switch item.subscripeType {
                        case 0:
                            Text(item.isFinished ? "新版本已生效" : "订阅类型：版本更新")
                        case 1:
                            Text(item.isFinished ? "应用已上架" : "订阅类型：应用上架")
                        case 2:
                            Text(item.isFinished ? "应用已下架" : "订阅类型：应用下架")
                        default:
                            Text("")
                        }
                        }
                        .font(.subheadline)
                        .foregroundColor(.pink)
                        .padding([.top, .bottom], 2)
                        
                        Group {
                            Text("App ID：\(item.appId)")
                            Text("地区：\(item.regionName)")
                        }
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 1)
                        
                        // 新应用上架
                        if item.subscripeType != 1 {
                            Text("当前版本：v\(item.currentVersion)").font(.footnote).padding(.bottom, 5)
                        }
                        
                        if item.isFinished {
                            Text("结束时间：\(item.finishTime)")
                                .lineLimit(2)
                                .font(.footnote)
                                .foregroundColor(.green)
                                .padding(.bottom, 8)
                        } else {
                            Text("状态未生效，最后检查时间：\(item.finishTime)")
                                .lineLimit(2)
                                .font(.footnote)
                                .foregroundColor(.blue)
                                .padding(.bottom, 5)
                        }
                    }
                }
            }.padding(.leading, 10)
        }
    }
}

  
struct SubscriptionHome_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionHome()
    }
}

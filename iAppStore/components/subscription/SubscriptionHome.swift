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
    @StateObject private var subscripeVM = AppSubscripeModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if subscripeVM.subscripes.count == 0 {
                    Spacer()
                    emptyImage
                } else {
                    subscripeListView
                }
                Spacer()
            }
            .navigationBarTitle("订阅 App 状态")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing: addButton )
            .sheet(isPresented: $isAddPresented, content: {
                SubscriptionAddView(
                    isAddPresented: $isAddPresented,
                    subscripeVM: subscripeVM
                )
            })
        }
    }
    
    private var emptyImage: some View {
        Image(systemName: "tray")
            .font(Font.system(size: 60))
            .foregroundColor(Color.tsmg_tertiaryLabel)
    }
    
    private var subscripeListView: some View {
        List {
            ForEach(subscripeVM.subscripes, id: \.startTimeStamp) { item in
                NavigationLink(
                    destination: AppDetailView(appId: String(item.appId), regionName: item.regionName, item: nil)
                ) {
                    SubscripteCellView(item: item)
                }
            }
            .onDelete { indexSet in
                subscripeVM.removeAt(indexSet: indexSet)
            }
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
    var item: AppSubscripe
    
    var body: some View {
        HStack {
            ImageLoaderView(
                url: item.artworkURL100,
                placeholder: {
                    Image("icon_placeholder")
                        .resizable()
                        .renderingMode(.original)
                        .cornerRadius(17)
                        .frame(width: 75, height: 75)
                },
                image: {
                    $0.resizable()
                        .renderingMode(.original)
                        .cornerRadius(17)
                        .frame(width: 75, height: 75)
                }
            )
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        
                        Text(item.trackName)
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

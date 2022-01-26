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
    
    var body: some View {
        NavigationView {
            Group {
                ZStack(alignment: .top) {
                    
                    if appRankModel.results.count == 0 {
                        VStack() {
                            Spacer()
                            Image(systemName: "tray.and.arrow.down")
                                .font(Font.system(size: 60))
                                .foregroundColor(Color.tsmg_tertiaryLabel)
                            Spacer()
                        }
                    } else {
                        
                        VStack() {
                            
                            List {
                                ForEach(appRankModel.results, id: \.imName.label) { item in
                                    let index = appRankModel.results.firstIndex { $0.imName.label == item.imName.label }
                                    NavigationLink(destination: AppDetailView(appId: item.id.attributes.imID, regionName: regionName, item: item)) {
                                        RankCellView(index: index ?? 0, item: item).frame(height: 110)
                                    }
                                }
                            }.padding(.top, 75)
                        }
                    }
                    
                    stickyHeaderView
                }.background(Color.clear)
                
            }
            .navigationBarTitle(appRankModel.rankTitle, displayMode: .inline)
            
        }.onAppear {
            
            if appRankModel.results.count == 0 {
                appRankModel.fetchRankData(rankName, categoryName, regionName)
            }
        }
    }
    
    /// 筛选栏
    var stickyHeaderView: some View {
        ZStack(alignment: .top) {
            
//            VStack {
//                BlurView(style: .light).frame(height: 75)
//                Spacer()
//            }
            
            VStack {
                Spacer().frame(height: 10)

                Text(appRankModel.rankUpdated).font(.footnote)

                RankSortView(rankName: $rankName, categoryName: $categoryName, regionName: $regionName) { rankName, categoryName, regionName in
                    appRankModel.fetchRankData(rankName, categoryName, regionName)
                }.background(Color.clear)

                Spacer()
            }
        }
    }
}

//struct BlurView: UIViewRepresentable {
//
//    let style: UIBlurEffect.Style
//
//    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .clear
//        let blurEffect = UIBlurEffect(style: style)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        view.insertSubview(blurView, at: 0)
//        NSLayoutConstraint.activate([
//            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
//            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
//        ])
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView,
//                      context: UIViewRepresentableContext<BlurView>) {
//
//    }
//}

//struct RankHome_Previews: PreviewProvider {
//    static var previews: some View {
//        RankHome()
//    }
//}

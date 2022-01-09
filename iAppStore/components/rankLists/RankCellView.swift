//
//  RankCellView.swift
//  iAppStore
//
//  Created by HTC on 2021/12/17.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct RankCellView: View {
    
    var index: Int
    var item: AppRank
    
    var body: some View {
        HStack {
            
            ImageLoaderView(
                url: item.imImage.last?.label,
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
                    
                    Text("\(index + 1)")
                        .font(.system(size: 16, weight: .heavy, design: .default))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                    
                    VStack(alignment: .leading) {
                        
                        Text(item.imName.label)
                            .foregroundColor(.tsmg_blue)
                            .font(.headline)
                            .lineLimit(2)
                            .truncationMode(.tail)
                        
                        Spacer().frame(height: 5)
                        
                        Text(item.summary?.label.replacingOccurrences(of: "\n", with: "") ?? item.rights?.label ?? "")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                            .lineLimit(2)
                            .truncationMode(.tail)
                        
                        Spacer().frame(height: 10)
                        
                        HStack {
                            Text(item.category.attributes.label).font(.footnote)
                            
                            if item.imPrice.attributes.amount != "0.00" {
                                Text("\(item.imPrice.attributes.currency) \(item.imPrice.attributes.amount)").font(.footnote).foregroundColor(.pink)
                            }
                        }.frame(height: 10)
                        
                        Text(item.imArtist.label).font(.footnote).lineLimit(1).foregroundColor(.gray)
                        
                    }
                }
            }
        }
        .contextMenu { AppContextMenu(appleID: item.id.attributes.imID, bundleID: item.id.attributes.imBundleID, appUrl: item.id.label) }
    }
}

//struct RankCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        RankCellView(index: <#T##Int#>, item: <#T##AppRank#>)
//    }
//}

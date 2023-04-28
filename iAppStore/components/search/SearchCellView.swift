//
//  SearchCellView.swift
//  iAppStore
//
//  Created by HTC on 2021/12/25.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct SearchCellView: View {
    
    var index: Int
    var item: AppDetail
    @State @AppStorage("kIsShowAppDataSize") private var isShowAppDataSize = false
    
    var body: some View {
        HStack {
            
            ImageLoaderView(
                url: item.artworkUrl100,
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
                    
                    Text("\(index + 1)")
                        .font(.system(size: 16, weight: .heavy, design: .default))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                    
                    VStack(alignment: .leading) {
                        
                        Text(item.trackName)
                            .foregroundColor(.tsmg_blue)
                            .font(.headline)
                            .lineLimit(2)
                            .truncationMode(.tail)
                        
                        Spacer().frame(height: 5)
                        
                        if isShowAppDataSize {
                            Text("占用大小：\(item.fileSizeMB)").font(.footnote).lineLimit(1).foregroundColor(.gray)
                            Text("最低支持系统：\(item.minimumOsVersion)").font(.footnote).lineLimit(1).foregroundColor(.gray)
                        } else {
                            Text(item.description.replacingOccurrences(of: "\n", with: ""))
                                .foregroundColor(.secondary)
                                .font(.footnote)
                                .lineLimit(2)
                                .truncationMode(.tail)
                        }
                        
                        Spacer().frame(height: 10)
                        
                        HStack {
                            Text((item.genres).joined(separator: ",")).font(.footnote)
                            
                            if item.price != 0.0 {
                                Text(item.formattedPrice ?? "-").font(.footnote).foregroundColor(.pink)
                            }
                        }.frame(height: 10)
                        
                        Text(item.artistName).font(.footnote).lineLimit(1).foregroundColor(.gray)
                        
                    }
                }
            }
        }
        .contextMenu { AppContextMenu(appleID: String(item.trackId), bundleID: item.bundleId, appUrl: item.trackViewUrl, developerUrl: item.artistViewUrl) }
    }
}



//struct SearchCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchCellView(index: 0, item: AppDetail(advisories: <#T##[String]?#>, appletvScreenshotUrls: <#T##[String]?#>, artistId: <#T##Int#>, artistName: <#T##String#>, artistViewUrl: <#T##String?#>, artworkUrl100: <#T##String#>, artworkUrl512: <#T##String#>, artworkUrl60: <#T##String#>, averageUserRating: <#T##Float#>, averageUserRatingForCurrentVersion: <#T##Float#>, bundleId: <#T##String#>, contentAdvisoryRating: <#T##String#>, currency: <#T##String#>, currentVersionReleaseDate: <#T##String#>, description: <#T##String#>, features: <#T##[String]#>, fileSizeBytes: <#T##String#>, formattedPrice: <#T##String?#>, genreIds: <#T##[String]#>, genres: <#T##[String]#>, ipadScreenshotUrls: <#T##[String]?#>, isGameCenterEnabled: <#T##Bool#>, isVppDeviceBasedLicensingEnabled: <#T##Bool#>, kind: <#T##String#>, languageCodesISO2A: <#T##[String]#>, minimumOsVersion: <#T##String#>, price: <#T##Double?#>, primaryGenreId: <#T##Int#>, primaryGenreName: <#T##String#>, releaseDate: <#T##String#>, releaseNotes: <#T##String?#>, screenshotUrls: <#T##[String]?#>, sellerName: <#T##String#>, sellerUrl: <#T##String?#>, supportedDevices: <#T##[String]#>, trackCensoredName: <#T##String#>, trackContentRating: <#T##String#>, trackId: <#T##Int#>, trackName: <#T##String#>, trackViewUrl: <#T##String#>, userRatingCount: <#T##Int#>, userRatingCountForCurrentVersion: <#T##Int#>, version: <#T##String#>, wrapperType: <#T##String#>))
//    }
//}

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


struct SearchCellView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellView(index: 0,
                       item: AppDetail(
                        advisories: ["偶尔/轻微的成人或性暗示题材", "偶尔/轻微的色情内容或裸露", "频繁/强烈的竞赛", "偶尔/轻微的亵渎或低俗幽默", "赌博", "偶尔/轻微的卡通或幻想暴力", "偶尔/轻微的惊悚或恐怖题材"],
                        appletvScreenshotUrls: [],
                        artistId: 1170416082,
                        artistName: "Beijing Microlive Vision Technology Co., Ltd",
                        artistViewUrl: "https://apps.apple.com/cn/developer/id1170416082",
                        artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/7a/08/16/7a081643-510b-acdb-d84b-088f8d877d8b/AppIcon-0-0-1x_U007emarketing-0-0-0-6-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.jpg",
                        artworkUrl512: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/7a/08/16/7a081643-510b-acdb-d84b-088f8d877d8b/AppIcon-0-0-1x_U007emarketing-0-0-0-6-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/512x512bb.jpg",
                        artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/7a/08/16/7a081643-510b-acdb-d84b-088f8d877d8b/AppIcon-0-0-1x_U007emarketing-0-0-0-6-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg",
                        averageUserRating: 4.88,
                        averageUserRatingForCurrentVersion: 4.88,
                        bundleId: "com.ss.iphone.ugc.Aweme",
                        contentAdvisoryRating: "17+",
                        currency: "CNY",
                        currentVersionReleaseDate: "2023-05-04T09:57:32Z",
                        description: "抖音是一个帮助用户表达自我，记录美好生活的短视频平台。\n\n● 记录美好在抖音\n智能匹配音乐、一键卡点视频，还有超多原创特效、滤镜、场景切换帮你一秒变大片，让你的生活轻松记录在抖音！\n● 实用内容在抖音\n生活妙招、美食做法、旅行攻略、科技知识、新闻时事、同城资讯，你需要的实用内容都在抖音！\n● 各行各业在抖音\n原创音乐人、京剧演员、非遗传承人、烧烤摊老板、快递小哥等，每个人真实的生活都在抖音！\n\n全民记录自我，生活的美好都在这里！",
                        features: ["iosUniversal"],
                        fileSizeBytes: "489774080",
                        formattedPrice: "免费",
                        genreIds: ["6016"],
                        genres: ["娱乐"],
                        ipadScreenshotUrls: [
                            "https://is4-ssl.mzstatic.com/image/thumb/Purple126/v4/10/4a/c0/104ac064-a13a-735a-ac7e-31a9a8be4c94/539c76eb-f80d-41e4-804e-ff2b366f5925_d40e52455be74f44b5e61e54777e4241.jpeg/552x414bb.jpg",
                            "https://is2-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/b2/a7/dc/b2a7dc31-6caa-f4f5-582b-be4f0c625493/31a3e47b-94a9-4c17-8f00-e3bb3c44a6bf_eb631323700b461ea4ce005400628e0d.png/552x414bb.png"],
                        isGameCenterEnabled: false,
                        isVppDeviceBasedLicensingEnabled: true,
                        kind: "software",
                        languageCodesISO2A: ["EN", "ZH"],
                        minimumOsVersion: "11.0",
                        price: 0.00,
                        primaryGenreId: 6016,
                        primaryGenreName: "Entertainment",
                        releaseDate: "2016-09-26T03:28:56Z",
                        releaseNotes: "运用全新的功能，让使用更加安全便捷",
                        screenshotUrls: ["https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/7d/82/93/7d8293e9-795f-5500-eefc-27dc035f70d1/d8e59776-5c71-4d6e-bf7d-c093486df192_b8da317377c04a2b8c2b1f8c9b290603.png/392x696bb.png","https://is5-ssl.mzstatic.com/image/thumb/Purple126/v4/85/9e/d5/859ed5ee-069e-d3ad-c3f5-8962486ce554/9b590a24-b7b3-4c71-a48c-3a65d263db11_796abc123df44955afae0b597f59abea.png/392x696bb.png"],
                        sellerName: "Beijing Microlive Vision Technology Co., Ltd",
                        sellerUrl: nil,
                        supportedDevices: ["iPhone5s-iPhone5s", "iPadAir-iPadAir", "..."],
                        trackCensoredName: "抖音",
                        trackContentRating: "17+",
                        trackId: 1142110895,
                        trackName: "抖音",
                        trackViewUrl: "https://apps.apple.com/cn/app/id1142110895",
                        userRatingCount: 46105612,
                        userRatingCountForCurrentVersion: 46105612,
                        version: "24.8.0",
                        wrapperType: "software"))
    }
}

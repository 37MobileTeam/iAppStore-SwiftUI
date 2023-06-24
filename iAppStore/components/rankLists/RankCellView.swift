//
//  RankCellView.swift
//  iAppStore
//
//  Created by HTC on 2021/12/17.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct RankCellView: View {
    
    let index: Int
    let regionName: String
    let item: AppRank
    
    @StateObject private var appModel = AppDetailModel()
    @State @AppStorage("kIsShowAppDataSize") private var isShowAppDataSize = false
    
    var body: some View {
        HStack {
            
            ImageLoaderView(
                url: item.imImage.last?.label,
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
                        
                        Text(item.imName.label)
                            .foregroundColor(.tsmg_blue)
                            .font(.headline)
                            .lineLimit(2)
                            .truncationMode(.tail)
                        
                        Spacer().frame(height: 5)
                        
                        if isShowAppDataSize {
                            Text("占用大小：\(appModel.app?.fileSizeMB ?? "")").font(.footnote).lineLimit(1).foregroundColor(.gray)
                            Text("最低支持系统：\(appModel.app?.minimumOsVersion ?? "")").font(.footnote).lineLimit(1).foregroundColor(.gray)
                        } else {
                            Text(item.summary?.label.replacingOccurrences(of: "\n", with: "") ?? item.rights?.label ?? "")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                                .lineLimit(2)
                                .truncationMode(.tail)
                        }
                        
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
        .contextMenu { AppContextMenu(appleID: item.id.attributes.imID, bundleID: item.id.attributes.imBundleID, appUrl: item.id.label, developerUrl: item.imArtist.attributes?.href) }
        .onAppear {
            if isShowAppDataSize && appModel.app == nil {
                appModel.searchAppData(item.id.attributes.imID, nil, regionName)
            }
        }
    }
}

struct RankCellView_Previews: PreviewProvider {
    static var previews: some View {
        RankCellView(index: 0,
                     regionName: "中国",
                     item: AppRank(
                        category: Category(attributes: CategoryAttributes(imID: "6014", label: "游戏", scheme: "https://apps.apple.com/cn/genre/ios/id6014", term: "Games")),
                        id: ID(attributes: IDAttributes(imBundleID: "com.sy.frxxz", imID: "1669437212"), label: "https://apps.apple.com/cn/app/69437212"),
                        imArtist: IMArtist(attributes: IMArtistAttributes(href: "https://apps.apple.com/cn/developer/id1652830936"), label: "Anhui Leihu Network Technology Co., Ltd."),
                        imContentType: IMContentType(attributes: IMContentTypeAttributes(label: "Application", term: "程序")),
                        imImage: [IMImage(attributes: IMImageAttributes(height: "75"), label: "https://is4-ssl.mzstatic.com/image/thumb/Purple116/v4/d4/bc/9f/d4bc9fb3-fee8-d718-7e09-0a1d12e36c74/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/75x75bb.png")],
                        imName: Title(label: "凡人修仙传：人界篇-正版授权"),
                        imPrice: IMPrice(attributes: IMPriceAttributes(amount: "0.00", currency: "CNY"), label: "获取"),
                        imReleaseDate: IMReleaseDate(attributes: Title(label: "2023年05月23日"), label: "2023-05-23T00:00:00-07:00"),
                        summary: Title(label: "道法万千 ，皆可成仙！原著正版授权，无数凡人用户十年期待，2023年度3D国风修仙MMO手游巨作《凡人修仙传：人界篇》已然上线，诚邀道友一同在修仙大世界御剑飞仙！\r\n\r\n【仙界奇闻】\r\n本游戏由李连杰先生代言，接引各位道友；\r\n本游戏主题曲《凡非凡》由胡彦斌先生献唱；\r\n登陆即可领取仙界接引礼包（青竹蜂云剑、绝版称号助力修仙之旅）！\r\n\r\n\r\n【仙界特色】\r\n——由凡入仙 谱写凡人新篇章 ——\r\n岂闻韶华尽何年，回首沧桑，此恨绵绵，风月如剑，看我破天。道不尽仙凡殊途，尽人间！\r\n带你沉浸式体验道祖韩立修仙旅途，原著各大经典宗门任君选择，近百个记忆中的人物、法宝法器、名场面悉数呈现。\r\n\r\n—— 道法万千 自由搭配其乐无穷 ——\r\n创新海量功法设定，流派不同道法各异。剑、法、魔、体四系功法各有千秋，技能组合策略多变，进阶套路由你定义！可以根据个人不同仙缘、选择，成就属于你的无上大道，扬名立万，开宗立派！\r\n\r\n——自由探索 新修仙体验——\r\n若说无缘，三千大千世界，十万菩提众生，怎么单单与你想见？\r\n修仙绝不止修仙，除了打坐修炼破境界、渡劫飞升御心魔，还能呼朋引伴勇闯试炼，游历四方寻奇遇，更能收集法宝御灵宠、采集灵草炼灵丹！修仙人手艺在这里全面展现，多方位提升你的实力，凡人到仙人虽路途漫漫，也能自在成仙！\r\n\r\n——次世代品质 新视听感受——\r\n采用3D国风美术铺开立体丰满、宏大华丽的凡人大世界，人、灵、仙三界活灵活现，这是一场逍遥天地间的东方浪漫奇想之约，希望与你共赴沉醉其间！\r\n\r\n诚邀各位道友关注官方公众号【凡人修仙传人界篇】，即可获取仙界最新动态、最新八卦，最全的仙缘福利尽在掌握！"),
                        rights: Title(label: "© Anhui Leihu Network Technology Co., Ltd."),
                        title: Title(label: "凡人修仙传：人界篇-正版授权 - Anhui Leihu Network Technology Co., Ltd.")
                     )
        )
    }
}

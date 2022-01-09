//
//  AppDetailContentView.swift
//  iAppStore
//
//  Created by HTC on 2021/12/23.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import SwiftUI

enum AppDetailAlertType: Identifiable {
    case copyBundleId
    
    var id: Int { hashValue }
}

struct AppDetailContentView: View {
    
    @StateObject var appModel = AppDetailModel()
    
    @State private var alertType: AppDetailAlertType?

    var body: some View {
        
        if appModel.app == nil {
            Rectangle()
                .overlay(Color.tsmg_systemGroupedBackground)
                .cornerRadius(20)
                .padding(.all)
                .animation(.easeInOut)
                .transition(.opacity)
        } else {
            
            ScrollView {
                // Header Section
                AppDetailHeaderView(appModel: appModel, alertType: $alertType)
                
                // ScreenShot View
                AppDetailScreenShowView(appModel: appModel)
                
                // Content View
                AppDetailContentSectionView(appModel: appModel)
                
                // Footer Section
                AppDetailFooterView(appModel: appModel)
            }
            .alert(item: $alertType) { type in
                switch type {
                case .copyBundleId:
                    appModel.app?.bundleId.copyToClipboard()
                    return Alert(title: Text("提示"), message: Text("包名内容复制成功！"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}


// MARK:  - Header Section
struct AppDetailHeaderView: View {
    
    @StateObject var appModel: AppDetailModel
    @Binding var alertType: AppDetailAlertType?
    
    var body: some View {
        ZStack {
            ImageLoaderView(
                url: appModel.app?.artworkUrl100,
                placeholder: {},
                image: {
                    $0.resizable()
                        .blur(radius: 50, opaque: true)
                        .overlay(Color.black.opacity(0.25))
                        .animation(.easeInOut)
                        .transition(.opacity)
                }
            )
            
            if appModel.app == nil {
                Rectangle().foregroundColor(.white).padding(.all).animation(.easeInOut).transition(.opacity)
            }
            
            HStack(alignment: .top) {
                
                VStack(alignment: .center) {
                    
                    ImageLoaderView(
                        url: appModel.app?.artworkUrl512,
                        placeholder: {
                            Image("icon_placeholder")
                                .resizable()
                                .renderingMode(.original)
                                .cornerRadius(20)
                                .frame(width: 100, height: 100)
                        },
                        image: {
                            $0.resizable()
                                .renderingMode(.original)
                                .cornerRadius(20)
                                .frame(width: 100, height: 100)
                        }
                    )
                    
                    Spacer().frame(height: 15)
                    
                    Text("v\(appModel.app?.version ?? "")")
                        .foregroundColor(Color.tsmg_systemBackground)
                    
                    Spacer()
                    
                    Text(appModel.app?.averageRating ?? "")
                        .foregroundColor(Color.tsmg_systemBackground)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("满分5分").font(.footnote).foregroundColor(.tsmg_systemBackground.opacity(0.5)).fontWeight(.heavy)
                    
                    Spacer()
                }
                
                Spacer().frame(width: 20)
                
                VStack(alignment: .leading) {
                    AppDetailTextView(key: "价格", value: appModel.app?.formattedPrice ?? "")
                    AppDetailTextView(key: "分级", value: appModel.app?.contentAdvisoryRating ?? "")
                    AppDetailTextView(key: "分类", value: (appModel.app?.genres ?? []).joined(separator: ","))
                    AppDetailTextView(key: "App ID", value: String(appModel.app?.trackId ?? 0))
                    
                    HStack {
                        Text("包名").font(.subheadline)
                        if #available(iOS 15.0, *) {
                            Button(appModel.app?.bundleId ?? "") {
                                alertType = .copyBundleId
                            }.buttonStyle(.bordered)
                        } else {
                            Button(appModel.app?.bundleId ?? "") {
                                alertType = .copyBundleId
                            }
                        }
                    }
                    
                    AppDetailTextView(key: "开发者", value: appModel.app?.artistName ?? "")
                    AppDetailTextView(key: "上架时间", value: appModel.app?.releaseTime ?? "")
                    
                }.foregroundColor(Color.tsmg_systemBackground)
                
                Spacer()
                
            }.padding([.leading, .trailing], 12).padding([.top, .bottom], 18)
            
        }.frame(alignment: .top)
    }
}


// MARK: - AppDetailTextView
struct AppDetailTextView: View {
    
    var key: String
    var value: String
    
    var body: some View {
        HStack {
            Text(key).font(.subheadline)
            Text(value).font(.subheadline).fontWeight(.bold)
        }.padding(1)
    }
}

// MARK: - AppDetailScreenShowView
struct AppDetailScreenShowView: View {
    
    @StateObject var appModel: AppDetailModel
    @State private var extendiPadShot: Bool = false
    
    var body: some View {
        
        HStack {
            Text("预览").font(.title3).fontWeight(.bold).padding([.top, .leading], 12)
            Spacer()
        }
        
        VStack(alignment: .leading) {
            
            if appModel.app != nil && appModel.app!.isSupportiPhone {
                
                AppDetailScreenShotView(screenshotUrls: appModel.app?.screenshotUrls, imageWidth: 200)
                
                HStack {
                    Image(systemName: "iphone").foregroundColor(.gray).font(.body)
                    if appModel.app!.isSupportiPad && !extendiPadShot {
                        Image(systemName: "ipad").foregroundColor(.gray).font(.body)
                        Text("iPhone 和 iPad App").foregroundColor(.gray).font(.footnote).fontWeight(.medium)
                        Spacer()
                        Image(systemName: "chevron.down").foregroundColor(.gray).font(.body)
                    } else {
                        Text("iPhone").foregroundColor(.gray).font(.footnote).fontWeight(.medium)
                        Spacer()
                    }
                }
                .background(Color.tsmg_systemBackground)
                .padding([.leading, .trailing], 12)
                .padding([.top, .bottom], 10)
                .onTapGesture {
                    if appModel.app!.isSupportiPad {
                        extendiPadShot = true
                    }
                }
            }
        }.padding(.bottom, 5)
        
        VStack(alignment: .leading) {
            if (appModel.app != nil && extendiPadShot)
                || (appModel.app != nil && !appModel.app!.isSupportiPhone && appModel.app!.isSupportiPad)
            {
                AppDetailScreenShotView(screenshotUrls: appModel.app?.ipadScreenshotUrls, imageWidth: 300)
                
                HStack {
                    Image(systemName: "ipad").foregroundColor(.gray).font(.body)
                    Text("iPad").foregroundColor(.gray).font(.footnote).fontWeight(.medium)
                    Spacer()
                }
                .padding([.leading, .trailing], 12)
                .padding([.top, .bottom], 10)
            }
        }.padding(.bottom, 5)
        
        Divider().padding(.bottom, 12).padding([.leading, .trailing], 10)
    }
}



struct AppDetailScreenShotView: View {
    
    var screenshotUrls: [String]?
    var imageWidth: CGFloat = 200
    @State private var selectedShot: Bool = false
    @State private var selectedImgUrl: String?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack() {
                ForEach(0..<(screenshotUrls ?? [String]()).count) { index in
                    let url = screenshotUrls![index]
                    Button(action: {
                        selectedImgUrl = url.imageAppleScale()
                        selectedShot = true
                    }) {
                        
                        ImageLoaderView(
                            url: url.imageAppleScale(),
                            placeholder: {
                                Image("icon_placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(11)
                                    .frame(width: imageWidth)
                            },
                            image: {
                                $0.resizable()
                                    .scaledToFit()
                                    .cornerRadius(11)
                                    .overlay(RoundedRectangle(cornerRadius: 11).stroke(Color.gray, lineWidth: 0.1))
                                    .frame(width: imageWidth)
                            }
                        )
                    }
                    .padding([.leading, .trailing], 3)
                    .sheet(isPresented: $selectedShot) {
                        
                    } content: {
                        AppDetailBigImageShowView(selectedShot: $selectedShot, selectedImgUrl: $selectedImgUrl)
                    }
                }
            }
        }.padding([.leading, .trailing], 8)
    }
}

struct AppDetailBigImageShowView: View {
    
    @Binding var selectedShot: Bool
    @Binding var selectedImgUrl: String?
    @State var showSheet = false
    @State private var shareImage: UIImage?
    
    var body: some View {
        HStack {
            Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "square.and.arrow.up").imageScale(.large)
            }
            .frame(width: 60, height: 60, alignment: .center)
            .padding([.top, .leading], 8)
            .sheet(isPresented: $showSheet) {
                // Warn: a temporary solution
                if let data = NSData(contentsOf: URL(string: selectedImgUrl!)!),
                   let img = UIImage(data: data as Data) {
                    ShareSheet(items: [img])
                }
            }
            
            Spacer()
            
            Button {
                selectedShot = false
            } label: {
                Image(systemName: "xmark.circle").imageScale(.large)
            }
            .frame(width: 60, height: 60, alignment: .center)
            .padding([.top, .trailing], 8)
        }
        
        Spacer()
        
        ImageLoaderView(
            url: selectedImgUrl,
            placeholder: {
                Image("icon_placeholder")
                    .resizable()
                    .scaledToFit()
            },
            image: {
                $0.resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.1))
            },
            completion: { img in
                DispatchQueue.main.async{
                    shareImage = img
                }
                
            }
        ).padding([.leading, .trailing], 5)
        
        Spacer()
    }
}

// MARK: - Content View
struct AppDetailContentSectionView: View {
    
    @StateObject var appModel: AppDetailModel
    @State private var isShowAllContent: Bool = false
    @State private var isShowUpdateContent: Bool = false
    
    var body: some View {
        
        // Content Section
        ZStack(alignment: .bottomTrailing) {
            
            HStack{
                Text(isShowAllContent ? appModel.app?.description ?? "" : appModel.app?.description.replacingOccurrences(of: "\n", with: "") ?? "")
                    .font(.subheadline)
                    .lineLimit(isShowAllContent ? .max : 3)
                Spacer()
            }
            
            if isShowAllContent == false {
                Button("更多") {
                    isShowAllContent = true
                }
                .font(.subheadline)
                .foregroundColor(Color.blue)
                .background(Color.tsmg_systemBackground)
                .offset(x: 5, y: 0)
                .shadow(color: .tsmg_systemBackground.opacity(0.9), radius: 3, x: -12)
            }
        }
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 12)
        
        HStack {
            VStack(alignment: .leading) {
                Text(appModel.app?.artistName ?? "").foregroundColor(Color.blue).font(.subheadline)
                Spacer().frame(height: 5)
                Text("开发者").font(.footnote).foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.gray).font(.body)
        }
        .background(Color.tsmg_systemBackground)
        .padding(12)
        .onTapGesture {
            if let url = URL(string: appModel.app?.artistViewUrl ?? "") {
                UIApplication.shared.open(url)
            }
        }
        
        Divider().padding(.bottom, 15).padding([.leading, .trailing], 10)
        
        HStack {
            Text("新功能").font(.title3).fontWeight(.bold).padding(.leading, 12)
            Spacer()
        }
        
        HStack {
            Text("版本 \(appModel.app?.version ?? "")").foregroundColor(.gray).font(.subheadline).padding(.leading, 12)
            Spacer()
            Text(appModel.app?.currentVersionReleaseTime ?? "").foregroundColor(.gray).font(.subheadline).padding(.trailing, 12)
        }.padding(.top, 10)
        
        ZStack(alignment: .bottomTrailing) {
            HStack {
                Text(isShowUpdateContent ? appModel.app?.releaseNotes ?? "" : appModel.app?.releaseNotes?.replacingOccurrences(of: "\n", with: "") ?? "")
                    .font(.subheadline)
                    .lineLimit(isShowUpdateContent ? .max : 3)
                Spacer()
            }
            
            if isShowUpdateContent == false {
                Button("更多") {
                    isShowUpdateContent = true
                }
                .font(.subheadline)
                .foregroundColor(Color.blue)
                .background(Color.tsmg_systemBackground)
                .offset(x: 5, y: 0)
                .shadow(color: .tsmg_systemBackground.opacity(0.9), radius: 3, x: -12)
            }
        }
        .padding([.leading, .trailing], 12)
        .padding(.bottom, 10)
        
        Divider().padding(.bottom, 15).padding([.leading, .trailing], 10)
    }
}



// MARK: - Footer View
struct AppDetailFooterView: View {
    
    @StateObject var appModel: AppDetailModel
    
    var body: some View {
        
        HStack {
            Text("信息").font(.title3).fontWeight(.bold).padding([.top, .leading], 12)
            Spacer()
        }
        
        Group {
            AppDetailFooterCellView(name: "评分", description: appModel.app?.averageRating ?? "")
            AppDetailFooterCellView(name: "评论", description: String(appModel.app?.userRatingCount ?? 0) + "条")
            AppDetailFooterCellView(name: "占用大小", description: appModel.app?.fileSizeMB ?? "")
            AppDetailFooterCellView(name: "最低支持系统", description: appModel.app?.minimumOsVersion ?? "")
            AppDetailFooterCellView(name: "类别", description: (appModel.app?.genres ?? []).joined(separator: "、"))
            AppDetailFooterCellView(name: "供应商", description: appModel.app?.sellerName ?? "", extendText: appModel.app?.artistName ?? "")
        }
        
        Group {
            AppDetailFooterCellView(name: "兼容性", description: "\(appModel.app?.supportedDevices.count ?? 0)种", extendText: (appModel.app?.supportedDevices ?? []).joined(separator: "\n"))
            AppDetailFooterCellView(name: "支持语言", description: "\(appModel.app?.languageCodesISO2A.count ?? 0)种", extendText: (appModel.app?.languageCodesISO2A ?? []).joined(separator: "、"))
            AppDetailFooterCellView(name: "年龄分级", description: appModel.app?.contentAdvisoryRating ?? "", extendText: (appModel.app?.advisories ?? []).joined(separator: "\n"))
            AppDetailFooterCellView(name: "更新时间", description: appModel.app?.currentVersionReleaseTime ?? "")
            AppDetailFooterCellView(name: "上架时间", description: appModel.app?.releaseTime ?? "")
        }
        
        Spacer().frame(height: 30)
    }
    
}




// MARK: - AppDetailTextView
struct AppDetailFooterCellView: View {
    
    var name: String
    var description: String
    var extendText: String?
    @State private var isShowExtendText = false
    
    var body: some View {
        
        Group {
            if extendText == nil {
                HStack {
                    Text(name).font(.subheadline).foregroundColor(.gray)
                    Spacer()
                    Text(description).font(.subheadline)
                }
            } else {
                if isShowExtendText {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(name).font(.subheadline).foregroundColor(.gray)
                            Text(description).font(.subheadline)
                            if extendText != nil && description != extendText {
                                Text(extendText ?? "").font(.subheadline)
                            }
                        }
                        Spacer()
                    }
                } else {
                    HStack {
                        Text(name).font(.subheadline).foregroundColor(.gray)
                        Spacer()
                        Text(description).font(.subheadline)
                        Image(systemName: "chevron.down").foregroundColor(.gray).font(.body)
                    }
                    .background(Color.tsmg_systemBackground)
                    .onTapGesture {
                        isShowExtendText = true
                    }
                }
            }
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 12)

        Divider().padding(.top, 5).padding([.leading, .trailing], 10)
    }
}


struct AppDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailContentView()
    }
}

//
//  SearchHome.swift
//  iAppStore
//
//  Created by HTC on 2021/12/15.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import SwiftUI


struct SearchHome: View {
    
    @State private var isSearching = false
    @State private var searchText = ""
    @AppStorage("kSearchRegionName") private var regionName: String = "中国"
    @State private var filterViewIsExpanded = false
    @StateObject private var appModel = AppDetailModel()
    
    var body: some View {
        NavigationView {
            Group {
                SearchBarView(searchText: $searchText, regionName: $regionName, appModel: appModel).padding([.leading, .trailing], 12)
                
                ZStack {
                    
                    List {
                        ForEach(appModel.results, id: \.trackId) { item in
                            let index = appModel.results.firstIndex { $0.trackId == item.trackId }
                            NavigationLink(destination: AppDetailView(appId: String(item.trackId), regionName: regionName, item: nil)) {
                                SearchCellView(index: index ?? 0, item: item).frame(height: 110)
                            }
                        }
                    }
                    
                    if searchText.count == 0 && appModel.results.count == 0 {
                        
                        Image(systemName: "tray.full")
                            .font(Font.system(size: 60))
                            .foregroundColor(Color.tsmg_tertiaryLabel)
                    }
                    
                    if filterViewIsExpanded {
                        SearchFilterView(searchText: $searchText, regionName: $regionName, filterViewIsExpanded: $filterViewIsExpanded, appModel: appModel)
                    }
                }
            }
            .navigationBarTitle("搜索")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing:
                                    HStack {
                                        filterButton
                                    })
        }
//        if #available(iOS 15.0, *) {
//            .searchable(text: $searchText, placement: .toolbar, prompt: "游戏、App 等", suggestions: {
//                Text("🍎").searchCompletion("apple")
//                Text("🍐").searchCompletion("pear")
//                Text("🍌").searchCompletion("banana")
//            }).onSubmit(of: .search) {
//                print(searchText)
//            }
//        }
    }
    
    private var filterButton: some View {
        Button(action: {
            filterViewIsExpanded.toggle()
        }) {
            HStack {
                Image(systemName: "line.3.horizontal.decrease.circle").imageScale(.medium)
                Text(regionName)
            }.frame(height: 30)
        }
    }
}

// MARK: - SearchBarView
struct SearchBarView: View {
    
    @Binding var searchText: String
    @Binding var regionName: String
    @StateObject var appModel: AppDetailModel
    @State private var isSearching = false
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading){
                Rectangle().foregroundColor(.tsmg_tertiarySystemGroupedBackground).cornerRadius(10).frame(height: 40)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    
                    let serachBar = TextField("游戏、App 等", text: $searchText,  onEditingChanged: changedSearch, onCommit: fetchSearch)
                        .textFieldStyle(.plain)
                    
                    if #available(iOS 15.0, *) {
                        serachBar.submitLabel(.search)
                    } else {
                        serachBar
                    }
                    
                    if searchText.count > 0 {
                        Button(action: clearSearch) {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .padding(.trailing, 5)
                        .foregroundColor(.gray)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            if searchText.count > 0 {
                Button(action: cancelSearch) {
                    Text("取消").foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    func changedSearch(isEditing: Bool) {
        //debugPrint(isEditing)
    }
    
    func fetchSearch() {
        debugPrint(searchText)
        appModel.searchAppData(nil, searchText, regionName)
    }
    
    func clearSearch() {
        searchText = ""
    }
    
    func cancelSearch() {
        searchText = ""
        appModel.results = []
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


// MARK: - Filter View
struct SearchFilterView: View {
    
    @Binding var searchText: String
    @Binding var regionName: String
    @Binding var filterViewIsExpanded: Bool
    @StateObject var appModel: AppDetailModel
    
    var body: some View {
        VStack {
            Divider()
            
            ScrollView {
                ForEach(0..<TSMGConstants.regionTypeLists.count, id: \.self){index in
                    HStack{
                        let type = TSMGConstants.regionTypeLists[index]
                        if type == regionName {
                            Text(type).padding(.horizontal).padding(.top, 10).foregroundColor(.blue)
                        } else {
                            Text(type).padding(.horizontal).padding(.top, 10)
                        }
                        Spacer()
                        if type == regionName {
                            Image(systemName: "checkmark").padding(.horizontal).padding(.top, 10).foregroundColor(.blue)
                        }
                    }
                    .background(Color.tsmg_systemBackground)
                    .onTapGesture {
                        // 点击筛选条件
                        let type = TSMGConstants.regionTypeLists[index]
                        if searchText.count > 0 && type != regionName {
                            appModel.searchAppData(nil, searchText, type)
                        }
                        
                        withAnimation{
                            regionName = type
                            filterViewIsExpanded = false
                        }
                        
                    }
                }
            }
            .background(Color.tsmg_systemBackground)
            .frame(maxHeight: 300).offset(y: -8)
            
            Spacer()
        }
    }
}



struct SearchHome_Previews: PreviewProvider {
    static var previews: some View {
        SearchHome()
    }
}

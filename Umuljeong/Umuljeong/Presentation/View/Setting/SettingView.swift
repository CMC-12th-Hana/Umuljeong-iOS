//
//  SettingView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI

struct SettingView: View {
    @Binding var showSetting:Bool
    
    var menu:[SettingModel] = [SettingModel(name: "업무분류 카테고리명 변경", imageName: "seperate", view: AnyView(ChangeWorkCategoryView())), SettingModel(name: "비밀번호 변경", imageName: "password", view: AnyView(ChangePasswordView())), SettingModel(name: "로그아웃", imageName: "Logout",view: AnyView(LogoutView())), SettingModel(name: "기업 탈퇴하기", imageName: "reSign", view: AnyView(ResignView())), SettingModel(name: "앱 정보", imageName: "appInfo", view: AnyView(AppInfoView()))]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                List {
                    ForEach(menu) { menu in
                        NavigationLink(destination: menu.view )
                        {
                            HStack (spacing: 20) {
                                Image(menu.imageName)
                                    .frame(width: 32, height: 32)
                                
                                VStack (alignment: .leading, spacing: 5) {
                                    Text(menu.name)
                                        .font(.headline)
                                }
                                Spacer()
                                //
                                //                            VStack {
                                //                                Image("rightErrow")
                                //                            }
                            }
                            .frame(width: 335, height: 60)
                        }
                    }
                    .listRowSeparator(.hidden)
                }//: LIST
            }//:ZStack
            .onAppear{ UINavigationBar
                .appearance().titleTextAttributes = [.font : UIFont(name: "Pretendard-Regular", size: 16)!]}
            .navigationBarTitle(Text("환경설정"), displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
            .navigationBarItems(
                trailing: Button(action: {
                    withAnimation { showSetting.toggle() }
                }, label: {
                    Image("grayX")
                }))
            }
    }
}

struct SettingView_Previews: PreviewProvider {
    @State static var showSetting = false
    static var previews: some View {
        SettingView(showSetting: $showSetting)
    }
}

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
            VStack{
                ForEach(menu) { menu in
                    NavigationLink(destination: menu.view
                        .navigationDesignDefault(title: menu.name)
                    ){
                        SettingCategoryCell(imageName: menu.imageName, name: menu.name)
                            .padding(.horizontal, 14)
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
            .navigationTitleFontDefault(title: "환경설정")
            .navigationAddDividerLine()
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

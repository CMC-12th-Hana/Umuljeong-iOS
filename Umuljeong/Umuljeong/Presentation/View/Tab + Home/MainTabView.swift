//
//  MainTabView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/10.
//

import SwiftUI

struct MainTabView: View {
    //화면 이동
    @State var initPageNumber: Int = 0
    @State var showSetting:Bool = false
    @ObservedObject var calendarViewModel = CalendarViewModel()
    
    var xOffset: CGFloat {
        showSetting ? 0 : -UIScreen.main.bounds.width
    }
    var width: CGFloat {
        UIScreen.main.bounds.width
    }
    var height: CGFloat {
        UIScreen.main.bounds.height
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
            NavigationView {
                ZStack{
    
                TabView(selection: $initPageNumber) {
                    
                    HomeView(selectedTab: $initPageNumber, showSetting: $showSetting, calendarViewModel: calendarViewModel)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("홈")
                        }
                        .tag(0)
                    
                    CompanyListView(selectedTab: $initPageNumber)
                        .tabItem {
                            Image(systemName: "globe")
                            Text("고객관리")
                        }
                        .tag(1)
                    
                    BusinessManageView(selectedTab: $initPageNumber)
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("사업관리")
                        }
                        .tag(2)
                    
                    MemberView(selectedTab: $initPageNumber)
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("구성원")
                        }
                        .tag(3)
                    
                }
                
                
                .overlay(
                    VStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 0.1)
                            .foregroundColor(.gray)
                            .frame(width: width, height: height/4)
                            .shadow(color: Color.gray, radius: 1, x: 0, y: -0.2)
                            .padding(.bottom, -(height/5.4))
                    }
                )
                    
                
                .accentColor(Color("main"))
                .shadow(radius: 20)
                
                
                SettingView(showSetting: $showSetting)
                    .offset(x: showSetting ? 0 : xOffset)
                    .animation(.linear(duration: 0.15), value: showSetting)
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

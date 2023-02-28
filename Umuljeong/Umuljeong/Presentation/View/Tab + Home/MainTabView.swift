//
//  MainTabView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/10.
//

import SwiftUI

struct MainTabView: View {
    //화면 이동
    @State var tabSelection: Tags = .tag1
    @State var showSetting:Bool = false
    @State var showMonthCalendar:Bool = false
    @ObservedObject var viewModel = CalendarViewModel()
    
    var xOffset: CGFloat {
        showSetting ? 0 : -UIScreen.main.bounds.width
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        ZStack{
            NavigationView {
                TabView(selection: $tabSelection) {
                    MainHomeView(calendarViewModel: viewModel, showMonthCalendar: $showMonthCalendar)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("홈")
                        }
                    
                        .tag(Tags.tag1)
                    
                    CustomerView(selectedTab: $tabSelection)
                        .tabItem {
                            Image(systemName: "globe")
                            Text("고객사")
                        }
                        .tag(Tags.tag2)
                    
                    BusinessManageView(selectedTab: $tabSelection)
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("사업관리")
                        }
                        .tag(Tags.tag3)
                    
                    MainEmployeeView(selectedTab: $tabSelection)
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("구성원")
                        }
                        .tag(Tags.tag4)
                    
                }
                .navigationBarItems(
                    leading:
                        Group{
                            if tabSelection == .tag1 {
                                leadingNavigationItem
                            }
                        }
                    ,trailing:
                        Group{
                            if tabSelection == .tag1 {
                                trailingNavigationItem
                            }
                        }
                )
            }
            .transaction { transaction in
                transaction.animation = nil
            }
            
            SettingView(showSetting: $showSetting)
                .offset(x: showSetting ? 0 : xOffset)
                .animation(.linear(duration: 0.15), value: showSetting)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


extension MainTabView {
    
    var leadingNavigationItem: some View {
        HStack {
            Button(action: {
                showSetting.toggle()
            }, label: {
                Image(systemName: "line.3.horizontal")
            })

            HStack {
                Text(viewModel.monthCalendarYearMonth)

                Button(action: {
                    showMonthCalendar.toggle()
                }, label: {
                    Image("downArrow")
                })
            }
        }
    }

    var trailingNavigationItem: some View {
        Button(action: {
        withAnimation { showSetting.toggle() }
        }, label: {
            Image("bellDefault")
        })
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

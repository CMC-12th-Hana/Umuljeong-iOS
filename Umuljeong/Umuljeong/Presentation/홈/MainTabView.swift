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
    @ObservedObject var viewModel = MainTaskViewModel()
    
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
                            ImageBox(rectangleSize: 26, image: tabSelection == .tag1 ? Image("tab11") : Image("tab12"))
                            
                            Text("업무")
                                .font(.body6)
                                .foregroundColor(tabSelection == .tag1 ? Color("main") : Color("font2"))
                        }
                        .tag(Tags.tag1)
                    
                    ClientView(selectedTab: $tabSelection)
                        .tabItem {
                            ImageBox(rectangleSize: 26, image: tabSelection == .tag2 ? Image("tab21") : Image("tab22"))
                            
                            Text("고객사")
                                .font(.body6)
                                .foregroundColor(tabSelection == .tag2 ? Color("main") : Color("font2"))
                        }
                        .tag(Tags.tag2)
                    
                    BusinessView(selectedTab: $tabSelection)
                        .tabItem {
                            ImageBox(rectangleSize: 26, image: tabSelection == .tag3 ? Image("tab31") : Image("tab32"))
                            
                            Text("사업")
                                .font(.body6)
                                .foregroundColor(tabSelection == .tag3 ? Color("main") : Color("font2"))
                        }
                        .tag(Tags.tag3)
                    
                    MainMemberView(selectedTab: $tabSelection)
                        .tabItem {
                            ImageBox(rectangleSize: 26, image: tabSelection == .tag4 ? Image("tab41") : Image("tab42"))
                            
                            Text("구성원")
                                .font(.body6)
                                .foregroundColor(tabSelection == .tag4 ? Color("main") : Color("font2"))
                        }
                        .tag(Tags.tag4)
                    
                }
                
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 3)
                )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
//                .navigationBarItems(
//                    leading:
//                        Group{
//                            if tabSelection == .tag1 {
//                                leadingNavigationItem
//                                    .padding()
//                            }
//                        }
//                    ,trailing:
//                        Group{
//                            if tabSelection == .tag1 {
//                                trailingNavigationItem
//                                    .padding(.trailing, 0)
//                            }
//                        }
//                )
            }
//            .transaction { transaction in
//                transaction.animation = nil
//            }
            
//            SettingView()
//                .offset(x: showSetting ? 0 : xOffset)
//                .animation(.linear(duration: 0.15), value: showSetting)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

//
//extension MainTabView {
//
//    var leadingNavigationItem: some View {
//        HStack {
////            Button(action: {
////                showSetting.toggle()
////            }, label: {
////                Image(systemName: "line.3.horizontal")
////            })
//            Spacer()
//                .frame(width: 28)
//
//            HStack {
//                Text(viewModel.monthCalendarYearMonth)
//                    .font(.customTitle2)
//
//                Button(action: {
//                    showMonthCalendar.toggle()
//                }, label: {
//                    Image("downArrow")
//                })
//            }
//        }
//    }
//
//    var trailingNavigationItem: some View {
//        HStack(spacing: 10) {
//            NavigationLink {
//                AlertSettingView()
//            } label: {
//                ImageBox(rectangleSize: 24, image: Image("bell"))
//            }
//
//            NavigationLink {
//                SettingView()
//            } label: {
//                ImageBox(rectangleSize: 24, image: Image("setting"))
//            }
//        }
//    }
//}


extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

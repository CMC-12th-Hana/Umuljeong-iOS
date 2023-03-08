//
//  MainHomeView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI
import FSCalendar

struct MainHomeView: View {
//    @Binding var selectedTab: Tags //탭바 페이지 이동
    @ObservedObject var viewModel = MainTaskViewModel()
    @State var calendarViewModel: MainTaskViewModel
    @Binding var showMonthCalendar: Bool

    var body: some View {
            VStack(spacing: 0) {
                customNavigationBar
                
                ZStack(alignment: .top) {
                    WeekCalendar(viewModel: calendarViewModel)
                        .frame(height: calendarViewModel.weekCalendarHeight)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 30)
                }
                
                
                ScrollView {
                    TaskListView(isLeader: true, viewModel: $calendarViewModel)
                }
                .background(Color("bg3"))
            }
            .sheet(isPresented: $showMonthCalendar) {
                showCalendarPopup
            }
            .toolbarBackground(Color.white, for: .navigationBar)
    }
}



extension MainHomeView {
    var showCalendarPopup: some View {
        VStack(spacing: 15){
            Spacer()
                .frame(height: 20)
            HStack(spacing: 15) {
                Button {
                    calendarViewModel
                    .tappedButtonPage(isPrev: true)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("leftButton"))
                }
                
                Text(calendarViewModel.monthCalendarYearMonth)
                    .font(.customTitle2)
                
                Button {
                    calendarViewModel.tappedButtonPage(isPrev: false)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("rightArrow"))
                }
            }
            MonthCalendar(viewModel: calendarViewModel)
            .frame(height: 294)
            .padding(.horizontal, 40)
        }
        .frame(height: 328)
        .presentationDetents([.calendarSize])
        .presentationDragIndicator(.hidden)
    }
    
    var customNavigationBar: some View {
        HStack(spacing: 15) {
            HStack {
                Text(viewModel.monthCalendarYearMonth)
                    .font(.customTitle2)
                Button(action: {
                    showMonthCalendar.toggle()
                }, label: {
                    Image("downArrow")
                })
            }
            .padding(.leading, 45)
            
            Spacer()
            
            NavigationLink {
                AlertSettingView()
            } label: {
                ImageBox(rectangleSize: 24, image: Image("bell"))
            }
            
            NavigationLink {
                SettingView()
            } label: {
                ImageBox(rectangleSize: 24, image: Image("setting"))
            }
            .padding(.trailing, 20)
        }
        .frame(height: 61)
    }
        
}

struct MainHomeView_Previews: PreviewProvider {
    @State static var showMonthCalendar:Bool = false
//    @State static var selectedTab = Tags.tag1
//    @State static var showSetting = false
    @StateObject static var calendarViewModel = MainTaskViewModel()
    
    static var previews: some View {
        MainHomeView(calendarViewModel: calendarViewModel, showMonthCalendar: $showMonthCalendar)
    }
}



extension PresentationDetent {
    static let calendarSize = Self.height(328)
}

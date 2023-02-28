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
    @ObservedObject var viewModel = CalendarViewModel()
    @State var calendarViewModel: CalendarViewModel
    @Binding var showMonthCalendar: Bool

    var body: some View {
//        NavigationView{
            VStack(spacing: 0) {
                WeekCalendar(viewModel: calendarViewModel)
                    .frame(height: calendarViewModel.weekCalendarHeight)
                    .padding(.top, 25)
                    .padding(.horizontal, 15)
                
                ScrollView {
                    TaskListView(viewModel: $calendarViewModel)
                        .padding(.top, 28)
                }
                .background(Color("bg2"))
            }
            .sheet(isPresented: $showMonthCalendar) {
                showCalendarPopup
            }
            .toolbarBackground(Color.white, for: .navigationBar)
    }
}



extension MainHomeView {
    
    var showCalendarPopup: some View {
        VStack{
            HStack{
                Button {
                    calendarViewModel
                    .tappedButtonPage(isPrev: true)
                } label: {
                    Text("좌 버튼")
                }
                
                Text(calendarViewModel.monthCalendarYearMonth)
                
                Button {
                    calendarViewModel.tappedButtonPage(isPrev: false)
                } label: {
                    Text("우 버튼")
                }
            }
            MonthCalendar(viewModel: calendarViewModel)
            .frame(height: 252)
        }
        .presentationDetents([.calendarSize])
        .presentationDragIndicator(.hidden)
    }
}

struct MainHomeView_Previews: PreviewProvider {
    @State static var showMonthCalendar:Bool = false
//    @State static var selectedTab = Tags.tag1
//    @State static var showSetting = false
    @StateObject static var calendarViewModel = CalendarViewModel()
    
    static var previews: some View {
        MainHomeView(calendarViewModel: calendarViewModel, showMonthCalendar: $showMonthCalendar)
    }
}



extension PresentationDetent {
    static let calendarSize = Self.height(328)
}

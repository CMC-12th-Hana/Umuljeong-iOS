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
                HStack(spacing: 10) {
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
                    
                
                ZStack(alignment: .top) {
//                    HStack(alignment: .center, spacing: 0) {
//                        Text("일")
//                        Text("월")
//                        Text("화")
//                        Text("수")
//                        Text("목")
//                        Text("금")
//                        Text("토")
//                    }
//                    .frame(maxWidth: .infinity)
//                    .font(.body2)
                    
                    
                    WeekCalendar(viewModel: calendarViewModel)
                        .frame(height: calendarViewModel.weekCalendarHeight)
//                        .frame(height: 70)
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
        VStack{
            HStack(spacing: 20) {
                Button {
                    calendarViewModel
                    .tappedButtonPage(isPrev: true)
                } label: {
                    Image("backButton")
                }
                
                Text(calendarViewModel.monthCalendarYearMonth)
                    .font(.customTitle1)
                
                Button {
                    calendarViewModel.tappedButtonPage(isPrev: false)
                } label: {
                    Image("rightArrow")
                }
            }
            MonthCalendar(viewModel: calendarViewModel)
            .frame(height: 252)
            .padding(.horizontal, 30)
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

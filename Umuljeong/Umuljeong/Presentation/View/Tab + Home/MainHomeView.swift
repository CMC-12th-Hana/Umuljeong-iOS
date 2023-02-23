//
//  MainHomeView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI
import FSCalendar

struct MainHomeView: View {
    @Binding var selectedTab: Int //탭바 페이지 이동 (혹시 몰라)
    @Binding var showSetting:Bool
    @ObservedObject var viewModel = CalendarViewModel()
    @State var calendarViewModel: CalendarViewModel
    
    @State var showSheet: Bool = false

    var body: some View {
        NavigationView{
                VStack(alignment: .center, spacing: 0) {
                    WeekCalendar(viewModel: calendarViewModel)
                        .frame(height: calendarViewModel.weekCalendarHeight)
                        .padding(.vertical, 30)
                        .padding(.horizontal, 15)
                    
                    Rectangle()
                        .fill(Color("bg2"))
                        .frame(height: 8)
                    
                        TeskListView()
                }//: VStack
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
            .navigationBarItems(
                leading:
                    HStack {
                        Button(action: {
                            showSetting.toggle()
                        }, label: {
                            Image(systemName: "line.3.horizontal")
                        })
                        HStack {
                            Text("\(calendarViewModel.monthCalendarYearMonth)")
                            Button(action: {
                                showSheet.toggle()
                            }, label: {
                                Image("downArrow")
                            })
                        }
                        
                    }
                ,
                trailing: Button(action: {
                    withAnimation { showSetting.toggle() }
                }, label: {
                    Image("bellDefault")
                }))

        }
        
        
        .sheet(isPresented: $showSheet) {
            VStack{
                HStack{
                    Button {
                        calendarViewModel.tappedButtonPage(isPrev: true)
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
//            WeekCalendarView(calendar: calendarViewModel.monthCalendar, isCalendarExpanded: true)
//                .frame(height: calendarViewModel.calendarHeight)
//                .frame(height: 400)
                .background(Color.yellow)
            // Custom Size
                .presentationDetents([.calendarSize])
                .presentationDragIndicator(.hidden)
        }
//        .padding(.bottom,
//            UIApplication.shared.windows.first?.safeAreaInsets.top)
    }
    
}

struct MainHomeView_Previews: PreviewProvider {
    @State static var selectedTab = 0
    @State static var showSetting = false
    @StateObject static var calendarViewModel = CalendarViewModel()
    
    static var previews: some View {
//        HomeView(selectedTab: $selectedTab, showSetting: $showSetting)
        MainHomeView(selectedTab: $selectedTab, showSetting: $showSetting, calendarViewModel: calendarViewModel)
    }
}



extension PresentationDetent {
    static let calendarSize = Self.height(328)
}

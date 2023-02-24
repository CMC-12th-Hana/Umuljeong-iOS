//
//  MainHomeView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI
import FSCalendar

struct MainHomeView: View {
    @Binding var selectedTab: Int //탭바 페이지 이동 
    @Binding var showSetting:Bool
    @ObservedObject var viewModel = CalendarViewModel()
    @State var calendarViewModel: CalendarViewModel
    @State var showSheet: Bool = false

    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                WeekCalendar(viewModel: calendarViewModel)
                    .frame(height: calendarViewModel.weekCalendarHeight)
                    .padding(.top, 25)
                    .padding(.horizontal, 15)
                
                ScrollView {
                    TaskListView(viewModel: $calendarViewModel)
                        .padding(.top, 28)
                        .defaultAppStyleHorizentalPadding()
                }
                .background(Color("bg2"))
            }
            .sheet(isPresented: $showSheet) {
                showCalendarPopup
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .navigationBarItems(
                leading:
                    leadingNavigationItem
                ,trailing:
                    trailingNavigationItem
            )
        }
    }
}


extension MainHomeView {
    var leadingNavigationItem: some View {
        HStack {
            Button(action: {
                showSetting.toggle()
            }, label: {
                Image(systemName: "line.3.horizontal")
            })
            
            HStack {
                Text(calendarViewModel.monthCalendarYearMonth)
                
                Button(action: {
                    showSheet.toggle()
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
    @State static var selectedTab = 0
    @State static var showSetting = false
    @StateObject static var calendarViewModel = CalendarViewModel()
    
    static var previews: some View {
        MainHomeView(selectedTab: $selectedTab, showSetting: $showSetting, calendarViewModel: calendarViewModel)
    }
}



extension PresentationDetent {
    static let calendarSize = Self.height(328)
}

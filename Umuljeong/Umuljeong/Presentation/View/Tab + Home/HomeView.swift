//
//  HomeView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI
import FSCalendar

struct HomeView: View {
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
                        //week는 할당 필요
                            .frame(width: 310)
                            .background(Color.orange)
                    
                    Rectangle()
                        .fill(Color("bg1"))
                        .frame(height: 8)
                    
                        TeskListView()
                        .background(Color.green)
                }
                .background(Color.blue)
            
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
                    Image(systemName: "gear")
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

struct HomeView_Previews: PreviewProvider {
    @State static var selectedTab = 0
    @State static var showSetting = false
    @StateObject static var calendarViewModel = CalendarViewModel()
    
    static var previews: some View {
//        HomeView(selectedTab: $selectedTab, showSetting: $showSetting)
        HomeView(selectedTab: $selectedTab, showSetting: $showSetting, calendarViewModel: calendarViewModel)
    }
}



extension PresentationDetent {
    static let calendarSize = Self.height(328)
}

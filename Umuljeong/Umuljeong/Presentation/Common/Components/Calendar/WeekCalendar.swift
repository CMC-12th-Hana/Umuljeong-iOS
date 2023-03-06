//
//  WeekCalendar.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/13.
//

import SwiftUI
import FSCalendar

struct WeekCalendar<viewModelType: CalendarVM>: UIViewRepresentable {
    @ObservedObject var viewModel: viewModelType
    
    init(viewModel: viewModelType) {
        self.viewModel = viewModel
    }
    var calendar = FSCalendar()
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.headerHeight = 0
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scope = .week
        calendar.appearance.borderRadius = 0.15
        calendar.appearance.selectionColor = UIColor(named: "main")
        calendar.appearance.weekdayFont = UIFont.body2
        calendar.appearance.weekdayTextColor = UIColor(named: "font1")
        calendar.appearance.titleFont = UIFont.body1
//        calendar.calendarWeekdayView.isHidden = true
//        calendar.calendarWeekdayView.removeFromSuperview()
        calendar.placeholderType = .none
        
        calendar.layer.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.setCurrentPage(viewModel.selecteDate, animated: true)
        uiView.select(viewModel.selecteDate)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        
        var viewModel: viewModelType
        
        init(viewModel: viewModelType) {
            self.viewModel = viewModel
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            viewModel.selectDate(date)
        }
        
        func calendar(_ calendar: FSCalendar,
                      boundingRectWillChange bounds: CGRect,
                      animated: Bool) {
//            viewModel.weekCalendarHeight = bounds.height
            viewModel.weekCalendarHeight = 67
        }
    }
}

struct WeekCalendar_Previews: PreviewProvider {
    @StateObject static var viewModel = CalendarViewModel()
    static var previews: some View {
        WeekCalendar(viewModel: viewModel)
    }
}
//
//struct WeekCalendarView: UIViewRepresentable {
//    @State var calendar:FSCalendar
//    @State var isCalendarExpanded: Bool
//
//    func makeUIView(context: Context) -> FSCalendar {
//        calendar.calendarHeaderView.isHidden = true
//        calendar.headerHeight = 0
//        calendar.locale = Locale(identifier: "ko_KR")
//
////            // 선택된 날짜 모서리 설정
//        calendar.appearance.borderRadius = 0
//
////        // 달에 유효하지않은 날짜 지우기
//        calendar.placeholderType = .none
////
////            // 평일 & 주말 색상 설정
//        calendar.appearance.titleDefaultColor = .black  // 평일
//        calendar.appearance.titleWeekendColor = .red    // 주말
////
//        return calendar
//  }
//    func updateUIView(_ uiView: FSCalendar, context: Context) {
//        let scope: FSCalendarScope = isCalendarExpanded ? .month : .week
//        uiView.setScope(scope, animated: false)
//
//  }
//}
//
//
//struct WeekCalendarView_Previews: PreviewProvider {
////    @State static var isCalendarExpanded = false
////    @State static var clickDate = Date()
////    @State static var monthViewModel = CalendarViewModel()
//
//    static var previews: some View {
//        WeekCalendarView(calendar: FSCalendar(), isCalendarExpanded: false)
//        WeekCalendarView(calendar: FSCalendar(), isCalendarExpanded: true)
//    }
//}


//
//struct CalendarView: UIViewRepresentable {
//  typealias UIViewType = FSCalendar
//    let dateFormatter = DateFormatter()
//  func makeUIView(context: Context) -> FSCalendar {
//    let calendar = FSCalendar()
//    calendar.delegate = context.coordinator
//    calendar.dataSource = context.coordinator
//    calendar.scope = .week
////    calendar.pagingEnabled = false
//
//      calendar.locale = Locale(identifier: "ko_KR")
//
//      // 헤더 폰트 설정
//      calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)
//
//      // Weekday 폰트 설정
//      calendar.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
//
//      // 각각의 일(날짜) 폰트 설정 (ex. 1 2 3 4 5 6 ...)
//      calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
//
//      // 헤더의 날짜 포맷 설정
//      calendar.appearance.headerDateFormat = "YYYY년 MM월"
//
//      // 헤더의 폰트 색상 설정
//      calendar.appearance.headerTitleColor = UIColor.link
//
//      // 헤더의 폰트 정렬 설정
//      // .center & .left & .justified & .natural & .right
//      calendar.appearance.headerTitleAlignment = .left
//
//      // 헤더 높이 설정
//      calendar.headerHeight = 100
//
//      // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
//      calendar.appearance.headerMinimumDissolvedAlpha = 0.0
//
//      // 선택된 날짜 모서리 설정
//      calendar.appearance.borderRadius = 0
//
//      // 평일 & 주말 색상 설정
//      calendar.appearance.titleDefaultColor = .black  // 평일
//      calendar.appearance.titleWeekendColor = .red    // 주말
//
//      // 다중 선택
////      calendar.allowsMultipleSelection = true
//
//      // 꾹 눌러서 드래그 동작으로 다중 선택
////      calendar.swipeToChooseGesture.isEnabled = true
//    return calendar
//  }
//
//    // 날짜 선택 시 콜백 메소드
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print(dateFormatter.string(from: date) + " 날짜가 선택되었습니다.")
//    }
//     //날짜 선택 해제 콜백 메소드
//    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print(dateFormatter.string(from: date) + " 날짜가 선택 해제 되었습니다.")
//    }
//
//
//  func updateUIView(_ uiView: FSCalendar, context: Context) {
//  }
//  class Coordinator: NSObject,
//                        FSCalendarDelegate,
//                     FSCalendarDataSource,
//    FSCalendarDelegateAppearance
//
//    {
//      func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//              print(dateFormatter.string(from: date) + " 선택됨")
//          }
//  }
//
//  func makeCoordinator() -> Coordinator {
//    return Coordinator()
//  }
//}

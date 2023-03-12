//
//  MonthCalendarView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/14.
//

import SwiftUI
import FSCalendar

struct MonthCalendar<viewModelType: CalendarVM>: UIViewRepresentable {
    @ObservedObject var viewModel: viewModelType
    
    var calendar = FSCalendar()
    
    init(viewModel: viewModelType) {
        self.viewModel = viewModel
//        calendar.select(viewModel.selectedDate)
    }
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.headerHeight = 0
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.weekdayFont = UIFont.special3
        calendar.appearance.titleFont = UIFont.body3
        calendar.appearance.weekdayTextColor =  UIColor(named: "font1")
        calendar.appearance.borderRadius = 0.2
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor(named: "error")
        calendar.calendarWeekdayView.weekdayLabels[1].textColor = UIColor(named: "font2")
        calendar.calendarWeekdayView.weekdayLabels[2].textColor = UIColor(named: "font2")
        calendar.calendarWeekdayView.weekdayLabels[3].textColor = UIColor(named: "font2")
        calendar.calendarWeekdayView.weekdayLabels[4].textColor = UIColor(named: "font2")
        calendar.calendarWeekdayView.weekdayLabels[5].textColor = UIColor(named: "font2")
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor(named: "main")
        calendar.placeholderType = .none
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.setCurrentPage(viewModel.monthCalendarCurrentDate, animated: true)
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
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            DispatchQueue.main.async{ [self] in
                viewModel.pageScroll(calendar.currentPage)
            }
            }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            let weekday = Calendar.current.component(.weekday, from: date)
            if weekday == 1 {
                return UIColor(named: "error") // 주말 폰트 색상 변경
            } else if weekday == 7 {
                return UIColor(named: "main")
            }
            return appearance.titleDefaultColor
        }
        
        }
    }



extension MonthCalendar {
    func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        calendar.currentPage = cal.date(byAdding: dateComponents, to: calendar.currentPage)!
        calendar.setCurrentPage(calendar.currentPage, animated: true)
    }
}


struct MonthCalendar_Previews: PreviewProvider {
    @StateObject static var viewModel = DateStartFinishViewModel()
    static var previews: some View {
        MonthCalendar(viewModel: viewModel)
    }
}

//struct MonthCalendarView: UIViewRepresentable {
//    @State var calendar:FSCalendar
////    @State var isCalendarExpanded: Bool
//
//    func makeUIView(context: Context) -> FSCalendar {
//        calendar.scope = .month
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
////        let scope: FSCalendarScope = isCalendarExpanded ? .month : .week
////        uiView.setScope(scope, animated: false)
//  }
//}
//
//
//struct MonthCalendarView_Previews: PreviewProvider {
//    @State static var calendar = FSCalendar()
//    
//    static var previews: some View {
//        MonthCalendarView(calendar: calendar)
//    }
//}

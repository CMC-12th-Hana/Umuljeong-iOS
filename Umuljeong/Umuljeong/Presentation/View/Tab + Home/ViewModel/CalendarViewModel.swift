//
//  CalendarViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/13.
//

import Foundation
import FSCalendar

class CalendarViewModel: ObservableObject, CalendarVM {
    @Published var weekCalendarHeight: CGFloat = 300.0
    
    // FsCalendar 인스턴스
    private var calendar = FSCalendar()
    
    @Published var selectedDate: Date = Date()
    
    @Published var monthCalendarCurrentDate: Date = Date()
    
    @Published var monthCalendarYearMonth:String = ""
    
    init() {
        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
    }
    
    func selectDate(_ date: Date) {
        selectedDate = date
        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: date)
        //        currentMonthPage = date
    }
    
    func pageScroll(_ date: Date) {
        monthCalendarCurrentDate = date
        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: date)
    }
    
    func tappedButtonPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        monthCalendarCurrentDate = cal.date(byAdding: dateComponents, to: monthCalendarCurrentDate)!
        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: monthCalendarCurrentDate)
    }
}

//class CalendarViewModel: NSObject, ObservableObject {
//    @Published var selectedDate = SelectedDate()
//
//    @Published var weekCalendar: FSCalendar = FSCalendar()
//    @Published var monthCalendar: FSCalendar = FSCalendar()
//    @Published var calendarHeight: CGFloat = 300.0
//
//    @Published var selectedYearMonth: String = ""
//    @Published var sheetSelectedYearMonth: String = ""
//    @Published var selectedDateString: String = ""
//
//    override init() {
//        super.init()
//        self.weekCalendar.delegate = self
//        self.weekCalendar.dataSource = self
//        self.weekCalendar.scope = .week
//
//        self.monthCalendar.delegate = self
//        self.monthCalendar.dataSource = self
//        self.monthCalendar.scope = .month
//
//        selectedYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
//        sheetSelectedYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
//        selectedDateString = CalendarDateFomatter.date.string(from: CalendarService.shared.model.focusedDate)
//        self.weekCalendar.placeholderType = .none
//        self.monthCalendar.placeholderType = .none
//    }
//}
//
//extension CalendarViewModel: FSCalendarDelegate {
//
//    func calendar(_ calendar: FSCalendar,
//                  didSelect date: Date,
//                  at monthPosition: FSCalendarMonthPosition) {
//        dateSelected(date)
//    }
//
//    func calendar(_ calendar: FSCalendar,
//                  boundingRectWillChange bounds: CGRect,
//                  animated: Bool) {
//        calendarHeight = bounds.height
////        calendar.frame = CGRect(origin: calendar.frame.origin, size: bounds.size)
//    }
//
//    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
////        selectedYearMonth = CalendarDateFomatter.yearMonth.string(from: calendar.currentPage)
//        sheetSelectedYearMonth = CalendarDateFomatter.yearMonth.string(from: calendar.currentPage)
////        weekCalendar.currentPage = calendar.currentPage
////        monthCalendar.currentPage = calendar.currentPage
//        print("하이")
//        }
//}
//
//extension CalendarViewModel: FSCalendarDataSource {
//
//    func calendar(_ calendar: FSCalendar,
//                  numberOfEventsFor date: Date) -> Int {
//        numberOfEvent(for: date)
//    }
//}
//
//extension CalendarViewModel {
//
//    func numberOfEvent(for date: Date) -> Int {
//        /// some logic here
//        return 0
//    }
//
//    func scrollCurrentPage(isPrev: Bool) {
//        let cal = Calendar.current
//        var dateComponents = DateComponents()
//        dateComponents.month = isPrev ? -1 : 1
//
//        sheetSelectedYearMonth = CalendarDateFomatter.yearMonth.string(from: monthCalendar.currentPage)
//        monthCalendar.currentPage = cal.date(byAdding: dateComponents, to: (monthCalendar.currentPage ))!
//        monthCalendar.setCurrentPage(monthCalendar.currentPage, animated: true)
//    }
//
//
//
//    func dateSelected(_ date: Date) {
//        CalendarService.shared.moveFoucused(date: date) //model 변경 요청
//        weekCalendar.select(date)
//        monthCalendar.select(date)
//        selectedDate.date = date
//        selectedYearMonth =  CalendarDateFomatter.yearMonth.string(from: date)
//        sheetSelectedYearMonth = CalendarDateFomatter.yearMonth.string(from: date)
//        selectedDateString = CalendarDateFomatter.date.string(from: date)
//
////        DispatchQueue.main.async { [weak self] in
////            guard let self = self else { return }
////
////            self.selectedDate = date.description
////        }
//    }
//}

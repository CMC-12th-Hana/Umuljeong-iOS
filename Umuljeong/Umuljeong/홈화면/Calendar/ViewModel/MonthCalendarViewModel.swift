//
//  MonthCalendarViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/14.
//
//
//import Foundation
//import FSCalendar
//
//class MonthCalendarViewModel: NSObject, ObservableObject {
//    @Published var selectedDate = SelectedDate()
//    
//    @Published var calendar: FSCalendar
//    @Published var selectedYearMonth: String = ""
//    @Published var selectedDateString: String = ""
//    
//    init(calendar:FSCalendar) {
//        self.calendar = calendar
//        super.init()
//        self.calendar.delegate = self
//        self.calendar.dataSource = self
//        selectedYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
//        selectedDateString = CalendarDateFomatter.date.string(from: CalendarService.shared.model.focusedDate)
////        calendar.scope = isWeelCalendar ? .week : .month
//        self.calendar.placeholderType = .none
//    }
//}
//
//extension MonthCalendarViewModel: FSCalendarDelegate {
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
////        calendarHeight = bounds.height
//    }
//}
//
//extension MonthCalendarViewModel: FSCalendarDataSource {
//
//    func calendar(_ calendar: FSCalendar,
//                  numberOfEventsFor date: Date) -> Int {
//        numberOfEvent(for: date)
//    }
//}
//
//private extension MonthCalendarViewModel {
//
//    func numberOfEvent(for date: Date) -> Int {
//        /// some logic here
//        return 0
//    }
//
//    func dateSelected(_ date: Date) {
//        CalendarService.shared.moveFoucused(date: date) //model 변경 요청
//        calendar.select(date)
//        selectedYearMonth =  CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
//        selectedDateString = CalendarDateFomatter.date.string(from: CalendarService.shared.model.focusedDate)
//        
////        DispatchQueue.main.async { [weak self] in
////            guard let self = self else { return }
////
////            self.selectedDate = date.description
////        }
//    }
//}

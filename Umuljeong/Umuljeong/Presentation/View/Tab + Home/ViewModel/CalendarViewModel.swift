//
//  CalendarViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/13.
//

import Foundation
import FSCalendar

class CalendarViewModel: NSObject, ObservableObject {
    @Published var selectedDate = SelectedDate()
    
    @Published var weekCalendar: FSCalendar = FSCalendar()
    @Published var monthCalendar: FSCalendar = FSCalendar()
    @Published var calendarHeight: CGFloat = 300.0
    
    @Published var selectedYearMonth: String = ""
    @Published var selectedDateString: String = ""
    
    override init() {
        super.init()
        self.weekCalendar.delegate = self
        self.weekCalendar.dataSource = self
        self.weekCalendar.scope = .week
        
        self.monthCalendar.delegate = self
        self.monthCalendar.dataSource = self
        self.monthCalendar.scope = .month
        
        selectedYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
        selectedDateString = CalendarDateFomatter.date.string(from: CalendarService.shared.model.focusedDate)
        self.weekCalendar.placeholderType = .none
        self.monthCalendar.placeholderType = .none
    }
}

extension CalendarViewModel: FSCalendarDelegate {

    func calendar(_ calendar: FSCalendar,
                  didSelect date: Date,
                  at monthPosition: FSCalendarMonthPosition) {
        dateSelected(date)
    }

    func calendar(_ calendar: FSCalendar,
                  boundingRectWillChange bounds: CGRect,
                  animated: Bool) {
        calendarHeight = bounds.height
//        calendar.frame = CGRect(origin: calendar.frame.origin, size: bounds.size)
    }
}

extension CalendarViewModel: FSCalendarDataSource {

    func calendar(_ calendar: FSCalendar,
                  numberOfEventsFor date: Date) -> Int {
        numberOfEvent(for: date)
    }
}

private extension CalendarViewModel {

    func numberOfEvent(for date: Date) -> Int {
        /// some logic here
        return 0
    }

    func dateSelected(_ date: Date) {
        CalendarService.shared.moveFoucused(date: date) //model 변경 요청
        weekCalendar.select(date)
        monthCalendar.select(date)
        selectedDate.date = date
        selectedYearMonth =  CalendarDateFomatter.yearMonth.string(from: date)
        selectedDateString = CalendarDateFomatter.date.string(from: date)
        
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//
//            self.selectedDate = date.description
//        }
    }
}

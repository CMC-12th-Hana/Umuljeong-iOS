//
//  AddBusinessViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import Foundation
import FSCalendar

class AddBusinessViewModel: ObservableObject, CalendarVM {
    var weekCalendarHeight: CGFloat = 300.0 //필요없는거 추후 삭제 (현재 프로토콜에 걸림)

    private var calendar = FSCalendar()
    
    @Published var showStartCalendar: Bool = false
    @Published var showFinishCalendar: Bool = false

    @Published var selectedDate: Date = Date()
    @Published var monthCalendarCurrentDate: Date = Date()
    
    @Published var startDate: Date?
    @Published var finishDate: Date?
    
    @Published var startDateString:String?
    @Published var finishDateString:String?
    
    var monthCalendarYearMonth:String = ""
    
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
    }
    
    func startDateSet(_ date: Date) {
        startDate = date
        changeStartDateToString(date)
        
    }
    
    func finishDateSet(_ date: Date) {
        finishDate = date
        changeFinishDateToString(date)
    }
    
    func changeStartDateToString(_ date: Date) {
        startDateString = CalendarDateFomatter.date.string(from: date)
    }
    
    func changeFinishDateToString(_ date: Date) {
        finishDateString = CalendarDateFomatter.date.string(from: date)
    }
    
    
    
    
}

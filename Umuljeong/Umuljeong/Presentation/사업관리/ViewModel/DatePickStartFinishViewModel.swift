//
//  DataViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/11.
//

import SwiftUI
import FSCalendar

class DatePickStartFinishViewModel: ObservableObject, PickDateCalendarVM, CalendarVM {
    
    init() {
        EditBusinessService.shared.resetDate()
        
        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
    }
    
    var weekCalendarHeight: CGFloat = 300.0 //필요없는거 추후 삭제 (현재 프로토콜에 걸림)

    private var calendar = FSCalendar()
    
    @Published var showStartCalendar: Bool = false
    @Published var showFinishCalendar: Bool = false

    @Published var selecteDate: Date = Date()
    @Published var monthCalendarCurrentDate: Date = Date()
    
    @Published var startDate: Date?
    @Published var finishDate: Date?
    
    @Published var startDateString:String?
    @Published var finishDateString:String?
    
    var monthCalendarYearMonth:String = ""
    
    
    
    func setDefault() {
        let startFinishDate = EditBusinessService.shared.getDateInfo()

        if let startDate = startFinishDate.0 {
            self.startDate = startDate
            changeStartDateToString(startDate)
        }
        if let finishDate = startFinishDate.1 {
            self.finishDate = finishDate
            changeFinishDateToString(finishDate)
        }
    }
    
    func selectDate(_ date: Date) {
        selecteDate = date
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
        EditBusinessService.shared.setStartDate(startDate: date)
    }
    
    func finishDateSet(_ date: Date) {
        finishDate = date
        changeFinishDateToString(date)
        EditBusinessService.shared.setFinishDate(finishDate: date)
    }
    
    func startDateReset() {
        print("시작 데이터 리셋")
        startDate = nil
        startDateString = ""
        EditBusinessService.shared.setStartDate(startDate: nil)
    }
    
    func finishDateReset() {
        print("마지막 데이터 리셋")
        finishDate = nil
        finishDateString = ""
        EditBusinessService.shared.setFinishDate(finishDate: nil)
    }
    
    func changeStartDateToString(_ date: Date) {
        startDateString = CalendarDateFomatter.date.string(from: date)
    }
    
    func changeFinishDateToString(_ date: Date) {
        finishDateString = CalendarDateFomatter.date.string(from: date)
    }
}


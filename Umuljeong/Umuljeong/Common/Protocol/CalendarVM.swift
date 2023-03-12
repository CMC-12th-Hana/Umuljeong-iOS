//
//  CalendarVM.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/20.
//

import Foundation

protocol CalendarVM: ObservableObject {
    var selecteDate: Date {get set}
    var monthCalendarCurrentDate: Date {get set}
//    var monthCalendarYearMonth: String {get set}
    var weekCalendarHeight: CGFloat {get set}
    
    func selectDate(_ date: Date)
    func pageScroll(_ date: Date)
    func tappedButtonPage(isPrev: Bool)
}

protocol PickDateCalendarVM: ObservableObject {
    var startDate: Date? {get set}
    var finishDate: Date? {get set}
    var selecteDate: Date {get set}
    var monthCalendarCurrentDate: Date {get set}
//    var monthCalendarYearMonth: String {get set}
    var weekCalendarHeight: CGFloat {get set}
    
    func selectDate(_ date: Date)
    func pageScroll(_ date: Date)
    func tappedButtonPage(isPrev: Bool)
    
    func startDateSet(_ date: Date)
    func finishDateSet(_ date: Date)
    
    func startDateReset()
    func finishDateReset()
}








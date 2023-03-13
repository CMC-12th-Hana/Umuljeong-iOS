//
//  DatePickCalendar.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/20.
//

import SwiftUI
import FSCalendar

struct StartDatePickCalendar<viewModelType: PickDateCalendarVM>: UIViewRepresentable {
    @ObservedObject var viewModel: viewModelType
    
    var calendar = FSCalendar()
    
    init(viewModel: viewModelType) {
        self.viewModel = viewModel
        calendar.select(viewModel.startDate)
        calendar.headerHeight = 0
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.weekdayFont = UIFont.body5
        calendar.appearance.titleFont = UIFont.body5
        calendar.appearance.borderRadius = 0.2
        calendar.appearance.weekdayTextColor =  UIColor(named: "font1")
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor(named: "error")
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor(named: "main")
        calendar.placeholderType = .none
    }
    
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.select(viewModel.startDate)
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
//            viewModel.showStartCalendar.toggle()
            print("첫번째 캘린더 선택 반응 ")
            
            if viewModel.startDate == date {
                viewModel.startDate = nil
                calendar.deselect(calendar.selectedDates[0])
                viewModel.startDateReset()
            } else {
                viewModel.startDateSet(date)
            }
//            viewModel.selectDate(date)
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
        
        public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
            
        }
        
        func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
            // 선택된 날짜 중에서 특정 조건을 검사하고, 조건을 만족하면 선택을 해제하지 않음
            return true
        }
        }
    }



extension StartDatePickCalendar {
    func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        calendar.currentPage = cal.date(byAdding: dateComponents, to: calendar.currentPage)!
        calendar.setCurrentPage(calendar.currentPage, animated: true)
    }
}


struct StartDatePickCalendar_Previews: PreviewProvider {
    @StateObject static var viewModel = DatePickStartFinishViewModel()
    static var previews: some View {
        StartDatePickCalendar(viewModel: viewModel)
    }
}

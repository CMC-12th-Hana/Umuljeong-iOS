//
//  LastDatePickCalendar.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/20.
//

import SwiftUI
import FSCalendar

struct FinishDatePickCalendar: UIViewRepresentable {
    @ObservedObject var viewModel: DetailCustomerViewModel
    
    var calendar = FSCalendar()
    
    init(viewModel: DetailCustomerViewModel) {
        self.viewModel = viewModel
        calendar.headerHeight = 0
        calendar.locale = Locale(identifier: "ko_KR")
        
        calendar.appearance.weekdayFont = UIFont.body5
        calendar.appearance.titleFont = UIFont.body5
        calendar.appearance.weekdayTextColor =  UIColor(named: "font1")
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor(named: "error")
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor(named: "main")

        calendar.placeholderType = .none
        
        calendar.select(viewModel.startDate)
        if viewModel.startDate != nil {
            self.calendar.select(viewModel.finishDate)
        }
//        calendar.select(viewModel.selectedDate)
    }
    
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.allowsMultipleSelection = true
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
        
        var viewModel: DetailCustomerViewModel
        
        init(viewModel: DetailCustomerViewModel) {
            self.viewModel = viewModel
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            
            if viewModel.startDate == nil && calendar.selectedDates.count > 1 {
                calendar.deselect(calendar.selectedDates[0])
            }
            if calendar.selectedDates.count > 2 {
                calendar.deselect(calendar.selectedDates[1])
            }
            
            if viewModel.finishDate == date {
                viewModel.finishDate = nil
            } else {
                viewModel.finishDateSet(date)
            }
//            viewModel.showFinishCalendar.toggle()
//            viewModel.finishDateSet(date)
//            viewModel.selectDate(date)
        }
        
        func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
            // 선택된 날짜 중에서 특정 조건을 검사하고, 조건을 만족하면 선택을 해제하지 않음
            if viewModel.startDate == date {
                return false
            }
            
            return true
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
        
            
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
            // 선택한 두 날짜 사이의 기간을 구합니다.
//            print("1")
//            if let startDate = viewModel.startDate {
//                print("2")
//                if date == startDate{
//                    return .red
//                }
//            }
//
//            if let startDate = viewModel.startDate, let finishDate = viewModel.finishDate {
//                if date >= startDate && date <= finishDate {
//                    // 선택한 두 날짜 사이에 있는 날짜는 색칠합니다.
//                    return UIColor(red: 50/255, green: 200/255, blue: 255/255, alpha: 0.3)
//                    }
//                }
            return nil
            }
        } //: Class

}



extension FinishDatePickCalendar {
    func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        calendar.currentPage = cal.date(byAdding: dateComponents, to: calendar.currentPage)!
        calendar.setCurrentPage(calendar.currentPage, animated: true)
    }
}


struct FinishDatePickCalendar_Previews: PreviewProvider {
    @StateObject static var viewModel = DetailCustomerViewModel()
    static var previews: some View {
        FinishDatePickCalendar(viewModel: viewModel)
    }
}

//
//  BusinessCalendar.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/20.
//

import SwiftUI
import FSCalendar

//struct BusinessCalendar: UIViewRepresentable {
//    @ObservedObject var viewModel: CustomerCalendarViewModel
//    
//    var calendar = FSCalendar()
//    
//    func makeUIView(context: Context) -> FSCalendar {
//        calendar.delegate = context.coordinator
//        calendar.dataSource = context.coordinator
//        return calendar
//    }
//    
//    func updateUIView(_ uiView: FSCalendar, context: Context) {
//        uiView.setCurrentPage(viewModel.monthCalendarCurrentDate, animated: true)
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(viewModel: viewModel)
//    }
//    
//    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
//        
//        var viewModel: CustomerCalendarViewModel
//        
//        init(viewModel: CustomerCalendarViewModel) {
//            self.viewModel = viewModel
//        }
//        
//        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//            viewModel.selectDate(date)
//        }
//        
//        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//            viewModel.pageScroll(calendar.currentPage)
//            print("하이")
//            }
//    }
//}
//
//
//extension BusinessCalendar {
//    func scrollCurrentPage(isPrev: Bool) {
//        let cal = Calendar.current
//        var dateComponents = DateComponents()
//        dateComponents.month = isPrev ? -1 : 1
//        calendar.currentPage = cal.date(byAdding: dateComponents, to: calendar.currentPage)!
//        calendar.setCurrentPage(calendar.currentPage, animated: true)
//    }
//}
//
//
//struct BusinessCalendar_Previews: PreviewProvider {
//    @StateObject static var viewModel = CustomerCalendarViewModel()
//    static var previews: some View {
//        BusinessCalendar(viewModel: viewModel)
//    }
//}

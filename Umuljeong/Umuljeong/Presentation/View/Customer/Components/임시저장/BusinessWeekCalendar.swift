//
//  BusinessWeekCalendar.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/20.
//

import SwiftUI
import FSCalendar

//struct BusinessWeekCalendar<viewModelType: CalendarVM>: UIViewRepresentable {
//    @ObservedObject var viewModel: viewModelType
//    
//    init(viewModel: viewModelType) {
//        self.viewModel = viewModel
//    }
//
//    var calendar = FSCalendar()
//    
//    func makeUIView(context: Context) -> FSCalendar {
//        calendar.delegate = context.coordinator
//        calendar.dataSource = context.coordinator
//        calendar.scope = .week
//        return calendar
//    }
//    
//    func updateUIView(_ uiView: FSCalendar, context: Context) {
//        uiView.setCurrentPage(viewModel.selectedDate, animated: true)
//        uiView.select(viewModel.selectedDate)
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(viewModel: viewModel)
//    }
//    
//    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
//        
//        var viewModel: viewModelType
//        
//        init(viewModel: viewModelType) {
//            self.viewModel = viewModel
//        }
//        
//        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//            viewModel.selectDate(date)
//        }
//    }
//}
//
//struct BusinessWeekCalendar_Previews: PreviewProvider {
//    @StateObject static var viewModel = DetailCustomerViewModel()
//    static var previews: some View {
//        BusinessWeekCalendar(viewModel: viewModel)
//    }
//}

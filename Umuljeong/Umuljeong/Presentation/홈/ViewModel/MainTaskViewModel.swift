//
//  CalendarViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/13.
//

import Foundation
import FSCalendar

class MainTaskViewModel: ObservableObject, CalendarVM {
    @Published var weekCalendarHeight: CGFloat = 300.0
    private var calendar = FSCalendar()
    @Published var selecteDate: Date = Date()
    @Published var monthCalendarCurrentDate: Date = Date()
    @Published var monthCalendarYearMonth:String = ""
    @Published var taskFeedList:[TaskFeedModel] = []
    @Published var taskMemberFeedList:[TaskMemberFeedModel] = []
    
    init() {
        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
        requestDateToTaskFeed(Date: Date())
        requestDateToMemberFeed(Date:Date()) //<- 리더일 때만 
    }
    
    func getDate() -> Date {
        return selecteDate
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
        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: monthCalendarCurrentDate)
    }
}

extension MainTaskViewModel {

    //업무 이름, 업무 명
    func requestDateToTaskFeed(Date:Date) {
        let requestResult = true //임시
        switch requestResult {
        case true: taskFeedList = [TaskFeedModel(taskNmae: "조개 껍데기 모으기", categoryModel: CategoryModel(id: 0, catogoryName: "A/S", categoryColor: "8F00FF".checkColorCategory()))] //색상 날라온 거 처리해서 보내주기 //이건 레포지터리 딴에서 해결 //예시로 남겨두
        case false: break
        }
    }
    
    func requestDateToMemberFeed(Date:Date){
        let requestResult = true //임시
        switch requestResult {
        case true: taskMemberFeedList = [TaskMemberFeedModel(memberName: "보노보노", taskList: [TaskFeedModel(taskNmae: "조개 껍데기 모으기", categoryModel: CategoryModel(id: 0, catogoryName: "A/S", categoryColor: "8F00FF".checkColorCategory()))])] //색상 날라온 거 처리해서 보내주기 //이건 레포지터리 딴에서 해결 //예시로 남겨두
        case false: break
        }
    }
    
    
    
    
    
}

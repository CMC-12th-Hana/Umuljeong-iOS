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
    @Published var weekCalendarYearMonth:String = ""
    @Published var taskFeedList:[TaskDtoList] = []
    @Published var taskMemberFeedList:[MemberTaskList] = []


    let taskRepository = TaskMainTaskAllRepository()
    let memberRepository = TaskMainMemberAllRepository()
    
    init() {
        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
        weekCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
        requestAllTask()
        requestAllMemberTask()
//        requestDateToTaskFeed(Date: Date())
//        requestDateToMemberFeed(Date:Date()) //<- 리더일 때만
    }
    
    func requestAllTask() {
        taskRepository.requestMainTaskAll(searchDate: CalendarDateFomatter.date.string(from: self.selecteDate)) { reqResult in
            switch reqResult {
            case .success(let taskInfo):
                guard let info = taskInfo else {return}
                
                self.taskFeedList = info.taskDtoList
                print(self.taskFeedList)
                print("날짜별 메인 요청 성공")
            case .failure(_):
                print("날짜별 메인 요청 실패")
            }
        }
    }
    
    func requestAllMemberTask() {
        memberRepository.requestMainMemberTaskAll(searchDate: CalendarDateFomatter.date.string(from: self.selecteDate)) { reqResult in
            switch reqResult {
            case .success(let memberInfo):
                guard let info = memberInfo else {return}
                self.taskMemberFeedList = self.convertToMemberTaskList(response: info)
                print(self.taskMemberFeedList)
//                taskFeedList = memberInfo
                print("날짜별 멤버의 요청 성공")
            case .failure(_):
                print("날짜별 멤버의요청 실패")
            }
        }
    }
    
    func convertToMemberTaskList(response: MemberTaskResponse) -> [MemberTaskList] {
        var memberTaskList: [MemberTaskList] = []
        for memberDto in response.memberDtoList {
            let memberId = memberDto.taskDtoList.first?.memberId ?? 0
            let taskCount = memberDto.count
            let taskDtoList = memberDto.taskDtoList
            let name = memberDto.name
            let memberTask = MemberTaskList(memberId: memberId, memberName: name, taskCount: taskCount, taskDtoList: taskDtoList)
            memberTaskList.append(memberTask)
        }
        return memberTaskList
    }
                                 
    func changeDate() {
        self.requestAllTask()
        //권한에 따라
        self.requestAllMemberTask()
    }
    
    
    func getDate() -> Date {
        return selecteDate
    }
    
    func selectDate(_ date: Date) {
        selecteDate = date
        monthCalendarCurrentDate = date
        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: date)
        weekCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: date)
        self.changeDate()
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
//    func requestDateToTaskFeed(Date:Date) {
//        let requestResult = true //임시
//        switch requestResult {
//        case true:
////            taskFeedList = [TaskFeedModel(taskNmae: "조개 껍데기 모으기", categoryModel: CategoryModel(id: 0, catogoryName: "A/S", categoryColor: "8F00FF".checkColorCategory()))] //색상 날라온 거 처리해서 보내주기 //이건 레포지터리 딴에서 해결 //예시로 남겨두
//        case false: break
//        }
//    }
//
//    func requestDateToMemberFeed(Date:Date){
//        let requestResult = true //임시
//        switch requestResult {
//        case true:
////            taskMemberFeedList = [TaskMemberFeedModel(memberName: "보노보노", taskList: [TaskFeedModel(taskNmae: "조개 껍데기 모으기", categoryModel: CategoryModel(id: 0, catogoryName: "A/S", categoryColor: "8F00FF".checkColorCategory()))])] //색상 날라온 거 처리해서 보내주기 //이건 레포지터리 딴에서 해결 //예시로 남겨두
//        case false: break
//        }
//    }
    
    
    
    
    
}

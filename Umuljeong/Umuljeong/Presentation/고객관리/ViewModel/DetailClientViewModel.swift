//
//  CustomerCalendarViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/20.
//

import Foundation
import FSCalendar

class DetailClientViewModel: ObservableObject {
    let getDetailRepository = ClientDetailRepository()
    let removeRepository = ClientRemoveRepository()
        
    @Published var clientName: String = ""
    @Published var clientMainTel: String = ""
    @Published var department: String = ""
    @Published var partManagerName: String = ""
    @Published var partManagerTel: String = ""
    @Published var alertErrorMessage: String = "통신이 불안정합니다."
    @Published var taskCount: String = "0"
    @Published var businessCount: String = "0"
    
    let infoRepository = ClientDetailRepository()
    
    func requestCustomerInfo(clientId:Int, requestResult: @escaping (Bool) -> ()) {
        infoRepository.requestClientDetail(clientId: clientId){ result in
            switch result {
            case .success(let clientInfo):
                self.clientName = clientInfo?.name ?? ""
                self.clientMainTel = clientInfo?.tel  ?? ""
                self.department = clientInfo?.salesRepresentativeDto.department  ?? ""
                self.partManagerName = clientInfo?.salesRepresentativeDto.name  ?? ""
                self.partManagerTel = clientInfo?.salesRepresentativeDto.phoneNumber  ?? ""
                self.taskCount = String(clientInfo?.taskCount ?? 0)
                self.businessCount = String(clientInfo?.businessCount ?? 0)
                requestResult(true)
            case .failure(.requestError(let message)): self.alertErrorMessage = message; requestResult(false)
            case .failure(.token):
                self.alertErrorMessage = "로그인 기간이 만료되었습니다. 다시 로그인 해주세요"; requestResult(false)
            }
        }
    }
    
    func requestClientRemove(clientId:Int, requestResult: @escaping (Bool) -> ()) {
        removeRepository.requestClientRemove(clientId: clientId) { result in
            switch result {
            case .success: requestResult(true)
                
            case .failure(_): requestResult(false)
                
            }
        }
    }

//
//
//
//    var weekCalendarHeight: CGFloat = 300.0 //필요없는거 추후 삭제 (현재 프로토콜에 걸림)
//
//    private var calendar = FSCalendar()
//
//    @Published var showStartCalendar: Bool = false
//    @Published var showFinishCalendar: Bool = false
//
//    @Published var selecteDate: Date = Date()
//    @Published var monthCalendarCurrentDate: Date = Date()
//
//    @Published var startDate: Date?
//    @Published var finishDate: Date?
//
//    @Published var startDateString:String?
//    @Published var finishDateString:String?
//
//    var monthCalendarYearMonth:String = ""
//
//    init() {
//        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: CalendarService.shared.model.focusedDate)
//    }
//
//
    func requestDetail(clientId: Int) {
        print("내가 건넨 clientId 가 일단 뭐야? : \(clientId)")
        getDetailRepository.requestClientDetail(clientId: clientId) { result in
            switch result {
            case .success(let clientInfo):
                self.clientName = clientInfo?.name ?? ""
                self.clientMainTel = clientInfo?.tel ?? ""
                self.partManagerName = clientInfo?.salesRepresentativeDto.name ?? ""
                self.department = clientInfo?.salesRepresentativeDto.department ?? ""
            case .failure(.requestError(let message)): self.alertErrorMessage = message;
            case .failure(.token):
                self.alertErrorMessage = "로그인 기간이 만료되었습니다. 다시 로그인 해주세요";
            }
        }
    }
//
//    func selectDate(_ date: Date) {
//        selecteDate = date
//        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: date)
//        //        currentMonthPage = date
//    }
//
//    func pageScroll(_ date: Date) {
//        monthCalendarCurrentDate = date
//        monthCalendarYearMonth = CalendarDateFomatter.yearMonth.string(from: date)
//    }
//
//    func tappedButtonPage(isPrev: Bool) {
//        let cal = Calendar.current
//        var dateComponents = DateComponents()
//        dateComponents.month = isPrev ? -1 : 1
//        monthCalendarCurrentDate = cal.date(byAdding: dateComponents, to: monthCalendarCurrentDate)!
//    }
//
//    func startDateSet(_ date: Date) {
//        startDate = date
//        changeStartDateToString(date)
//
//    }
//
//    func finishDateSet(_ date: Date) {
//        finishDate = date
//        changeFinishDateToString(date)
//    }
//
//    func changeStartDateToString(_ date: Date) {
//        startDateString = CalendarDateFomatter.date.string(from: date)
//    }
//
//    func changeFinishDateToString(_ date: Date) {
//        finishDateString = CalendarDateFomatter.date.string(from: date)
//    }
//
//
//
    
}

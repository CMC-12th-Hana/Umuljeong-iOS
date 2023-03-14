//
//  CalendarService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/14.
//

import Foundation

class CalendarService {
    static var shared = CalendarService()

    private init() {}

    //모델 소유
    var model = CalendarModel(eventDate: Date())

    //모델 변경 상황 메서드
    func moveFoucused(date: Date) {
        model.focusedDate = date
    }
}

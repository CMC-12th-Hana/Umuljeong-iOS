//
//  MonthCalendarView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/14.
//

import SwiftUI
import FSCalendar

struct MonthCalendarView: UIViewRepresentable {
    @State var calendar:FSCalendar

    func makeUIView(context: Context) -> FSCalendar {
        calendar.scope = .month
        
        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 20)
        calendar.calendarHeaderView.isHidden = true
        calendar.headerHeight = 0
            // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
    
            // 선택된 날짜 모서리 설정
        calendar.appearance.borderRadius = 0
        
        // 달에 유효하지않은 날짜 지우기
        calendar.placeholderType = .none
    
            // 평일 & 주말 색상 설정
        calendar.appearance.titleDefaultColor = .black  // 평일
        calendar.appearance.titleWeekendColor = .red    // 주말
        
        return calendar
  }
    func updateUIView(_ uiView: FSCalendar, context: Context) {
  }
}


struct MonthCalendarView_Previews: PreviewProvider {
    
    static var previews: some View {
        MonthCalendarView(calendar: FSCalendar())
    }
}

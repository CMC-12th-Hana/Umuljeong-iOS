//
//  CalendarModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/13.
//

import Foundation

struct CalendarDateFomatter {

    static var yearMonth:DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.timeZone = TimeZone(abbreviation: "KST")
        df.dateFormat = "yyyy년 MM월"
        return df
    }()
    
    static var date:DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.timeZone = TimeZone(abbreviation: "KST")
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()

}

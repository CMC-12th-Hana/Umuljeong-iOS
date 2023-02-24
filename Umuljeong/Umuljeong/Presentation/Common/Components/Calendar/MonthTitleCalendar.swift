//
//  MonthTitleCalendar.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/20.
//

import SwiftUI
import FSCalendar

struct MonthTitleCalendar: View {
    @State var calendar:FSCalendar
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    
                } label: {
                    Text("좌 버튼")
                }
                Text("라벨")
                Button {
                    
                } label: {
                    Text("우 버튼")
                }

            }
//            MonthCalendar(viewModel: CalendarViewModel)
        }
    }
}

//struct MonthTitleCalendar_Previews: PreviewProvider {
//    static var previews: some View {
//        MonthTitleCalendar(calendar: FSCalendar())
//    }
//}

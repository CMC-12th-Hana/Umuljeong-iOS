//
//  TESTVIEW.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/20.
//

import SwiftUI

struct TESTVIEW: View {
    @StateObject var viewModel = DateStartFinishViewModel()
    var body: some View {
        VStack{
            HStack{
                Button {
                    viewModel.tappedButtonPage(isPrev: true)
                } label: {
                    Text("좌 버튼")
                }
                Text(viewModel.monthCalendarYearMonth)
                Button {
                    viewModel.tappedButtonPage(isPrev: false)
                } label: {
                    Text("우 버튼")
                }

            }
//            BusinessWeekCalendar(viewModel: viewModel)
//                .frame(width:300)
//                .frame(height:300)
//            BusinessCalendar(viewModel: viewModel)
        }
    }
}

struct TESTVIEW_Previews: PreviewProvider {
    static var previews: some View {
        TESTVIEW()
    }
}

//
//  StartFinishDateView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct StartFinishDateView: View {
    @Binding var showStartCalendar:Bool
    @Binding var showFinishCalendar:Bool
    var startDateString:String = ""
    var finishDateString:String = ""
    
    var body: some View {
        HStack(spacing:10){
            ZStack{
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("line2"), lineWidth: 1)

                    HStack{
                        Text(startDateString == "" ? "시작일자" : startDateString)
                            .foregroundColor(startDateString == "" ? Color("font3") : Color("font1"))
                        Spacer()
                        Button {
                            showStartCalendar.toggle()
                        } label: {
                            Image("calendar")
                        }
                    }
                    .padding(.horizontal, 15)

            }
            ZStack{
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("line2"), lineWidth: 1)
                    HStack{
                        Text(finishDateString == "" ? "종료일자" : finishDateString)
                            .foregroundColor(finishDateString == "" ? Color("font3") : Color("font1"))
                        Spacer()
                        Button {
                            showFinishCalendar.toggle()
                        } label: {
                            Image("calendar")
                        }
                    }
                    .padding(.horizontal, 15)
            }
        }
        .frame(height:42)
    }
}

struct StartFinishDateView_Previews: PreviewProvider {
    @ObservedObject static var viewModel = DatePickStartFinishViewModel()
    
    static var previews: some View {
        StartFinishDateView(showStartCalendar: $viewModel.showStartCalendar, showFinishCalendar: $viewModel.showFinishCalendar, startDateString: viewModel.startDateString ?? "", finishDateString: viewModel.finishDateString ?? "")
    }
}

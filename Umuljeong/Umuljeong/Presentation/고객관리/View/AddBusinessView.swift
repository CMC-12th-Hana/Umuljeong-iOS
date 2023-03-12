//
//  AddBusinessView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct AddBusinessView: View {
    @StateObject var dateViewModel =  DateStartFinishViewModel()
    @StateObject var infoViewModel = AddBusinessViewModel()
    @Environment(\.presentationMode) var presentationMode

    let clientId:Int
    @Binding var isShowingSheet:Bool

    var body: some View {
        VStack(spacing:20){
            BasicTextFiled(label: "사업 이름", placeHolder: "사업 이름을 입력해주세요", inputText: $infoViewModel.businessName)
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing:0){
                    Text("예상 사업기간")
                    Text("*")
                        .foregroundColor(Color("error"))
                }
                .font(.body4)
                StartFinishDateView(showStartCalendar: $dateViewModel.showStartCalendar, showFinishCalendar: $dateViewModel.showFinishCalendar, startDateString: dateViewModel.startDateString, finishDateString: dateViewModel.finishDateString)
            }
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing:0){
                    Text("참여 구성원 추가")
                }
                .font(.body4)
                
                NavigationLink {
                    AddBusinessMemberView()
                } label: {
                    ImportEmployeeLabel()
                }
            }
            
            descriptionView
                
            BasicTextFiled(label: "매출액", placeHolder: "예상 매출액을 숫자로 입력해주세요", inputText: $infoViewModel.revenue, checkRed: false)
            
            Spacer()
            
            Button {
                infoViewModel.requestAddBusiness(clientId: clientId) {
                    result in
                    if result == true {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        
                    }
                }
            } label: {
                BasicButtonLabel(text: "저장")
            }
            .padding(.bottom, 10)


            }
        .sheet(isPresented: $dateViewModel.showStartCalendar, onDismiss: {
            isShowingSheet = true
        }) {
            startCalendarPopup
                .presentationDetents([.calendarSize])
                .presentationDragIndicator(.hidden)
        }
        .sheet(isPresented: $dateViewModel.showFinishCalendar, onDismiss: {
            isShowingSheet = true
        }) {
            finishCalendarPopup
                .presentationDetents([.calendarSize])
                .presentationDragIndicator(.hidden)
        }
        .navigationDesignDefault(title: "사업 추가하기")
    }
}

extension AddBusinessView {
    
    var descriptionView:some View {
        VStack(spacing: 8) {
            HStack {
                Text("특이사항(사업 설명란)")
                    .font(.body3)
                Spacer()
            }
            descriptionTextField
        }
    }
    
    var descriptionTextField: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 6)
                .stroke(lineWidth: 1.0)
                .fill(Color("bg1"))
                .frame(height: 260)
            
            MultilineTextField(text: $infoViewModel.description, placeholder: "사업 설명을 입력해주세요")
                .autocorrectionDisabled(true)
                .font(.body2)
                .padding(.horizontal, 13)
                .padding(.vertical, 10)
                .frame(height: 260)
        }
    }
    
    
    var startCalendarPopup: some View {
        VStack(spacing: 15){
            Spacer()
                .frame(height: 20)
            HStack(spacing: 15) {
                Button {
                    dateViewModel.tappedButtonPage(isPrev: true)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("leftButton"))
                }
                Text(dateViewModel.monthCalendarYearMonth)
                    .font(.customTitle2)
                
                Button {
                    dateViewModel.tappedButtonPage(isPrev: false)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("rightArrow"))
                }
            }
            StartDatePickCalendar(viewModel: dateViewModel)
                .padding(.horizontal, 40)
                .frame(height: 294)
        }
        .frame(height: 328)
        .presentationDetents([.calendarSize])
        .presentationDragIndicator(.hidden)
    }
    var finishCalendarPopup: some View {
        VStack(spacing:15){
            Spacer()
                .frame(height: 20)
            HStack(spacing: 15) {
                Button {
                    dateViewModel.tappedButtonPage(isPrev: true)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("leftButton"))
                }
                Text(dateViewModel.monthCalendarYearMonth)
                    .font(.customTitle2)
                
                Button {
                    dateViewModel.tappedButtonPage(isPrev: false)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("rightArrow"))
                }
            }
            FinishDatePickCalendar(viewModel: dateViewModel)
                .padding(.horizontal, 40)
                .frame(height: 294)
        }
    }
}

struct AddBusinessView_Previews: PreviewProvider {
    @State static var isShowingSheet:Bool = false
    static var previews: some View {
        AddBusinessView(clientId: 0, isShowingSheet: $isShowingSheet)
    }
}

//
//  DetailCustomerView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct DetailClientView: View {
    @State private var searchText = ""
    @State var alertRemove:Bool = false
    let clientId: Int
    @ObservedObject var infoViewModel = DetailClientViewModel()
    @ObservedObject var dateViewModel =  DateStartFinishViewModel()
    @Binding var isShowingSheet:Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing:0){
                aboutCompany
                HStack{
                    Text("\(infoViewModel.clientName)에서 함께한 사업")
                        .font(.customTitle2)
                    Image("info")
                    Spacer()
                }
                .padding(.bottom, 30)
                clientCountInfoBox
                .padding(.bottom, 60)
                
                // MARK: - 고객사의 사업 확인
                HStack{
                    Text("사업명 검색")
                    .font(.customTitle2)
                    Spacer()
                }
                .padding(.bottom, 20)
        
                SearchBar(text: $searchText, guideText: "찾으시는 사업명을 입력해주세요")
                .padding(.bottom, 20)
                StartFinishDateView(showStartCalendar: $dateViewModel.showStartCalendar, showFinishCalendar: $dateViewModel.showFinishCalendar, startDateString: dateViewModel.startDateString, finishDateString: dateViewModel.finishDateString)
                    .padding(.bottom, 40)
                VStack{
                    NavigationLink {
                        AddBusinessView(clientId: self.clientId, isShowingSheet: $isShowingSheet)
                    } label: {
                        PlusButtonLabel(label: "사업 추가하기")
                    }
                    .padding(.bottom, 20)

                    NavigationLink {
//                        AddCustomerView()
//                            .navigationTitleFontDefault(title: "기업 추가하기")
                    } label: {
                        OtherTaskLabel()
                    }
                    BusinessCell()
                }
    }
            .sheet(isPresented: $dateViewModel.showStartCalendar, onDismiss: {
                isShowingSheet = true
            }) {
                startCalendarPopup
                // Custom Size
                    .presentationDetents([.calendarSize])
                    .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $dateViewModel.showFinishCalendar, onDismiss: {
                isShowingSheet = true
            }) {
                finishCalendarPopup
//                .onDisappear()
                .presentationDetents([.calendarSize])
                .presentationDragIndicator(.hidden)
            }
        } //: ScorllView
        .onAppear{
            infoViewModel.requestDetail(clientId: self.clientId)
        }
        .defaultAppStyleHorizentalPadding()

        .navigationBarItems(
            trailing:
                Button(action: {
                    alertRemove.toggle()
                }, label: {
                    Image("delete")
                }
            )
        )
        .popupNavigationAlertView(height: 182, show: $alertRemove) {
            RemoveClientAlert(showPopup: $alertRemove) { userChoice in
                if userChoice == true {
                    print("사용자가 삭제 누름")
                    infoViewModel.requestClientRemove(clientId: clientId) { result in
                        if result == true {
                            print("삭제완료")
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            print("삭제요청 실패")
                            //네트워크 알림창 출력
                        }
                    }
                } else {
                    print("사용자가 취소 누름")
                    //취소 눌러서 아무일도 안일어남
                }
            }
        }
    }
    
    var aboutCompany: some View {
        VStack(spacing:0){
            HStack(spacing: 0){
                Image("companyIcon")
                    .padding(10)
                    .background(
                        Circle()
                            .fill(Color("bg3"))
                    )
                
                Text(infoViewModel.clientName)
                    .font(.customTitle2)
                
                NavigationLink {
                    EditClientView(to: .edit(clientId))
                        .navigationTitleFontDefault(title: "기업명 수정하기")
                } label: {
                    Image("pencil")
                }
                
                
                Spacer()
            }
            .padding(.bottom, 20)
            
            DetailCustomerCallCell(label: "기술자 담당 전화", phoneNumber: infoViewModel.partManagerTel)
                .padding(.bottom, 20)
            HStack{
                Text("영업 담당 부서 / \(infoViewModel.department)")
                    .font(.body4)
                Spacer()
            }
            DetailCustomerCallCell(label: "기업대표전화", phoneNumber: infoViewModel.clientMainTel)
                .padding(.bottom, 10)
            
            DetailCustomerCallCell(label: "영업담당자명", phoneNumber: infoViewModel.partManagerName)
                .padding(.bottom, 70)
        }
    }
    
    var clientCountInfoBox: some View {
        HStack(spacing:10){
            NavigationLink {
                VisitGraphView()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("line2"), lineWidth: 1)
                        .background(Color("bg3"))
                    VStack{
                            Text("누적업무건수")
                            .font(.body1)
                                .foregroundColor(Color("font1"))
                        Image("visitImage")
                        Text(infoViewModel.taskCount)
                            .font(.special5)
                            .foregroundColor(Color("main"))
                    }
                }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("line2"), lineWidth: 1)
                    .background(Color("bg3"))
                VStack{
                    HStack{
                        Text("사업건수")
                            .font(.body1)
                            .foregroundColor(Color("font1"))
                    }
                    Image("businessImage")
                    Text(infoViewModel.businessCount)
                        .font(.special5)
                        .foregroundColor(Color("main"))
                }
            }
        }
        .frame(height:162)
    }
    
    
}

extension DetailClientView {
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

struct DetailClientView_Previews: PreviewProvider {
    @State static var isShowingSheet:Bool = false
    static var previews: some View {
        DetailClientView(clientId: 1, isShowingSheet: $isShowingSheet)
    }
}

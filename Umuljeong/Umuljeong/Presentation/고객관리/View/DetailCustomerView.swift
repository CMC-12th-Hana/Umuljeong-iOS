//
//  DetailCustomerView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct DetailCustomerView: View {
    @State private var searchText = ""
//    @State var showSheet: Bool = false
    @ObservedObject var viewModel = DetailCustomerViewModel()
    @Binding var isShowingSheet:Bool
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ScrollView {
            VStack(spacing:0){
                aboutCompany
                HStack{
                    Text("기업명과 함께한 사업")
                        .font(.customTitle2)
                    Spacer()
                }
                .padding(.bottom, 30)
                CustomerDetailImage()
                .padding(.bottom, 60)
                HStack{
                    Text("사업명 검색")
                    .font(.customTitle2)
                    Spacer()
                }
                .padding(.bottom, 20)
                SearchBar(text: $searchText, guideText: "찾으시는 사업명을 입력해주세요")
                .padding(.bottom, 20)
                StartFinishDateView(showStartCalendar: $viewModel.showStartCalendar, showFinishCalendar: $viewModel.showFinishCalendar, startDateString: viewModel.startDateString, finishDateString: viewModel.finishDateString)
                    .padding(.bottom, 40)
                VStack{
                    NavigationLink {
                        AddBusinessView()
                            .navigationTitleFontDefault(title: "사업 추가하기")
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
            .sheet(isPresented: $viewModel.showStartCalendar, onDismiss: {
                isShowingSheet = false
                // 네비게이션 링크 호출
//                presentationMode.wrappedValue.dismiss()
            }) {
                VStack(spacing:15){
                    HStack{
                        Button {
                            viewModel.tappedButtonPage(isPrev: true)
                        } label: {
                            Text("좌 버튼")
                        }
                        Text(viewModel.monthCalendarYearMonth)
                            .font(.customTitle2)
                        Button {
                            viewModel.tappedButtonPage(isPrev: false)
                        } label: {
                            Text("우 버튼")
                        }
                    }
                    StartDatePickCalendar(viewModel: viewModel)
                        .padding(.horizontal, 40)
                        .frame(height: 252)
    
                }
                    .background(Color.yellow)
                // Custom Size
                    .presentationDetents([.calendarSize])
                    .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $viewModel.showFinishCalendar) {
                VStack(spacing:15){
                    HStack{
                        Button {
                            viewModel.tappedButtonPage(isPrev: true)
                        } label: {
                            Text("좌 버튼")
                        }
                        Text(viewModel.monthCalendarYearMonth)
                            .font(.customTitle2)
                        Button {
                            viewModel.tappedButtonPage(isPrev: false)
                        } label: {
                            Text("우 버튼")
                        }
                    }
                    .frame(height: 20)
                    FinishDatePickCalendar(viewModel: viewModel)
                        .padding(.horizontal, 40)
                        .frame(height: 252)
                }
                .onDisappear()
    //                .frame(height: 400)
                    .background(Color.yellow)
                // Custom Size
                    .presentationDetents([.calendarSize])
                    .presentationDragIndicator(.hidden)
            }
        } //: ScorllView
        .defaultAppStyleHorizentalPadding()

        .navigationBarItems(
            trailing:
                NavigationLink {
                    AddCustomerView(clientId: 0) //여기 선택한 값 넣어주기
                        .navigationTitleFontDefault(title: "기업명 수정하기")
                } label: {
                    Image("pencil")
                })
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
                
                Text("기업명")
                    .font(.customTitle2)
                Spacer()
            }
            .padding(.bottom, 20)
            
            DetailCustomerCallCell(label: "기술자 담당 전화", phoneNumber: "02-4820-1123")
                .padding(.bottom, 20)
            HStack{
                Text("영업 담당 부서 / 부서명")
                    .font(.body4)
                Spacer()
            }
            DetailCustomerCallCell(label: "기업대표전화", phoneNumber: "02-4820-1123")
                .padding(.bottom, 10)
            
            DetailCustomerCallCell(label: "영업담당자명", phoneNumber: "02-4820-1123")
                .padding(.bottom, 70)
        }
    }
    
    
}

struct DetailCustomerView_Previews: PreviewProvider {
    @State static var isShowingSheet:Bool = false
    static var previews: some View {
        DetailCustomerView(isShowingSheet: $isShowingSheet)
    }
}

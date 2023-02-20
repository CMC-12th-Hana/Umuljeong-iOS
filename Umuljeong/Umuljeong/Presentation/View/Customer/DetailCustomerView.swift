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
                    
                    TaskWithDateCell()
                }
                
            }
                

            
            
        } //: ScorllView
        .sheet(isPresented: $viewModel.showStartCalendar) {
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
//                .frame(height: 400)
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
//                .frame(height: 400)
                .background(Color.yellow)
            // Custom Size
                .presentationDetents([.calendarSize])
                .presentationDragIndicator(.hidden)
        }
        .padding(.horizontal, 15)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .navigationBarBackButtonImageDefault()
        .navigationBarItems(
            trailing:
                NavigationLink {
                    AddCustomerView(업무부서명: "업무 부서명", 담당자명: "담당자명", 담당자전화번호: "담당자 전화번호")
                        .navigationTitleFontDefault(title: "기업명 수정하기")
                } label: {
                    Image("pencil")
                })
        .navigationTitleFontDefault(title: "기업 리스트 상세")
        
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
    static var previews: some View {
        DetailCustomerView()
    }
}

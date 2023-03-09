//
//  DetailCustomerView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct DetailClientView: View {
    @State private var searchText = ""
    let clientId: Int
//    @State var showSheet: Bool = false
//    @ObservedObject var viewModel = BusinessManagerViewModel()
    @ObservedObject var viewModel = DetailCustomerViewModel()
    @Binding var isShowingSheet:Bool
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ScrollView {
            VStack(spacing:0){
                aboutCompany
                HStack{
                    Text("\(viewModel.clientName)에서 함께한 사업")
                        .font(.customTitle2)
                    Image("info")
                    Spacer()
                }
                .padding(.bottom, 30)
                clientCountInfoBox
                .padding(.bottom, 60)
                
                // MARK: - 고객사의 사업 확인
//                HStack{
//                    Text("사업명 검색")
//                    .font(.customTitle2)
//                    Spacer()
//                }
//                .padding(.bottom, 20)
                
//                SearchBar(text: $searchText, guideText: "찾으시는 사업명을 입력해주세요")
//                .padding(.bottom, 20)
//                StartFinishDateView(showStartCalendar: $viewModel.showStartCalendar, showFinishCalendar: $viewModel.showFinishCalendar, startDateString: viewModel.startDateString, finishDateString: viewModel.finishDateString)
//                    .padding(.bottom, 40)
//                VStack{
//                    NavigationLink {
//                        AddBusinessView()
//                            .navigationTitleFontDefault(title: "사업 추가하기")
//                    } label: {
//                        PlusButtonLabel(label: "사업 추가하기")
//                    }
//                    .padding(.bottom, 20)
//
//                    NavigationLink {
////                        AddCustomerView()
////                            .navigationTitleFontDefault(title: "기업 추가하기")
//                    } label: {
//                        OtherTaskLabel()
//                    }
//                    BusinessCell()
//                }
            }
//            .sheet(isPresented: $viewModel.showStartCalendar, onDismiss: {
//                isShowingSheet = false
//            }) {
//                VStack(spacing:15){
//                    HStack{
//                        Button {
//                            viewModel.tappedButtonPage(isPrev: true)
//                        } label: {
//                            Text("좌 버튼")
//                        }
//                        Text(viewModel.monthCalendarYearMonth)
//                            .font(.customTitle2)
//                        Button {
//                            viewModel.tappedButtonPage(isPrev: false)
//                        } label: {
//                            Text("우 버튼")
//                        }
//                    }
//                    StartDatePickCalendar(viewModel: viewModel)
//                        .padding(.horizontal, 40)
//                        .frame(height: 252)
//
//                }
//                    .background(Color.yellow)
//                // Custom Size
//                    .presentationDetents([.calendarSize])
//                    .presentationDragIndicator(.hidden)
//            }
//            .sheet(isPresented: $viewModel.showFinishCalendar) {
//                VStack(spacing:15){
//                    HStack{
//                        Button {
//                            viewModel.tappedButtonPage(isPrev: true)
//                        } label: {
//                            Text("좌 버튼")
//                        }
//                        Text(viewModel.monthCalendarYearMonth)
//                            .font(.customTitle2)
//                        Button {
//                            viewModel.tappedButtonPage(isPrev: false)
//                        } label: {
//                            Text("우 버튼")
//                        }
//                    }
//                    .frame(height: 20)
//                    FinishDatePickCalendar(viewModel: viewModel)
//                        .padding(.horizontal, 40)
//                        .frame(height: 252)
//                }
//                .onDisappear()
//    //                .frame(height: 400)
//                    .background(Color.yellow)
//                // Custom Size
//                    .presentationDetents([.calendarSize])
//                    .presentationDragIndicator(.hidden)
//            }
        } //: ScorllView
        .onAppear{
            viewModel.requestDetail(clientId: self.clientId)
        }
        
        .defaultAppStyleHorizentalPadding()

        .navigationBarItems(
            trailing:
                Button(action: {
                    //고객사 삭제하기 통신
                }, label: {
                    Image("delete")
                }
            )
        )
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
                
                Text(viewModel.clientName)
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
            
            DetailCustomerCallCell(label: "기술자 담당 전화", phoneNumber: viewModel.partManagerTel)
                .padding(.bottom, 20)
            HStack{
                Text("영업 담당 부서 / \(viewModel.department)")
                    .font(.body4)
                Spacer()
            }
            DetailCustomerCallCell(label: "기업대표전화", phoneNumber: viewModel.clientMainTel)
                .padding(.bottom, 10)
            
            DetailCustomerCallCell(label: "영업담당자명", phoneNumber: viewModel.partManagerName)
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
                        Text(viewModel.taskCount)
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
                    Text(viewModel.businessCount)
                        .font(.special5)
                        .foregroundColor(Color("main"))
                }
            }
        }
        .frame(height:162)
    }
    
    
}

struct DetailCustomerView_Previews: PreviewProvider {
    @State static var isShowingSheet:Bool = false
    static var previews: some View {
        DetailClientView(clientId: 1, viewModel: DetailCustomerViewModel(), isShowingSheet: $isShowingSheet)
    }
}

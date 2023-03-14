//
//  BusinessManageView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI

struct BusinessView: View {
    @Binding var selectedTab: Tags
    @StateObject var viewModel = BusinessViewModel()
    @State var searchWord: String = ""
    
    var body: some View {
        VStack{
            searchArea
                .defaultAppStyleHorizentalPadding()
            
            StartFinishDateView(showStartCalendar: $viewModel.showStartCalendar, showFinishCalendar: $viewModel.showFinishCalendar, startDateString: viewModel.startDateString, finishDateString: viewModel.finishDateString)
                .padding(.bottom, 20)
            
            Divider()
                .padding(.bottom, 30)
            
            HStack(spacing:0){
                Image("businessImage")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(.trailing, 10)
                Text("내가 참여중인 사업")
                    .font(.body2)
                Spacer()
            }
            
            ScrollView{
                ForEach(viewModel.businessInfo, id: \.businessId) { info in
                    MainBusinessLabel(clientName: info.clientName, businessName: info.name, startDate: info.businessPeriodDto.start, finishDate: info.businessPeriodDto.finish, memberCount: info.memberDtoList.count)
                }
            }
        }
        .sheet(isPresented: $viewModel.showStartCalendar, onDismiss: {
//            isShowingSheet = true
        }) {
            startCalendarPopup
                .presentationDetents([.calendarSize])
                .presentationDragIndicator(.hidden)
        }
        .sheet(isPresented: $viewModel.showFinishCalendar, onDismiss: {
//            isShowingSheet = true
        }) {
            finishCalendarPopup
            .presentationDetents([.calendarSize])
            .presentationDragIndicator(.hidden)
        }
        .onAppear{
            viewModel.requestBusinessAll()
        }
    }
    
    var searchArea: some View {
        HStack(spacing: 15){
            SearchBar(text: $viewModel.searchText, guideText: "찾으시는 사업명을 입력해주세요")
        }
    }


    var startCalendarPopup: some View {
        VStack(spacing: 15){
            Spacer()
                .frame(height: 20)
            HStack(spacing: 15) {
                Button {
                    viewModel.tappedButtonPage(isPrev: true)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("leftButton"))
                }
                Text(viewModel.monthCalendarYearMonth)
                    .font(.customTitle2)
                
                Button {
                    viewModel.tappedButtonPage(isPrev: false)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("rightArrow"))
                }
            }
            StartDatePickCalendar(viewModel: viewModel)
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
                    viewModel.tappedButtonPage(isPrev: true)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("leftButton"))
                }
                Text(viewModel.monthCalendarYearMonth)
                    .font(.customTitle2)
                
                Button {
                    viewModel.tappedButtonPage(isPrev: false)
                } label: {
                    ImageBox(rectangleSize: 16, image: Image("rightArrow"))
                }
            }
            FinishDatePickCalendar(viewModel: viewModel)
                .padding(.horizontal, 40)
                .frame(height: 294)
        }
    }




}

struct BusinessManageView_Previews: PreviewProvider {
    @State static var selectedTab = Tags.tag1
    static var previews: some View {
        BusinessView(selectedTab: $selectedTab)
    }
}

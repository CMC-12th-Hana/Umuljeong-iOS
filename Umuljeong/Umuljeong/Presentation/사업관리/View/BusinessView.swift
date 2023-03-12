//
//  BusinessManageView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI

struct BusinessView: View {
    @Binding var selectedTab: Tags
    @ObservedObject var dateViewModel =  DateStartFinishViewModel()
    @ObservedObject var infoViewModel = BusinessViewModel()
    @State var searchWord: String = ""
    
    var body: some View {
        VStack{
            searchArea
                .defaultAppStyleHorizentalPadding()
            
            StartFinishDateView(showStartCalendar: $dateViewModel.showStartCalendar, showFinishCalendar: $dateViewModel.showFinishCalendar, startDateString: dateViewModel.startDateString, finishDateString: dateViewModel.finishDateString)
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
                BusinessCell()
                BusinessCell()
                BusinessCell()
                
            }
        }
        .sheet(isPresented: $dateViewModel.showStartCalendar, onDismiss: {
//            isShowingSheet = false
        }) {
            VStack(spacing:15){
                HStack{
                    Button {
                        dateViewModel.tappedButtonPage(isPrev: true)
                    } label: {
                        Text("좌 버튼")
                    }
                    Text(dateViewModel.monthCalendarYearMonth)
                        .font(.customTitle2)
                    Button {
                        dateViewModel.tappedButtonPage(isPrev: false)
                    } label: {
                        Text("우 버튼")
                    }
                }
                StartDatePickCalendar(viewModel: dateViewModel)
                    .padding(.horizontal, 40)
                    .frame(height: 252)

            }
                .background(Color.yellow)
            // Custom Size
                .presentationDetents([.calendarSize])
                .presentationDragIndicator(.hidden)
        }
        .sheet(isPresented: $dateViewModel.showFinishCalendar) {
            VStack(spacing:15){
                HStack{
                    Button {
                        dateViewModel.tappedButtonPage(isPrev: true)
                    } label: {
                        Text("좌 버튼")
                    }
                    Text(dateViewModel.monthCalendarYearMonth)
                        .font(.customTitle2)
                    Button {
                        dateViewModel.tappedButtonPage(isPrev: false)
                    } label: {
                        Text("우 버튼")
                    }
                }
                .frame(height: 20)
                FinishDatePickCalendar(viewModel: dateViewModel)
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
    }
    
    var searchArea: some View {
        HStack(spacing: 15){
            SearchBar(text: $infoViewModel.searchText, guideText: "찾으시는 사업명을 입력해주세요")
//            NavigationLink(destination: {
//                AddBusinessView()
//            }, label: {
//                ImageBox(rectangleSize: 24, image: Image("bluePlusButton"))
//            })
        }
    }
}

struct BusinessManageView_Previews: PreviewProvider {
    @State static var selectedTab = Tags.tag1
    static var previews: some View {
        BusinessView(selectedTab: $selectedTab)
    }
}

//
//  RoleSelectView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

struct RoleSelectView: View {
    @ObservedObject var viewModel = RoleSelectViewModel()
    @State var onTappedNew: Bool = false
    @State var onTappedJoin: Bool = false
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                goCompanyView
                    .frame(height: 230)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                self.onTappedNew = true
                            }
                            .onEnded { _ in
                                self.onTappedNew = false
                            }
                    )
                    
                goJoiningView
                    .frame(height: 230)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                self.onTappedJoin = true
                            }
                            .onEnded { _ in
                                self.onTappedJoin = false
                            }
                    )
            }
            .defaultAppStyleHorizentalPadding()
        }
        .popupNavigationAlertView(radius: 6, height: 197, show: $viewModel.validJoinAlert) {
            ValidJoinAlert(showPopup: $viewModel.validJoinAlert, moveMainTabView: $viewModel.moveMainTab)
        }
        .popupNavigationAlertView(radius: 6, height: 197,show: $viewModel.inValidJoinAlert) {
            InValidJoinAlert(showPopup: $viewModel.inValidJoinAlert)
        }
        .fullScreenCover(isPresented: $viewModel.moveMainTab) {
            MainTabView()
        }
    }
    
    
    var goCompanyView: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 6)
                .stroke(onTappedNew ? Color("main") : Color("line2"), lineWidth: 2)

            NavigationLink {
                CompanyCreateView()
            } label: {
                VStack(spacing: 0) {
                    ImageBox(rectangleSize: 120, image: Image("company"))
                        .padding(.bottom, 6)
                    Text("시작하기")
                        .font(.customTitle2)
                        .foregroundColor(Color("main"))
                        .padding(.bottom, 10)
                    HStack(spacing: 0){
                        Text("Field Mate")
                            .foregroundColor(Color("main"))
                        Text("를 통해 업무관리를 시작하시겠습니까?")
                            .foregroundColor(Color("font1"))
                    }
                    .font(.body3)
                }
                .background(Color.white)
            }
        }
        .background(Color.white)
    }
        
        
    var goJoiningView: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 6)
                .stroke(onTappedJoin ? Color("main") : Color("line2"), lineWidth: 2)
            Button {
                    viewModel.requestCheckVaildJoinCompany()
            } label: {
                VStack(spacing: 0) {
                    ImageBox(rectangleSize: 120, image: Image("joining"))
                        .padding(.bottom, 6)
                    Text("합류하기")
                        .font(.customTitle2)
                        .padding(.bottom, 10)
                    Text("초대를 받았다면 합류하기를 통해 시작하세요!")
                        .font(.body3)
                }
                .foregroundColor(Color("font1"))
            }
        }
    }
}

struct RoleSelectView_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectView()
    }
}

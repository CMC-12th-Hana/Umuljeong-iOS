//
//  BusinessDetailView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import SwiftUI

struct DetailBusinessView: View {
    @StateObject var viewModel = DetailBusinessViewModel()
    @State private var isShowingSheetStartDate = false
    let businessId:Int
    
    @State var text: String = "" //지울거
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 30) {
                
                BusinessInfoBoxView
                
                VStack(spacing: 10){
                    NavigationLink {
                        BusinessMemberListView(businessId: self.businessId)
                    } label: {
                        TaskMemberLabel(count: viewModel.memberCount)
                    }
                    
                    TaskGraphLabel()
                    TaskCalendarLabel()
                }
                
                descriptionView
            }
        }
        .onAppear{
            viewModel.requestInfoBusiness(businessId: self.businessId) { result in
                switch result {
                case .success:
                    print("로딩 성공")
                case .failure:
                    print("로딩 실패")
                }
            }
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    //사업 삭제하기 버튼 작동
                }, label: {
                    Image("delete")
                }
            )
        )
    }
        
    
    var BusinessInfoBoxView: some View {
        VStack(alignment:.leading, spacing: 20){
            HStack(spacing: 10){
                ZStack {
                    Circle()
                        .fill(Color("bg2"))
                        .frame(width: 40, height: 40)
                    
                    Image("companyIcon")
                }
                Text(viewModel.name)
                    .font(.customTitle2)
                
                NavigationLink {
                    EditBusinessView(isShowingSheet: $isShowingSheetStartDate, to: .fix(businessId))
                } label: {
                    ImageBox(rectangleSize: 24, image: Image("grayPencil"))
                }
                
                Spacer()
                
                
            }
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    BlueLable()
                    Text("\(viewModel.start)~\(viewModel.finish)")
                        .font(.body2)
                        .foregroundColor(Color("font1"))
                    
                }
                
                HStack {
                    GrayLabel()
                    Text(viewModel.revenue)
                        .font(.body2)
                        .foregroundColor(Color("font1"))
                }
            }
            .padding(.leading, 10)
        }
    }
    
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
            
            
            // MARK: - 텍스트 필드 아니고 고정으로 변경
            Text(viewModel.description)
//            MultilineTextField(text: $viewModel.description, placeholder: "사업 설명을 입력해주세요")
//                .autocorrectionDisabled(true)
//                .font(.body2)
//                .padding(.horizontal, 13)
//                .padding(.vertical, 10)
//                .frame(height: 260)
        }
    }
}

struct BusinessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailBusinessView(businessId: 0)
    }
}

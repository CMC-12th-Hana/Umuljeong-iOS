//
//  AddCustomerView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct AddCustomerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var inputText: String = ""
    @State var 업무부서명:String = ""
    @State var 담당자명:String = ""
    @State var 담당자전화번호:String = ""
    
    
    var body: some View {
        VStack{
            VStack(spacing:17) {
                BasicTextFiled(label: "기업 이름", placeHolder: "기업 이름을 입력해주세요", inputText: $inputText)
                BasicTextFiled(label: "기업 대표 전화", placeHolder: "기업 대표 전화번호를 입력해주세요", inputText: $inputText)
            }
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color("bg2"))
            )
            VStack(alignment:.leading){
                Text("해당 기업 영업 담당")
                    .font(.customTitle2)
                    .padding(.vertical, 30)
                BasicTextFiled(label: "부서명", placeHolder: "부서명을 입력해주세요", inputText: $업무부서명, checkRed: false)

                    .padding(.bottom, 20)
                BasicTextFiled(label: "담당자명 및 전화번호", placeHolder: "전화번호를 입력해주세요", inputText: $담당자명, checkRed: false)
                BasicTextFiled(label: "없음", placeHolder: "전화번호를 입력해주세요", inputText: $담당자전화번호, checkRed: false, isLabel: false)
            }
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("완료")
                    .font(.custom("Pretendard-Bold", size: 16))
                    .frame(width: 335, height: 50)
                    .foregroundColor(.white)
                    .background(
                        Color("main")
                            .cornerRadius(6)
                    )
            }
        }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
            .navigationBarBackButtonImageDefault()
    }
}

struct AddCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomerView()
    }
}

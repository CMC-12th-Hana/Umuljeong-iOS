//
//  SignUpView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

struct SignUpView: View {
    @State var inputText: String = ""
    
    var body: some View {
        VStack(spacing: 26) {
            VStack(alignment: .leading, spacing: 6) {
                Text("사용자 정보를 입력해 주세요")
                    .font(.custom("Pretendard-Bold", size: 24))
                Text("입력한 이메일 및 휴대폰 번호는 로그인 아이디로 사용됩니다.")
                    .font(.custom("Pretendard-Regular", size: 14))
            }.frame(width: 335)
                .padding(30)
            
            
            customTextField(label: "이름", inputText: inputText)
            customTextField(label: "이메일", inputText: inputText)
            customTextField(label: "휴대폰 번호", inputText: inputText)
            customTextField(label: "비밀번호", inputText: inputText)
            customTextField(label: "비밀번호 재입력", inputText: inputText)
            

            Button {
                //버튼 누르면 로그인 화면 이동
            } label: {
                Text("가입하기")
                    .font(.custom("Pretendard-Bold", size: 16))
                    .frame(width: 335, height: 50)
                    .foregroundColor(.white)
                    .background(
                        Color("main")
                            .cornerRadius(6)
                    )
            }
            

            
        }
        .navigationBarTitle("회원가입", displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.white,                                         for: .navigationBar)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


struct customTextField: View {
    
    @State var inputText:String
    var label:String
    
    init(label: String, inputText: String) {
        self.label = label
        self.inputText = inputText
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 1) {
                Text(label)
                Text("*")
            }
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1.0)
                    .fill(Color("line1"))
                    .frame(width: 335, height: 49)
                
                
                TextField("이메일 또는 휴대폰 번호", text: $inputText)
                    .font(.custom("Pretendard-Regular", size: 16))
                    .frame(width: 305, height: 49)
            }
        }
    }
}

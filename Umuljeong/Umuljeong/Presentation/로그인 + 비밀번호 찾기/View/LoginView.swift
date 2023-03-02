//
//  SignInView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

struct LoginView: View {
    // property
    @State var inputText: String = ""
    @State var userNameData: [String] = []
    @State var autoLogin: Bool = true
    @State var saveId: Bool = false
    
    var body: some View {
    
        NavigationView {
            VStack (spacing: 20) {
                Image("Vector")
                    .resizable()
                    .frame(width: 60, height: 61.3)
                    .padding(50)
                
                // TextField 한줄 - 적은양의 text 입력시 사용
                
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1.0)
                        .fill(Color("line1"))
                        .frame(width: 335, height: 49)
                        
                    
                    TextField("이메일 또는 휴대폰 번호", text: $inputText)
                        .font(.custom("Pretendard-Regular", size: 16))
                        .frame(width: 305, height: 49)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1.0)
                        .fill(Color("line1"))
                        .frame(width: 335, height: 49)
                        
                    
                    TextField("비밀번호 입력", text: $inputText)
                        .font(.custom("Pretendard-Regular", size: 16))
                        .frame(width: 305, height: 49)
                }
                
                HStack(spacing: 15) {
                    Group {
                        HStack {
                            noCheckBox
                            Text("자동로그인")
                                .font(.custom("Pretendard-Regular", size: 13))
                                
                        }
                        HStack {
                            yesCheckBox
                            Text("아이디 저장")
                                .font(.custom("Pretendard-Regular", size: 13))
                        }
                    }.frame(height: 24)
                    .foregroundColor(Color("font2") )
                    Spacer()
                }.frame(width: 335)
                    
                    
                VStack(spacing: 10) {
                    Button {
                        //버튼 누르면 로그인 화면 이동
                    } label: {
                        Text("로그인")
                            .font(.custom("Pretendard-Bold", size: 16))
                            .frame(width: 335, height: 50)
                            .foregroundColor(.white)
                            .background(
                                Color("main")
                                    .cornerRadius(6)
                            )
                    }
                    
                    Button {
                        // action
                        
                    } label: {
                        // label
                        Text("비밀번호 찾기")
                            .font(.custom("Pretendard-Regular", size: 14))
                            .underline()
                    }
                    .accentColor(Color("font2"))
                }
                
                NavigationLink {
                    // destination : 목적지 -> 어디로 페이지 이동할꺼냐
                    SignUpView()
                } label: {
                    Text("회원가입")
                        .font(.custom("Pretendard-Bold", size: 16))
                        .foregroundColor(Color("main"))
                        .frame(width: 335, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("main"), lineWidth: 1.5)
                        )
                }.navigationTitle("")
                

            
            }// : VStack
            .padding()
            
        } // : Navigation
        } // : Body

    
    
    var noCheckBox: some View {
        ZStack {
            Rectangle()
                .fill(Color("main"))
                .frame(width: 24, height: 24)
                .cornerRadius(2)
            
            Image("check")
        }
    }
    
    var yesCheckBox: some View {
        ZStack {
            Rectangle()
                .fill(Color("bg1"))
                .frame(width: 24, height: 24)
                .cornerRadius(2)
            Image("check")
        }
    }
    
    
        // function
        func isTextEnough() -> Bool {
        // 2개 이상의 텍스트가 되면 ture, 아니면 false
        if inputText.count >= 2 {
            return true
        } else {
            return false
        }
        }

        func saveText() {
        userNameData.append(inputText)
        inputText = ""
        }

}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

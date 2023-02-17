//
//  ButtonTextFiled.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/10.
//

import SwiftUI

struct ButtonTextFiled: View {
    @Binding var inputText:String
    @Binding var errorMessage: String?
    let textFiledStyle: TextFiledStyle
    let onTapGesture: Bool?
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 1) {
                Text(self.textFiledStyle.type)
                    .font(.custom("Pretendard-Regular", size: 16))
                Text("*")
                    .foregroundColor(Color("error"))
                    .font(.custom("Pretendard-Regular", size: 16))
            }
            
            HStack(alignment: .firstTextBaseline, spacing: 7.75) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1.0)
                        .fill(roundRectangleColorChange())
                        .frame(height: 46)
                    
                    TextField(textFiledStyle.placeHolder, text: $inputText)
                        .font(.custom("Pretendard-Regular", size: 16))
                        .padding(13)
                        .frame(height: 46)
                }
                
                Button {
                    print("")
                } label: {
                    Text(buttonName)
                        .font(.custom("Pretendard-Regular", size: 16))
                        .foregroundColor(Color("line2"))
                        .padding(13)
                        .frame(height: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("line2"), lineWidth: 1)
                        )
                }
            }
        }
        .frame(width: 335)
    }
    
    var buttonName:String {
        switch self.textFiledStyle {
        case .email:
            return "중복확인"
        case .phoneNumber:
            return "인증번호 받기"
        default:
            return "중복확인"
        }
    }
    
    func roundRectangleColorChange() -> Color {
        guard let onTap = onTapGesture else {return Color("line1")}
        
        if onTap {
            return Color("font1")
        } else {
            if inputText != "" && errorMessage != nil {
                return Color("error")
            }
            return Color("line1")
        }
    }
}

struct ButtonTextFiled_Previews: PreviewProvider {
    @State static var contentText: String = ""
    @State static var text: String?
    static var previews: some View {
        ButtonTextFiled(inputText: $contentText, errorMessage: $text, textFiledStyle: .email, onTapGesture: nil)
    }
}

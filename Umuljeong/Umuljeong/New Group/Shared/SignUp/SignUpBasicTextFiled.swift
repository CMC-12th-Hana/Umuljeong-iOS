//
//  SignUpBasicTextFiled.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/07.
//

import SwiftUI

struct SignUpBasicTextFiled: View {
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
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1.0)
                    .fill(roundRectangleColorChange())
                    .frame(width: 335, height: 46)
                
                if textFiledStyle.isPasswordField {
                    SecureField(textFiledStyle.placeHolder, text: $inputText)
                        .font(.custom("Pretendard-Regular", size: 16))
                        .frame(width: 305, height: 46)
                        .textContentType(.username)
                } else {
                    TextField(textFiledStyle.placeHolder, text: $inputText)
                        .font(.custom("Pretendard-Regular", size: 16))
                        .frame(width: 305, height: 46)
                }
            }
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

struct SignUpBasicTextFiled_Previews: PreviewProvider {
    @State static var contentText: String = "안녕하세요"
    @State static var text: String?
    static var previews: some View {
        SignUpBasicTextFiled(inputText: $contentText, errorMessage: $text, textFiledStyle: .username, onTapGesture: nil)
    }
}



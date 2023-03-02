//
//  BasicTextFiled.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/10.
//

import Foundation
import SwiftUI

struct BasicTextFiled: View {
    var label:String
    var placeHolder:String
    @Binding var inputText:String
    var checkRed:Bool = true
    var isLabel:Bool = true
    @State var placeHolderColor:Color = Color("line2")
        
    var body: some View {
        VStack(spacing:8){
            HStack(spacing: 1) {
                if isLabel {
                    Text(label)
                        .font(.body3)
                    if checkRed {
                        Text("*")
                            .foregroundColor(Color("error"))
                            .font(.body3)
                    }
                }
                Spacer()
            }
            
            TextField(placeHolder, text: $inputText, onEditingChanged: { onEditingChanged in
                if !onEditingChanged {
                    placeHolderColor = Color("line2")
                } else {
                    placeHolderColor = Color("line1")
                }
            })
            .padding(.leading, 15)
            .font(.body3)
            .frame(height: 54)
            .foregroundColor(Color("font1"))
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1.0)
                    .fill(placeHolderColor)
                    .frame(height: 46)
            )
            
        }
    }
}

struct BasicTextFiled_Previews: PreviewProvider {
    @State static var contentText: String = ""
    static var previews: some View {
        BasicTextFiled(label: "이룸", placeHolder: "이름을 입력하세요", inputText: $contentText)
    }
}

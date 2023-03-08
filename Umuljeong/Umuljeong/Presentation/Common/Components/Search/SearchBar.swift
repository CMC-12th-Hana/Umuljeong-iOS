//
//  SearhBar.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/18.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let guideText:String
//    var onEditingChanged:(()->())?
    
    var body: some View {
        HStack {
            HStack(spacing: 10) {
                Image("glass")
                    .padding(.leading, 15)
 
                TextField(guideText, text: $text, onEditingChanged: { changed in
                    print("텍스트 필드 내 호출 시점 확인")
//                    if changed {
//                        print("텍스트 필드 내 호출 changed == true 호출 시점 확인")
//                        guard let onEditingChange = onEditingChanged else {return}
//                        onEditingChange()
//                    }
                })
                    .font(.body3)
                    .foregroundColor(Color("font1"))
                    .padding(EdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0))
 
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .padding(.trailing, 15)
                    }
                } else {
                    EmptyView()
                }
            }
            .foregroundColor(.secondary)
            .background(Color("bg2"))
            .cornerRadius(10.0)
        }
    }
}


struct SearchBar_Previews: PreviewProvider {
    @State static var textt:String = ""
    static var previews: some View {
        SearchBar(text: $textt, guideText: "찾으시는 기업명을 입력해주세요")
    }
}

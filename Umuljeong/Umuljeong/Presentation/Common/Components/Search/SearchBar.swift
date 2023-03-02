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
    
    var body: some View {
        HStack {
            HStack(spacing: 10) {
                Image("glass")
                    .padding(.leading, 15)
 
                TextField(guideText, text: $text)
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

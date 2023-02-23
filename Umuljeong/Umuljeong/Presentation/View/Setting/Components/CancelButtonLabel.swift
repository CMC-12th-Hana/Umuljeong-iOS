//
//  CancelButtonLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/22.
//

import SwiftUI

struct CancelButtonLabel: View {
    
    var body: some View {
        HStack{
            Spacer()
            Text("취소")
                .font(.body1)
                .foregroundColor(Color("font2"))
            Spacer()
        }
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("bg2"))
        )
    }
}

struct CancelButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        CancelButtonLabel()
    }
}

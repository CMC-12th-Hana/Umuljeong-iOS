//
//  LeaderLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/01.
//

import SwiftUI

struct LeaderLabel: View {
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.black)
                .frame(width: width, height: height)
            Text("리더")
                .foregroundColor(Color.white)
                .font(.special1)
        }
    }
}

struct LeaderLabel_Previews: PreviewProvider {
    static var previews: some View {
        LeaderLabel(width: 30, height: 17)
    }
}

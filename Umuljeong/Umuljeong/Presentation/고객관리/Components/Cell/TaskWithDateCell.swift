//
//  TaskWithDateCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct BusinessCell: View {
    var body: some View {
        ZStack {
            HStack(spacing:0){
                VStack(alignment: .leading, spacing: 0){
                    Text("리얼코리아")
                        .padding(.bottom, 4)
                    Text("2023.1.23 - 1.15")
                }
                Spacer()
                HStack{
                    Image("defaultUser")
                        .padding(5)
                        .background(
                            Circle()
                                .fill(Color("bg2"))
                        )
                        .padding(.trailing, 6)
                    Text("5")
                }
                
            }
        }
        .padding(15)
        .frame(height: 85)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("bg3"))
        )
    }
}

struct BusinessCell_Previews: PreviewProvider {
    static var previews: some View {
        BusinessCell()
    }
}

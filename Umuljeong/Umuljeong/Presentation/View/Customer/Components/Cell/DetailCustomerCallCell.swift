//
//  DetailCustomerCallCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct DetailCustomerCallCell: View {
    let label:String
    let phoneNumber:String
    
    var body: some View {
        ZStack {
                HStack(alignment:.center, spacing:8){
                    Text(label)
                        .padding(.trailing, 30)
                    Text(phoneNumber)
                    
                    Spacer()
                    
                    Button {
                        //전화걸기
                    } label: {
                        Image("phone")
                            .padding(.vertical, 6)
                            .padding(.horizontal, 13)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color("line2"), lineWidth: 1)
                            )
                    }
                }//: HStack
                .font(.body4)
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("bg3"))
                )
        }
    }
}

struct DetailCustomerCallCell_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailCustomerCallCell(label: "영업부서", phoneNumber: "010-2222-2222")
    }
}

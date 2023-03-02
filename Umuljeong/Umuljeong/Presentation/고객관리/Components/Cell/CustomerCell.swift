//
//  CustomerCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct CustomerCell: View {
    let customer:String
    let visitCount:Int
    let businessCount:Int
    
    var body: some View {
        ZStack {
            VStack(alignment:.leading){
                HStack(alignment:.top, spacing:8){
                    visitsLabel
                    businessLabel
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
                Text(customer)
                    .foregroundColor(Color("font1"))
            }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("bg3"))
                )
        }
    }
    
    var visitsLabel: some View {
        ZStack {
            HStack(spacing: 3){
                Text("방문건수")
                Text("\(visitCount)")
            }
                .font(.body3)
                .foregroundColor(Color("font3"))
                .padding(.vertical, 3)
                .padding(.horizontal, 8)
                .background(
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color("main"))
                )
        }
    }
        
        var businessLabel: some View {
            ZStack {
                HStack(spacing: 3){
                    Text("사업건수")
                    Text("\(businessCount)")
                }
                    .font(.body3)
                    .foregroundColor(Color("main"))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color("main").opacity(0.4), lineWidth: 1)
                    )
            }
    }
}


struct CustomerCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomerCell(customer: "고객사", visitCount: 0, businessCount: 0)
    }
}

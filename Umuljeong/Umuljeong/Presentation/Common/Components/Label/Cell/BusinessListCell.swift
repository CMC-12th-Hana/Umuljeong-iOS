//
//  BusinessListCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/16.
//

import SwiftUI

struct BusinessListCell: View {
    let work:String
    let customer:String
    let category:String
    let categoryColor:CategoryColor
    
    var body: some View {
        ZStack {
            HStack{
                VStack(alignment:.leading, spacing: 3){
                    Text(work).font(.custom("Pretendard Bold", size: 16)).foregroundColor(Color("font4"))
                    
                    Text(customer).font(.custom("Pretendard Medium", size: 14)).foregroundColor(Color("font2"))
                    
                }
                Spacer()
                
                CategoryLabel(label: category, color: categoryColor)
            }
                .font(.custom("Pretendard-Regular", size: 16))
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("bg3"))
                )
        }
    }
}

struct BusinessListCell_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListCell(work: "디지툴리얼코리아 전용 회선", customer: "디지털 리얼 코리아", category: "문의", categoryColor: .first)
    }
}

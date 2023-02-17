//
//  WorkListCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/16.
//

import SwiftUI

struct WorkListCell: View {
    let work:String
    let custumer:String
    let category:String
    let categoryColor:Color
    
    var body: some View {
        ZStack {
            HStack{
                VStack(alignment:.leading, spacing: 3){
                    Text(work).font(.custom("Pretendard Bold", size: 16)).foregroundColor(Color("font4")).tracking(0.46)
                    
                    Text(custumer).font(.custom("Pretendard Medium", size: 14)).foregroundColor(Color("font2")).tracking(0.46)
                    
                }
                Spacer()
                
                WorkLabel(label: category, color: categoryColor)
            }
                .font(.custom("Pretendard-Regular", size: 16))
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("bg3"))
//                     .stroke(Color("line2").opacity(0.7), lineWidth: 1)
                    //                .foregroundColor(Color("line2"))
                )
        }
    }
}

struct WorkListCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkListCell(work: "디지툴리얼코리아 전용 회선", custumer: "디지털 리얼 코리아", category: "문의", categoryColor: Color("main"))
    }
}

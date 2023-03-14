//
//  TaskWithDateCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct ClientBusinessLabel: View {
    var businessName:String = "사업명"
    var startDate:String = "2023.00.00"
    var finishDate:String = "2023.00.00"
    var memberCount:Int = 0
    
    var body: some View {
        ZStack {
            HStack(alignment: .bottom){
                VStack(alignment: .leading, spacing: 0){
                    Text(businessName)
                        .font(.body1)
                        .foregroundColor(Color("font1"))
                        .padding(.bottom, 4)
                    Text("\(startDate) - \(finishDate)")
                        .foregroundColor(Color("font2"))
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
                    Text("\(memberCount)")
                        .font(.body2)
                }
                .padding(.trailing, 5)
                
            }
        }
        .padding(15)
        .frame(height: 86)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("bg3"))
        )
    }
}

struct BusinessCell_Previews: PreviewProvider {
    static var previews: some View {
        ClientBusinessLabel()
    }
}

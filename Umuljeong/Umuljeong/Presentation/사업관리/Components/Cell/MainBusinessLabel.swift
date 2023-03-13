//
//  MainBusinessLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/14.
//

import SwiftUI

struct MainBusinessLabel: View {
    var clientName:String = "고객사명"
    var businessName:String = "사업명"
    var startDate:String = "2023-00-00"
    var finishDate:String = "2023-00-00"
    var memberCount:Int = 0
    
    var body: some View {
        ZStack {
            HStack(alignment: .bottom){
                VStack(alignment: .leading, spacing: 0){
                    
                    Text(clientName)
                        .font(.body3)
                        .foregroundColor(Color("font2"))
                    Text(businessName)
                        .font(.body1)
                        .foregroundColor(Color("font1"))
                        .padding(.bottom, 10)
                        
                    Text("\(startDate) ~ \(finishDate)")
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
        .frame(height: 112)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("bg3"))
        )
    }
}

struct MainBusinessLabel_Previews: PreviewProvider {
    static var previews: some View {
        MainBusinessLabel()
    }
}


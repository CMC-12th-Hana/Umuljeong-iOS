//
//  TaskMemberLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import SwiftUI

struct TaskMemberLabel: View {
    var title:String = "참여한 구성원"
    var count:Int
    var body: some View {
        ZStack {
            HStack(spacing:0){
        
                
                profileCircle
                    .padding(.trailing, 20)
                
                Text(title)
                    .font(.body2)
                    .foregroundColor(Color("font1"))
                
                Spacer()
                
                HStack(spacing: 4) {
                    Text(count > 0 ? String(count) : "")
                            .font(.body1)
                            .foregroundColor(Color("main"))
                    
                    ImageBox(rectangleSize: 24, image: Image("rightArrow"))
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 70)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("bg3"))
        )
    }
    
    var profileCircle: some View {
        ZStack {
            Circle()
                .fill(Color("bg2"))
                .frame(width: 30, height: 30)

            Rectangle()
                .fill(Color.clear)
                .overlay(
                    ZStack{
                        Image("defaultUser")
                            .padding(.top, 5.36)
                    }
                    .frame(width:30, height:30)
                    .clipShape(Circle())
                )
            
        }
        .frame(width: 30, height: 30)
    }
}

struct TaskMemberLabel_Previews: PreviewProvider {
    static var previews: some View {
        TaskMemberLabel(count: 0)
    }
}

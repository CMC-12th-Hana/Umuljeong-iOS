//
//  CustomerDetailImage.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct CustomerDetailImage: View {
    let 방문건수:String = ""
    let 사업건수:String = ""
    var body: some View {
        HStack(spacing:10){
            NavigationLink {
                VisitGraphView()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("line2"), lineWidth: 1)
                        .background(Color("bg3"))
                    VStack{
                        HStack{
                            Text("방문건수")
                                .foregroundColor(Color("font1"))
                            Image("info")
                        }
                        Image("visitImage")
                        Text(방문건수)
                    }
                }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("line2"), lineWidth: 1)
                    .background(Color("bg3"))
                VStack{
                    HStack{
                        Text("사업건수")
                            .foregroundColor(Color("font1"))
                    }
                    Image("businessImage")
                    Text(방문건수)
                }
            }
        }
        .frame(height:162)
    }
}



struct CustomerDetailImage_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetailImage()
    }
}

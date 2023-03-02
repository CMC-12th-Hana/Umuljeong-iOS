//
//  EmployeeProfileView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct EmployeeProfileView: View {
    @State var searchWord: String = ""
    
    var body: some View {
        VStack{
            SearchBar(text: $searchWord, guideText: "이름/사번/휴대폰번호")
            
            ScrollView{
                
            }
        }
        .padding(.horizontal, 15)
    }
}

struct EmployeeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeProfileView()
    }
}

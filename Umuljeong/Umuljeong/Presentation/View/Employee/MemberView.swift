//
//  MemberView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI

struct MainEmployeeView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        Text("MemberView")
    }
}

struct MemberView_Previews: PreviewProvider {
    @State static var selectedTab = 3
    static var previews: some View {
        MainEmployeeView(selectedTab: $selectedTab)
    }
}

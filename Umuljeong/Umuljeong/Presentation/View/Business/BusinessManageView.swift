//
//  BusinessManageView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI

struct BusinessManageView: View {
    @Binding var selectedTab: Int
    var body: some View {
        Text("BusinessManageView")
    }
}

struct BusinessManageView_Previews: PreviewProvider {
    @State static var selectedTab = 2
    static var previews: some View {
        BusinessManageView(selectedTab: $selectedTab)
    }
}

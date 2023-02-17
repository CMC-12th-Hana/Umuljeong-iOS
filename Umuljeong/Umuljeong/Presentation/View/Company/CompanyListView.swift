//
//  CompanyListView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI

struct CompanyListView: View {
    @Binding var selectedTab: Int
    var body: some View {
        Text("CompanyListView")
            .navigationBarItems(
                leading: Image(systemName: "line.3.horizontal"),
                trailing: Button(action: {
                }, label: {
                    Image(systemName: "person")
                }))
        }
    }

struct CompanyListView_Previews: PreviewProvider {
    @State static var selectedTab = 1
    static var previews: some View {
        CompanyListView(selectedTab: $selectedTab)
    }
}

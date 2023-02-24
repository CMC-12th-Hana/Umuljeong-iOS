//
//  SearhView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/23.
//

import SwiftUI

struct SearhView: View {
    @State var searchText:String = ""
    let searchTopic:String
    var body: some View {
        ScrollView{
            SearchBar(text: $searchText, guideText: "찾으시는 \(searchTopic)을 입력해주세요")
            
        }
    }
}

struct SearhView_Previews: PreviewProvider {
    @State static var searchText:String = ""
    static var previews: some View {
        SearhView(searchTopic: "고객사명")
    }
}

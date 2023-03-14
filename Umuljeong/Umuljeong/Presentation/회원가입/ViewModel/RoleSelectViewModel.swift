//
//  RoleSelectViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/07.
//

import Foundation

class RoleSelectViewModel: ObservableObject {
    @Published var validJoinAlert: Bool = false
    @Published var inValidJoinAlert: Bool = false
    @Published var moveMainTab: Bool = false
    
    func requestCheckVaildJoinCompany() {
        let networkResult = true//임의의 값
        if networkResult == true {
            validJoinAlert = true
        } else {
            inValidJoinAlert = true
        }
    }
    
    
    
}

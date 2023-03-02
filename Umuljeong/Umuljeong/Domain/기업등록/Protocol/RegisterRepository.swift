//
//  RegisterRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol RegisterCompanyRepository {
    func requestJoin(companyInfo: RegisterCompanyInfo) -> 서버응답
}

protocol RegisterUserRepository {
    func requestJoin(companyInfo: RegisterCompanyInfo) -> 서버응답
}

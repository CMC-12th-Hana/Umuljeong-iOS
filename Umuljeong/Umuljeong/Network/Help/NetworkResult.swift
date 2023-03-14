//
//  NetworkResult.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/02.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestError
    case pathError
    case serverError
    case networkFail
}

enum CodeNetworkResult<T> {
    case succes(T)
    case requestError //잘못된 코드 번호
    case pathError 
    case serverError
    case networkFail
}

enum SignupNetworkResult<T> {
    case success(T)
    case requestError //잘못된
    case pathError
    case serverError
    case networkFail
}

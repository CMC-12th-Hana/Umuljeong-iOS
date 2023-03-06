//
//  NetworkError.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/04.
//

import Foundation

enum NetworkError<T>: Error {
     case requestError //실패이긴 한데, 어떤 결과인 지
     case networkFail //아예 통신 실패
}

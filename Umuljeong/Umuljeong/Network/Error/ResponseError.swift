//
//  ResponseError.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/08.
//

import Foundation

enum ResponseError: Error {
    case requestError(String)
    case token
}


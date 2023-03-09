//
//  ResponseErrorMessage.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/08.
//

import Foundation

struct ErrorMessageReponse:Codable {
    let errorCode: String
    let message: String
    let cause: String
}

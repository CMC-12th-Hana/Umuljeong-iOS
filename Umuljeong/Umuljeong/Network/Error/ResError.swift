//
//  ResError.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/10.
//

import Foundation

//진짜 진짜 최종
enum ResError: Error {
    case BAD_REQUEST_400(String) //요청한 양식 문제 //400
    case NOT_FOUND_404(String) //없는 자료 접근 //404
    case OVER_TOKEN_401 //토큰 문제 //로그인 화면 변경 //그냥 화면 하나 파기 //401
    case CHANGE_AUTHORITY_403 //권한 변경 //로그인 화면 변경 //그냥 화면 하나 파기 //403
    case FAILURE_NETWORK //네트워크 실패 //그냥 화면 하나 파기
    case NON_TOKEN //토큰이 아예 없음 
}

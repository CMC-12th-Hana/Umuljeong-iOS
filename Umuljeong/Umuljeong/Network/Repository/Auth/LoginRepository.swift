//
//  LoginRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/04.
//

import Foundation
import Alamofire

class LoginRepository {

    func requestLogin(loginInfo: LoginInfo, completion: @escaping (Bool) -> Void) {
        let url = URLConstants.Auth_Login //통신할 API 주소

        let header : HTTPHeaders = ["Content-Type":"application/json"]
        
        //요청 바디
        let body : Parameters = [
            "phoneNumber": loginInfo.phoneNumber,
            "password": loginInfo.password
        ]
        
        let dataRequest = AF.request(url,
                                    method: .post,
                                    parameters: body,
                                    encoding: JSONEncoding.default,
                                    headers: header)
        
        //request 시작 ,responseData를 호출하면서 데이터 통신 시작
        dataRequest.responseData{
            response in //데이터 통신의 결과가 response에 담기게 된다
            switch response.result {
            case .success: //데이터 통신이 성공한 경우에
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(false)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> Bool {
        switch statusCode {
        case ..<300 : return isVaildData(data: data);
//        case 400...500 : return false
        default : return false
        }
    }
    
    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
    private func isVaildData(data: Data) -> Bool {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        guard let decodedData = try? decoder.decode(SignupResponse.self, from: data) else {return false}
        ApiManager.shared.accessTokenSet(accessToken: decodedData.accessToken ?? "")
        return true
    }
    
}

enum LoginError:Error {
    case requestError
    case responseModelError
    case networkFail
}

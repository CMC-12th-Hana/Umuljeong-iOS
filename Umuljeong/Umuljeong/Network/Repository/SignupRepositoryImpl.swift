//
//  LoginRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/02.
//

import Foundation
import Alamofire


class SignupRepositoryImpl {

    func requestSignup(signupInfo: SignupInfo, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstants.signupURL //통신할 API 주소

        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
        
        //요청 바디
        let body : Parameters = [
            "name": signupInfo.name,
            "phoneNumber": signupInfo.phoneNumber,
            "password": signupInfo.password,
            "passwordCheck" : signupInfo.passwordCheck
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
                
//            case .success(let res):
//                print(String(data: res, encoding: .utf8) ?? "") // 바디 출력
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case ..<300 : return isVaildData(data: data)
        case 400..<500 : return .pathError
        case 500..<600 : return .serverError
        default : return .networkFail
        }
    }
    
    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
    private func isVaildData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        guard let decodedData = try? decoder.decode(SignupResponse.self, from: data) else { return .pathError }
        
        return .success(decodedData as Any)
    }
    
}

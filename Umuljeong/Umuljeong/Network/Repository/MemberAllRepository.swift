//
//  MemberAddsRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation
import Alamofire
import KeychainSwift

class MemberAllRepository {

    func requestMemberAll(completion: @escaping (Result<Bool, NetworkError<Bool>>) -> Void) {
        let url = URLConstants.Member_All(companyId: "1") //통신할 API 주소

        guard let accessToken = KeychainSwift().get("accessToken") else {
            return completion(.failure(.networkFail))
                }

        let header : HTTPHeaders = ["Content-Type":"application/json",
                                    "Authorization":"Bearer " + accessToken]
    
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        //request 시작 ,responseData를 호출하면서 데이터 통신 시작
        dataRequest.responseData{
            response in //데이터 통신의 결과가 response에 담기게 된다
            switch response.result {
            case .success(let res): //데이터 통신이 성공한 경우에
                
//            case .success(let res):
                print(String(data: res, encoding: .utf8) ?? "") // 바디 출력
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                if networkResult == .success(true) {
                    completion(networkResult)
                }
                
                if networkResult == .failure(.requestError) {
                    print("토큰만료임!!!")
                    ApiManager.shared.refreshToken { isSuccess in
                        if isSuccess {
                            print("토큰 새로 받아오기 성공 ><")
                            completion(.success(true))
                        } else {
                            print("토큰 새로 받아오기 실패ㅠㅠ")
                            completion(.failure(.networkFail))
                        }
                    }
                }
                
            case .failure:
                completion(.failure(.networkFail))
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> Result<Bool, NetworkError<Bool>> {
        switch statusCode {
        case ..<300 : return .success(true)
        case 404 : return .failure(.requestError)
        default : return .failure(.networkFail)
        }
    }
    
    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
//    private func isVaildData(data: Data) -> Result<Bool, NetworkError<Bool>> {
//        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
//        guard let decodedData = try? decoder.decode(SignupResponse.self, from: data) else { return .pathError }
//
//        return .success(decodedData as Any)
//    }
    
}


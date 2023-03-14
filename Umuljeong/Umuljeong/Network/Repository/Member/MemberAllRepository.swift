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

    func requestMemberAll(completion: @escaping (Result<MemberAllInfoResponse?, ResError>) -> Void) {
        
        guard let accessToken = KeychainSwift().get("accessToken") else {
            return completion(.failure(.NON_TOKEN))
                }
        
        guard let companyId = ApiManager.shared.myCompanyId() else {
            return completion(.failure(.CHANGE_AUTHORITY_403))
        }
            
        let url = URLConstants.Member_All(companyId: companyId) //통신할 API 주

        let header : HTTPHeaders = ["Content-Type":"application/json",
                                    "Authorization":"Bearer " + accessToken]
    
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        
        dataRequest.responseData { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            
            case .success(let res): //데이터 통신이 성공한 경우에
                
                print(String(data: res, encoding: .utf8) ?? "") // 바디 출력
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                if statusCode == 401 {
                    print("토큰만료임!!!")
                    ApiManager.shared.refreshToken { isSuccess in
                        if isSuccess {
                            print("토큰 새로 받아오기 성공 ><")
                            self.requestMemberAll(completion: completion)
                        } else {
                            print("토큰 새로 받아오기 실패ㅠㅠ")
                            completion(.failure(.OVER_TOKEN_401))
                        }
                    }
                } else {
                    let networkResult = self.judgeStatus(by: statusCode, value)
                    completion(networkResult)
                }
                
            case .failure:
                completion(.failure(.FAILURE_NETWORK))
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data) -> Result<MemberAllInfoResponse?, ResError> {
        switch statusCode {
        case ..<300: return .success(isVaildData(data: data))
        case 400: return .failure(.BAD_REQUEST_400(isInValidData(data: data)))
        case 401: return .failure(.OVER_TOKEN_401)
        case 403: return .failure(.CHANGE_AUTHORITY_403)
        case 404: return .failure(.NOT_FOUND_404(isInValidData(data: data)))
        default: return .failure(.FAILURE_NETWORK)
        }
    }
    
    private func isVaildData(data: Data) -> MemberAllInfoResponse? {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        guard let decodedData = try? decoder.decode(MemberAllInfoResponse.self, from: data) else { return nil }
        return decodedData
    }
    
    private func isInValidData(data: Data) -> String {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ErrorMessageReponse.self, from: data) else { return "네트워크 연결 상태가 좋지 않습니다." }
        return decodedData.message
    }
    
}


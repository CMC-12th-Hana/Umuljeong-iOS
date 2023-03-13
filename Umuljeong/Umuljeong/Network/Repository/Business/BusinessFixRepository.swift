//
//  BusinessFixRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation
import Alamofire
import KeychainSwift

class BusinessFixRepository {

    func requestBusinessFix(businessId: Int, businessInfo: BusinessInfoRequest, completion: @escaping (Result<Bool, ResError>) -> Void) {

        guard let accessToken = KeychainSwift().get("accessToken") else {
            return completion(.failure(.NON_TOKEN))
                }
        
        let url = URLConstants.Business_Fix(businessId: String(businessId)) //통신할 API 주소

        let header : HTTPHeaders = ["Content-Type":"application/json",
                                    "Authorization":"Bearer " + accessToken]
        
        //요청 바디
        let body : Parameters = [
            "name": businessInfo.name,
            "businessPeriodDto": [
                "start": businessInfo.businessPeriodDto.start,
                "finish":businessInfo.businessPeriodDto.finish
                ],
            "memberIdList": businessInfo.memberIdList,
            "revenue": businessInfo.revenue,
            "description": businessInfo.description
        ]

        
        let dataRequest = AF.request(url,
                                     method: .patch,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { [weak self] response in
            
            guard let self = self else { return }
            
            switch response.result {
            case .success(let res): //데이터 통신이 성공한 경우에
                
//            case .success(let res):
                print("왜 실패??🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                print(String(data: res, encoding: .utf8) ?? "") // 바디 출력
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                let networkResult = self.judgeStatus(by: statusCode, value)

                if statusCode == 401 {
                    print("토큰만료임!!!")
                    ApiManager.shared.refreshToken { isSuccess in
                        if isSuccess {
                            print("토큰 새로 받아오기 성공 ><")
                            self.requestBusinessFix(businessId: businessId, businessInfo: businessInfo, completion: completion)
                        } else {
                            print("토큰 새로 받아오기 실패ㅠㅠ")
                            completion(.failure(.OVER_TOKEN_401))
                        }
                    }
                }  else {
                    let networkResult = self.judgeStatus(by: statusCode, value)
                    completion(networkResult)
                }
                
            case .failure:
                completion(.failure(.FAILURE_NETWORK))
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> Result<Bool, ResError> {
        switch statusCode {
        case ..<300: return .success(true)
        case 400: return .failure(.BAD_REQUEST_400(isInValidData(data: data)))
        case 401: return .failure(.OVER_TOKEN_401)
        case 403: return .failure(.CHANGE_AUTHORITY_403)
        case 404: return .failure(.NOT_FOUND_404(isInValidData(data: data)))
        default: return .failure(.FAILURE_NETWORK)
        }
    }
    
    private func isInValidData(data: Data) -> String {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ErrorMessageReponse.self, from: data) else { return "네트워크 연결 상태가 좋지 않습니다." }
        return decodedData.message
    }
    
}

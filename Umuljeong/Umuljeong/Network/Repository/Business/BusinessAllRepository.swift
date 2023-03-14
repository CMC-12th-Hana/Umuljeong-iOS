//
//  BusinessAllRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/15.
//

import Foundation
import Alamofire
import KeychainSwift

class BusinessAllRepository {
    func requestBusinessAll(searchText:String, startDate:String, finishDate:String, completion: @escaping (Result<BusinessListResponse?, ResError>) -> Void) {
        
        guard let accessToken = KeychainSwift().get("accessToken") else {
            return completion(.failure(.NON_TOKEN))
                }
        
        guard let companyId = ApiManager.shared.myCompanyId() else {
            return completion(.failure(.CHANGE_AUTHORITY_403))
        }
        
        let url = URLConstants.Business_All(companyId: companyId)

        let header : HTTPHeaders = ["Content-Type":"application/json",
                                    "Authorization":"Bearer " + accessToken]
        
        let body : Parameters = [
            "name": searchText,
            "start": startDate,
            "finish": finishDate
        ]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: body,
                                     encoding: URLEncoding.queryString,
                                     headers: header)
        
        dataRequest.responseData { [weak self] response in
            
            guard let self = self else { return }
            switch response.result {
                
            case .success(let res):

                print(String(data: res, encoding: .utf8) ?? "") // 바디 출력
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                if statusCode == 401 {
                    ApiManager.shared.refreshToken { isSuccess in
                        if isSuccess {
                            self.requestBusinessAll(searchText: searchText, startDate: startDate, finishDate: finishDate, completion: completion)
                        } else {
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
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> Result<BusinessListResponse?, ResError> {
        switch statusCode {
        case ..<300: return .success(isVaildData(data: data))
        case 400: return .failure(.BAD_REQUEST_400(isInValidData(data: data)))
        case 401: return .failure(.OVER_TOKEN_401)
        case 403: return .failure(.CHANGE_AUTHORITY_403)
        case 404: return .failure(.NOT_FOUND_404(isInValidData(data: data)))
        default: return .failure(.FAILURE_NETWORK)
        }
    }
    
    private func isVaildData(data: Data) -> BusinessListResponse? {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        guard let decodedData = try? decoder.decode(BusinessListResponse.self, from: data) else { return nil }
        return decodedData
    }
    
    private func isInValidData(data: Data) -> String {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ErrorMessageReponse.self, from: data) else { return "네트워크 연결 상태가 좋지 않습니다." }
        return decodedData.message
    }
    
}

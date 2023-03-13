//
//  CategoryRemoveRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation
import Alamofire
import KeychainSwift

class CategoryRemoveRepository {

    func requestCategoryRemove(taskCategoryIdList: [Int], completion: @escaping (Result<Bool, ResError>) -> Void) {
        
        guard let accessToken = KeychainSwift().get("accessToken") else {
            return completion(.failure(.NON_TOKEN))
                }
        
        let url = URLConstants.TaskCategory_Remove //통신할 API 주소
        
        let queryString = "categoryIds=\(taskCategoryIdList.map(String.init).joined(separator: ","))"


        let header : HTTPHeaders = ["Content-Type":"application/json",
                                    "Authorization":"Bearer " + accessToken]
        
        let dataRequest = AF.request("\(url)?\(queryString)",
                                     method: .delete,
                                     encoding: URLEncoding.queryString,
                                     headers: header)
        

        dataRequest.responseData { [weak self] response in
            
            guard let self = self else { return }
            
            switch response.result {
                
            case .success(let res):
                
                print(String(data: res, encoding: .utf8) ?? "")
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                if statusCode == 401 {
                    ApiManager.shared.refreshToken { isSuccess in
                        if isSuccess {
                            self.requestCategoryRemove(taskCategoryIdList: taskCategoryIdList, completion: completion)
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

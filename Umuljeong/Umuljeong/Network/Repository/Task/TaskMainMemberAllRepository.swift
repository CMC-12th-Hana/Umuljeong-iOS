//
//  TaskMainMemberAllRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/14.
//

import Foundation
import Alamofire
import KeychainSwift

class TaskMainMemberAllRepository {

    func requestMainMemberTaskAll(searchDate:String, completion: @escaping (Result<MemberTaskResponse?, ResError>) -> Void) {

        guard let accessToken = KeychainSwift().get("accessToken") else {
            return completion(.failure(.NON_TOKEN))
                }
        
        guard let companyId = ApiManager.shared.myCompanyId() else {
            return completion(.failure(.CHANGE_AUTHORITY_403))
        }
        
        let url = URLConstants.Task_Main_All(companyId: companyId)

        let header : HTTPHeaders = ["Content-Type":"application/json",
                                    "Authorization":"Bearer " + accessToken]
        
        //요청 바디
        let body : Parameters = [
            "date": searchDate,
            "type": "MEMBER"
        ]
        
            
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: body,
                                     encoding: URLEncoding.queryString,
                                     headers: header)
        
        //request 시작 ,responseData를 호출하면서 데이터 통신 시작
        dataRequest.responseData { [weak self] response in
            
            guard let self = self else { return }
            
            switch response.result {
                
            case .success(let res):
                print("메인 사원 별 업무 가져오기 결과")
                print(String(data: res, encoding: .utf8) ?? "")

                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                if statusCode == 401 {
                    print("토큰만료임!!!")
                    ApiManager.shared.refreshToken { isSuccess in
                        if isSuccess {
                            self.requestMainMemberTaskAll(searchDate: searchDate, completion: completion)
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
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> Result<MemberTaskResponse?, ResError> {
        switch statusCode {
        case ..<300: return .success(isVaildData(data: data))
        case 400: return .failure(.BAD_REQUEST_400(isInValidData(data: data)))
        case 401: return .failure(.OVER_TOKEN_401)
        case 403: return .failure(.CHANGE_AUTHORITY_403)
        case 404: return .failure(.NOT_FOUND_404(isInValidData(data: data)))
        default: return .failure(.FAILURE_NETWORK)
        }
    }
    
    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
    private func isVaildData(data: Data) -> MemberTaskResponse? {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        guard let decodedData = try? decoder.decode(MemberTaskResponse.self, from: data) else { return nil }
        return decodedData
    }
    
    private func isInValidData(data: Data) -> String {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ErrorMessageReponse.self, from: data) else { return "네트워크 연결 상태가 좋지 않습니다." }
        return decodedData.message
    }
}

//
//  ClientAddRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation
import Alamofire
import KeychainSwift

class ClientAddRepository {
    func requestClientAdd(name:String, tel:String, managerName:String, managerCall:String, department:String, completion: @escaping (Result<Bool, ResponseError>) -> Void) {

        guard let accessToken = KeychainSwift().get("accessToken") else {
            return completion(.failure(.token))
                }
        
        guard let companyId = ApiManager.shared.myCompanyId() else {
            return completion(.failure(.token))
        }
        
        let url = URLConstants.Client_Add(companyId: companyId) //통신할 API 주소

        let header : HTTPHeaders = ["Content-Type":"application/json",
                                    "Authorization":"Bearer " + accessToken]
        
        //요청 바디
        let body : Parameters = [
            "name": name,
            "tel": tel,
            "salesRepresentativeDto" : [
                "name": managerName,
                "phoneNumber": managerCall,
                "department": department
            ]
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
            case .success(let res): //데이터 통신이 성공한 경우에
                
//            case .success(let res):
                print(String(data: res, encoding: .utf8) ?? "") // 바디 출력
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
//                if networkResult == .success(true) {
                    
//                }
                
                if statusCode == 401 {
                    print("토큰만료임!!!")
                    ApiManager.shared.refreshToken { isSuccess in
                        if isSuccess {
                            print("토큰 새로 받아오기 성공 ><")
                            completion(.success(true))
                        } else {
                            print("토큰 새로 받아오기 실패ㅠㅠ")
                            completion(.failure(.token))
                        }
                    }
                } else {
                    let networkResult = self.judgeStatus(by: statusCode, value)
                    completion(networkResult)
                }
                
            case .failure:
                completion(.failure(.requestError("통신이 불안정합니다")))
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> Result<Bool, ResponseError> {
        switch statusCode {
        case ..<300 : return .success(true)
        case 401 : return .failure(.token)
        default : return .failure(.requestError(isInValidData(data: data)))
        }
    }
    
//    통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
    
    private func isInValidData(data: Data) -> String {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        guard let decodedData = try? decoder.decode(ErrorMessageReponse.self, from: data) else { return "네트워킹 에러가 발생하였습니다." }
        return decodedData.message
    }
}



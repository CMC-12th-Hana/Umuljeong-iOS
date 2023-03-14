//
//  ClientDetailRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation
import Alamofire
import KeychainSwift

class ClientDetailRepository {

    func requestClientDetail(clientId:Int, completion: @escaping (Result<ClientInfo?, ResponseError>) -> Void) {
        let url = URLConstants.Client_Detail(clientId: String(clientId)) //통신할 API 주소

        guard let accessToken = KeychainSwift().get("accessToken") else {
            return completion(.failure(.token))
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
                print(res)
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}
                
                if statusCode == 401 {
                    print("토큰만료임!!!")
                    ApiManager.shared.refreshToken { isSuccess in
                        if isSuccess {
                        } else {
                            completion(.failure(.token))
                        }
                    }
                }
                
                let networkResult = self.judgeStatus(by: statusCode, value)

                completion(networkResult)
                
            case .failure:
                completion(.failure(.requestError("통신이 불안정합니다")))
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> Result<ClientInfo?, ResponseError> {
        switch statusCode {
        case ..<300 : return .success(isVaildData(data: data))
        case 400...404 : return .failure(.requestError(isInValidData(data: data)))
        default : return .failure(.token)
        }
    }
    
    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
    private func isVaildData(data: Data) -> ClientInfo? {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        guard let decodedData = try? decoder.decode(ClientInfo.self, from: data) else { return nil }
        return decodedData
    }
    
    private func isInValidData(data: Data) -> String {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        guard let decodedData = try? decoder.decode(ErrorMessageReponse.self, from: data) else { return "네트워킹 에러가 발생하였습니다." }
        return decodedData.message
    }
    
}

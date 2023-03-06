//
//  ApiManager.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/04.
//

import Foundation
import KeychainSwift
import Alamofire


class ApiManager {
    static let shared = ApiManager()
    let keychain = KeychainSwift() // 키체인 사용을 위해 KeychainSwift 라이브러리를 이용합니다.
    private var accessToken: String?

    private init() {
        accessToken = keychain.get("accessToken") // 키체인에서 액세스 토큰을 가져옵니다.
    }
    
    func accessTokenSet(accessToken:String) {
        self.keychain.set(accessToken, forKey: "accessToken")
    }
    
    func refreshToken(completion: @escaping (_ isSuccess:Bool) -> Void) {
        let url = URLConstants.Auth_Login //통신할 API 주소

        let header : HTTPHeaders = ["Content-Type":"application/json"]
        
        //요청 바디
        let body : Parameters = [
            "phoneNumber": "01011111111",
            "password": "qweR!1234"
        ]
        
        let dataRequest = AF.request(url,
                                    method: .post,
                                    parameters: body,
                                    encoding: JSONEncoding.default,
                                    headers: header)
        
        
        //리프레쉬 토큰으로 액세스 토큰 발급해오기
        dataRequest.responseData{
            response in //데이터 통신의 결과가 response에 담기게 된다
            switch response.result {
            case .success: //데이터 통신이 성공한 경우에
                guard let statusCode = response.response?.statusCode, statusCode == 200 else {return}
                guard let value = response.value else {return}
                
                let decoder = JSONDecoder()
                
                guard let decodedData = try? decoder.decode(SignupResponse.self, from: value) else { return }
                
                self.keychain.set(decodedData.accessToken ?? "", forKey: "accessToken")
                
                completion(true)

            case .failure:
                completion(false)
            }
        }
    }
}

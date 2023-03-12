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
    static let shared = ApiManager() //
    let keychain = KeychainSwift() // 키체인 사용을 위해 KeychainSwift 라이브러리를 이용합니다.
    private var accessToken: String?
    
    private var companyId: String?
    private var memberId: String?
    private var companyName: String?
    private var userName: String?
    private var userRole: String?
    private var isLogin:Bool?

    private init() {
        accessToken = keychain.get("accessToken") // 키체인에서 액세스 토큰을 가져옵니다.
        companyId = keychain.get("myCompanyId")
        memberId = keychain.get("myMemberId")
        companyName = keychain.get("myCompanyName")
        userName = keychain.get("myName")
        userRole =  keychain.get("myRole")
        isLogin = keychain.getBool("isLogin")
    }
    
    func uniqueUserInfoSet(_ userInfo: UserInfoResponse) { //회사 생성 / 합류 / 로그인
        self.keychain.set(String(userInfo.companyId), forKey: "myCompanyId")
        self.keychain.set(String(userInfo.memberId), forKey: "myMemberId")
        self.keychain.set(userInfo.companyName, forKey: "myCompanyName")
        self.keychain.set(userInfo.name, forKey: "myName")
        self.keychain.set(userInfo.role, forKey: "myRole")
        self.keychain.set(true, forKey: "isLogin")
    }
    
    func memberInfoSet(name:String) {
        self.keychain.set(name, forKey: "myName")
        userName = keychain.get("myName")
    }
    
    func accessTokenSet(accessToken:String) { //회사 생성 / 합류 / 로그인
        self.keychain.set(accessToken, forKey: "accessToken")
    }
    
    func myCompanyId() -> String? {
        return self.companyId
    }
    
    func myMemberId() -> String? {
        return self.memberId
    }
    
    func myCompanyName() -> String? {
        return self.companyName
    }
    
    func myName() -> String? {
        return self.userName
    }
    
    func myRole() -> Bool? {
        return self.userRole == "리더"
    }
    
    func myLoginState() -> Bool? {
        return self.isLogin
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

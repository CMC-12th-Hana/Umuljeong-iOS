//
//  TaskAddRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation
import Alamofire
import KeychainSwift
import UIKit

class TaskAddRepository {
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width // 새 이미지 확대/축소 비율
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.draw(in: CGRectMake(0, 0, newWidth, newHeight))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage(named: "smileDark")!}
        UIGraphicsEndImageContext()
        return newImage
    }

    func requestTaskAdd(businessId: Int, taskCategoryId:Int, date:String, title:String, description: String, taskImageList:[UIImage], completion: @escaping (Result<Bool, ResError>) -> Void) {

        guard let accessToken = KeychainSwift().get("accessToken") else {
            return completion(.failure(.NON_TOKEN))
                }

        
        let url = URLConstants.Task_Add

        let header : HTTPHeaders = ["Content-Type":"multipart/form-data",
                                    "Authorization":"Bearer " + accessToken]

        //요청 바디
        let requiredParams : Parameters = [
            "businessId": businessId,
            "taskCategoryId": taskCategoryId,
            "date": date,
            "title": title,
            "description": description
        ]
        
        // 멀티파트 데이터 생성
        let multipartFormData = { (formData: MultipartFormData) in
            // 쿼리 파라미터 데이터 추가
            for (key, value) in requiredParams {
                formData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
            // 이미지 배열 데이터 추가
            for (index, image) in taskImageList.enumerated() {
                let scaledImage = self.resizeImage(image: image, newWidth: 400)
                if let imageData = scaledImage.jpegData(compressionQuality: 0.5) {
                    formData.append(imageData, withName: "taskImageList[\(index)]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
        }
        

        let dataRequest = AF.upload(multipartFormData: multipartFormData, to: url, method: .post, headers: header)
            .validate()


        dataRequest.responseData { [weak self] response in

            guard let self = self else { return }

            switch response.result {

            case .success(let res):

                print(String(data: res, encoding: .utf8) ?? "") // 바디 출력
                
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.value else {return}

                if statusCode == 401 {
                    print("토큰만료임!!!")
                    ApiManager.shared.refreshToken { isSuccess in
                        if isSuccess {
                            self.requestTaskAdd(businessId: businessId, taskCategoryId: taskCategoryId, date: date, title: title, description: description, taskImageList: taskImageList, completion: completion)
                        } else {
                            completion(.failure(.OVER_TOKEN_401))
                        }
                    }
                } else {
                    let networkResult = self.judgeStatus(by: statusCode, value)
                    completion(networkResult)
                }

            case .failure(let res):
                
                print(res) // 바디 출력
                
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

//
//  ClientViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/08.
//

import Foundation
import Combine

class ClientViewModel: ObservableObject {
    @Published var clientFeedInfo:[ClientInfo] = []
    @Published var searchText: String = ""
    let repository = ClientAllRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        requestAllClient()
        
        $searchText
            .sink { [weak self] _ in
                            self?.requestClientSearch()
                        }
            .store(in: &cancellables)
    }
    
    func requestAllClient() {
        repository.requestClientAll { response in
                switch response {
                case .success(let resClientFeedInfo):
                    self.clientFeedInfo = resClientFeedInfo?.clientCompanyDtoList ?? []
                    print(self.clientFeedInfo)
                    print("고객사_전체보기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
                default : print("고객사_전체보기 통신 실패")
                }
            }
    }
    
    func requestClientSearch() {
        
        //searchText에 대해서 리퀘스트 하고, 불러 온 결과 ClientFeed에 적용
        
        print("searchText 바뀔 때 마다 요청 중 / searchText 변경 확인 : \(searchText)")
    }
}

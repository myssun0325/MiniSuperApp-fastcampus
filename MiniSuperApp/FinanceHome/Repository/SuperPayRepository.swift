//
//  SuperPayRepository.swift
//  MiniSuperApp
//
//  Created by mason on 2022/03/27.
//

import Foundation
import Combine

protocol SuperPayRepository {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error>
}

final class SuperPayRepositoryImpl: SuperPayRepository {
    
    var balance: ReadOnlyCurrentValuePublisher<Double> { balanceSubject }
    private let balanceSubject = CurrentValuePublisher<Double>(0)
    
    func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            self?.bgQueue.async {
                Thread.sleep(forTimeInterval: 2)
                promise(.success(()))
                let newBalance = (self?.balanceSubject.value).map { $0 + amount }
                newBalance.map { self?.balanceSubject.send($0) }
                
            }
        }
        .eraseToAnyPublisher()
    }
    
    private let bgQueue = DispatchQueue(label: "topup.repository.queue") // 백엔드처럼 딜레이를 주기 위해서 백그라운드 큐를 하나 생성.
}


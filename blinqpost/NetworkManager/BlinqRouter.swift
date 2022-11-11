//
//  BlinqRouter.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

typealias Parameter = [String: Any]

protocol BlinqpayRouter {
    associatedtype Endpoint: BlinqpayRequestType
    func request(_ request: Endpoint) -> Single<(Any?, Error?)>
}

class Router<T: BlinqpayRequestType>: BlinqpayRouter {
    
    func request(_ request: T) -> Single<(Any?, Error?)> {
        switch request.operation {
        case .read:
            return read(request)
        case .create(let data):
            return create(request, data: data)
        case .update(let data):
            return update(request, data: data)
        case .delete:
            return delete(request)
        case .query:
            return query(request) //, completion: completion)
        }
    }
    private func query(_ request: T) -> Single<(Any?, Error?)> {//, completion: @escaping NetworkRouterCompletion<Any>) {
        return Single<(Any?, Error?)>.create { (single) in
            request.collectionQuery?.getDocuments { snapshot, error in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success((snapshot as Any, nil)))
                }
            }
            return Disposables.create { }
        }
        
    }
    
    private func read(_ request: T) -> Single<(Any?, Error?)> {
        return Single<(Any?, Error?)>.create { (single) -> Disposable in
            request.documentRefernce?.getDocument { (snapshot, error) in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success((snapshot as Any, nil)))
                }
            }
            return Disposables.create { }
        }
        
    }
    
    private func create(_ request: T, data: Parameter) -> Single<(Any?, Error?)> {
        return Single<(Any?, Error?)>.create { (single) -> Disposable in
            request.documentRefernce?.setData(data, merge: true) { (error) in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success((nil, nil)))
                }
            }
            return Disposables.create { }
        }
        
        
    }
    
    private func update(_ request: T, data: Parameter) -> Single<(Any?, Error?)> {
        return Single<(Any?, Error?)>.create { (single) -> Disposable in
            request.documentRefernce?.updateData(data) { _ in
                single(.success((nil, nil)))
            }
            return Disposables.create { }
        }
    }
    
    private func delete(_ request: T) -> Single<(Any?, Error?)> {
        return Single<(Any?, Error?)>.create { (single) in
            request.documentRefernce?.delete { (error) in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success((nil, nil)))
                }
            }
            return Disposables.create { }
        }
    }
}

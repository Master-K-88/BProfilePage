//
//  BlinqpayRequestType.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import FirebaseFirestore

protocol BlinqpayRequestType {
    var operation: Operations { get }
    var documentRefernce: DocumentReference? { get }
    var collectionReference: CollectionReference? { get }
    var baseDocumentReference: DocumentReference? { get }
    var collectionQuery: Query? { get }
}

extension BlinqpayRequestType {
    var collectionQuery: Query? { return nil}
}

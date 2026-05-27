//
//  Query+FirestoreHelpers.swift
//  RGToDoList
//
//  Created by joe on 5/27/26.
//

import FirebaseFirestore
import Combine

extension Query {
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        let snapshot = try await self.getDocuments()
        return try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
    }
    
    func addSnapshotListener<T>(as type: T.Type) -> (AnyPublisher<[T], Error>, ListenerRegistration) where T : Decodable {
        let publisher = PassthroughSubject<[T], Error>()
        let listener = self.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            let items: [T] = documents.compactMap({ try? $0.data(as: T.self) })
            publisher.send(items)
        }
        return (publisher.eraseToAnyPublisher(), listener)
    }
}

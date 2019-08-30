//
//  LanguageRankingDataSource.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 30/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import Foundation
import Combine

class LanguageRankingDataSource: ObservableObject {

    let language: String
    @Published var locationType = LocationType.world
    @Published var locationName: String = "" {
        didSet {
            fetchUsers()
        }
    }

    @Published var searchText = ""
    @Published var users: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                self.searchUsersSubject.send(self.users)
            }
        }
    }

    private let searchUsersSubject = PassthroughSubject<[User], Never>()

    init(language: String) {
        self.language = language

        _ = $searchText
            .receive(on: DispatchQueue.main)
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .assign(to: \.locationName, on: self)
    }

    private static let urlString = "http://git-awards.com/api/v0/users"

    func fetchUsers() {

        let type = self.locationType

        var urlComponents = URLComponents(url: URL(string: Self.urlString)!, resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "language", value: language))
        queryItems.append(URLQueryItem(name: "page", value: "1"))
        queryItems.append(URLQueryItem(name: "type", value: type.name))

        if type != .world {
            queryItems.append(URLQueryItem(name: type.name, value: locationName))
        }
        urlComponents.queryItems = queryItems

        _ = URLSession(configuration: .default)
            .dataTaskPublisher(for: urlComponents.url!)
            .map { $0.data }
            .decode(type: Users.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { self.users = $0.users }
            )
    }
}

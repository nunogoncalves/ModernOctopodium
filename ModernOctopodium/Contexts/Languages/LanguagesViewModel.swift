//
//  LanguagesViewModel.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 30/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import Foundation
import Combine

class LanguagesViewModel {

    let searchLanguages = PassthroughSubject<[String], Never>()

    private var languages: [String] = [] {
        didSet {
            searchLanguages.send(languages)
        }
    }

    private let languagesPublisher = URLSession(configuration: .default)
        .dataTaskPublisher(for: URL(string: "http://git-awards.com/api/v0/languages?sort=popularity")!)
        .map { $0.data }
        .decode(type: Languages.self, decoder: JSONDecoder())
        .map { $0.languages }

    init() {
        _ = languagesPublisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { self.languages = $0 }
            )
    }
}

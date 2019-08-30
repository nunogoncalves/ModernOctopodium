//
//  LanguagesView.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 30/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import SwiftUI

struct LanguagesView: View {

    private let viewModel: LanguagesViewModel

    init(viewModel: LanguagesViewModel) {
        self.viewModel = viewModel
    }

    @State var languages: [String] = []
    @State var filterText = ""
    @State var isLoading: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Filter", text: $filterText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accentColor(.white)
                    .cornerRadius(5)
                    .padding(10)
                List {
                    ForEach(filteredLanguages, id: \.self) { language in
                        NavigationLink(destination: LanguageRankingView(language: language)) {
                            LanguageRow(language: language)
                        }
                    }
                }
            }
            .navigationBarTitle("Languages", displayMode: .inline)
        }
        .onAppear {

            _ = self.viewModel.searchLanguages
                .receive(on: DispatchQueue.main)
                .assign(to: \.languages, on: self)
        }
    }

    var filteredLanguages: [String] {
        if filterText.isEmpty { return languages }
        let resultPredicate = NSPredicate.containing(filterText)
        return languages.filter { resultPredicate.evaluate(with: $0) }
    }
}

struct LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesView(viewModel: LanguagesViewModel())
    }
}

extension NSPredicate {
    static func containing(_ text: String) -> NSPredicate {
        return NSPredicate(format: "self contains[c] %@", text)
    }
}

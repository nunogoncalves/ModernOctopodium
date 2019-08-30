//
//  LanguageRankingView.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 30/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import SwiftUI

struct LanguageRankingView: View {

    @ObservedObject private var dataSource: LanguageRankingDataSource
    let language: String

    init(language: String) {
        self.language = language
        self.dataSource = LanguageRankingDataSource(language: language)
    }

    var body: some View {
        VStack {
            Picker("", selection: $dataSource.locationType) {
                Text(.world).tag(with: .world)
                Text(.country).tag(with: .country)
                Text(.city).tag(with: .city)
            }
            .padding(20)
            .pickerStyle(SegmentedPickerStyle())

            if dataSource.locationType == .country || dataSource.locationType == .city {
                TextField(dataSource.locationType.name, text: $dataSource.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.gray)
                    .accentColor(.white)
                    .cornerRadius(5)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
            List {
                ForEach(dataSource.users, id: \.self) { user in
                    Text(user.username)
                }
            }
        }
        .navigationBarTitle(language)
    }
}

#if DEBUG
struct LanguageRankingView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageRankingView(language: "Swift")
    }
}
#endif

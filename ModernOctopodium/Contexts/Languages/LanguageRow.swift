//
//  LanguageRow.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 30/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import SwiftUI

struct LanguageRow: View {

    var language: String

    var image: UIImage? { UIImage(named: language.lowercased()) }

    var body: some View {

        HStack {
            LanguageImage(language: language)
            Text(language)
                .padding(.trailing, 5)
        }
    }
}

struct LanguagesRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LanguageRow(language: "Swift")
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
    }
}

//
//  LanguageImage.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 30/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import SwiftUI

struct LanguageImage: View {

    var language: String
    var image: UIImage? { UIImage(named: language.lowercased()) }

    var body: some View {
        HStack {
            if image != nil {
                Image(uiImage: image!)
            } else {
                Text(String(language.first!))
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
        }
        .padding(5)
    }
}

struct LanguageImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LanguageImage(language: "Swift")
            LanguageImage(language: "Ruby")
            LanguageImage(language: "Random")
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
    }
}

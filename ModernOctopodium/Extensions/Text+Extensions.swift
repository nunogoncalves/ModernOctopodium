//
//  Text+Extensions.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 30/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import SwiftUI

extension Text {

    init(_ locationType: LocationType) {
        self.init(locationType.name)
        _ = tag(locationType)
    }
    
    func tag(with locationType: LocationType) -> some View { tag(locationType) }
}

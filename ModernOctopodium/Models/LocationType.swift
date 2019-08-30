//
//  LocationType.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 30/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import Foundation

enum LocationType {
    case world
    case country
    case city

    var id: Int {
        switch self {
        case .world: return 0
        case .country: return 1
        case .city: return 2
        }
    }

    var name: String { String(describing: self) }
}

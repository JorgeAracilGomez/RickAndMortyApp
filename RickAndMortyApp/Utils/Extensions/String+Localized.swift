//
//  String+Localized.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 8/2/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

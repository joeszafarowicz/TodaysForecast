//
//  Capitalizations.swift
//  TodaysForecast
//
//  Created by Joseph Szafarowicz on 1/11/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

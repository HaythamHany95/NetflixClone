//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Haytham on 30/08/2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

//
//  ColorPallete.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 14/08/25.
//

import UIKit

enum ColorPallete {
    static let background = UIColor(named: "background") ?? .systemBackground
    static let tabBarColor = UIColor(named: "tabBarColor") ?? .systemBackground
    static let primaryButtonColor = UIColor.systemPink
    static let secondaryButtonColor = UIColor.systemIndigo
}

enum ImageAsset {
    static let tagLogo = UIImage(named: "tagLogo") ?? UIImage()
}

//
//  ColorPallete.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 14/08/25.
//

import UIKit

enum ColorPallete {
    static var background: UIColor {
        return UIColor(named: "background") ?? UIColor.blue
    }
}

enum ImageAsset {
    static var tagLogo: UIImage {
        return UIImage(named: "tagLogo") ?? UIImage()
    }
}

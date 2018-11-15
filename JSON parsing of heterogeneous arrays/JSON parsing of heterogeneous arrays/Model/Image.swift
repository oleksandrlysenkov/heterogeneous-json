//
//  Image.swift
//  JSON parsing of heterogeneous arrays
//
//  Created by Oleksandr Lysenkov on 11/15/18.
//

import CoreGraphics


struct Image: Media, Decodable {
    var size: CGSize
    var sourceURL: String
}

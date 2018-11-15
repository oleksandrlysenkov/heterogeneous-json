//
//  Video.swift
//  JSON parsing of heterogeneous arrays
//
//  Created by Oleksandr Lysenkov on 11/15/18
//

import Foundation


struct Video: Media, Decodable {
    var duration: TimeInterval
    var sourceURL: String
}

//
//  MediaDecoder.swift
//  JSON parsing of heterogeneous arrays
//
//  Created by Oleksandr Lysenkov on 11/15/18.
//

import Foundation
import CoreGraphics


struct MediaDecoder: Decodable {
    var media: Media?
    
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let mediaTypeString = (try? values.decode(String.self, forKey: .type)) ?? ""
        let mediaType = MediaType(rawValue: mediaTypeString)
        switch mediaType ?? .unknown {
        case .image:
            self.media = try? Image(from: decoder)
        case .video:
            self.media = try? Video(from: decoder)
        case .unknown:
            break
        }
    }
}

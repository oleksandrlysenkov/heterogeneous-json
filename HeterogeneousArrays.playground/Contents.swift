import Foundation
import CoreGraphics
import XCTest


protocol Media {
    var sourceURL: String { get set}
}

struct Image: Media, Decodable {
    var size: CGSize
    var sourceURL: String
}

struct Video: Media, Decodable {
    var duration: TimeInterval
    var sourceURL: String
}

enum MediaType: String {
    case image
    case video
    case unknown
}

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

var mediaArray: [Media] = []
let jsonString = """
[{"type":"video","sourceURL":"http://google.com","duration":60},{"type":"image","sourceURL":"http://google.com","size":[60,60]}]
"""

if let jsonData = jsonString.data(using: .utf8) {
    let mediaDecodersArray = (try? JSONDecoder().decode([MediaDecoder].self, from: jsonData)) ?? []
    mediaArray = mediaDecodersArray.compactMap{ $0.media }
}

mediaArray.count

let video = mediaArray[0] as? Video
let image = mediaArray[1] as? Image

video != nil
video?.duration == 60
image != nil
image?.size == CGSize(width: 60, height: 60)

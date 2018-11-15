//
//  JSON_parsing_of_heterogeneous_arraysTests.swift
//  JSON parsing of heterogeneous arraysTests
//
//  Created by Oleksandr Lysenkov on 11/15/18.
//

import XCTest
@testable import JSON_parsing_of_heterogeneous_arrays


class JSON_parsing_of_heterogeneous_arraysTests: XCTestCase {
    
    func testDecoding() {
        var mediaArray: [Media] = []
        let jsonString = "[{\"type\":\"video\",\"sourceURL\":\"http://\",\"duration\":60},{\"type\":\"image\",\"sourceURL\":\"http://\",\"size\":[60,60]}]"

        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed converting JSON string to data")
            return
        }
        
        let mediaDecodersArray = (try? JSONDecoder().decode([MediaDecoder].self, from: jsonData)) ?? []
        mediaArray = mediaDecodersArray.compactMap{ $0.media }
        
        guard mediaArray.count == 2 else {
            XCTFail("Not all the elements were parsed")
            return
        }
        
        let video = mediaArray[0] as? Video
        let image = mediaArray[1] as? Image
        XCTAssert(video != nil, "A video wasn't parsed")
        XCTAssert(video?.duration == 60, "Duration of a video wasn't parsed")
        XCTAssert(image != nil, "An image wasn't parsed")
        XCTAssert(image?.size == CGSize(width: 60, height: 60), "Size of an image wasn't parsed")
    }
}

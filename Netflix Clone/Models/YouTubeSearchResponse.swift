//
//  YouTubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Haytham on 02/09/2023.
//

import Foundation

struct YouTubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}



/*
 items =     (
             {
         etag = "7UboJMIrQupqmQDzXlM_1RJx7Zk";
         id =             {
             kind = "youtube#video";
             videoId = "71xBu_VHTfY";
         };
 */

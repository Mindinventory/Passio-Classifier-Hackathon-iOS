//
//  YogaList.swift
//  YogaPose
//
//  Created by iMac-00017 on 05/10/22.
//

import Foundation
struct YogaList : Codable {
    let passioID : String?
    let name : String?
    let sanskrit : String?
    let english : String?
    let type : String?
    let description : String?
    let url : String?
    let benefits : String?
    var isExpanded : Bool? = false

    enum CodingKeys: String, CodingKey {

        case passioID = "passioID"
        case name = "name"
        case sanskrit = "sanskrit"
        case english = "english"
        case type = "type"
        case description = "description"
        case url = "url"
        case benefits = "benefits"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        passioID = try values.decodeIfPresent(String.self, forKey: .passioID)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        sanskrit = try values.decodeIfPresent(String.self, forKey: .sanskrit)
        english = try values.decodeIfPresent(String.self, forKey: .english)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        benefits = try values.decodeIfPresent(String.self, forKey: .benefits)
    }

}

extension Decodable {
    static func parse(jsonFile: String) -> Self? {
      guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let output = try? JSONDecoder().decode(self, from: data)
          else {
        return nil
      }

      return output
    }
}

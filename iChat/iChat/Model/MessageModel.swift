//
//  MessageModel.swift
//  iChat
//
//  Created by Darío Gallegos on 3/8/22.
//

import FirebaseFirestoreSwift
import Foundation

struct MessageModel: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var user: String
    var message: String
    var timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case message
        case user
        case timestamp
    }
}

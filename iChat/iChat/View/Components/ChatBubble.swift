//
//  ChatBubble.swift
//  iChat
//
//  Created by Darío Gallegos on 4/8/22.
//

import SwiftUI

struct ChatBubble: Shape {
    var myMessage: Bool
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [.topLeft,
                                                    .topRight,
                                                    myMessage ? .bottomLeft : .bottomRight],
                                cornerRadii: CGSize(width: 16, height: 16))
        return Path(path.cgPath)
    }
}

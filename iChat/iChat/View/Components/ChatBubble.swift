//
//  ChatBubble.swift
//  iChat
//
//  Created by Darío Gallegos on 4/8/22.
//

import SwiftUI

enum BubbleTail {

    case left
    case right
    
    var alignment: Alignment {
        switch self {
        case .left:
            return .bottomLeading
        case .right:
            return .bottomTrailing
        }
    }
    
    var image: String {
        switch self {
        case .left:
            return "incomingTail"
        case .right:
            return "outgoingTail"
        }
    }
}

struct ChatBubble: View {
    var color = Color.blue
    var text: String
    var tail: BubbleTail = .left
    
    var body: some View {
        ZStack(alignment: tail.alignment) {
            Image(tail.image)
                .renderingMode(.template)
                .foregroundColor(.blue)
                .padding(EdgeInsets(top: 0, leading: -5, bottom: -2, trailing: 0))
            Text(text)
                .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color)
        )
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(text: "Hola que tal todosss")
            .preferredColorScheme(.dark)
    }
}

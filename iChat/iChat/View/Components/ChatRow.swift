//
//  ChatRow.swift
//  iChat
//
//  Created by Darío Gallegos on 4/8/22.
//

import SwiftUI

struct ChatRow: View {
    @AppStorage("current_user") var user = ""

    var chatData: MessageModel
    var body: some View {
        HStack(spacing: 16) {
            
            if chatData.user != user {
                NickName(name: chatData.user)
            }
            
            if chatData.user == user {
                Spacer(minLength: 0)
            }
            
            VStack(alignment: chatData.user == user ? .trailing : .leading, spacing: 5) {
                
                ChatBubble(text: chatData.message, tail: chatData.user == user ? .right : .left)
                
                Text(chatData.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(chatData.user != user ? .leading : .trailing, 10)
            }
            
            if chatData.user == user {
                NickName(name: chatData.user)
            }
            
            if chatData.user != user {
                Spacer(minLength: 0)
            }
        }
        .padding(.horizontal)
        .id(chatData.id)
    }
}


struct NickName: View {
    @AppStorage("current_user") var user = ""
    var name: String = ""
    var body: some View {
        Text(String(name.first!))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(name == user ? .blue.opacity(0.5) : .green.opacity(0.5))
            .clipShape(Circle())
    }
}

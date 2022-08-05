//
//  Home.swift
//  iChat
//
//  Created by Darío Gallegos on 3/8/22.
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeModel = HomeModel()
    var body: some View {
        VStack {
            
            //NavigationBar
            
            ScrollViewReader { reader in
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(homeModel.messages) { message in
                            ChatRow(chatData: message)
                        }
                    }
                }
            }
            
            //NavBar
            HStack(spacing: 16) {
                TextField("Enter Message", text: $homeModel.inputText)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color.primary.opacity(0.06))
                    .clipShape(Capsule())
                
                if homeModel.inputText != "" {
                    Button {
                        
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }

                }
            }
            .animation(.default, value: 0.1)
            .padding()
        }
        .onAppear(perform: {
            homeModel.onAppear()
        })
    }
}

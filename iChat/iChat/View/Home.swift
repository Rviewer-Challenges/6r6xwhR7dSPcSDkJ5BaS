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
            ScrollView {
                ForEach(homeModel.messages) { message in
                    ChatRow(chatData: message)
                }
            }
        }
        .onAppear(perform: {
            homeModel.onAppear()
        })
    }
}

//
//  Home.swift
//  iChat
//
//  Created by Darío Gallegos on 3/8/22.
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeModel = HomeModel()
    @State var scrolled = false
    var body: some View {
        VStack {
            
            //NavigationBar
            
            ScrollViewReader { reader in
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(homeModel.messages) { message in
                            ChatRow(chatData: message)
                                .onAppear {
                                    //First time scrolling
                                    if message.id == self.homeModel.messages.last?.id && !scrolled {
                                        reader.scrollTo(homeModel.messages.last?.id, anchor: .bottom)
                                        scrolled = true
                                    }
                                }
                        }
                        .onChange(of: homeModel.messages) { newValue in
                            //Cada vez que un usuario escribe un mensaje hace scroll hacia abajo
                            //TODO: Hacer que solo haga scroll cuando el usuario envia mensajes, y que indique si hay msj disponibles de otros usuarios para hacer scroll
                            //TODO: Vaciar el text field sin esperar a que se envie el mensaje pues tarda un poquito en borrarlo.
                            
                            reader.scrollTo(homeModel.messages.last?.id, anchor: .bottom)
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
                        homeModel.writeMessages()
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

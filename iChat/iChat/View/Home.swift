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
    @State var showingPicker = false
    @State var selectedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            
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
                .background(Color.backgroundColor)
                
            }
            
            InputBar(inputText: $homeModel.inputText) {
//                homeModel.selectedImage = selectedImage
//                homeModel.uploadPhoto()
                homeModel.writeMessages()
            } openPhoto: {
                showingPicker = true
            }
        }
        .sheet(isPresented: $showingPicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .onAppear(perform: {
            homeModel.onAppear()
        })
    }
}

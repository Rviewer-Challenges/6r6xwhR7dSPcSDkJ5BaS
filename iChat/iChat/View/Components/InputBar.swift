//
//  InputBar.swift
//  iChat
//
//  Created by Darío Gallegos on 7/8/22.
//

import SwiftUI

struct InputBar: View {
    @Binding var inputText: String
    @State var isShowingPicker = false
    @State var selectedImage: UIImage?
    var action: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Button {
                    
                } label: {
                    Image(systemName: "paperclip")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                        .frame(width: 40, height: 40)
                }
                
                TextField("Enter Message", text: $inputText)
                    .padding(.horizontal)
                    .frame(height: 40)
                    .background(Color.primary.opacity(0.05))
                    .clipShape(Capsule())
                
                Button {
                    if inputText != "" {
                        action?()
                    }
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                        .frame(width: 40, height: 40)
                        .background(inputText != "" ? Color.greenColor : Color.clear)
                        .clipShape(Circle())
                }
            }
        }
        .padding(8)
        .background(Color.lightColor.opacity(0.5))
    }
}

struct InputBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputBar(inputText: .constant(""))
                .preferredColorScheme(.light)
            
            InputBar(inputText: .constant("Hola"))
                .preferredColorScheme(.dark)
        }
    }
}

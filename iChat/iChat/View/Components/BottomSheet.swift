//
//  BottomSheet.swift
//  iChat
//
//  Created by Darío Gallegos on 17/8/22.
//

import SwiftUI

struct BottomSheet: View {
    
    //Gestures properties
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    
    //State sheet properties
    var showPicker: (()-> Void)?
    
    var body: some View {
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                let maxHeight = height - 300
                return AnyView(
                    ZStack {
                        
                        BlurView(style: .systemUltraThinMaterialDark)
                            .clipShape(RoundedCorner(corners: [.topLeft, .topRight], radius: 24))
                        VStack {
                            
                            HStack {
                                Button {
                                    withAnimation {
                                        showPicker?()
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.title)
                                }
                                .padding(.horizontal)
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: 60, height: 4)
                                    .padding(.top)
                            }
                                                        
                            ScrollView(.vertical) {
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: 300, height: 300)
                                
                                Rectangle()
                                    .fill(.yellow)
                                    .frame(width: 300, height: 300)
                                
                                Rectangle()
                                    .fill(.green)
                                    .frame(width: 300, height: 300)
                                Rectangle()
                                    .fill(.purple)
                                    .frame(width: 300, height: 300)
                            }
                            Spacer()
                        }
                        //.frame(maxHeight: .infinity, alignment: .top)
                        
                    }
                        .offset(y: maxHeight) //initial state offset
                        .offset(y: -offset > 0 ? offset : 0)
                        .gesture(
                            DragGesture()
                                .updating($gestureOffset, body: { value, output, _ in
                                    output = value.translation.height
                                    onChange()
                                }).onEnded({ value in
                                    withAnimation {
                                        //states for moving bottom sheet
                                        if -offset > 100 && -offset < maxHeight / 2 {
                                            //Mid state
                                            offset = -(maxHeight / 2)
                                        }
                                        else if -offset > maxHeight / 2 {
                                            offset = -maxHeight
                                        }
                                        else {
                                            offset = 0
                                        }
                                    }
                                    
                                    //storing las offset to gesture can continue from the last position
                                    lastOffset = offset
                                })
                            
                        )
                )
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .background(.clear)
     }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (Utils.maxHieght - 100)
        return progress * 30
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}

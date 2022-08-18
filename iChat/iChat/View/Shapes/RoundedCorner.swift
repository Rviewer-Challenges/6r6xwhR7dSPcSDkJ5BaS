//
//  RoundedCorner.swift
//  iChat
//
//  Created by Darío Gallegos on 17/8/22.
//

import SwiftUI

struct RoundedCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

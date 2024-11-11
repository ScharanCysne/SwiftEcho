//
//  RoundedCorner.swift
//  echo
//
//  Created by Nicholas Scharan on 10/11/24.
//

import SwiftUI


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner, enableBorder: Bool) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
            .overlay{
                RoundedCorner(radius: radius, corners: corners).stroke(.gray, lineWidth: enableBorder ? 1 : 0)
            }
    }
}

#Preview {
    RoundedCorner(radius: 12, corners: [.topLeft, .topRight, .bottomLeft])
}

#Preview {
    RoundedCorner(radius: 12, corners: [.topLeft, .topRight, .bottomLeft])
}

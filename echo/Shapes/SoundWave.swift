//
//  SoundWave.swift
//  echo
//
//  Created by Nicholas Scharan on 10/11/24.
//

import SwiftUI

struct SoundWaveShape: Shape {
    var amplitude: CGFloat = 10
    var frequency: CGFloat = 10
    var phase: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let start = 4 * rect.width / 10
        let end = 6 * rect.width / 10
        
        // Starting from the left side of the rectangle
        path.move(to: CGPoint(x: start, y: rect.midY))

        // Generate the wave
        for x in stride(from: start, to: end, by: 1) {
            let relativeX = x / rect.width
            let y = amplitude * sin(relativeX * frequency * .pi * 2 + phase) + rect.midY
            path.addLine(to: CGPoint(x: x, y: y))
        }

        return path
    }
}

struct SoundWaveView: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        ZStack {
            ForEach(0..<5) { i in
                SoundWaveShape(amplitude: CGFloat(5 + i * 5), frequency: 10)
                    .stroke(Color.blue.opacity(0.5 - Double(i) * 0.1), lineWidth: 2)
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                phase = .pi * 2 // Animate the phase to make the waves move
            }
        }
    }
}

#Preview {
    SoundWaveView()
}

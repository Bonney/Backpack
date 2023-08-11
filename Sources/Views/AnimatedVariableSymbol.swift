//
//  Created by Matt Bonney on 11/28/22.
//

import SwiftUI

public struct AnimatedVariableSymbol: View {
    @State private var progress: Double = 0.0
    private let systemName: String
    private let timer = Timer.publish(every: 1/6, on: .main, in: .common).autoconnect()

    public init(systemName: String) {
        self.systemName = systemName
    }

    public var body: some View {
        Image(systemName: systemName, variableValue: progress)
            .animation(.linear, value: progress)
            .onReceive(timer) { timerOutput in
                var newProgress = progress + 0.1
                if newProgress > 1.0 {
                    newProgress = 0.0
                }
                self.progress = newProgress
            }
    }
}

struct SFLoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AnimatedVariableSymbol(systemName: "timelapse")
                .foregroundStyle(.blue)
            AnimatedVariableSymbol(systemName: "message.and.waveform.fill")
                .foregroundStyle(.green)
            AnimatedVariableSymbol(systemName: "airplayaudio")
                .foregroundStyle(.purple)
        }
        .font(.system(size: 80))
        .imageScale(.large)
    }
}

import SwiftUI

public struct MaterialGradient: View {
    let material: Material
    let allowsHitTesting: Bool
    let edge: UnitPoint

    private let gradient: Gradient = Gradient(colors: [
        Color.black.opacity(0),
        Color.black.opacity(0.1),
        Color.black.opacity(0.5),
        Color.black.opacity(0.75),
        Color.black.opacity(1),
        Color.black.opacity(1),
        Color.black.opacity(1)
    ])

    public init(
        _ material: Material = Material.ultraThin,
        to edge: UnitPoint = .bottom,
        allowsHitTesting: Bool = false
    ) {
        self.material = material
        self.edge = edge
        self.allowsHitTesting = allowsHitTesting
    }

    public var body: some View {
        Rectangle()
            .fill(Color.clear)
            .background(Material.ultraThin)
            .mask(LinearGradient(gradient: self.gradient, startPoint: self.edge.opposite, endPoint: self.edge))
            .allowsHitTesting(self.allowsHitTesting)
    }
}

struct MaterialGradient_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ForEach(0..<10, id: \.self) { _ in
                Text("a Row")
            }
        }
        .scrollContentBackground(.hidden)
        .background(.blue, ignoresSafeAreaEdges: .all)
        .overlay(alignment: .top) {
                MaterialGradient(to: .top)
                    .frame(height: 400)
                    .ignoresSafeArea()
                    .overlay(alignment: .top) {
                        Text("MaterialGradient")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.gray.opacity(1.0))
                            .blendMode(.plusDarker)
                            .padding()
                    }
            }
    }
}


import simd

/// A 3-element struct used to represent a set of color components, such as `rgb`,` lab`, `lch`, and so on.
public typealias ChromaComponents = SIMD3<Double>

/// A 3x3 matrix used to perform color transformations
public typealias ColorMatrix = matrix_double3x3

extension ColorMatrix {
	@inlinable
	public init(x: ChromaComponents, y: ChromaComponents, z: ChromaComponents) {
		self.init(rows: [x, y, z])
	}
}

extension ColorMatrix {
	@inlinable
	public func dotProduct(_ components: ChromaComponents) -> ChromaComponents {
		self * components
	}
}

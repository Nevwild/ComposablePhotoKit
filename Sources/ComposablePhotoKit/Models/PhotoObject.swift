import Photos

/// A value type wrapper for `PHObject`. This type is necessary so that we can do equality checks
/// and write tests against its values.

public struct PhotoObject: Equatable {

    public let rawValue: PHObject?

    public var localIdentifier: String

    public init(rawValue: PHObject) {
        self.rawValue = rawValue
        self.localIdentifier = rawValue.localIdentifier
    }

    public init(localIdentifier: String) {
        self.rawValue = nil
        self.localIdentifier = localIdentifier
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.localIdentifier == rhs.localIdentifier
    }
}

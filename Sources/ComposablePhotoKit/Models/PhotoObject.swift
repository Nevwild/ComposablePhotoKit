import Photos

/// A value type wrapper for `PHObject`. This type is necessary so that we can do equality checks
/// and write tests against its values.

public struct PhotoObject {

    public let rawValue: PHObject

    public var localIdentifier: String

    public init(_ rawValue: PHObject) {
        self.rawValue = rawValue
        self.localIdentifier = rawValue.localIdentifier
    }
}

extension PhotoObject: Equatable {}

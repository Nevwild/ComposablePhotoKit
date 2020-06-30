import Photos

/// A value type wrapper for `PHObjectChangeDetails`. This type is necessary so that we can do equality checks
/// and write tests against its values.

public struct PhotoObjectChangeDetails {

    public let rawValue: PHObjectChangeDetails<PHObject>

    public init(_ rawValue: PHObjectChangeDetails<PHObject>) {
        self.rawValue = rawValue
        self.objectBeforeChanges = PhotoObject(rawValue: rawValue.objectBeforeChanges)
        if let after = rawValue.objectAfterChanges {
            self.objectAfterChanges = PhotoObject(rawValue: after)
        } else {
            self.objectAfterChanges = nil
        }
        self.assetContentChanged = rawValue.assetContentChanged
        self.objectWasDeleted = rawValue.objectWasDeleted
    }

    var objectBeforeChanges: PhotoObject
    var objectAfterChanges: PhotoObject?
    var assetContentChanged: Bool
    var objectWasDeleted: Bool
}

extension PhotoObjectChangeDetails: Equatable {}

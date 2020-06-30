import Photos

/// A value type wrapper for `PHChange`. This type is necessary so that we can do equality checks
/// and write tests against its values.

public struct PhotoChange {

    public let rawValue: PHChange

    public init(rawValue: PHChange) {
      self.rawValue = rawValue
    }

    public func changeDetails(for fetchResult: PhotoFetchResult<AnyObject>) ->  PhotoFetchResultChangeDetails? {
        guard let details = rawValue.changeDetails(for: fetchResult.rawValue) else { return nil }
        return PhotoFetchResultChangeDetails(details)
    }

    public func changeDetails(for object: PhotoObject) -> PhotoObjectChangeDetails? {
        guard let changeDetails = rawValue.changeDetails(for: object.rawValue) else { return nil }
        return PhotoObjectChangeDetails(changeDetails)
    }
    
    public func changeDetails(for fetchResult: PhotoFetchResult<PhotoObject>) -> PhotoFetchResultChangeDetails? {
        guard let changeDetails = rawValue.changeDetails(for: fetchResult.rawValue) else { return nil }
        return PhotoFetchResultChangeDetails(changeDetails)
    }

}

extension PhotoChange: Equatable {}


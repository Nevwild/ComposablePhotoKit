import Photos

/// A value type wrapper for `PHFetchResultChangeDetails`. This type is necessary so that we can do equality checks
/// and write tests against its values.

public struct PhotoFetchResultChangeDetails {

    public let rawValue: PHFetchResultChangeDetails<PHObject>

    public init(_ rawValue: PHFetchResultChangeDetails<PHObject>) {
        self.rawValue = rawValue
        self.hasIncrementalChanges = rawValue.hasIncrementalChanges
        self.removedIndexes = rawValue.removedIndexes
        self.removedObjects = rawValue.removedObjects
        self.insertedIndexes = rawValue.insertedIndexes
        self.insertedObjects = rawValue.insertedObjects
        self.changedIndexes = rawValue.changedIndexes
        self.changedObjects = rawValue.changedObjects
        self.hasMoves = rawValue.hasMoves
    }

    public init(from: PhotoFetchResult<AnyObject>, to: PhotoFetchResult<AnyObject>, changedObjects: [PhotoObject]) {

        self.rawValue = PHFetchResultChangeDetails(from: from.rawValue,
                                                   to: to.rawValue,
                                                   changedObjects: changedObjects.map { $0.rawValue}
        )

        self.hasIncrementalChanges = self.rawValue.hasIncrementalChanges
        self.removedIndexes = self.rawValue.removedIndexes
        self.removedObjects = self.rawValue.removedObjects
        self.insertedIndexes = self.rawValue.insertedIndexes
        self.insertedObjects = self.rawValue.insertedObjects
        self.changedIndexes = self.rawValue.changedIndexes
        self.changedObjects = self.rawValue.changedObjects
        self.hasMoves = self.rawValue.hasMoves
    }

    var fetchResultBeforeChanges: PhotoFetchResult<Any> {
        PhotoFetchResult(rawValue: rawValue.fetchResultBeforeChanges)
    }
    var fetchResultAfterChanges: PhotoFetchResult<Any>{
        PhotoFetchResult(rawValue: rawValue.fetchResultAfterChanges)
    }

    var hasIncrementalChanges: Bool
    var removedIndexes: IndexSet?
    var removedObjects: [PHObject]
    var insertedIndexes: IndexSet?
    var insertedObjects: [PHObject]
    var changedIndexes: IndexSet?
    var changedObjects: [PHObject]
    var hasMoves: Bool

    func enumerateMoves(_ moves: @escaping (Int, Int) -> Void) {
        rawValue.enumerateMoves(moves)
    }

}

extension PhotoFetchResultChangeDetails: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hasIncrementalChanges == rhs.hasIncrementalChanges
            && lhs.removedIndexes == rhs.removedIndexes
            && lhs.removedObjects == rhs.removedObjects
            && lhs.insertedIndexes == rhs.insertedIndexes
            && lhs.insertedObjects == rhs.insertedObjects
            && lhs.changedIndexes == rhs.changedIndexes
            && lhs.changedObjects == rhs.changedObjects
            && lhs.hasMoves == rhs.hasMoves
    }
}

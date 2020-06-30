import Photos

/// A value type wrapper for `PHFetchResultChangeDetails`. This type is necessary so that we can do equality checks
/// and write tests against its values.

public struct PhotoFetchResultChangeDetails {

    public let rawValue: PHFetchResultChangeDetails<PHObject>

    public init(rawValue: PHFetchResultChangeDetails<PHObject>) {
        self.rawValue = rawValue
    }

    public init(from: PHFetchResult<ObjectType>, to: PHFetchResult<ObjectType>, changedObjects: [ObjectType]) {
        self.rawValue =  PHFetchResultChangeDetails.init(from: from, to: to, changedObjects: changedObjects)
    }

    var fetchResultBeforeChanges: PHFetchResult<ObjectType> { rawValue.fetchResultBeforeChanges }
    var fetchResultAfterChanges: PHFetchResult<ObjectType> { rawValue.fetchResultAfterChanges }

    var hasIncrementalChanges: Bool

    var removedIndexes: IndexSet?

    var removedObjects: [PHObject]

    var insertedIndexes: IndexSet?

    var insertedObjects: [PHObject]

    var changedIndexes: IndexSet?

    var changedObjects: [PHObject]

    var hasMoves: Bool

    func enumerateMoves((Int, Int) -> Void)

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

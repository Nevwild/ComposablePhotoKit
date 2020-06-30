import Photos

/// A value type wrapper for `PHFetchResult`. This type is necessary so that we can do equality checks
/// and write tests against its values.

public struct PhotoFetchResult<AnyObject> {

    public let rawValue: PHFetchResult<PHObject>

    public init(rawValue: PHFetchResult<PHObject>) {
        self.rawValue = rawValue
        //FIXME: get rid of this if else
        if let first = rawValue.firstObject,
           let last = rawValue.lastObject {
            self.firstObject = PhotoObject(first)
            self.lastObject = PhotoObject(last)
        } else {
            self.firstObject = nil
            self.lastObject = nil
        }
        self.count = rawValue.count
    }

    func contains(_ anObject: PhotoObject) -> Bool { rawValue.contains(anObject.rawValue)
    }

    var count: Int

    func countOfAssets(with: PHAssetMediaType) -> Int {
        rawValue.countOfAssets(with: with)
    }

    var firstObject: PhotoObject?

    var lastObject: PhotoObject?

    func object(at: Int) -> PhotoObject {PhotoObject(rawValue.object(at: at))}

    // TODO:how to subscript photoobject
//    subscript(Int) -> PhotoObject {
//        rawValue[int]
//    }

    func objects(at: IndexSet) -> [PhotoObject] {
        rawValue.objects(at: at).map { PhotoObject($0) }
    }

    func index(of: PhotoObject) -> Int {rawValue.index(of: of.rawValue)}

    func index(of: PhotoObject, inRange: NSRange) -> Int {rawValue.index(of: of.rawValue, in: inRange)}

   // TODO: figure out how to enumerate objects
//    func enumerateObjects(at: IndexSet, options: NSEnumerationOptions, using: @escaping (PhotoObject, Int, UnsafeMutablePointer<ObjCBool>) -> Void) {
//        rawValue.enumerateObjects(at: at, options: options, using: using)
//    }
//
//    func enumerateObjects((PhotoObject, Int, UnsafeMutablePointer<ObjCBool>) -> Void){photoObject, int, pointer in  rawValue.enumerateObjects(photoObject, int, pointer)}
//
//    func enumerateObjects(options: NSEnumerationOptions, using: (PhotoObject, Int, UnsafeMutablePointer<ObjCBool>) -> Void)


}
extension PhotoFetchResult: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.count == rhs.count
            && lhs.firstObject == rhs.firstObject
            && lhs.firstObject == rhs.lastObject
    }
}

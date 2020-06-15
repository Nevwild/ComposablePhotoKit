//
//  PhotoChange.swift
//  RecollMobile
//
//  Created by Nevill Wilder on 6/15/20.
//  Copyright © 2020 NevWild. All rights reserved.
//

import Photos

/// A value type wrapper for `PHChange`. This type is necessary so that we can do equality checks
/// and write tests against its values.

public struct PhotoChange {

    public let rawValue: PHChange
    public var changeDetailsForObject: PhotoObject
    public var changeDetailsForFetchResult: PHFetchResult<AnyObject>
    public init(rawValue: PHChange) {
      self.rawValue = rawValue

    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.changeDetailsForObject == rhs.changeDetailsForObject
        &&

        lhs.changeDetailsForFetchResult == rhs.changeDetailsForFetchResult

    }



}

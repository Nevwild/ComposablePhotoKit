//
//  PhotoFetchResult.swift
//  RecollMobile
//
//  Created by Nevill Wilder on 6/15/20.
//  Copyright © 2020 NevWild. All rights reserved.
//

import Photos

public struct PhotoFetchResult: Equatable {

    public let rawValue: PHFetchResult<PHObject>?


    public var firstObject: PHObject?
    public var lastObject: PHObject?
    public init(fetchResult: PHFetchResult<PHObject>) {
        self.rawValue = nil
        self.firstObject = fetchResult.firstObject
        self.lastObject = fetchResult.lastObject
    }

    public init(localIdentifier: String){
        self.rawValue = nil
        self.localIdentifier = localIdentifier
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.localIdentifier == rhs.localIdentifier
    }
}

//
//  PhotoObject.swift
//  RecollMobile
//
//  Created by Nevill Wilder on 6/15/20.
//  Copyright © 2020 NevWild. All rights reserved.
//

import Photos


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

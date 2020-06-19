//
//  Interface.swift
//  RecollMobile
//
//  Created by Nevill Wilder on 6/12/20.
//  Copyright © 2020 NevWild. All rights reserved.
//

import Combine
import ComposableArchitecture
import Photos
import PhotosUI

//TODO: Figure out where to put the perform changes methods of the photolibrary. I intuiit that they should be actions, but I'm not sure how to handle objc blocks in the tca.

public struct PhotoLibrary {

    public enum Action : Equatable {
        // TODO: These are both coming from seperate protocols. Should they be represented by different action enums?
        case photoLibraryDidChange(PHChange)
        case photoLibraryDidBecomeUnavailable(PHPhotoLibrary)
    }

    public struct Error: Swift.Error, Equatable {
        public let error: NSError

        public init(_ error: Swift.Error) {
            self.error = error as NSError
        }
    }

    public var authorizationStatus: () -> PHAuthorizationStatus = {
        _unimplemented("authorizationStatus")
    }

    var create: (AnyHashable) -> Effect<Action, Never> = { _ in _unimplemented("create") }

    var destroy: (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("destroy") }


    var requestAuthorization: (AnyHashable) -> Effect<Never, Never> = { _ in
        _unimplemented("requestAuthorization")
    }

    public func create(id: AnyHashable) -> Effect<Action, Never> {
        self.create(id)
    }

    public func destroy(id: AnyHashable) -> Effect<Never, Never> {
        self.destroy(id)
    }

    var set: (AnyHashable, Properties) -> Effect<Never, Never> = { _, _ in _unimplemented("set")
    }
    
    public func requestAuthorization(id: AnyHashable) -> Effect<Never, Never> {
        self.requestAuthorization(id)
    }

    public func set(
        id: AnyHashable,
        unavailabilityReason: Error)
    -> Effect<Never, Never> {
        self.set(
            id,
            Properties(
                unavailabilityReason: unavailabilityReason)
            )
    }
}

extension PhotoLibrary {
    public struct Properties:Equatable{
        var unavailabilityReason: Error? = nil
    }
}

extension PhotoLibrary {

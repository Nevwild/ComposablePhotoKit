//
//  Live.swift
//  RecollMobile
//
//  Created by Nevill Wilder on 6/15/20.
//  Copyright © 2020 NevWild. All rights reserved.
//

import ComposableArchitecture
import Photos


extension PhotoLibrary {

    public static let live: PhotoLibrary = { () -> PhotoLibrary in

        var library = PhotoLibrary()

        library.authorizationStatus = PHPhotoLibrary.authorizationStatus()

        // TODO: build out create
        library.create { id in
            Effect.run { subscriber in
                let library = library.sharedPhotoLibrary
            }
        }
        // TODO: build out destroy
        library.destroy {id in
            .fireAndForget {

            }
        }
    }()
}
private struct Dependencies {
    let library: PHPhotoLibrary
    let libraryChangeObserver: PhotoLibraryChangeObserver
    let availabilityObserver: PhotoLibraryAvailabilityObserver
    let subscriber: Effect<PhotoLibrary.Action, Never>.Subscriber
}

private var dependencies: [AnyHashable: Dependencies] = [:]

private class PhotoLibraryAvailabilityObserver: NSObject, PHPhotoLibraryAvailabilityObserver {

    let subscriber: Effect<PhotoLibrary.Action, Never>.Subscriber

    init(_ subscriber: Effect<PhotoLibrary.Action, Never>.Subscriber) {
        self.subscriber = subscriber
    }

    // TODO:figure out if i need to wrap the photolibrary in a value type
    func photoLibraryDidBecomeUnavailable(_ photoLibrary: PHPhotoLibrary) {
        subscriber.send(.photoLibraryDidBecomeUnavailable(photoLibrary))
    }
}

private class PhotoLibraryChangeObserver: NSObject, PHPhotoLibraryChangeObserver {

    let subscriber: Effect<PhotoLibrary.Action, Never>.Subscriber

    init(_ subscriber: Effect<PhotoLibrary.Action, Never>.Subscriber) {
        self.subscriber = subscriber
    }

    // TODO: create PhotoChange value type for this subscription
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        subscriber.send(.photoLibraryDidChange(changeInstance))
    }
}


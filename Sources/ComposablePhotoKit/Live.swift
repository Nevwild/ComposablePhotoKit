//
//  Live.swift
//  RecollMobile
//
//  Created by Nevill Wilder on 6/15/20.
//  Copyright © 2020 NevWild. All rights reserved.
//

import Combine
import ComposableArchitecture
import Photos

extension PhotoLibrary {

    public static let live: PhotoLibrary = { () -> PhotoLibrary in

        var library:PhotoLibrary = PhotoLibrary()

        library.authorizationStatus = PHPhotoLibrary.authorizationStatus

        library.create = { id in
            Effect.run { subscriber in
                let sharedLibrary = PHPhotoLibrary.shared

                var availabilityObserver = PhotoLibraryAvailabilityObserver(subscriber)
                sharedLibrary().register(availabilityObserver)

                var changeObserver = PhotoLibraryChangeObserver(subscriber)
                sharedLibrary().register(changeObserver)

                dependencies[id] = Dependencies(
                    library: sharedLibrary(),
                    libraryChangeObserver: changeObserver,
                    availabilityObserver: availabilityObserver,
                    subscriber: subscriber)

                return AnyCancellable {
                    dependencies[id] = nil
                }
            }
        }

        // TODO: build out destroy
        library.destroy = { id in
            .fireAndForget {
                dependencies[id]?.subscriber.send(completion: .finished)
                dependencies[id] = nil
            }
        }
        return library
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


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

    public static let live: PhotoLibrary = {

        var library = PhotoLibrary()

        library.authorizationStatus = PHPhotoLibrary.authorizationStatus()
        library.create { id in
            Effect.run { subscriber in
                let library = library.sharedPhotoLibrary
private struct Dependencies {
  let libraryChangeObserver: PhotoLibraryChangeObserver
  let availabilityObserver: PhotoLibraryAvailabilityObserver
  let subscriber: Effect<PhotoLibrary.Action, Never>.Subscriber
}

private var dependencies: [AnyHashable: Dependencies] = [:]

                

            }

        }

        library
    }()
}

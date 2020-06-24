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

    var sharedPhotoLibrary:PHPhotoLibrary {PHPhotoLibrary.shared()}

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

    
    // TODO:
    var requestAuthorization: (AnyHashable) -> Effect<Never, Never> = { _ in
        _unimplemented("requestAuthorization")
    }


    // TODO:
    var registerChangeObserver: (AnyHashable) -> Effect<Never, Never> = {_ in _unimplemented("registerChangeObserver")
    }
    // TODO:
    var unregisterChangeObserver: (AnyHashable) -> Effect<Never, Never> = {_ in _unimplemented("unregisterChangeObserver")
    }

    var registerAvailabilityObserver: (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("registerChangeObserver")
    }

    var unregisterAvailabilityObserver: (AnyHashable) -> Effect<Never, Never> = { _ in
        _unimplemented("unregisterAvailabilityObserver")
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

    public func registerAvailabilityObserver(id: AnyHashable) -> Effect<Never, Never> {
        self.registerAvailabilityObserver(id)
    }
    public func unregisterAvailabilityObserver(id: AnyHashable) -> Effect<Never, Never> {
        self.unregisterAvailabilityObserver(id)
    }

    public func registerChangeObserver(id: AnyHashable) -> Effect<Never, Never> {
        self.registerChangeObserver(id)
    }
    public func unregisterChangeObserver(id: AnyHashable) -> Effect<Never, Never> {
        self.unregisterAvailabilityObserver(id)
    }

extension PhotoLibrary {
    public struct Properties:Equatable{
        var unavailabilityReason: Error? = nil
    }
}
`
 //

 #import <Foundation/Foundation.h>
 #import <Photos/PhotosTypes.h>

 NS_ASSUME_NONNULL_BEGIN
 API_AVAILABLE_BEGIN(macos(10.13), ios(8), tvos(10))

 @class PHChange;
 @class PHPhotoLibrary;

 typedef NS_ENUM(NSInteger, PHAuthorizationStatus) {
 PHAuthorizationStatusNotDetermined = 0, // User has not yet made a choice with regards to this application
 PHAuthorizationStatusRestricted,        // This application is not authorized to access photo data.
 // The user cannot change this application’s status, possibly due to active restrictions
 //   such as parental controls being in place.
 PHAuthorizationStatusDenied,            // User has explicitly denied this application access to photos data.
 PHAuthorizationStatusAuthorized         // User has authorized this application to access photos data.
 };

 #pragma mark -
 @protocol PHPhotoLibraryChangeObserver <NSObject>
 // This callback is invoked on an arbitrary serial queue. If you need this to be handled on a specific queue, you should redispatch appropriately
 - (void)photoLibraryDidChange:(PHChange *)changeInstance;

 @end

 #pragma mark -
 API_AVAILABLE(macos(10.15), ios(13), tvos(13))
 @protocol PHPhotoLibraryAvailabilityObserver <NSObject>
 // This notification is posted on a private queue.
 - (void)photoLibraryDidBecomeUnavailable:(PHPhotoLibrary *)photoLibrary API_AVAILABLE(macos(10.15), ios(13), tvos(13));
 @end

 /*!
 @class        PHPhotoLibrary
 @abstract     A PHPhotoLibrary provides access to the metadata and image data for the photos, videos and related content in the user's photo library, including content from the Camera Roll, iCloud Shared, Photo Stream, imported, and synced from iTunes.
 @discussion   ...
 */
 #pragma mark -
 OS_EXPORT
 @interface PHPhotoLibrary : NSObject

 + (PHPhotoLibrary *)sharedPhotoLibrary;

 + (PHAuthorizationStatus)authorizationStatus;
 + (void)requestAuthorization:(void(^)(PHAuthorizationStatus status))handler;

 #pragma mark - Library availability

 @property (readonly, atomic, nullable, strong) NSError *unavailabilityReason API_AVAILABLE(macos(10.15), ios(13), tvos(13));

 - (void)registerAvailabilityObserver:(id<PHPhotoLibraryAvailabilityObserver>)observer API_AVAILABLE(macos(10.15), ios(13), tvos(13));
 - (void)unregisterAvailabilityObserver:(id<PHPhotoLibraryAvailabilityObserver>)observer API_AVAILABLE(macos(10.15), ios(13), tvos(13));

 #pragma mark - Applying Changes

 // handlers are invoked on an arbitrary serial queue
 // Nesting change requests will throw an exception
 - (void)performChanges:(dispatch_block_t)changeBlock completionHandler:(nullable void(^)(BOOL success, NSError *__nullable error))completionHandler;
 - (BOOL)performChangesAndWait:(dispatch_block_t)changeBlock error:(NSError *__autoreleasing *)error;

 #pragma mark - Change Handling

 - (void)registerChangeObserver:(id<PHPhotoLibraryChangeObserver>)observer;
 - (void)unregisterChangeObserver:(id<PHPhotoLibraryChangeObserver>)observer;

 @end

 API_AVAILABLE_END
 NS_ASSUME_NONNULL_END
 */

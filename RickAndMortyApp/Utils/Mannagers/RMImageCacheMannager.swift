//
//  RMImageCacheMannager.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 7/2/23.
//

import UIKit

final class RMImageCacheMannager {
    
    static let shared = RMImageCacheMannager()
    
    private init() {}
    
    /// The cache where the images that are downloaded as the cells are displayed are stored.
    private let cache = NSCache<NSString, NSData>()
    
    /// Returns the global system queue with the specified quality-of-service class.
    /// qos: .utility -> The quality-of-service class for tasks that the user does not track actively.
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    // MARK: - Store Image on Cache
    private func cache(image: Data, forKey value: String) {
        let image = NSData(data: image)
        let itemKey = NSString(string: value)
        self.cache.setObject(image, forKey: itemKey)
    }
    
    // MARK: - Image Cache
    /// Private getter for a cache image for key imput
    /// - Parameter value: key for the cached image (image url path)
    /// - Returns: Return the Data os the image stored
    private func getImageCache(forKey value: String) -> Data? {
        let itemKey = NSString(string: value)
        return cache.object(forKey: itemKey) as? Data
    }
    
    // MARK: - Image Downloading
    /// Download a image from given image path.
    /// Store the downloaded Image in the internal cache.
    /// - Parameters:
    ///   - imagePath: url path for download image.
    ///   - completion: Return the Data os the image downloaded.
    private func downloadImage(imagePath: String, completion: @escaping (Data?) -> ()) {
        guard let imageUrl = URL(string: imagePath) else { return }
        utilityQueue.async {
            guard let data = try? Data(contentsOf: imageUrl) else { return }

            self.cache(image: data, forKey: imagePath)
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}

// MARK: ImageCache - Public Methods

extension RMImageCacheMannager {
    
    // MARK: - Image Loading
    /// Return the cached image for the key if its posible.
    /// If the image is not being cached, the method downloads it, caches the image, and returns it on completion.
    /// - Parameters:
    ///   - value: url path for the cache or download image.
    ///   - completion: Return the Data os the image cached or downloaded.
    public func loadImage(forKey value: String, completion: @escaping (Data?) -> Void) {
        if let cachedImage = getImageCache(forKey: value) {
            completion(cachedImage)
        } else {
            downloadImage(imagePath: value) { downloadedImage in
                completion(downloadedImage)
            }
        }
    }
}


//
//  ImageService.swift
//  TrabajoFinal
//
//  Created by Mac 11 on 24/06/22.
//

import Foundation
import UIKit

class ImageService {
    static func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: url) {data,url, error in
            var downloadedImage:UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        dataTask.resume()
    }
}

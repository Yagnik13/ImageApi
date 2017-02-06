//
//  APImanager.swift
//  ImageAPI
//
//  Created by Yagnik on 03/02/17.
//  Coopyright © 2017 Yagnik. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString,UIImage>()

class APImanager: NSObject {
    
    func callGetWebservice(urlString: String, completionHandler: (([Image])->Void)? ) {
        
        var imgs = [Image]()
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    return
                }
                
                if let data = data {
                    print(data)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        if let reponseArray = json as? NSArray {
                            // print(reponseArray)
                            for responseDict in reponseArray {
                                if let dict = responseDict as? [String: AnyObject] {
                                    
                                    guard let title = dict["title"] as? String else { break }
                                    guard let id = dict["id"] as? Int else { break }
                                    // guard let userId = dict["userId"] as? Int else { break }
                                    guard let thumbnailUrl = dict["thumbnailUrl"] as? String else { break }
                                    guard let bigImgUrl = dict["url"] as? String else { break }
                                    
                                    let images = Image(id: id, title: title,bigImgUrl: bigImgUrl ,thumbnailUrl: thumbnailUrl)
                                    
                                    imgs.append(images)
                                    
                                }
                            }
                            
                            DispatchQueue.main.async {
                                completionHandler?(imgs)
                            }
                            
                        }
                        
                    }catch let err {
                        print(err)
                    }
                }
                
            }).resume()
        }
    }
    
    
    
    func getImage(from urlString: String, for indexPath: IndexPath, completion: ((UIImage)->())?) {
        // convert to URL
        // create urlSession and resume it
        // get the image data in Data form
        // convert imageData to UIImage
        
        let cacheKey = "\(indexPath.row)"
        
        if let cachedImage = imageCache.object(forKey: cacheKey as NSString) {
            completion?(cachedImage)
            return
        }
    
        else  if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    return
                }
                
                if let data = data {
                    if let image = UIImage(data: data) {
                        //print(image)
                        imageCache.setObject(image, forKey: "\(indexPath.row)" as NSString)
                        DispatchQueue.main.async {
                            
                            completion?(image)
                        }
                    }
                    
                }
            }).resume()
        }
    }
}

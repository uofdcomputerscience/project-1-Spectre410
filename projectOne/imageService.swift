//
//  imageService.swift
//  projectOne
//
//  Created by Matt Pritchett on 10/7/19.
//  Copyright © 2019 Matt Pritchett. All rights reserved.
//

import UIKit

class imageService {
    var record: [URL:UIImage] = [:]
    
    func getImage(for url: URL, completion: @escaping ((UIImage) -> Void)) {
        
        // download the image, and call the completion with the url and image.
        // the cell can then verify that the image being returned is the one
        // requested.
        // you may even keep a dictionary of results, and then call the completion
        // with an entry from that dictionary, if one exists, otherwise make the
        // network call and store its result in the dictionary as well as calling
        // the completion. This would allow the _second_ call for any image to not
        // perform a network operation!
        if self.record[url] != nil {
            completion(record[url]!)
        }

        let request = URLRequest(url: url)
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: request) { (data, response, error) in
            let image = UIImage(data: data!)
            self.record[url] = image
            completion(image!)
        }
        task.resume()

        
    }
    
}



    


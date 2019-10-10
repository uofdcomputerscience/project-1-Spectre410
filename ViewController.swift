//
//  ViewController.swift
//  projectOne
//
//  Created by Matt Pritchett on 10/7/19.
//  Copyright © 2019 Matt Pritchett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var container = MercuryContainer(mercury:[])
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.dataSource = self
        let urlString = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let semaphore = DispatchSemaphore(value: 0)
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: request) { (data, response, error) in
            self.container = try! JSONDecoder().decode(MercuryContainer.self, from: data!)
            semaphore.signal()
            self.tableView.reloadData()
        }
        task.resume()
        semaphore.wait()
        super.viewDidLoad()
        
    }


}





extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return container.mercury.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var image: UIImage = UIImage(named: "def_image")!
        let i = container.mercury[indexPath.item]
        image = imageService().getImage(for: i.imageURL)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell")!
        if let imageCell = cell as? imageCell {
            imageCell.tableImage.image = image
            imageCell.nameField.text = i.name
            imageCell.typeField.text = i.type
        }
        return cell
    }
    
    
}

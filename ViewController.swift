//
//  ViewController.swift
//  projectOne
//
//  Created by Matt Pritchett on 10/7/19.
//  Copyright © 2019 Matt Pritchett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var container = MercuryContainer(a:[])

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        let urlString = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: request) { (data, response, error) in
            self.container = try! JSONDecoder().decode(MercuryContainer.self, from: data!)
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
        
        
        super.viewDidLoad()
        
    }


}





extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return container.a.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = container.a[indexPath.item]
        let image = imageService().getImage(for: i.imageURL)
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell")!
        DispatchQueue.main.async(){
            if let imageCell = cell as? imageCell {
            imageCell.tableImage.image = image
            imageCell.nameField.text = i.name
            imageCell.typeField.text = i.type
            }
        }
        return cell
    }
    
    
}

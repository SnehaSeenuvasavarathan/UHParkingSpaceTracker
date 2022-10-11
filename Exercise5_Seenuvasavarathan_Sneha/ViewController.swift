//
//  ViewController.swift
//  Exercise5_Seenuvasavarathan_Sneha
//
//  Created by Sneha Seenuvasavarathan on 10/10/22.
//

import UIKit

class ViewController: UIViewController {
    var zone = Zones()
    @IBOutlet weak var zoneImage: UIImageView!
    @IBOutlet weak var zoneName: UILabel!
    @IBOutlet weak var lotsName: UILabel!
    @IBOutlet weak var zoneAbout: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        zoneName.text = zone.name
        lotsName.text = zone.lots
        zoneAbout.text = zone.about
                
                URLSession.shared.dataTask(with: zone.map, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    DispatchQueue.main.async {
                        self.zoneImage.image = UIImage(data: data!)
                    }
                }).resume()
            }
        // Do any additional setup after loading the view.
    }





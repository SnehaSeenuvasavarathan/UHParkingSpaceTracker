//
//  TableViewController.swift
//  Exercise5_Seenuvasavarathan_Sneha
//
//  Created by Sneha Seenuvasavarathan on 10/10/22.
//

import UIKit
struct Zones: Codable {
    let name: String
    let free: Int
    let close_to: String
    let logo: URL
    let map: URL
    let lots: String
    let info: URL
    let about: String
    
    init() {
        name = ""
        free = 0
        close_to = ""
        logo = URL(string: "http://www.google.com")!
        map = URL(string: "http://www.google.com")!
        lots = ""
        info = URL(string: "http://www.google.com")!
        about = ""
    }
    
}

class TableViewController: UITableViewController {
    var zone = [Zones]()
    var selectedZone = Zones()

        override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://cpl.uh.edu/courses/ubicomp/fall2022/webservice/parking/parkinglots.json")
        if url != nil{
            getData(url:url!)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return zone.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let name = cell.viewWithTag(1) as! UILabel
        let free = cell.viewWithTag(2) as! UILabel

        name.text = zone[indexPath.row].name
        free.text = "Free: \(zone[indexPath.row].free)"
        for section in 0..<tableView.numberOfSections {
                for row in 0..<tableView.numberOfRows(inSection: section) {
                    let indexPath = NSIndexPath(row: row, section: section)
                    var color = tableView.cellForRow(at: indexPath as IndexPath)

                    color?.textLabel?.textColor = .red

                    
                }

            }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedZone = zone[indexPath.row]
            self.performSegue(withIdentifier: "seg_details", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg_details" {
                    let detailed_view = segue.destination as! ViewController
                    detailed_view.zone = selectedZone
                }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func getData(url: URL) {

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

                if let data = data {
                    do {
                        // Convert the data to JSON
                        let jsonDecoder = JSONDecoder()
                        let zones = try jsonDecoder.decode(Array<Zones>.self, from: data)
    //                    print(languages)
                        self.zone = zones
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                        print("Error trying to decode JSON object")
                    }

                } else if let error = error {
                    print(error.localizedDescription)
                }
            }

            task.resume()
        }
    
}

//
//  MasterViewController.swift
//  FahdsApp-P1
//
//  Created by Fahd on 4/24/21.
//

import Foundation
import UIKit
var ItemsArray = [DGRGItems]()

class MasterViewContoller : UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor =  UIColor.black.withAlphaComponent(0.85)
        self.tableView.separatorColor = UIColor.clear
        populateItemsObjects()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetail") {
            let controller = segue.destination as! ViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller.ReceiveItem  = ItemsArray[indexPath!.row]
            controller.itemCounter = indexPath!.row
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.systemTeal
        cell.textLabel!.text = ItemsArray[indexPath.row].ItemName
        cell.detailTextLabel!.text = "Verse: " + String(ItemsArray[indexPath.row].ItemNumber)
        let lockIcon = UIImage(named: ItemsArray[indexPath.row].ItemImage)
        let lockIconView = UIImageView(image: lockIcon)
        lockIconView.frame = CGRect(x: 0, y: 0, width: 220, height: 60)
        cell.accessoryView = lockIconView
        cell.accessoryView?.contentMode =  UIView.ContentMode.scaleToFill
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "The Holy Quran"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.systemTeal
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
    }

}

func populateItemsObjects() {
    let endPoint = "https://raw.githubusercontent.com/cfahd/data/main/data.json"
    let jsURL:URL = URL(string: endPoint)!
    let jsonData  = try? Data(contentsOf: jsURL)
    print(jsonData ?? "Error. No data to print. JSONData is nil")
    if(jsonData != nil) {
        let dictionary:NSDictionary = (try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        print(dictionary)
        let htDictionary = dictionary["DGRGItems"]! as! [[String:AnyObject]]
        for index in 0...htDictionary.count - 1 {
            let singleHT = htDictionary[index]
            let ht = DGRGItems()
            ht.ItemName = singleHT["ItemName"]! as! String
            ht.ItemNumber = singleHT["ItemNumber"]! as! String
            ht.ItemTranslation1 = singleHT["ItemTranslation1"]! as! String
            ht.ItemTranslation2 = singleHT["ItemTranslation2"]! as! String
            ht.ItemDuration = singleHT["ItemDuration"]! as! String
            ht.ItemImage = singleHT["ItemImage"]! as! String
            ht.ItemDifficulty = singleHT["ItemDifficulty"]! as! String
            ht.ItemSite = singleHT["ItemSite"]! as! String
            ht.ItemSound = singleHT["ItemSound"]! as! String
            ItemsArray.append(ht)
        }
    }
}

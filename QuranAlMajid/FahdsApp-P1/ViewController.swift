//
//  ViewController.swift
//  FahdsApp-P1
//
//  Created by Fahd on 3/10/21.
//
/*
    this App is developed as an educational project”. If any copyrighted materials are included in accordance to the multimedia fair use guidelines, a notice should be added and states that “certain materials are included under the fair use exemption of the U.S. Copyright Law and have been prepared according to the multimedia fair use guidelines and are restricted from further use”.
*/

import UIKit
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblNumber: UILabel!
    
    @IBOutlet weak var lblDescription1: UILabel!
    @IBOutlet weak var lblDescription2: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblDifficulty: UILabel!
    
    @IBOutlet weak var switchFav: UISwitch!
    @IBOutlet weak var iconDur: UIImageView!
    @IBOutlet weak var iconPlay: UIImageView!
    @IBOutlet weak var iconStop: UIImageView!
    @IBOutlet weak var iconMem: UIImageView!
    @IBOutlet weak var iconFav: UIImageView!
    @IBOutlet weak var iconDesc1: UIImageView!
    @IBOutlet weak var iconDesc2: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var iconTheme: UIImageView!
    @IBOutlet weak var btnTheme: UIButton!
    @IBOutlet weak var iconSite: UIImageView!
    @IBOutlet weak var btnVisit: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblSave: UILabel!
    
    @IBAction func btnRandomColor(_ sender: Any) {themeColor()}
    
    func themeColor(){
        //Show use of Random Value. Generates random theme color.
        let colorsArray = [UIColor.systemGreen,UIColor.systemTeal,UIColor.systemOrange,UIColor.systemPink]
        let myColor =  colorsArray.randomElement()
        let elementsUI = [iconDur, switchFav,iconPlay,iconFav,iconStop,iconMem,iconDesc1,iconDesc2,btnNext,iconTheme,iconSite,btnVisit,btnTheme,btnStop,btnPlay]
        for x in elementsUI {x?.tintColor = myColor}
        btnPlay.setTitleColor(myColor, for: .normal)
        btnStop.setTitleColor(myColor, for: .normal)
        btnVisit.setTitleColor(myColor, for: .normal)
        switchFav.thumbTintColor = myColor
        lblSave.textColor = myColor
        lblName.textColor = myColor
    }
    
    func defaultThemeColor(){
        let myColor =  UIColor.systemTeal
        let elementsUI = [iconDur, switchFav,iconPlay,iconFav,iconStop,iconMem,iconDesc1,iconDesc2,btnNext,iconTheme,iconSite,btnVisit,btnTheme,btnStop,btnPlay]
        for x in elementsUI {x?.tintColor = myColor}
        btnPlay.setTitleColor(myColor, for: .normal)
        btnStop.setTitleColor(myColor, for: .normal)
        btnVisit.setTitleColor(myColor, for: .normal)
        switchFav.thumbTintColor = myColor
        lblSave.textColor = myColor
        lblName.textColor = myColor
    }
    
    var selectedSite = ""
    var mySound:AVAudioPlayer?
    
    
    @IBAction func btnNextItem(_ sender: Any) {
        itemCounter+=1
        if itemCounter == ItemsArray.count { itemCounter = 0 }
        mainView.alpha = 0
        updateUI()
        UIView.animate(withDuration: 1.0, animations: {
            self.mainView.alpha = 1
        })
        
    }
    
    @IBAction func btnInfo(_ sender: Any) {
        let url = URL(string:selectedSite)
        UIApplication.shared.open(url!)
    }
    
    @IBAction func btnPlay(_ sender: Any) {
        // Project uses sound files to convey intent
        let mypath = String(ItemsArray[itemCounter].ItemSound)
        let path = Bundle.main.path(forResource: mypath, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        mySound = try? AVAudioPlayer(contentsOf: url)
        mySound?.play()
    }
    /*
        Stop button done outside of the syllabus (creative thinking).
        Adds additional functionaity when interacting with sounds.
    */
    @IBAction func btnStop(_ sender: Any){mySound?.stop()}
    
    @IBAction func switchFav(_ sender: Any) {
        UserDefaults.standard.set(lblName.text, forKey: "favorite")
    }
    func updateUI(){
        //Show use of Classes, Arrays, Random Value
        lblName.text = ItemsArray[itemCounter].ItemName
        lblNumber.text = String(ItemsArray[itemCounter].ItemNumber)
        lblDescription1.text = ItemsArray[itemCounter].ItemTranslation1
        lblDescription2.text = ItemsArray[itemCounter].ItemTranslation2
        lblDuration.text = ItemsArray[itemCounter].ItemDuration
        lblDifficulty.text = ItemsArray[itemCounter].ItemDifficulty
        imgItem.image = UIImage(named: ItemsArray[itemCounter].ItemImage)
        let favName = UserDefaults.standard.string(forKey: "favorite")
        switchFav.isOn = (ItemsArray[itemCounter].ItemName == favName)
        selectedSite = ItemsArray[itemCounter].ItemSite
        switch ItemsArray[itemCounter].ItemDifficulty {
            case "Easy" :
                lblDifficulty.textColor = UIColor.green
            case "Moderate" :
                lblDifficulty.textColor = UIColor.yellow
            case "Hard" :
                lblDifficulty.textColor = UIColor.red
            default :
                lblDifficulty.textColor = UIColor.white
        }
    }
    
    func updateInitial(){
        //Show use of Classes, Arrays, Random Value
        lblName.text = ReceiveItem?.ItemName
        lblNumber.text = String(ReceiveItem!.ItemNumber)
        lblDescription1.text = ReceiveItem?.ItemTranslation1
        lblDescription2.text = ReceiveItem?.ItemTranslation2
        lblDuration.text = ReceiveItem?.ItemDuration
        lblDifficulty.text = ReceiveItem?.ItemDifficulty
        imgItem.image = UIImage(named: ReceiveItem!.ItemImage)
        let favName = UserDefaults.standard.string(forKey: "favorite")
        switchFav.isOn = (ReceiveItem?.ItemName == favName)
        selectedSite = ReceiveItem!.ItemSite
        switch ReceiveItem?.ItemDifficulty {
            case "Easy" :
                lblDifficulty.textColor = UIColor.green
            case "Moderate" :
                lblDifficulty.textColor = UIColor.yellow
            case "Hard" :
                lblDifficulty.textColor = UIColor.red
            default :
                lblDifficulty.textColor = UIColor.white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mainView.alpha = 1
        self.mainView.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        defaultThemeColor()
        populateItemsObjects()
        updateInitial()
    }
    var ReceiveItem:DGRGItems? = nil
    var itemCounter:Int = 0
}


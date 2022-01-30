//
//  ViewController.swift
//  SunriseApp
//
//  Created by Takeya Shimizu on 2022/01/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameInput: UITextField!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func findSunrise(_ sender: Any) {
        let apiKey = "d656ffaab4e7c04246e108ad5a586119"
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityNameInput.text!)&appid=\(apiKey)"
        getURL(url: url)
    }
    
    func getURL(url: String) {
        do {
            let apiURL = URL(string: url)!
            let data = try Data(contentsOf: apiURL)
            let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
            print(json)
        } catch {
            print("error occurred...")
            self.sunriseTimeLabel.text = "サーバーに接続できません"
        }
    }
}


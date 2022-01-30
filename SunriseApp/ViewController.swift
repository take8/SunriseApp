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
            // print(json)
            let sys = json["sys"] as! [String:Any]
            let sunrise = sys["sunrise"] as! TimeInterval
            // print(sunrise)
            let formattedDate = self.formatDate(dateUnix: sunrise)
            self.sunriseTimeLabel.text = "日の出時刻: \(formattedDate)"
        } catch {
            print("error occurred...")
            self.sunriseTimeLabel.text = "サーバーに接続できません"
        }
    }

    // TODO: extensionにすべき?
    // TODO: Anyはよろしくないはず
    func formatDate(dateUnix: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: dateUnix)

        // NSDate型を日時文字列に変換するためのNSDateFormatterを生成
        let formatter = DateFormatter()
        // formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "Hms", options: 0, locale: Locale(identifier: "ja_JP"))

        // NSDateFormatterを使ってNSDate型 "date" を日時文字列 "dateStr" に変換
        let dateStr: String = formatter.string(from: date)
        return dateStr
    }
}


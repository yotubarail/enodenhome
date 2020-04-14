//
//  ViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2019/05/23.
//  Copyright © 2019 滝浪翔太. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell") as! stationTableViewCell
        
        cell.nameLabel.text = self.stationList[indexPath.row]
//        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    @IBOutlet weak var stationTableView: UITableView!
    
    
    let stationList = ["藤沢(EN01)", "石上(EN02)", "柳小路(EN03)", "鵠沼(EN04)", "湘南海岸公園(EN05)",
                       "江ノ島(EN06)", "腰越(EN07)", "鎌倉高校前(EN08)", "七里ヶ浜(EN09)", "稲村ヶ崎（EN10)",
                       "極楽寺（EN11)", "長谷（EN12)", "由比ヶ浜(EN13)", "和田塚(EN14)", "鎌倉(EN15)"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        stationTableView.delegate = self
        stationTableView.dataSource = self
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        bannerView.delegate = self
    }
    
    
    // セルタップ時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // タップ時の処理を記述
        // StoryboardでStoryboard IDを設定する
        
        switch indexPath.row {
            
        //藤沢をタップした時の処理
        case 0: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "fujisawaChoose") as! fujisawaViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //石上をタップした時の処理
        case 1: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "ishigamiChoose") as! ishigamiViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //柳小路をタップした時の処理
        case 2: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "yanagikoujiChoose") as! yanagikoujiViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        // 鵠沼をタップした時の処理
        case 3: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "kugenumaChoose") as! kugenumaViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //湘南海岸公園をタップした時の処理
        case 4: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "kouenChoose") as! kouenViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //江ノ島をタップした時の処理
        case 5: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "enoshimaChoose") as! enoshimaViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //腰越をタップした時の処理
        case 6: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "koshigoeChoose") as! koshigoeViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //鎌倉高校前をタップした時の処理
        case 7: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "koukouChoose") as! koukouViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //七里ヶ浜をタップした時の処理
        case 8: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "sitirigahamaChoose") as! sitirigahamaViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //稲村ヶ崎をタップした時の処理
        case 9: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "inamuragasakiChoose") as! inamuragasakiViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //極楽寺をタップした時の処理
        case 10: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "gokurakujiChoose") as! gokurakujiViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //長谷をタップした時の処理
        case 11: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "haseChoose") as! haseViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        //由比ヶ浜をタップした時の処理
        case 12: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "yuigahamaChoose") as! yuigahamaViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        // 和田塚をタップした時の処理
        case 13: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "wadazukaChoose") as! wadazukaViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            
        // 鎌倉をタップした時の処理
        case 14: tableView.deselectRow(at: indexPath, animated: true)
        let nextView = storyboard?.instantiateViewController(withIdentifier: "kamakuraChoose") as! kamakuraViewController
        self.navigationController?.pushViewController(nextView, animated: true)
            

            
            
        default: break
            
        }
        
        
    }
    
    @IBAction func config(_ sender: Any) {
        let touchConfig = storyboard?.instantiateViewController(withIdentifier: "configView") as! configViewController
        self.navigationController?.pushViewController(touchConfig, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
     bannerView.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(bannerView)
     view.addConstraints(
       [NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: bottomLayoutGuide,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0),
        NSLayoutConstraint(item: bannerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0)
       ])
    }
    
    
    
    
    


}


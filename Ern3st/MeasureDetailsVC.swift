//
//  MeasureDetailsVC.swift
//  Ern3st
//
//  Created by Muhammad Ali on 16/07/2023.
//

import UIKit

class MeasureDetailsVC: UIViewController {
    
    @IBOutlet weak var armTitleLabel: UILabel!
    
    @IBOutlet weak var armLabel: UILabel!
    
    @IBOutlet weak var chestTitleLabel: UILabel!
    
    @IBOutlet weak var chestLabel: UILabel!
    
    @IBOutlet weak var hipTitleLabel: UILabel!
    
    
    @IBOutlet weak var hipLabel: UILabel!
    
    @IBOutlet weak var collarTitleLabel: UILabel!
    
    @IBOutlet weak var collarLabel: UILabel!
    
    @IBOutlet weak var detailsMeasurementView: UIView!
    
    @IBOutlet weak var delButton: UIButton!
    
    var sdk: TG3DMobileScan!
    var scan: Scan!
    
    @IBOutlet weak var delBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.sdk == nil {
            self.sdk = TG3DMobileScan(apiKey: "jpbDi9zrB1zXXpWLnMCdUm2ay3EXxz0rfeIt")
            self.sdk!.currentRegion() { (rc, baseUrl) in
                if rc == 0 {
                    self.sdk!.setup(baseUrl: baseUrl)
                }
            }
            self.sdk.accessToken = StaticData.accessToken
            self.sdk.authToken = StaticData.authToken
        }
        configViews()
        
        
        // Do any additional setup after loading the view.
    }
    func configViews(){
        detailsMeasurementView.addShadowWithLowerCorner(radius: 16)
        detailsMeasurementView.addShadowWithUpperCorner(radius: 16)
        let font = UIFont(name: "PanamaMonospace-Regular", size: 20)!
        let font_btn = UIFont(name: "PanamaMonospace-Regular", size: 25)!
        delButton.underlineTextWithCustomFont(text: "DELETE", font: font_btn, underlineStyle: .single)
        
        // Call the function to underline the text with a custom font
        armTitleLabel.underlineWithCustomFont(text: "ARM LENGTH", font: font, underlineStyle: .single)
        chestTitleLabel.underlineWithCustomFont(text: "CHEST CIRCUMFERENCE", font: font, underlineStyle: .single)
        hipTitleLabel.underlineWithCustomFont(text: "HIPS", font: font, underlineStyle: .single)
        armTitleLabel.underlineWithCustomFont(text: "ARM LENGTH", font: font, underlineStyle: .single)
        collarTitleLabel.underlineWithCustomFont(text: "COLLAR", font: font, underlineStyle: .single)
        let tid = scan.scan_tid
        print("scan tid in Measure details \(tid)")
        self.sdk?.doGetAutoMeasurements(tid: tid){data,response in
            print("data and response in measurements")
            var chestCircum = "0 "
            var armLength = "0 "
            var collarCircum = "0 "
            var lowHipCircum = "0 "
            
            let dict = response!["measurement"] as! [String: Any]
            print(dict)
            if let dict2 = dict["Chest Circumference"] as? [String: Any]{
                let str = String(String(describing: dict2["value"]!))
                chestCircum = String(str.prefix(4))
            }
            
            if let dict3 = dict["Left Arm Length"] as? [String: Any]{
                let str = String(String(describing: dict3["value"]!))
                armLength = String(str.prefix(4))
            }
            
            
            
            if let dict4 = dict["Collar Circumference"] as? [String: Any]{
                let str = String(String(describing: dict4["value"]!))
                collarCircum = String(str.prefix(4))
            }
            
            
            if let dict5 = dict["Low Hip Circumference"] as? [String: Any]{
                let str = String(String(describing: dict5["value"]!))
                lowHipCircum = String(str.prefix(4))
                
            }
            DispatchQueue.main.async {
                self.chestLabel.underlineWithCustomFont(text: chestCircum + " CM", font: font, underlineStyle: .single)
                self.armLabel.underlineWithCustomFont(text: armLength + " CM", font: font, underlineStyle: .single)
                self.collarLabel.underlineWithCustomFont(text: collarCircum + " CM", font: font, underlineStyle: .single)
                self.hipLabel.underlineWithCustomFont(text: collarCircum + " CM", font: font, underlineStyle: .single)
                
            }
            
            
            
            
        }
    }
        
        @IBAction func dismissSelf(_ sender: Any) {
            self.dismiss(animated: true)
        }
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        @objc private func backButtonTapped() {
            // Perform any necessary actions before dismissing the view controller
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }


//
//  GetStartedViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 04/02/2023.
//

import UIKit
import AVKit
import DWAnimatedLabel
class GetStartedViewController: BaseViewController {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var promoLabel: DWAnimatedLabel!
    
    let smallVideoPlayerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoLabel.textColor = .white
        promoLabel.animationType = .shine
        
        
        
        promoLabel.font = UIFont(name:"GaramondLight-Italic",size:50)
        promoLabel.textAlignment = .center
        promoLabel.numberOfLines = 0
        promoLabel.text = "Timeless Pieces, Digitally Conceived, Artsinally Tailored"
        promoLabel.startAnimation(duration: 4, nil)
        // Do any additional setup after loading the view.
        // UIFont(name: "PanamaMonospace-Regular", size: 20)
        // Replace "CustomFontName" with the actual name of your custom font
       

        
        
       
        
    }
    
    
    @IBAction func showPermissionVC(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowPermissionScreen", sender: nil)
    }
    
}

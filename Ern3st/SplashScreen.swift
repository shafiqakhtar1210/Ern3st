//
//  SplashScreen.swift
//  Ern3st
//
//  Created by Muhammad Ali on 13/09/2022.
//

import UIKit

class SplashScreen: BaseViewController {
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        logo.alpha = 0.0
        if logo.alpha == 0.0 {
                UIImageView.animate(withDuration: 2.0, delay: 0.2, options: .curveEaseIn, animations: {
                    self.logo.alpha = 1.0
                    } )
                }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.performSegue(withIdentifier: "GoToStartScreen", sender: nil)
            // your code here
        }
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

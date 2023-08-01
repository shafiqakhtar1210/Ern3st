//
//  GetStartedViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 04/02/2023.
//

import UIKit
import AVKit
import DWAnimatedLabel
import SwiftUI
class GetStartedViewController: BaseViewController {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var promoLabel: DWAnimatedLabel!
    
    let smallVideoPlayerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoLabel.textColor = .white
        promoLabel.animationType = .shine
        
        
        
        promoLabel.font = UIFont(name:"GaramondLight-Italic",size:40)
        promoLabel.textAlignment = .center
        promoLabel.numberOfLines = 0
        promoLabel.text = "Timeless  pieces, \n Digitally  conceived -- \n Artsinally  Tailored '."
        promoLabel.startAnimation(duration: 4, nil)
        // Do any additional setup after loading the view.
        let font = UIFont(name: "PanamaMonospace-Regular", size: 20)!
        // Replace "CustomFontName" with the actual name of your custom font
        nextBtn.underlineTextWithCustomFont(text: "GET STARTED", font: font, underlineStyle: .single)
       

        
        
       
        
    }
    
    
    @IBAction func showPermissionVC(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowPermissionScreen", sender: nil)
    }
    
}
struct RepresentableGetsStartedView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GetStartedViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myViewController = storyboard.instantiateViewController(withIdentifier: "GetStartedVC") as! GetStartedViewController
        return myViewController

    }
    
    func updateUIViewController(_ uiViewController: GetStartedViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = GetStartedViewController
    
    

    

}
struct GetStartedViewPreview: PreviewProvider{
    static var previews: some View{
        RepresentableGetsStartedView()
    }
    
    
    
}

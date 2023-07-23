//
//  BaseViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 17/09/2022.
//

import UIKit
import BubbleTransition
import Tg3dMobileScanSDK_iOS

class BaseViewController: UIViewController, UITextFieldDelegate  {
    let transition = BubbleTransition()
  
    var appDelegate:AppDelegate!
    var activityIndicator: UIActivityIndicatorView!
    var blurEffect: UIBlurEffect!
    var blurEffectView: UIVisualEffectView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        

        // Do any additional setup after loading the view.
    }
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let controller = segue.destination
      controller.transitioningDelegate = self
      controller.modalPresentationCapturesStatusBarAppearance = true
      controller.modalPresentationStyle = .custom
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    func showSimpleAlert(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message,         preferredStyle: UIAlertController.Style.alert)

       
         alert.addAction(UIAlertAction(title: "OK",
                                       style: UIAlertAction.Style.default,
                                       handler: {(_: UIAlertAction!) in
                                         //Sign out action
         }))
         self.present(alert, animated: true, completion: nil)
     }
    
    @objc func backAction() -> Void {
        self.dismiss(animated: true)
    }
}
extension BaseViewController: UIViewControllerTransitioningDelegate{
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint(x: view.frame.maxX, y: view.frame.maxY)
         transition.bubbleColor = UIColor(rgb: 0xEDEAE4)
        return transition
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
            transition.transitionMode = .dismiss
            transition.startingPoint = CGPoint(x: view.frame.maxX, y: view.frame.maxY)
             transition.bubbleColor = UIColor(rgb: 0xEDEAE4)
            return transition
    }
    func addActivityIndicator(){
        blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)

    }
   
    func addBackButton(){
            let backButton = UIButton(type: .custom)
            let image = UIImage(named: "back")!
            
            backButton.setImage(image, for: .normal) // Replace "backIcon" with the name of your image
            backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)

            // Position the button as desired
            backButton.frame = CGRect(x: 16, y: 32, width: 30, height: 30)

            view.addSubview(backButton)       }
    @objc func goBack() {
        // Handle the action when the back button is tapped
        dismiss(animated: true, completion: nil)
    }

    
    func removeActivityIndicator(){
        blurEffectView.removeFromSuperview()
        activityIndicator.removeFromSuperview()

    }
    //UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Hide the keyboard when the user taps "Return"
           textField.resignFirstResponder()
           return true
       }
}


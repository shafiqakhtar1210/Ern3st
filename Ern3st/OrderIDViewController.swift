//
//  OrderIDViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 17/12/2022.
//

import UIKit

class OrderIDViewController: BaseViewController, ApiNetworkManagerDelegate {
    func orderFetched() {
        showMyAlert()
        
    }
    func idNotFound() {
        self.removeActivityIndicator()
        print("id not found")
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error",
                                                    message: "No Order Found with the given ID. Please recheck Order Id on our web",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)

            // back to main page
            
        }
    }
    
    let apiManager = ApiNetworkManager()

    @IBOutlet weak var ordeeIDTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        apiManager.delegate = self
        ordeeIDTF.delegate = self
      
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        self.addActivityIndicator()
        
        let orderID: String = ordeeIDTF.text ?? ""
        
        if orderID.count == 0 {
            ordeeIDTF.shake()
            let alertController = UIAlertController(title: "Username or email can not be null",
                                                    message: "Please input a valid email or password.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        GlobalUserData.orderId = orderID
        apiManager.fetchUserOrders(orderID: orderID)
       
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass data between storyboards
        
        if let destinationViewController = segue.destination as? ViewController {
           
            destinationViewController.currentSegue = segue.identifier!
        }
       
    }
    
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true)
    }
    func showMyAlert(){
        let alertController = UIAlertController(title: "Congratulations", message: "You have successfully completed the steps to complete", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { _ in
            self.performSegue(withIdentifier: "showProfilePage2", sender: nil)
            // Handle Button 1 action
        }
        
       
        
        alertController.addAction(action1)
      
        
        present(alertController, animated: true, completion: nil)
    }

}
protocol ApiNetworkManagerDelegate {
    func orderFetched()
    func idNotFound()
    
    
}

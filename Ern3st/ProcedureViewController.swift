//
//  ProcedureViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 18/06/2023.
//

import UIKit

class ProcedureViewController: BaseViewController {
    @IBOutlet weak var nextProcedureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let font_btn = UIFont(name: "PanamaMonospace-Regular", size: 25)!
        nextProcedureButton.underlineTextWithCustomFont(text: "NEXT", font: font_btn, underlineStyle: .single)
    }
    @IBAction func nextProcedureBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "showLoginPage", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  let vc = segue.destination as! ViewController
       // vc.currentSegue = segue.identifier!
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

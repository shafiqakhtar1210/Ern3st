//
//  ScansTableViewController.swift
//  Ern3st
//
//  Created by Muhammad Ali on 02/05/2023.


import UIKit

class ScansTableViewController: UITableViewController {

    let data = GlobalUserData.scans
    var showMeasures = false
    var selectedScan: Scan!
    var sdk: TG3DMobileScan!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sdk = TG3DMobileScan(apiKey: "jpbDi9zrB1zXXpWLnMCdUm2ay3EXxz0rfeIt")
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
           
           // Set the back button as the left bar button item
           navigationItem.leftBarButtonItem = backButton
        let nib = UINib(nibName: "ScanTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ScansTableViewCell")
        
        let backgroundImage = UIImage(named: "tvbg")
              let backgroundImageView = UIImageView(image: backgroundImage)
              
              // Set the content mode of the image view
              backgroundImageView.contentMode = .scaleAspectFill
              
              // Set the background view of the table view
              tableView.backgroundView = backgroundImageView    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedScan = data[indexPath.row]
       
        self.performSegue(withIdentifier: "showMeasureDetailsVC", sender: nil)
        
       
        print(selectedScan.scan_tid)
        
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMeasureDetailsVC" {
            print("just went here in segue")
            if let vc = segue.destination as? MeasureDetailsVC{
                print("just went further here in segue")
                vc.scan = selectedScan
             
                    
               
                // Access the view controller within the navigation controller
                           // viewController.currentSegue = "showMeasureDetailsVC"
                        }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScansTableViewCell", for: indexPath) as! ScansTableViewCell

        let item = data[indexPath.row]
        cell.configCell(scan: item)
        

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Move the cell off-screen and rotate it
        cell.transform = CGAffineTransform(translationX: 0, y: -tableView.frame.height)
        cell.transform = cell.transform.rotated(by: .pi / 2)

        // Animate the cell back to its original position
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.transform = .identity
        }, completion: nil)
    }
    @objc func backButtonTapped() {
        // Handle back button tap event
        print("this is called")
        self.dismiss(animated: true)
    }
    
    
}




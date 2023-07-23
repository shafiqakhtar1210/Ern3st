//
//  ScansTableViewCell.swift
//  Ern3st
//
//  Created by Muhammad Ali on 02/05/2023.
//

import UIKit

class ScansTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tidLabel: CustomLabel!
    @IBOutlet weak var dateLabel: CustomLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addShadow(radius: 16)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(scan: Scan){
        tidLabel.text = "tid: \(scan.scan_tid)"
        dateLabel.text = "Scan Date: \(scan.scan_date)"
        print("tid  \(scan.scan_tid)")
        
    }

}

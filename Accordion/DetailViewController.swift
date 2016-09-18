//
//  DetailViewController.swift
//  Accordion
//
//  Created by vitaro on 2016/09/18.
//  Copyright © 2016年 vitaro. All rights reserved.
//

import UIKit
// ADD:
class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Header
        guard let title = Singleton.shared.title,
              let detail = Singleton.shared.detail else { return }
        self.title = title + "-" + detail
        
        // label
        titleLabel.text = Singleton.shared.title
        detailLabel.text = Singleton.shared.detail
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Singleton.shared.clear()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

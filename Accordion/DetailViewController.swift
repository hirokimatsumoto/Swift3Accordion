//
//  DetailViewController.swift
//  Accordion
//
//  Created by vitaro on 2016/09/18.
//  Copyright © 2016年 vitaro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var titleLabelText = ""
    var detailLabelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
        detailLabel.text = detailLabelText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailViewController{
    
    /// Data with transition.
    ///
    /// - Parameters:
    ///   - title: hoge.
    ///   - detail: fuga.
    func send(title: String, detail: String) {
        // Header
        self.title = title + "-" + detail
        // title/detail
        titleLabelText = title
        detailLabelText = detail
    }
}

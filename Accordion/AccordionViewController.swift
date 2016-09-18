//
//  AccordionViewController.swift
//  Accordion Type TableView.
//
//  Created by bitaro on 2015/10/03.
//  Copyright © 2015年 bitaro. All rights reserved.
//

import UIKit

class AccordionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView :UITableView?
    
    /// section array.
    var sections: [(title: String, details: [String], extended: Bool)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ADD:
        title = "Accordion"
        
        // section value
        self.getSectionsValue()
        
        tableView = UITableView(frame: view.frame)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    /// MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowInSection = sections[section].extended ? sections[section].details.count + 1 : 1
        return rowInSection
    }
    
    /// MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let titleCellId = "TitleCell"
        let detailsCellId = "DetailsCell"
        let cellId = 0 == indexPath.row ? titleCellId : detailsCellId
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId)
        if nil == cell {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        }
        
        let section = sections[indexPath.section]
        cell?.textLabel?.text = 0 == indexPath.row ?
            section.title :                            // title
            "  \(section.details[indexPath.row - 1])"  // detail
        
        return cell!
    }
    
    /// MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if 0 == indexPath.row {
            // switching open or close
            sections[indexPath.section].extended = !sections[indexPath.section].extended
            
            if !sections[indexPath.section].extended {
                self.toContract(tableView, indexPath: indexPath)
            }else{
                self.toExpand(tableView, indexPath: indexPath)
            }
            
        }else{ // ADD:
            let section = sections[indexPath.section]
            let title = section.title
            let detail = section.details[indexPath.row - 1]
            print("tapped: \(title) - \(detail)")
            
            // transition
            Singleton.shared.title = title
            Singleton.shared.detail = detail
            
            let storyboard = UIStoryboard(name: "\(DetailViewController.self)", bundle: nil)
            let detailVC =
                storyboard.instantiateViewController(withIdentifier: "\(DetailViewController.self)")
            
            show(detailVC, sender: nil)
        }
        
        // deselect
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// close details.
    ///
    /// - Parameter tableView: self.tableView
    /// - Parameter indexPath: NSIndexPath
    fileprivate func toContract(_ tableView: UITableView, indexPath: IndexPath) {
        let startRow = indexPath.row + 1
        let endRow = sections[indexPath.section].details.count + 1
        
        var indexPaths: [IndexPath] = []
        for i in startRow ..< endRow {
            indexPaths.append(IndexPath(row: i , section:indexPath.section))
        }
        
        tableView.deleteRows(at: indexPaths,
            with: UITableViewRowAnimation.fade)
    }
    
    /// open details.
    ///
    /// - Parameter tableView: self.tableView
    /// - Parameter indexPath: NSIndexPath
    fileprivate func toExpand(_ tableView: UITableView, indexPath: IndexPath) {
        let startRow = indexPath.row + 1
        let endRow = sections[indexPath.section].details.count + 1
        
        var indexPaths: [IndexPath] = []
        for i in startRow ..< endRow {
            indexPaths.append(IndexPath(row: i, section:indexPath.section))
        }
        
        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        // scroll to the selected cell.
        tableView.scrollToRow(at: IndexPath(
            row:indexPath.row, section:indexPath.section),
            at: UITableViewScrollPosition.top, animated: true)
    }
    
    
    /// section values.
    fileprivate func getSectionsValue(){
        
        var details: [String]
        details = []
        details.append("details1")
        sections.append((title: "SECTION1", details: details, extended: false)) // close
        
        details = []
        details.append("details1")
        details.append("details2")
        sections.append((title: "SECTION2", details: details, extended: true)) // open
        
        details = []
        details.append("details1")
        details.append("details2")
        details.append("details3")
        sections.append((title: "SECTION3", details: details, extended: true)) // open
        
        details = []
        details.append("details1")
        details.append("details2")
        details.append("details3")
        details.append("details4")
        sections.append((title: "SECTION4", details: details, extended: false)) // close
        
        for i in 5...20 {
            details = []
            details.append("details1")
            details.append("details2")
            details.append("details3")
            details.append("details4")
            details.append("details5")
            sections.append((title: "SECTION\(i)", details: details, extended: false))
        }
    }
}


//
//  AccordionViewController.swift
//  Accordion Type TableView.
//
//  Created by bitaro on 2015/10/03.
//  Copyright © 2015年 bitaro. All rights reserved.
//

import UIKit

class AccordionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //受信者選択欄の各セルに入れるデータ
    let examineeData = ["ご本人","小山田　花","小山田　翔","小山田　圭子","別のご家族を追加"]
    
    var tableView :UITableView?
    
    /// section array.
    var sections: [(title: String, details: [String], extended: Bool)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // section value
        self.getSectionsValue()
        
        tableView = UITableView(frame: view.frame)
        tableView?.allowsMultipleSelection = false
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
        
        if 0 == indexPath.row {
            //ヘッダーに未選択のラジオボタンを入れる
            cell?.imageView?.image = UIImage(named: "btn_radio_off")
        }

        // セルが選択された時の背景色を消す
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell!
    }
    
    /// MARK: UITableViewDelegate
    // セルが選択された時に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ヘッダーセルが選択された場合の処理
        if 0 == indexPath.row {
            // switching open or close
            sections[indexPath.section].extended = !sections[indexPath.section].extended
            
            if !sections[indexPath.section].extended {
                self.toContract(tableView, indexPath: indexPath)
            }else{
                self.toExpand(tableView, indexPath: indexPath)
            }
            
            let cell = tableView.cellForRow(at:indexPath)
            // チェックマークを入れる
            cell?.imageView?.image = UIImage(named: "btn_radio_on")
            
        }else{
            // detailセル選択時の動きをかく
        }

    }
    
    // セルの選択が外れた時に呼び出される
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを外す
        cell?.imageView?.image = UIImage(named: "btn_radio_off")
        //ヘッダーセルの選択が外れた場合の処理
        if 0 == indexPath.row {
            // 開いているdetailセルを閉じる
            sections[indexPath.section].extended = !sections[indexPath.section].extended
            
            if !sections[indexPath.section].extended {
                self.toContract(tableView, indexPath: indexPath)
            }else{
                self.toExpand(tableView, indexPath: indexPath)
            }
            
        }else{
        }
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

        for i in 0...4 {
            
            //"別のご家族を追加"の場合
            if i == 4 {
                details = []
                details.append("お名前")
                details.append("ふりがな")
                details.append("生年月日")
                details.append("性別")
                sections.append((title: examineeData[i], details: details, extended: false))
                
            } else {
                //"別のご家族を追加"以外の場合
                details = []
                sections.append((title: examineeData[i], details: details, extended: false))
            }
        }
        
    }
}


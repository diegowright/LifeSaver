//
//  OptionTableViewController.swift
//  Mobile Computing Project App
//
//  Created by Zhenyu Zhang on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class OptionTableViewController: UITableViewController {
    
    fileprivate let sections = ["Options", "Themes", "Food Tracker"]
    fileprivate let options = [["about_ID"], ["selectTheme_ID", "createTheme_ID"], ["food_ID"]]
    fileprivate let white:UIColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Options"
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.options[section].count
    }
    
    /*
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
        
    }*/
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.options[indexPath.section][indexPath.row],
                                                 for: indexPath)
        cell.backgroundColor = white
        return cell
    }
}

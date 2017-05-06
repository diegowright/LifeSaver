//
//  SelectThemeTableVC.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 5/2/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class SelectThemeTableVC: UITableViewController {
    
    let themes:[Theme] = DataManager.shared.loadThemes()
    let white:UIColor = UIColor.white

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Theme"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell_ID", for: indexPath) as! ThemeCell
        
        cell.backgroundColor = white
        cell.themeButton.setTitle(self.themes[indexPath.row].name!, for: .normal)
        cell.tapAction = {
            (cell) in self.selectTheme(tableView.indexPath(for: cell)!.row)
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        return cell
    }
    
    func selectTheme(_ row: Int) {
        Appearance.setTheme(theme: self.themes[row])
    }
}

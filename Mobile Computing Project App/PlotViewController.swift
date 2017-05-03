//
//  PlotViewController.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 5/2/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//


import UIKit
import JBChart

class PlotViewController: UIViewController, JBBarChartViewDelegate, JBBarChartViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var barChart: JBBarChartView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIdx:Int = 0
    let white:UIColor = UIColor.white
    let black:UIColor = UIColor.black
    var plots:[Template] = DataManager.shared.loadAllTemplates()
    
    // Try to keep limit of 15 weeks back until function is implemented that can detect if bin size needs to be adjusted
    var chartLegend:[String] = []
    var chartData:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.darkGray
        //barChart.backgroundColor = UIColor.darkGray
        
        // Load data for initial plot
        self.assignPlotValues(0)
        
        // TableView setup
        tableView.delegate = self
        tableView.dataSource = self
        
        // bar chart setup
        barChart.backgroundColor = white
        barChart.delegate = self
        barChart.dataSource = self
        barChart.minimumValue = 0
        barChart.maximumValue = 100
        
        barChart.reloadData()
        barChart.setState(.collapsed, animated: false)
        
        // Load selected plot information
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Reanimate currently selected plot
        super.viewWillAppear(animated)
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: barChart.frame.width,
                                              height: 16))

        let footer1 = UILabel(frame: CGRect(x: 0, y: 0,
                                            width: barChart.frame.width/2 - 8,
                                            height: 16))
        footer1.textColor = black
        footer1.text = "\(chartLegend[0])"
        
        let footer2 = UILabel(frame: CGRect(x: barChart.frame.width/2 - 8, y: 0,
                                            width: barChart.frame.width/2 - 8,
                                            height: 16))
        footer2.textColor = black
        footer2.text = "\(chartLegend[chartLegend.count - 1])"
        footer2.textAlignment = NSTextAlignment.right
        
        footerView.addSubview(footer1)
        footerView.addSubview(footer2)
        
        let header = UILabel(frame: CGRect(x: 0, y: 0,
                                           width: barChart.frame.width,
                                           height: 50))
        header.textColor = black
        header.font = UIFont.systemFont(ofSize: 24)
        header.text = "Histogram of \(self.plots[self.selectedIdx].name!)"
        header.textAlignment = NSTextAlignment.center
        
        barChart.footerView = footerView
        barChart.headerView = header
        
        // Reload data for tableview
        self.plots = DataManager.shared.loadAllTemplates()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // our code
        barChart.reloadData()
        
        let timer = Timer.scheduledTimer(timeInterval: 0.5,
                                         target: self,
                                         selector:#selector(PlotViewController.showChart),
                                         userInfo: nil, repeats: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    
    func hideChart() {
        barChart.setState(.collapsed, animated: true)
    }
    
    func showChart() {
        barChart.setState(.expanded, animated: true)
    }
    
    // MARK: JBBarChartView
    
    func numberOfBars(in barChartView: JBBarChartView!) -> UInt {
        return UInt(chartData.count)
    }
    
    func barChartView(_ barChartView: JBBarChartView!, heightForBarViewAt index: UInt) -> CGFloat {
        return CGFloat(chartData[Int(index)])
    }
    
    func barChartView(_ barChartView: JBBarChartView!, colorForBarViewAt index: UInt) -> UIColor! {
        return (index % 2 == 0) ? UIColor.blue : UIColor.red
    }
    
    func barChartView(_ barChartView: JBBarChartView!, didSelectBarAt index: UInt) {
        let data = chartData[Int(index)]
        let key = chartLegend[Int(index)]
        
        //informationLabel.text = "Weather on \(key): \(data)"
        return
    }
    
    func didDeselect(_ barChartView: JBBarChartView!) {
        //informationLabel.text = ""
        return
    }
    
    //Mark: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plotCell_ID", for: indexPath) as! PlotCell
        cell.plotNameButton.setTitle(self.plots[indexPath.row].name!, for: .normal)
        cell.tapAction = {
            (cell) in
            self.assignPlotValues(indexPath.row)
            self.barChart.reloadData(animated: true)
            self.barChart.setState(.collapsed, animated: false)
        }
        return cell
    }
    
    // Assign plot data based on index row
    func assignPlotValues(_ idx: Int) {
        let newVals = EventSorting.sortByDate(template: self.plots[idx])
        
        // Format date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        dateFormatter.locale = NSLocale.autoupdatingCurrent
        
        // Create string array from date string returned
        var newDates:[String] = []
        for val in newVals.0 {
            newDates.append(dateFormatter.string(from: val))
        }
        
        self.chartLegend = newDates
        self.chartData = newVals.1
    }
}

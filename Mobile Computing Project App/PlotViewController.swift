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
    var plots:[String] = []
    
    var chartLegend = ["11-14", "11-15", "11-16", "11-17", "11-18", "11-19", "11-20"]
    var chartData = [70, 80, 76, 88, 90, 69, 74]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        
        // TableView setup
        tableView.delegate = self
        tableView.dataSource = self
        
        // bar chart setup
        barChart.backgroundColor = UIColor.darkGray
        barChart.delegate = self
        barChart.dataSource = self
        barChart.minimumValue = 0
        barChart.maximumValue = 100
        
        barChart.reloadData()
        barChart.setState(.collapsed, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: barChart.frame.width,
                                              height: 16))
        
        print("viewDidLoad: \(barChart.frame.width)")
        
        let footer1 = UILabel(frame: CGRect(x: 0, y: 0,
                                            width: barChart.frame.width/2 - 8,
                                            height: 16))
        footer1.textColor = UIColor.white
        footer1.text = "\(chartLegend[0])"
        
        let footer2 = UILabel(frame: CGRect(x: barChart.frame.width/2 - 8, y: 0,
                                            width: barChart.frame.width/2 - 8,
                                            height: 16))
        footer2.textColor = UIColor.white
        footer2.text = "\(chartLegend[chartLegend.count - 1])"
        footer2.textAlignment = NSTextAlignment.right
        
        footerView.addSubview(footer1)
        footerView.addSubview(footer2)
        
        let header = UILabel(frame: CGRect(x: 0, y: 0,
                                           width: barChart.frame.width,
                                           height: 50))
        header.textColor = UIColor.white
        header.font = UIFont.systemFont(ofSize: 24)
        header.text = "Weather: San Jose, CA"
        header.textAlignment = NSTextAlignment.center
        
        barChart.footerView = footerView
        barChart.headerView = header
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
        return (index % 2 == 0) ? UIColor.lightGray : UIColor.white
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
}

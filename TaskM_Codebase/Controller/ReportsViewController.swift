//
//  ReportsViewController.swift
//  TaskM_Codebase
//
//  Created by manasa on 8/26/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import UIKit
import Charts  

class ReportsViewController: UIViewController {

    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var chartView: PieChartView!
    
    var pendingData = PieChartDataEntry(value: 0)
    var inProgressData = PieChartDataEntry(value: 0)
    var completeData = PieChartDataEntry(value: 0)
    var chartEntry = [PieChartDataEntry]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.chartDescription?.text = ""
        
        pendingData.value = 10
        inProgressData.value = 20
        completeData.value = 15
        
        chartEntry = [pendingData, inProgressData, completeData]
        updateChartData()

    }
    
    func updateChartData(){
        let heading = ["In Progress", "Pending", "Complete"]
        
        let chartDataSet = PieChartDataSet(entries: chartEntry, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(named: "Progress"), UIColor(named: "Pending"), UIColor(named: "Complete")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        chartView.data = chartData
    }
}

//
//  MapMarkerView.swift
//  Cinerama Maps
//
//  Created by Asad on 04/12/2024.
//

import UIKit

class MapMarkerView: UIView {

    @IBOutlet weak var outerImg: UIImageView!
    
    @IBOutlet weak var innerImg: UIImageView!
    @IBOutlet weak var pinView: PieChartView!
    @IBOutlet weak var mapIcon: UIImageView!
    
    
    override func awakeFromNib() {
        outerImg.layer.shadowColor = UIColor.lightGray.cgColor
        outerImg.layer.shadowOpacity = 0.6
        outerImg.layer.shadowOffset = CGSize(width: 3, height: 3)
        outerImg.layer.shadowRadius = 5
        outerImg.layer.masksToBounds = false
    }
    
    
    
}

class PieChartView: UIView {
    var sliceColors: [UIColor] = [] // Example colors

    override func draw(_ rect: CGRect) {
        guard sliceColors.count > 0 else { return }
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let angleIncrement = 2 * CGFloat.pi / CGFloat(sliceColors.count)
        
        for i in 0..<sliceColors.count {
            let startAngle = CGFloat(i) * angleIncrement
            let endAngle = startAngle + angleIncrement
            
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.close()
            
            let sliceColor = sliceColors[i % sliceColors.count]
            sliceColor.setFill()
            path.fill()
        }
    }
}

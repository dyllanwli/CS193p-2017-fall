//
//  objectView.swift
//  Set
//
//  Created by jamfly on 2018/1/12.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import UIKit

class ObjectView: UIView {

    private var shape: Card.Shape?
    private var color: Card.Color?
    private var fill: Card.Fill?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, shape: Card.Shape, color: Card.Color, fill: Card.Fill) {
        self.init(frame: frame)
        self.shape = shape
        self.color = color
        self.fill = fill
    }
    
    private var path: UIBezierPath {
        if let shape = shape {
            switch shape {
            case .circle:
                return UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                    radius: bounds.height / 2,
                                    startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            case .square:
                return UIBezierPath(rect: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height))
            case .triangle:
                let path = UIBezierPath()
                path.move(to: CGPoint(x: bounds.width / 2, y: bounds.origin.y))
                path.addLine(to: CGPoint(x: bounds.origin.x, y: bounds.height))
                path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
                path.close()
                return path
            }
        }
        return UIBezierPath()
    }
    
    override func draw(_ rect: CGRect) {
        let shape = path
        var objectColor: UIColor
        if let color = color {
            switch color {
            case .green:
                objectColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                objectColor.setStroke()
            case .purple:
                objectColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                objectColor.setStroke()
            case .red:
                objectColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                objectColor.setStroke()
            }
        }
        
        if let fill = fill {
            switch fill {
            case .empty:
                shape.stroke()
            case .solid:
                shape.fill()
            case .stripe:
                var x = bounds.width / 10
                for _ in 0..<10 {
                    let path = UIBezierPath()
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: x))
                    path.stroke()
                    x *= 2
                }
            }
        }
    }
    

}

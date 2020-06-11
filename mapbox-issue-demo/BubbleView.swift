//
//  BubbleView.swift
//  mapbox-issue-demo
//
//  Created by Rustam G on 11.06.2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class BubbleView: UIView {

    private static let cornerRadius: CGFloat = 10
    static let triangleHeight: CGFloat = 14

    var color: UIColor = .green {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {

        let path = UIBezierPath()

        // start at lower left corner
        path.move(to: CGPoint(x: 0, y: bounds.height))
        // go to top left corner
        path.addLine(to: CGPoint(x: 0, y: BubbleView.cornerRadius))
        // draw top left rounded corner
        path.addArc(withCenter: CGPoint(x: BubbleView.cornerRadius, y: BubbleView.cornerRadius),
                    radius: BubbleView.cornerRadius,
                    startAngle: CGFloat(Double.pi / 2),
                    endAngle: -CGFloat(Double.pi / 2),
                    clockwise: true)
        // go to top right corner
        path.addLine(to: CGPoint(x: bounds.width - BubbleView.cornerRadius, y: 0))
        // draw top right rounded corner
        path.addArc(withCenter: CGPoint(x: bounds.width - BubbleView.cornerRadius, y: BubbleView.cornerRadius),
                    radius: BubbleView.cornerRadius,
                    startAngle: -CGFloat(Double.pi / 2),
                    endAngle: 0,
                    clockwise: true)
        // go to bottom right corner
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height - BubbleView.triangleHeight))
        // draw bottom right rounded corner
        path.addArc(withCenter: CGPoint(x: bounds.width - BubbleView.cornerRadius,
                                        y: bounds.height - BubbleView.cornerRadius - BubbleView.triangleHeight),
                    radius: BubbleView.cornerRadius,
                    startAngle: 0,
                    endAngle: CGFloat(Double.pi / 2),
                    clockwise: true)
        // go to bottom left corner
        path.addLine(to: CGPoint(x: BubbleView.triangleHeight / 2, y: bounds.height - BubbleView.triangleHeight))

        path.close()

        color.setFill()
        path.fill()
    }
}


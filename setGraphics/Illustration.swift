//
//  Illustration.swift
//  setGraphics
//
//  Created by Maulik Sharma on 04/10/18.
//  Copyright © 2018 Geekskool. All rights reserved.
//

import UIKit

class Illustration: UIView {
    
    var shapeID: Int = 1
    var colorID: Int = 1
    var shadeID: Int = 1
    
    func getPath(shapeID: Int) -> UIBezierPath {
        var path = UIBezierPath()
        switch shapeID {
        case 1:
            path.move(to: CGPoint(x: bounds.midX, y: bounds.minY))
            path.addLine(to: CGPoint(x: bounds.minX, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
            path.close()
        case 2:
            path = UIBezierPath(roundedRect: bounds, cornerRadius: ovalCornerRadius)
        case 3:
            path.move(to: <#T##CGPoint#>)
        default:
            break
        }
        return path
    }
    
    var color: UIColor {
        switch colorID {
        case 1:
            return .red
        case 2:
            return .green
        case 3:
            return .purple
        default:
            return .black
        }
    }
    
    override func draw(_ rect: CGRect) {
        let path = getPath(shapeID: shapeID)
        path.addClip()
        color.setFill()
        color.setStroke()
        switch shadeID {
        case 1:
            path.fill()
        case 2:
            path.lineWidth = pathLineWidth
            path.stroke()
        case 3:
            path.lineWidth = pathLineWidth
            path.stroke()
            var stripeOffset = bounds.minX
            while stripeOffset < bounds.maxX {
                let stripePath = UIBezierPath(rect: CGRect(x: stripeOffset, y: bounds.minY, width: stripeWidth, height: bounds.size.height))
                stripePath.fill()
                stripeOffset += (stripeWidth + stripeSpacing)
            }
        default:
            break
        }
    }
}

extension Illustration {
    struct SizeRatio {
        static let pathLineWidthToBoundsHeight: CGFloat = 0.15
        static let ovalCornerRadiusToBoundsHeight: CGFloat = 0.5
    }
    
    var pathLineWidth: CGFloat {
        return bounds.size.height * SizeRatio.pathLineWidthToBoundsHeight
    }
    
    var ovalCornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.ovalCornerRadiusToBoundsHeight
    }
    
    var stripeSpacing: CGFloat {
        return pathLineWidth / 2
    }
    
    var stripeWidth: CGFloat {
        return pathLineWidth / 5
    }
}


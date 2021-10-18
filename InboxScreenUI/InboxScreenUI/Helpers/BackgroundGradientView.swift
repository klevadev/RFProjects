//
//  BackgroundGradient.swift
//  InboxScreenUI
//
//  Created by KOLESNIKOV Lev on 04/12/2019.
//  Copyright © 2019 SwiftOverflow. All rights reserved.
//

import UIKit

@IBDesignable

class BackgroundGradientView: UIView {
    @IBInspectable var startColor: UIColor? {
        didSet {
            setupGradientsColor()
        }
    }
    
    @IBInspectable var endColor: UIColor? {
        didSet {
            setupGradientsColor()
        }
    }
    
    private let gradienLayer = CAGradientLayer()
    
    // Инициализатор при работе с View кодом
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    // Инициализатор при работе с View из Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        растягиваем по всем границами
        gradienLayer.frame = bounds
    }
    
    private func setupViews() {
        setupGradient()
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradienLayer)
        setupGradientsColor()
        gradienLayer.startPoint = CGPoint(x: 0, y: 0)
        gradienLayer.endPoint = CGPoint(x: 0, y: 0.7)
    }
    
    private func setupGradientsColor() {
        if let startColor = startColor, let endColor = endColor {
            gradienLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
}

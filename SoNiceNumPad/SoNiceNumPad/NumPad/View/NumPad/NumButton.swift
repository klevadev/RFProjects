//
//  Num.swift
//  SoNiceNumPad
//
//  Created by KOLESNIKOV Lev on 02/12/2019.
//  Copyright © 2019 SwiftOverflow. All rights reserved.
//

import UIKit

@IBDesignable
class NumButton: UIControl {
    
    let numSize: CGFloat = DeviceType.iPhoneSE ? NumPadConstants.SE.NumViewConstants.numViewSize  : NumViewConstants.numViewSize
    
    @IBInspectable var numberText: String? {
        didSet {
            self.numberLabel.text = numberText
        }
    }
    
    @IBInspectable var letterText: String? {
        didSet {
            self.letterLabel.text = letterText
        }
    }
    
    private var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.numberFontSize, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var letterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.letterFontSize, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: self.isHighlighted ? 0 : 0.35, delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.alpha = self.isHighlighted ? 0.25 : 1
            })
        }
    }
    
    private func setup() {
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        
        self.layer.borderWidth = 1.5
        self.layer.borderColor = #colorLiteral(red: 0.2784313725, green: 0.3019607843, blue: 0.3215686275, alpha: 1)
        self.clipsToBounds = true
        
        self.addSubview(numberLabel)
        self.addSubview(letterLabel)
    }
    
    private func updateLayout() {
        self.layer.cornerRadius = layer.frame.width / 2
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        self.heightAnchor.constraint(equalToConstant: numSize),
        self.widthAnchor.constraint(equalToConstant: numSize)])
    
        if letterText != nil {
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: DeviceType.iPhoneSE ? NumPadConstants.NumberLabel.topSEConstraintValue : NumPadConstants.NumberLabel.topConstraintValue).isActive = true
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            
            letterLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor).isActive = true
            letterLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        } else {
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
    }
}

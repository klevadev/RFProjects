//
//  PinView.swift
//  SoNiceNumPad
//
//  Created by KOLESNIKOV Lev on 03/12/2019.
//  Copyright © 2019 SwiftOverflow. All rights reserved.
//

import UIKit

@IBDesignable
class PinView: UIView {
    private var pinStackView: UIStackView = UIStackView()
    private var maxLength: Int = 4
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          setupViews()
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          setupViews()
      }
      
      private func setupViews() {
        
           pinStackView.axis = .horizontal
           pinStackView.distribution = .equalSpacing
           pinStackView.spacing = NumPadConstants.PinStackView.spacing
           pinStackView.translatesAutoresizingMaskIntoConstraints = false
        
           self.addSubview(pinStackView)
          
            for _ in 1...maxLength {
                pinStackView.addArrangedSubview(PinIndicator())
            }
        
           NSLayoutConstraint.activate([
               pinStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
               pinStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
           ])
      }
}

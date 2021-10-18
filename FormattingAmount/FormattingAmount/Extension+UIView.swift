//
//  Extension+UIView.swift
//  FormattingAmount
//
//  Created by Lev Kolesnikov on 22.01.2020.
//  Copyright © 2020 SwiftOverflow. All rights reserved.
//

import UIKit

extension UIView {
        /// Устанавливает UIElement на соответствующую позицию на экране.
        ///
        /// Параметры `top`, `left`, `bottom`, `right` могут быть nil.
        /// Так как возможно мы не хотим привязываться к какой либо границе View.
        /// - Parameters:
        ///     - top: Верхняя граница view к которой идет привязка элемента
        ///     - left: Левая граница view к которой идет привязка элемента
        ///     - bottom: Нижняя граница view к которой идет привязка элемента
        ///     - right: Правая граница view к которой идет привязка элемента
        ///     - paddingTop: Отступ от верхней границы view к которой привязывается элемент
        ///     - paddingLeft: Отступ от левой границы view к которой привязывается элемент
        ///     - paddingBottom: Отступ от нижней границы view к которой привязывается элемент
        ///     - paddingRight: Отступ от правой границы view к которой привязывается элемент
        ///     - width: Ширина элемента
        ///     - height: Высота элемента
        func setPosition(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
            
            //Позволит устанавливать элементы на любую позицию на которую мы захотим
            //Если вы хотите использовать автоматическую компоновку для ДИНАМИЧЕСКОГО расчета размера и позиции вашего представления, вы должны установить для этого свойства значение false, а затем предоставить не двусмысленный, не конфликтующий набор ограничений для представления.
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }
            
            if let left = left {
                self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }
            
            if let bottom = bottom {
                self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
            
            if let right = right {
                self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
            
            if width != 0 {
                self.widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if height != 0 {
                self.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
        ///Растягивает текущий элемент по границам передаваемого `view`
        ///
        /// - Parameters:
        ///     - view: UIView в котром мы хотим разместить текущий элемент
        func fillToSuperView(view: UIView) {
            self.setPosition(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
    }

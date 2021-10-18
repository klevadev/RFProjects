//
//  ThemeManager.swift
//  InboxScreenUI
//
//  Created by Lev Kolesnikov on 03.12.2019.
//  Copyright © 2019 SwiftOverflow. All rights reserved.
//

import UIKit

struct ThemeManager {
    
    struct Color {
        static let titleColor: UIColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
        static let subtitleColor: UIColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        static let backgroundColor: UIColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9607843137, alpha: 1)
        static let separatorColor: UIColor = #colorLiteral(red: 0.5217075944, green: 0.5256528854, blue: 0.5293963552, alpha: 1)
        
        static let startGradientColor: UIColor = #colorLiteral(red: 0.2745098039, green: 0.2862745098, blue: 0.2980392157, alpha: 1)
        static let endGradientColor: UIColor = #colorLiteral(red: 0.1215686275, green: 0.137254902, blue: 0.1490196078, alpha: 1)
    }
    
    struct Corner {
        static let cardViewCornerRadius: CGFloat = 10.0
        static let containerViewCornerRadius: CGFloat = 8.0
    }
    
    struct Font {
        
        struct Size {
            
            static let navigationTitleFontSize: CGFloat = 17.0
            
            static let inboxHeaderFontSize: CGFloat = 12.0
            static let inboxTimeFontSize: CGFloat = 12.0
            static let inboxTitleFontSize: CGFloat = 16.0
            static let inboxSubtitleFontSize: CGFloat = 14.0

        }
    }
}


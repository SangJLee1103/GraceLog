//
//  UILabel+Extension.swift
//  GraceLog
//
//  Created by 이상준 on 4/9/25.
//

import UIKit

extension UILabel {
    // 라벨 텍스트 색상 적용
    func setTextWithColoredPart(fullText: String, coloredPart: String, color: UIColor, defaultColor: UIColor = .gray200) {
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if let range = fullText.range(of: coloredPart) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: color, range: nsRange)
            
            let fullRange = NSRange(location: 0, length: fullText.count)
            attributedString.addAttribute(.foregroundColor, value: defaultColor, range: fullRange)
            
            attributedString.addAttribute(.foregroundColor, value: color, range: nsRange)
        }
        
        self.attributedText = attributedString
    }
}

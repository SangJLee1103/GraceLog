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
    
    func setLineHeight(multiple: CGFloat) {
        guard let text = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = multiple
        paragraphStyle.alignment = self.textAlignment
        
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: self.textColor ?? .black,
            .font: self.font ?? UIFont.systemFont(ofSize: 16)
        ])
        
        self.attributedText = attributedString
    }
}

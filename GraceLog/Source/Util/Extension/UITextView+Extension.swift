//
//  UITextView+Extension.swift
//  GraceLog
//
//  Created by 이상준 on 6/10/25.
//

import UIKit

extension UITextView {
    func setLineHeight(multiple: CGFloat) {
        guard let text = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = multiple
        
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: self.textColor ?? .black,
            .font: self.font ?? UIFont.systemFont(ofSize: 16)
        ])
        
        self.attributedText = attributedString
    }
}

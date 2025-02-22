//
//  String+Extension.swift
//  GraceLog
//
//  Created by 이상준 on 2/22/25.
//

import UIKit

extension String {
    func toDiaryDateAttributedString(
        regularFont: String = "Pretendard-Regular",
        boldFont: String = "Pretendard-Bold",
        regularSize: CGFloat = 12,
        boldSize: CGFloat = 15,
        color: UIColor = .themeColor
    ) -> NSAttributedString {
        let components = self.components(separatedBy: "\n")
        guard components.count == 2 else { return NSAttributedString(string: self) }
        
        let attributedString = NSMutableAttributedString()
        
        let part1 = NSAttributedString(
            string: components[0] + "\n",
            attributes: [
                .font: UIFont(name: regularFont, size: regularSize) ?? .systemFont(ofSize: regularSize),
                .foregroundColor: color
            ]
        )
        
        let part2 = NSAttributedString(
            string: components[1],
            attributes: [
                .font: UIFont(name: boldFont, size: boldSize) ?? .systemFont(ofSize: boldSize, weight: .bold),
                .foregroundColor: color
            ]
        )
        
        attributedString.append(part1)
        attributedString.append(part2)
        
        return attributedString
    }
}

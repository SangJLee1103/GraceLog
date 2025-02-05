//
//  UIView+Extension.swift
//  GraceLog
//
//  Created by 이상준 on 12/28/24.
//

import UIKit
import SnapKit

extension UIView {
    func setHeight(_ height: CGFloat) {
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
    
    func setWidth(_ width: CGFloat) {
        self.snp.makeConstraints {
            $0.width.equalTo(width)
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        self.snp.makeConstraints {
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
    }
}

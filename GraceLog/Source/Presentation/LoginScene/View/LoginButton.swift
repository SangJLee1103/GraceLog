//
//  LoginButton.swift
//  GraceLog
//
//  Created by 이상준 on 12/28/24.
//

import UIKit

enum LoginType {
    case google, apple
}

final class LoginButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHeight(50)

        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.background.cornerRadius = 25
        config.background.strokeWidth = 1
        config.background.strokeColor = .black
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-Bold", size: 15)
            return outgoing
        }
        configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = imageView {
            imageView.frame.origin.x = 17
        }
    }
    
    func setStyle(type: LoginType, title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        
        switch type {
        case .google:
            setImage(UIImage(named: "google"), for: .normal)
        case .apple:
            setImage(UIImage(named: "apple"), for: .normal)
        }
    }
}

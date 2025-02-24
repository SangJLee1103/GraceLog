//
//  CommunityButton.swift
//  GraceLog
//
//  Created by 이상준 on 2/22/25.
//

import UIKit
import Then
import SnapKit

final class CommunityButton: UIView {
    private let imageContainer = UIView().then {
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = .graceGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let stackView = UIStackView(arrangedSubviews: [imageContainer, imageView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        
        addSubview(stackView)
        
        imageContainer.addSubview(imageView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageContainer.snp.makeConstraints {
            $0.size.equalTo(75)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(image: UIImage?, title: String, backgroundColor: UIColor = .clear) {
        imageView.image = image
        titleLabel.text = title
        imageContainer.backgroundColor = backgroundColor
    }
}

//
//  DiaryAddImageCollectionViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 3/28/25.
//

import UIKit
import SnapKit
import Then

final class DiaryAddImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "DiaryAddImageCollectionViewCell"
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray200.cgColor
    }
    
    private let cameraImageView = UIImageView().then {
        $0.image = UIImage(named: "camera")
        $0.contentMode = .scaleAspectFit
    }
    
    private let countLabel = UILabel().then {
        $0.text = "0/10"
        $0.textColor = .gray200
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(cameraImageView)
        cameraImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        containerView.addSubview(countLabel)
        countLabel.snp.makeConstraints {
            $0.top.equalTo(cameraImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(9)
        }
    }
    
    func updateCount(current: Int, max: Int) {
        countLabel.text = "\(current)/\(max)"
    }
}

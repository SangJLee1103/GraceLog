//
//  DiaryImageCollectionViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 3/28/25.
//

import UIKit
import SnapKit
import Then

final class DiaryImageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "DiaryImageCollectionViewCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "diary_x"), for: .normal)
        $0.tintColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-12)
            $0.trailing.equalToSuperview().offset(12)
        }
    }
    
    func updateUI(with image: UIImage) {
        imageView.image = image
    }
}

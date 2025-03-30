//
//  DiaryImageTableViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 3/28/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class DiaryImageTableViewCell: UITableViewCell {
    static let identifier = "DiaryImageTableViewCell"
    
    private lazy var collectionView = UICollectionView().then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 70, height: 70)
        
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(DiaryAddImageCollectionViewCell.self, forCellWithReuseIdentifier: DiaryAddImageCollectionViewCell.identifier)
        $0.register(DiaryImageTableViewCell.self, forCellWithReuseIdentifier: DiaryImageTableViewCell.identifier)
    }
    
    private var images: [UIImage] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(110)
        }
    }
    
}

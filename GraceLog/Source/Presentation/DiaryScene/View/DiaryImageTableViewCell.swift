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
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 70, height: 70)
        return layout
    }()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(DiaryAddImageCollectionViewCell.self, forCellWithReuseIdentifier: DiaryAddImageCollectionViewCell.identifier)
        $0.register(DiaryImageCollectionViewCell.self, forCellWithReuseIdentifier: DiaryImageCollectionViewCell.reuseIdentifier)
        $0.delegate = self
        $0.dataSource = self
    }
    
    private var images: [UIImage] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        images = []
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        selectionStyle = .none
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(110)
        }
    }
}

extension DiaryImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryAddImageCollectionViewCell.identifier, for: indexPath) as? DiaryAddImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateCount(current: images.count, max: 10)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryImageCollectionViewCell.reuseIdentifier, for: indexPath) as? DiaryImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let imageIndex = indexPath.item - 1
            if imageIndex < images.count {
                cell.updateUI(with: images[imageIndex])
            }
            return cell
        }
    }
    
}

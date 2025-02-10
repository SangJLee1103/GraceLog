//
//  HomeDiaryCell.swift
//  GraceLog
//
//  Created by 이상준 on 2/8/25.
//

import UIKit
import Then
import SnapKit

struct DiaryItem {
    let date: String
    let title: String
    let subtitle: String
    let tags: [String]
    let image: UIImage?
}

final class HomeDiaryTableViewCell: UITableViewCell {
    static let identifier = "HomeDiaryTableViewCell"
    
    let items = [
        DiaryItem(
            date: "오늘\n2/14",
            title: "스터디 카페에 새로운 손님이?",
            subtitle: "나는 느꼈다,\n하나님께서 하심을",
            tags: ["#순종", "#도전", "#새해"],
            image: UIImage(named: "diary1")
        )
    ]
    
    private let imgView = UIImageView().then {
        $0.image = UIImage(named: "compass")
        $0.setDimensions(width: 20, height: 20)
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.textColor = .themeColor
        $0.text = "승렬님, 오늘도 하나님과 동행하세요"
    }
    
    private let diaryStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
        $0.distribution = .fill
    }
    
    private let timelineView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configure(with: items)
    }
    
    private func configureUI() {
        backgroundColor = UIColor(hex: 0xF4F4F4)
        
        let compassStack = UIStackView(arrangedSubviews: [imgView, titleLabel])
        compassStack.axis = .horizontal
        compassStack.spacing = 4
        
        contentView.addSubview(compassStack)
        compassStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.leading.trailing.equalToSuperview().inset(74)
        }
        
        contentView.addSubview(diaryStackView)
        diaryStackView.snp.makeConstraints {
            $0.top.equalTo(compassStack.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(timelineView)
        timelineView.snp.makeConstraints {
            $0.width.equalTo(2)
            $0.top.equalTo(diaryStackView)
            $0.bottom.equalTo(diaryStackView)
            $0.leading.equalToSuperview().offset(40)
        }
    }
    
    func configure(with items: [DiaryItem]) {
        // 기존 뷰 제거
        diaryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 데이터 개수에 따라 다이어리 아이템 추가
        items.enumerated().forEach { index, item in
            let itemView = createDiaryItemView(item: item, isFirst: index == 0)
            diaryStackView.addArrangedSubview(itemView)
        }
        
        // 타임라인 뷰 표시 여부
        timelineView.isHidden = items.count <= 1
    }
    
    
    private func createDiaryItemView(item: DiaryItem, isFirst: Bool) -> UIView {
        let containerView = UIView()
        
        // 날짜 레이블
        let dateLabel = UILabel().then {
            $0.text = item.date
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .gray
        }
        
        // 컨텐츠 뷰
        let contentView = UIView().then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
        }
        
        // 타이틀
        let titleLabel = UILabel().then {
            $0.text = item.title
            $0.font = .boldSystemFont(ofSize: isFirst ? 20 : 16)
            $0.numberOfLines = 0
        }
        
        // 서브타이틀
        let subtitleLabel = UILabel().then {
            $0.text = item.subtitle
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .gray
            $0.numberOfLines = 0
        }
        
        // 태그 스택
        let tagStack = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 8
        }
        
        item.tags.forEach { tag in
            let tagLabel = UILabel().then {
                $0.text = tag
                $0.font = .systemFont(ofSize: 12)
                $0.textColor = .blue
            }
            tagStack.addArrangedSubview(tagLabel)
        }
        
        // 이미지뷰
        if let image = item.image {
            let imageView = UIImageView(image: image).then {
                $0.contentMode = .scaleAspectFill
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 12
            }
            
            contentView.addSubview(imageView)
            imageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.height.equalTo(isFirst ? 200 : 150)
            }
        }
        
        // 레이아웃 설정
        containerView.addSubview(dateLabel)
        containerView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(tagStack)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(74)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        tagStack.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        return containerView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

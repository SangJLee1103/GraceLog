//
//  ProfileEditTableViewCell.swift
//  GraceLog
//
//  Created by 이상준 on 4/15/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class ProfileEditTableViewCell: UITableViewCell {
    static let identifier = "ProfileEditTableViewCell"
    
    var disposeBag = DisposeBag()
    var itemType: ProfileEditItemType = .nicknameEdit
    var onTextChanged: ((String, ProfileEditItemType) -> Void)?
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .gray200
    }
    
    private let infoField = UITextField().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        $0.textColor = .black
    }
    
    private let dividerView = UIView().then {
        $0.setHeight(1)
        $0.backgroundColor = .gray200
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        selectionStyle = .none
        
        [titleLabel, infoField, dividerView].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(23)
            $0.top.equalToSuperview().offset(26)
            $0.width.equalTo(50)
        }
        
        infoField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(40)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func configure(title: String, placeholder: String, info: String, itemType: ProfileEditItemType, onTextChanged: @escaping (String, ProfileEditItemType) -> Void) {
        self.itemType = itemType
        
        titleLabel.text = title
        infoField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: UIColor.gray200,
            .font: UIFont(name: "Pretendard-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
        ])
        infoField.text = info
        
        bind()
    }
    
    private func bind() {
        infoField.rx.controlEvent(.editingDidEnd)
            .withLatestFrom(infoField.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                print("🔥 TextField changed: \(text), type: \(self.itemType)") 
                self.onTextChanged?(text, self.itemType)
            })
            .disposed(by: disposeBag)
    }
}

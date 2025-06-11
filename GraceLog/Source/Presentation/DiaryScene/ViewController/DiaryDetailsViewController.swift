//
//  DiaryDetailsViewController.swift
//  GraceLog
//
//  Created by 이상준 on 6/7/25.
//

import UIKit
import FSCalendar
import RxSwift

final class DiaryDetailsViewController: GraceLogBaseViewController {
    weak var coordinator: DiaryDetailsCoordinator?
    var disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private lazy var calendarButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "diary_chevron")
        config.title = "25년 6월"
        config.baseForegroundColor = .white
        config.imagePlacement = .trailing
        config.imagePadding = 7
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-Bold", size: 24)
            return outgoing
        }
        $0.configuration = config
        $0.tintColor = .white
    }
    
    private let calendarView = FSCalendar().then {
        $0.tintColor = .white
        $0.scrollDirection = .horizontal
        $0.scope = .week
        $0.locale = Locale(identifier: "ko_KR")
        
        $0.headerHeight = 0
        
        $0.appearance.weekdayFont = UIFont(name: "Pretendard-Regular", size: 11)
        $0.appearance.weekdayTextColor = UIColor.white
        
        $0.appearance.titleFont = UIFont(name: "Pretendard-Regular", size: 20)
        $0.appearance.titleDefaultColor = UIColor.white
        
        $0.appearance.titleTodayColor = UIColor.white
    }
    
    private let diaryDetailsView = DiaryDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCalendarView()
        bind()
    }
    
    private func configureUI() {
        title = "나의 감사일기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(actionClose))
        
        view.backgroundColor = UIColor(hex: 0x161515)
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(safeArea.snp.height)
        }
        
        contentView.addSubview(calendarButton)
        calendarButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.leading.equalToSuperview().offset(21)
            $0.height.equalTo(27)
        }
        
        contentView.addSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.top.equalTo(calendarButton.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(300)
        }
        
        contentView.addSubview(diaryDetailsView)
        diaryDetailsView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.greaterThanOrEqualTo(568)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
    
    private func configureCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    private func bind() {
        calendarButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.calendarView.scope = self?.calendarView.scope == .month ? .week : .month
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func actionClose() {
        coordinator?.finish()
    }
}

extension DiaryDetailsViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarView.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
}

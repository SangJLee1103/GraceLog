//
//  DiaryDetailsViewController.swift
//  GraceLog
//
//  Created by 이상준 on 6/7/25.
//

import UIKit
import FSCalendar

final class DiaryDetailsViewController: GraceLogBaseViewController {
    weak var coordinator: DiaryDetailsCoordinator?
    
    private let calendarView = FSCalendar().then {
        $0.tintColor = .white
        $0.scrollDirection = .horizontal
        $0.scope = .week
        $0.locale = Locale(identifier: "ko_KR")
        $0.headerHeight = 27
        
        $0.appearance.headerTitleAlignment = .left
        $0.appearance.headerTitleColor = UIColor.white
        $0.appearance.headerDateFormat = "YY년 MM월"
        $0.appearance.headerTitleFont = UIFont(name: "Pretendard-Bold", size: 24)
        
        $0.appearance.weekdayFont = UIFont(name: "Pretendard-Regular", size: 11)
        $0.appearance.weekdayTextColor = UIColor.white
        
        $0.appearance.titleFont = UIFont(name: "Pretendard-Regular", size: 20)
        $0.appearance.titleDefaultColor = UIColor.white
        $0.appearance.titleTodayColor = UIColor.white
        
        $0.appearance.todayColor = UIColor.clear
        $0.appearance.titleTodayColor = UIColor.white
    }
    
    private let diaryDetailsView = DiaryDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCalendarView()
    }
    
    private func configureUI() {
        title = "나의 감사일기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(actionClose))
        
        view.backgroundColor = UIColor(hex: 0x161515)
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(19)
            $0.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(130)
        }
        
        view.addSubview(diaryDetailsView)
        diaryDetailsView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeArea).inset(18)
        }
    }
    
    @objc private func actionClose() {
        coordinator?.dismiss()
    }
    
    private func configureCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
    }
}

extension DiaryDetailsViewController: FSCalendarDelegate, FSCalendarDataSource {
  
}

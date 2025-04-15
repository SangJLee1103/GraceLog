//
//  DiaryUseCase.swift
//  GraceLog
//
//  Created by 이상준 on 3/30/25.
//

import Foundation
import RxSwift

protocol DiaryUseCase {
    var communityData: BehaviorSubject<CommunityDTO?> { get }
}

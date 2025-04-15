//
//  DiaryDataSource.swift
//  GraceLog
//
//  Created by 이상준 on 4/3/25.
//

import UIKit
import RxDataSources

enum DiarySectionItem {
    case images([UIImage])
    case title(String?)
    case description(String?)
    case keyword
    case shareOption(imageUrl: String, title: String, isOn: Bool)
    case settings
    case button(title: String)
    case divide(left: CGFloat, right:CGFloat)
}

enum DiarySection {
    case images(items: [DiarySectionItem])
    case title(header: String, items: [DiarySectionItem])
    case description(header: String, items: [DiarySectionItem])
    case keyword(header: String, desc: String, items: [DiarySectionItem])
    case shareOptions(header: String, items: [DiarySectionItem])
    case settings(items: [DiarySectionItem])
    case button(items: [DiarySectionItem])
    case divide(items: [DiarySectionItem])
}

extension DiarySection: SectionModelType {
    typealias Item = DiarySectionItem
    
    var items: [DiarySectionItem] {
        switch self {
        case .images(let items),
                .title(_, let items),
                .description(_, let items),
                .keyword(_, _, let items),
                .shareOptions(_, let items),
                .settings(let items),
                .button(let items),
                .divide(let items):
                
            return items
        }
    }
    
    var title: String? {
        switch self {
        case .images:
            return nil
        case .title(let header, _):
            return header
        case .description(let header, _):
            return header
        case .keyword(let header, _, _):
            return header
        case .shareOptions(let header, _):
            return header
        case .settings:
            return nil
        case .button:
            return nil
        case .divide:
            return nil
        }
    }
    
    var desc: String? {
        switch self {
        case .keyword(_, let desc, _):
            return desc
        default:
            return nil
        }
    }
    
    init(original: DiarySection, items: [DiarySectionItem]) {
        switch original {
        case .images:
            self = .images(items: items)
        case .title(let header, _):
            self = .title(header: header, items: items)
        case .description(let header, _):
            self = .description(header: header, items: items)
        case .keyword(let header, let desc, items: _):
            self = .keyword(header: header, desc: desc, items: items)
        case .shareOptions(let header, _):
            self = .shareOptions(header: header, items: items)
        case .settings(let items):
            self = .settings(items: items)
        case .button(let items):
            self = .button(items: items)
        case .divide(let items):
            self = .divide(items: items)
        }
    }
}

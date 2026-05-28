//
//  CGFloat+Extensions.swift
//  FlipTok
//
//  Created by Кирилл Казаков on 28.05.2026.
//

import UIKit

extension CGFloat {
    
    static let sideOffset: CGFloat = 16
    static let bottomOffset: CGFloat = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) > 0 ? 0 : 16
}

//
//  Font+Extensions.swift
//  FlipTok
//
//  Created by Dima on 13.01.2026.
//

import SwiftUI

extension Font {
    
    // MARK: - Helper
    
    private static func custom(_ font: Roboto, size: CGFloat) -> Font {
        return .custom(font.rawValue, size: size)
    }
    
    // MARK: - Headlines (для заголовков экранов, навигации)
    
    static let headline1 = custom(.medium, size: 24)
    static let headline2 = custom(.medium, size: 22)
    
    // MARK: - Основной текст контента (описания видео, никнеймы)
    
    static let text1 = custom(.regular, size: 16)
    static let text2 = custom(.medium, size: 15)
    static let text2SemiBold = custom(.semiBold, size: 15)
    static let text2Bold = custom(.bold, size: 15)
    
    // MARK: - Второстепенный текст (подписи, дата, звуки)
    
    static let text3 = custom(.regular, size: 13)
    static let text4 = custom(.medium, size: 13)
    static let text4Bold = custom(.bold, size: 13)
    
    // MARK: - Menu (нижнее меню, маленькие элементы)
    
    static let textMenu = custom(.regular, size: 11)
    
    // MARK: - Special (счетчики лайков, просмотров)
    
    static let numbers = custom(.medium, size: 34)
    static let description = custom(.medium, size: 13)
    
    // MARK: - Roboto
    
    private enum Roboto: String {
        case regular = "Roboto-Regular"
        case bold = "Roboto-Bold"
        case medium = "Roboto-Medium"
        case semiBold = "Roboto-SemiBold"
    }
}

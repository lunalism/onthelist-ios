//
//  Font+Extension.swift
//  OnTheList
//
//  Created by 최병진 on 3/29/25.
//

import SwiftUI

extension Font {
    static func pretendard(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        switch weight {
            case .heavy:
                return .custom("Pretendard-Black", size: size)
            case .bold:
                return .custom("Pretendard-Bold", size: size)
            case .medium:
                return .custom("Pretendard-Medium", size: size)
            case .light:
                return .custom("Pretendard-Light", size: size)
            case .thin:
                return .custom("Pretendard-Thin", size: size)
            default:
                return .custom("Pretendard-Regular", size: size)
        }
    }
}

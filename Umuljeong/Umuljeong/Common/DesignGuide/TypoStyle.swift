//
//  TypoStyle.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/17.
//

import SwiftUI
import UIKit

extension Font {
    static let customTitle1 = Font.custom("Pretendard-Bold", fixedSize: 24)
    static let customTitle2 = Font.custom("Pretendard-Bold", fixedSize: 18)
    static let body1 = Font.custom("Pretendard-Bold", fixedSize: 16)
    static let body2 = Font.custom("Pretendard-Medium", fixedSize: 16)
    static let body3 = Font.custom("Pretendard-Medium", fixedSize: 14)
    static let body4 = Font.custom("Pretendard-Regular", fixedSize: 14)
    static let body5 = Font.custom("Pretendard-Regular", fixedSize: 13)
    static let body6 = Font.custom("Pretendard-Medium", fixedSize: 12)
    
    static let special1 = Font.custom("Pretendard-Medium", fixedSize: 11)
    static let special2 = Font.custom("Pretendard-Bold", fixedSize: 20)
    static let special3 = Font.custom("Pretendard-SemiBold", fixedSize: 14)
    static let special4 = Font.custom("Pretendard-Regular", fixedSize: 16)
    static let special5 = Font.custom("Pretendard-SemiBold", fixedSize: 24)
}

extension UIFont {
//    static let title1 = Font.custom("Pretendard-Bold", fixedSize: 24)
    static let body1 = UIFont(name: "Pretendard-Bold", size: 16)
    static let body2 = UIFont(name: "Pretendard-Medium", size: 16)
    static let body3 = UIFont(name: "Pretendard-Medium", size: 14)
    static let body5 = UIFont(name: "Pretendard-Regular", size: 13)
    static let special3 = UIFont(name: "Pretendard-SemiBold", size: 14)
//    static let body1 = Font.custom("Pretendard-Bold", fixedSize: 16)
//    static let body2 = Font.custom("Pretendard-Medium", fixedSize: 16)
//    static let body3 = Font.custom("Pretendard-Medium", fixedSize: 14)
//    static let body4 = Font.custom("Pretendard-Regular", fixedSize: 14)
//    static let body5 = Font.custom("Pretendard-Regular", fixedSize: 13)
//    static let body6 = Font.custom("Pretendard-Medium", fixedSize: 12)
}

// 원래라면 폰트, 크기 외에 텍스트 스타일(TextStyle)까지 있어야겠지만 여기서는 제외시킴
//struct FontDescription {
//    let font: FontType
//    let size: CGFloat
//}
//
//struct LabelDescription {
//    let kern: Double
//    let lineHeight: CGFloat
//}
//
//// 열거형으로 구분해놓아 명칭으로 좀 더 쉽게,
//// 지정된 폰트 스타일을 적용 가능
//enum TypoStyle: Int, CaseIterable {
//    case header1 = 0        // 24pt / bold / -0.24 / 14.7
//
//    case title1             // 23pt / bold / 0 / 1.5
//    case title2             // 16pt / medium / 0 / 21.6
//    case title3             // 15pt / semibold / 0 / 21
//
//    case body1              // 22pt / bold / -0.22 / 30.8
//    case body2              // 18pt / semibold / 0 / 25.2
//    case body3              // 17pt / extrabold / 0 / 23.8
//    case body4              // 16pt / semibold / 0 / 24
//    case body5              // 15pt / semibold / 0 / 22.5
//    case body6              // 14pt / medium / 0 / 21
//    case body7              // 13pt / semibold / 0 / 18.2
//    case body8              // 12pt / medium / 0 / 16.8
//    case body9              // 11pt / bold / 0 / 16.5
//}
//
//extension TypoStyle {
//    private var fontDescription: FontDescription {
//        switch self {
//        case .header1:       return FontDescription(font: .pretendardBold, size: 24)
//
//        case .title1:   return FontDescription(font: .pretendardBold, size: 23)
//        case .title2:   return FontDescription(font: .pretendardMedium, size: 16)
//        case .title3:   return FontDescription(font: .pretendardSemibold, size: 16)
//
//        case .body1:    return FontDescription(font: .pretendardBold, size: 22)
//        case .body2:    return FontDescription(font: .pretendardSemibold, size: 18)
//        case .body3:    return FontDescription(font: .pretendardExtraBold, size: 17)
//        case .body4:    return FontDescription(font: .pretendardRegular, size: 16)
//        case .body5:    return FontDescription(font: .pretendardSemibold, size: 15)
//        case .body6:    return FontDescription(font: .pretendardMedium, size: 14)
//        case .body7:    return FontDescription(font: .pretendardSemibold, size: 13)
//        case .body8:    return FontDescription(font: .pretendardMedium, size: 12)
//        case .body9:    return FontDescription(font: .pretendardBold, size: 11)
//        }
//    }
//
//    public var labelDescription: LabelDescription {
//        switch self {
//        case .header1:       return LabelDescription(kern: -0.24, lineHeight: 3.53)
//
//        case .title1:   return LabelDescription(kern: 0, lineHeight: 1.5)
//        case .title2:   return LabelDescription(kern: 0, lineHeight: 1.35)
//        case .title3:   return LabelDescription(kern: 0, lineHeight: 1.4)
//
//        case .body1:    return LabelDescription(kern: -0.24, lineHeight: 1.4)
//        case .body2:    return LabelDescription(kern: 0, lineHeight: 1.4)
//        case .body3:    return LabelDescription(kern: 0, lineHeight: 1.4)
//        case .body4:    return LabelDescription(kern: 0, lineHeight: 1.4)
//        case .body5:    return LabelDescription(kern: 0, lineHeight: 1.5)
//        case .body6:    return LabelDescription(kern: 0, lineHeight: 1.5)
//        case .body7:    return LabelDescription(kern: 0, lineHeight: 1.4)
//        case .body8:    return LabelDescription(kern: 0, lineHeight: 1.4)
//        case .body9:    return LabelDescription(kern: 0, lineHeight: 1.5)
//        }
//    }
//}
//
//extension TypoStyle {
//    var font: UIFont {
//        guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
//            return UIFont()
//        }
//        return font
//    }
//}
//
//extension UILabel {
//    func setTypoStyle(font: UIFont, kernValue: Double = -0.6, lineSpacing: CGFloat = 4.0) {
//        if let labelText = text, labelText.count > 0 {
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.lineSpacing = lineSpacing
//            attributedText = NSAttributedString(string: labelText,
//                                                attributes: [
//                                                    .font: font,
//                                                    .kern: kernValue,
//                                                    .paragraphStyle: paragraphStyle])
//        }
//    }
//
//    func setTypoStyle(typoStyle: TypoStyle) {
//        let font = typoStyle.font
//        let kernValue = typoStyle.labelDescription.kern
//        let lineSpacing = typoStyle.labelDescription.lineHeight
//
//        if let labelText = text, labelText.count > 0 {
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.lineSpacing = lineSpacing
//            attributedText = NSAttributedString(string: labelText,
//                                                attributes: [
//                                                    .font: font,
//                                                    .kern: kernValue,
//                                                    .paragraphStyle: paragraphStyle])
//        }
//    }
//}

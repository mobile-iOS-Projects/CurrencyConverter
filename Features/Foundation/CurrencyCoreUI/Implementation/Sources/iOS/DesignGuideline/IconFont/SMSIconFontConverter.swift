//
//  SMSIconFontConverter.swift
//  SMSCoreUI
//
//  Created by Weiss, Alexander on 14.07.22.
//

import UIKit

enum SMSIconFontConverter {
    static func image(
        from character: SMSIconFontCharacter,
        color: UIColor,
        size: CGFloat
    ) -> UIImage {
        defer { UIGraphicsEndImageContext() }

        guard let unicodeChar = character.unicodeChar else { return UIImage() }

        let attributes = [
            NSAttributedString.Key.font: UIFont(
                name: character.fontName.rawValue,
                size: size
            ),
            NSAttributedString.Key.foregroundColor: color,
        ]

        let attributedString = NSAttributedString(
            string: unicodeChar,
            attributes: attributes as [NSAttributedString.Key: Any]
        )

        let imageRect = CGRect(x: 0, y: 0, width: size, height: size)
        let reqImageSize = CGSize(width: imageRect.width, height: imageRect.height)
        UIGraphicsBeginImageContextWithOptions(
            CGSize(
                width: reqImageSize.width,
                height: reqImageSize.height
            ),
            false,
            0
        )

        let drawnAttributedImageSize = attributedString.boundingRect(
            with: reqImageSize,
            options: .usesLineFragmentOrigin,
            context: nil
        )
        attributedString.draw(
            at: CGPoint(
                x: (imageRect.width / 2) - (drawnAttributedImageSize.width / 2),
                y: (imageRect.height / 2) - (drawnAttributedImageSize.height / 2)
            )
        )

        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}

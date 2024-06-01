//
//  SMSIconFontMapping.swift
//  SMSCoreUI
//
//  Created by Weiss, Alexander on 14.07.22.
//

import Foundation

// swiftlint:disable cyclomatic_complexity
public enum SMSIconFontMapping {
    public static var allIconSets: [SMSIconFontSet] {
        [
            sapIconSet,
            sapFiori2IconSet,
            sapFiori3IconSet,
            sapFiori4IconSet,
            sapFiori5IconSet,
            sapFiori6IconSet,
            sapFiori7IconSet,
            sapFiori8IconSet,
            sapFiori9IconSet,
            sapS4HanaIconSet,
            sapFioriNonNativeIconSet,
            businessSuiteInAppIconSet,
            sapTNTIconSet,
            sapFioriInAppIconSet,
        ]
    }

    static func iconFontCharacter(for nameSpaceURI: URL) -> SMSIconFontCharacter? {
        guard nameSpaceURI.scheme == "sap-icon" else { return nil }
        let fontAppID = nameSpaceURI.pathComponents.last ?? ""
        switch nameSpaceURI.host {
        // This is a special case where "Fiori2" namespaced icons can live in sapF2AndSAPIconSet OR sapFiori2IconSet
        case "Fiori2":
            return sapF2AndSAPIconSet.icons.keys
                .contains(fontAppID) ? (sapF2AndSAPIconSet.icons[fontAppID], .sapicon) :
                (sapFiori2IconSet.icons[fontAppID], .launchIcon)

        case "Fiori3":
            return (sapFiori3IconSet.icons[fontAppID], .launchIcon)

        case "Fiori4":
            return (sapFiori4IconSet.icons[fontAppID], .launchIcon)

        case "Fiori5":
            return (sapFiori5IconSet.icons[fontAppID], .launchIcon)

        case "Fiori6":
            return (sapFiori6IconSet.icons[fontAppID], .launchIcon)

        case "Fiori7":
            return (sapFiori7IconSet.icons[fontAppID], .launchIcon)

        case "Fiori8":
            return (sapFiori8IconSet.icons[fontAppID], .launchIcon)

        case "Fiori9":
            return (sapFiori9IconSet.icons[fontAppID], .launchIcon)

        case "S4Hana":
            return (sapS4HanaIconSet.icons[fontAppID], .launchIcon)

        case "FioriNonNative":
            return (sapFioriNonNativeIconSet.icons[fontAppID], .launchIcon)

        case "BusinessSuiteInAppSymbols":
            return (businessSuiteInAppIconSet.icons[fontAppID], .businessSuitInAppSymbols)

        case "SAP-icons-TNT":
            return (sapTNTIconSet.icons[fontAppID], .tntIcons)

        case "FioriInAppIcons":
            return (sapFioriInAppIconSet.icons[fontAppID], .fioriInAppIcons)

        default:
            return (sapIconSet.icons[nameSpaceURI.host ?? ""], .sapicon)
        }
    }
}

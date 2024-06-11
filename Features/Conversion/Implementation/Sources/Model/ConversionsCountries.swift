//
//  ConversionsCountries.swift
//  ConversionAPI
//
//  Created by Siarhei Runovich on 10.06.24.
//

import SwiftData
import SwiftUI

@Model
final public class ConversionsCountries: Decodable {
    var byn = ""
    var usd = ""
    var eur = ""
    var rub = ""
    var pln = ""

    init(byn: String = "", usd: String = "", eur: String = "", rub: String = "", pln: String = "") {
        self.byn = byn
        self.usd = usd
        self.eur = eur
        self.rub = rub
        self.pln = pln
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        byn = try container.decodeIfPresent(String.self, forKey: .byn) ?? ""
        usd = try container.decodeIfPresent(String.self, forKey: .usd) ?? ""
        eur = try container.decodeIfPresent(String.self, forKey: .eur) ?? ""
        rub = try container.decodeIfPresent(String.self, forKey: .rub) ?? ""
        pln = try container.decodeIfPresent(String.self, forKey: .pln) ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case byn
        case usd
        case eur
        case rub
        case pln
    }
}

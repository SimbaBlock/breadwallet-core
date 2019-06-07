//
//  BRCrypto.swift
//  BRCrypto
//
//  Created by Ed Gamble on 3/27/19.
//  Copyright © 2018 Breadwallet AG. All rights reserved.
//
//  See the LICENSE file at the project root for license information.
//  See the CONTRIBUTORS file at the project root for a list of contributors.
//
import BRCryptoC

///
/// A currency is a medium for exchange.
///
public final class Currency: Hashable {

    internal let core: BRCryptoCurrency

    /// A 'Unique Identifier
    internal var uids: String {
        return asUTF8String (cryptoCurrencyGetUids (core))
    }

    /// The code; e.g. BTC
    public var code: String {
        return asUTF8String (cryptoCurrencyGetCode (core))
    }

    /// The name; e.g. Bitcoin
    public var name: String {
        return asUTF8String (cryptoCurrencyGetName (core))
    }

    /// The type:
    public var type: String {
        return asUTF8String (cryptoCurrencyGetType (core))
    }

    internal init (core: BRCryptoCurrency) {
        self.core = core
    }

    internal convenience init (uids: String,
                               name: String,
                               code: String,
                               type: String) {
        self.init (core: cryptoCurrencyCreate(uids, name, code, type))
    }

    deinit {
        cryptoCurrencyGive (core)
    }

    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs === rhs || CRYPTO_TRUE == cryptoCurrencyIsIdentical (lhs.core, rhs.core)
    }

    public func hash (into hasher: inout Hasher) {
        hasher.combine (uids)
    }

    /// Used to map Currency -> Built-In-Blockchain-Network
    public static let codeAsBTC = "btc"
    public static let codeAsBCH = "bch"
    public static let codeAsETH = "eth"
}
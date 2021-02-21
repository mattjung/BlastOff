//
//  Extensions.swift
//  BlastOff
//
//  Created by Matt Jung on 19/02/2021.
//

import SwiftUI
import Foundation
import Combine
import OSLog

extension String: Error {}

extension Optional {
    func ifNilthrow(_ error: Error) throws -> Wrapped {
        switch self {
        case .some(let wrapped): return wrapped
        case .none: throw error
        }
    }
}

extension DateFormatter {
    convenience init(_ dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
    convenience init(_ dateStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
    }
}

extension NumberFormatter {
    convenience init(_ numberStyle: NumberFormatter.Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}

func with<T>(_ value: T, apply: (T) -> ()) -> T {
    apply(value)
    return value
}

extension String {
    var url: URL? { URL(string: self) }
}

extension UIImage {
    var image: Image { Image(uiImage: self) }
}

extension View {
    var any: AnyView { AnyView(self) }
}

extension Publisher {
    func `catch`<T>(logger: Logger, `default`: T) -> Publishers.Catch<Self, Just<T>>
    {
        self.catch { error -> Just<T> in
            defaultLog.log("\(error as NSObject)")
            return Just(`default`)
        }
    }
}

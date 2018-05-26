//
//  Violation.swift
//  DangerIBLinter
//
//  Created by SaitoYuta on 2018/05/26.
//

import Foundation

enum AbsolutePath {}
enum RelativePath {}

enum Level: String, Codable {
    case warning
    case error
}

struct Violation<PathType>: Codable {
    let message: String
    let level: Level
    private let path: String
}

extension Violation where PathType == AbsolutePath {
    var absolutePath: String { return path }

    func convert(gitRoot: String) -> Violation<RelativePath> {
        guard let range = path.range(of: gitRoot)else {
            fatalError()
        }
        var relativePath = path
        relativePath.removeSubrange(range)
        return .init(message: message, level: level, path: relativePath)
    }
}

extension Violation where PathType == RelativePath {
    var relativePath: String { return path }

    func toMarkdown() -> String {
        let formattedFile = path.split(separator: "/").last! + ":0"
        return "\(level.rawValue) | \(formattedFile) | \(message) |"
    }
}

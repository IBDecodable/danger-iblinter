import Foundation
import Danger

public struct IBLinter {
    static let danger = Danger()
}

extension IBLinter {

    public static func lint(inline: Bool = true) throws {
        let arguments = [
            "--reporter", "json"
        ]
        let shellExecutor = ShellExecutor()
        let output = shellExecutor.execute("iblinter", arguments: arguments)
        let pwd = shellExecutor.execute("pwd")
        let decoder = JSONDecoder()
        let files = danger.git.createdFiles + danger.git.modifiedFiles
        let violations = try decoder.decode([Violation<AbsolutePath>].self, from: output.data(using: .utf8)!)
        let filteredViolations = violations.map { $0.convert(gitRoot: pwd) }
            .filter {
                files.contains($0.relativePath)
        }

        if inline {
            filteredViolations
                .forEach {
                    fail(message: $0.message, file: $0.relativePath, line: 0)
            }
        } else {
            let header = """
                ### IBLinter found issues
                | Severity | File | Reason |
                | -------- | ---- | ------ |\n
                """
            let markdownMessage = filteredViolations.reduce(header) {
                $0 + $1.toMarkdown() + "\n"
            }
            markdown(markdownMessage)
        }
    }
}

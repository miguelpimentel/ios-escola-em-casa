import Danger

let danger = Danger()

// MARK: - Swiftlint
SwiftLint.lint(.all(directory: nil), inline: true)

// MARK: - Properties
let additions = danger.github.pullRequest.additions!
let deletions = danger.github.pullRequest.deletions!
let changedFiles = danger.github.pullRequest.changedFiles!

let modified = danger.git.modifiedFiles
let editedFiles = modified + danger.git.createdFiles
let prTitle = danger.github.pullRequest.title

// MARK: - Validate
let validator = Validator()
validator.validate()

// MARK: - Validation rules
protocol ValidatorBuilder {
    func validate()
}

struct Validator: ValidatorBuilder {

    func validate() {
        checkSize()
        checkContent()
        checkTitle()
        checkModifiedFiles()
        checkTests()

        logResume()
    }

    private func checkSize() {
        if (additions + deletions) > ValidationRules.bigPRThreshold {
            let message = """
                PR size seems relatively large.
                If this PR contains multiple changes, please split each into separate PR.
                will helps faster, easier review.
            """
            fail(message)
        }
    }

    private func checkContent() {
        let message = "PR has no description. You should provide a description of the changes that you have made."

        guard let body = danger.github.pullRequest.body else { return
            fail(message)
        }

        if body.isEmpty {
            fail(message)
        }
    }

    private func checkTitle() {
        if prTitle.contains("WIP") {
            let message = """
                PR is classed as Work in Progress.
            """
            warn(message)
        }

        if prTitle.count < ValidationRules.minPRTitle {
            let message = """
                PR title does not contain a related Jira task. Please use the format `[Jira Code] - Short Description`.
            """
            warn(message)
        }

        if !prTitle.contains("[JIRA-") {
            let message = """
                PR title does not contain a related Jira task. Please use the format `[Jira Code] - Short Description`.
            """
            warn(message)
        }
    }

    private func checkModifiedFiles() {
        if changedFiles > ValidationRules.maxChangedFiles {
            fail("PR contains too many changed files. Please split it in smaller PR")
        }
    }

    private func checkTests() {
        let testFiles = editedFiles.filter {
            ($0.contains("Tests") || $0.contains("Test")) && ($0.fileType == .swift  || $0.fileType == .m)
        }

        if testFiles.isEmpty {
            warn("PR does not contain any files related to Unit Tests")
        }
    }

    private func logResume() {
        let message =  """
            The PR added \(additions) and removed \(deletions) lines.  \(changedFiles) files changed.
        """

        warn(message)
    }
}

private struct ValidationRules {
    static let maxChangedFiles = 20
    static let minPRTitle = 10
    static let bigPRThreshold = 3000
}
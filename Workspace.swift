import ProjectDescription

let workspace = Workspace(
    name: "Workspace",
    projects: [
        "App"
    ],
    generationOptions: .options(
        enableAutomaticXcodeSchemes: false,
        renderMarkdownReadme: false
    )
)

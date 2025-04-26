import ProjectDescription

let project = Project(
    name: "NetworkAPI",
    targets: [
        .target(
            name: "NetworkAPI",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.NetworkAPI",
            deploymentTargets: DeploymentTargets.iOS("13.0.0"),
            infoPlist: .default,
            sources: "Sources/**",
            dependencies: [
                .external(name: "CombineMoya", condition: nil)
            ]
        ),

        .target(
            name: "NetworkAPITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.NetworkAPITests",
            infoPlist: .default,
            sources: "Tests/**",
            dependencies: [
                .target(name: "NetworkAPI"),
            ]
        ),
    ]
)

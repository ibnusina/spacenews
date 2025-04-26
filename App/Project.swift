import ProjectDescription

let debugAction: ExecutionAction = .executionAction(
    scriptText: "echo Debug",
    target: "App"
)
let debugScheme: Scheme = .scheme(
    name: "App-Debug",
    shared: false,
    buildAction: .buildAction(
        targets: ["App"],
        preActions: [debugAction]
    ),
    testAction: TestAction.targets(
        ["AppTests"]
    ),
    runAction: .runAction(
        configuration: .debug,
        executable: "App"
    ),
    archiveAction: .archiveAction(
        configuration: .debug
    )
)

let releaseAction: ExecutionAction = .executionAction(
    scriptText: "echo Release",
    target: "App"
)
let releaseScheme: Scheme = .scheme(
    name: "App-Release",
    shared: false,
    buildAction: .buildAction(
        targets: ["App"],
        preActions: [releaseAction]
    ),
    testAction: TestAction.targets(
        ["AppTests"]
    ),
    runAction: .runAction(
        configuration: .release,
        executable: "App"
    ),
    archiveAction: .archiveAction(
        configuration: .release
    )
)

let project = Project(
    name: "App",
    settings: Settings.settings(
        debug: [
            "CUSTOM_BUNDLE_ID": "sina.mobile.demo.debug",
            "CUSTOM_PRODUCT_NAME": "sina staging"
        ],
        release: [
            "CUSTOM_BUNDLE_ID": "sina.mobile.demo.prod",
            "CUSTOM_PRODUCT_NAME": "sina release"
        ]
    ),
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            productName: "${CUSTOM_PRODUCT_NAME}",
            bundleId: "${CUSTOM_BUNDLE_ID}",
            deploymentTargets: DeploymentTargets.iOS("14.0.0"),
            infoPlist: .file(
                path: "Resources/App-Info.plist"
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [
                .pre(script: """
                    RESOURCE_PATH=$SRCROOT/Resources

                    FILENAME_GOOGLE_SERVICE_INFO=GoogleService-Info.plist

                    if [ "$CONFIGURATION" == "Debug" ]; then
                        cp "$RESOURCE_PATH/$FILENAME_GOOGLE_SERVICE_INFO.debug" "$RESOURCE_PATH/$FILENAME_GOOGLE_SERVICE_INFO"
                    fi
                    if [ "$CONFIGURATION" == "Release" ]; then
                        cp "$RESOURCE_PATH/$FILENAME_GOOGLE_SERVICE_INFO.prod" "$RESOURCE_PATH/$FILENAME_GOOGLE_SERVICE_INFO"
                    fi
                    """, name: "Copy Google JSON")
            ],
            dependencies: [
                .project(
                    target: "NetworkAPI",
                    path: "../Frameworks/NetworkAPI",
                    condition: nil
                ),
                .external(name: "Alamofire", condition: nil)

            ]
        ),
        .target(
            name: "AppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(
                name: "App"
            )]
        ),
    ],
    schemes: [
        debugScheme,
        releaseScheme
    ]
)

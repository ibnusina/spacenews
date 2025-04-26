// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    
    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [:]
    )
#endif

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", exact: "5.8.0"),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.3")),

    ],
    targets: [
        .target(
            name: "PackageName",
            dependencies: ["CombineMoya"])
    ]
)

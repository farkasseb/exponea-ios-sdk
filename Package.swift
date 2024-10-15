// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "ExponeaSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ExponeaSDK",
            targets: ["ExponeaSDK"]),
        .library(
            name: "ExponeaSDK-Notifications",
            targets: ["ExponeaSDK-Notifications"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.6.1")
    ],
    targets: [
        // Main library
        .target(
            name: "ExponeaSDK",
            dependencies: ["ExponeaSDKShared", "ExponeaSDKObjC"],
            path: "ExponeaSDK/ExponeaSDK",
            exclude: ["Supporting Files/Info.plist"],
            resources: [.copy("Supporting Files/PrivacyInfo.xcprivacy")]
        ),
        // Notification extension library
        .target(
            name: "ExponeaSDK-Notifications",
            dependencies: ["ExponeaSDKShared"],
            path: "ExponeaSDK/ExponeaSDK-Notifications",
            exclude: ["Supporting Files/Info.plist"],
            resources: [.copy("Supporting Files/PrivacyInfo.xcprivacy")]
        ),
        // Code shared between ExponeaSDK and ExponeaSDK-Notifications
        .target(
            name: "ExponeaSDKShared",
            dependencies: ["SwiftSoup"],
            path: "ExponeaSDK/ExponeaSDKShared",
            exclude: ["Supporting Files/Info.plist"]
        ),
        // ObjC code required by main library
        .target(
            name: "ExponeaSDKObjC",
            dependencies: [],
            path: "ExponeaSDK/ExponeaSDKObjC",
            exclude: ["Info.plist"],
            publicHeadersPath: ".")
    ],
    swiftLanguageModes: [.v5]
)

// MARK: - Make all imports internal by default
extension Target {
    func addInternalImportsByDefaultFlag() -> Target {
        let newTarget = self
        newTarget.swiftSettings = (newTarget.swiftSettings ?? []) + [.enableUpcomingFeature("InternalImportsByDefault")]
        return newTarget
    }
}

package.targets = package.targets.map {
    if $0.type != .binary {
        return $0.addInternalImportsByDefaultFlag()
    } else {
        return $0
    }
}

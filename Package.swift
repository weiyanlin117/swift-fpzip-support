// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "fpzip",
    products: [
        .library(
            name: "C_fpzip",
            targets: ["C_fpzip"]
        ),
    ],
    targets: [
        .target(
            name: "C_fpzip",
            path: ".",
            exclude: [
                "src/fpe.inl",
                "src/pccodec.inl",
                "src/pcdecoder.inl",
                "src/pcencoder.inl",
                "src/pcmap.inl",
                "src/rcdecoder.inl",
                "src/rcencoder.inl",
                "src/rcqsmodel.inl",
                "src/CMakeLists.txt",
                "src/Makefile"
            ],
            sources: ["src"],
            publicHeadersPath: "include",
            cxxSettings: [
                .headerSearchPath("src"),
                .headerSearchPath("include"),
                .define("FPZIP_FP", to: "FPZIP_FP_FAST"),
                .define("FPZIP_BLOCK_SIZE", to: "0x1000"),
                .unsafeFlags(["-std=c++98", "-fPIC"])
            ]
        ),
        .executableTarget(
            name: "testfpzip",
            dependencies: ["C_fpzip"],
            path: "tests",
            exclude: [
                "CMakeLists.txt",
                "Makefile"
            ],
            sources: ["testfpzip.c"],
            cSettings: [
                .headerSearchPath("../include"),
                .define("FPZIP_FP", to: "FPZIP_FP_FAST")
            ]
        ),
    ],
    cxxLanguageStandard: .cxx11
)

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")

# We define our externals here instead of directly in WORKSPACE
# because putting the `new_git_repository` calls here instead of there
# works around https://github.com/bazelbuild/bazel/issues/1465 when
# passing `build_file` to the `new_git_repository`.
def externals():
    native.new_http_archive(
        name = "gtest",
        url = "https://github.com/google/googletest/archive/release-1.8.0.zip",
        sha256 = "f3ed3b58511efd272eb074a3a6d6fb79d7c2e6a0e374323d1e6bcbcc1ef141bf",
        build_file = "gtest.BUILD",
        strip_prefix = "googletest-release-1.8.0",
    )

    # their zip archive has symlinks that bazel does not like
    new_git_repository(
        name="spdlog",
        remote="https://github.com/gabime/spdlog.git",
        commit="ccd675a286f457068ee8c823f8207f13c2325b26", # v0.16.3
        build_file="//:spdlog.BUILD",
    )

    # proto_library, cc_proto_library, and java_proto_library rules implicitly
    # depend on @com_google_protobuf for protoc and proto runtimes.
    # This statement defines the @com_google_protobuf repo.
    native.http_archive(
        name = "com_google_protobuf",
        sha256 = "1f8b9b202e9a4e467ff0b0f25facb1642727cdf5e69092038f15b37c75b99e45",
        strip_prefix = "protobuf-3.5.1",
        urls = ["https://github.com/google/protobuf/archive/v3.5.1.zip"],
    )


    new_git_repository(
            name="lizard",
            remote="https://github.com/inikep/lizard.git",
            commit="6a1ed71450148c8aed57de3179b1bdd81800bada",
            build_file="//:lizard.BUILD",
        )

    new_git_repository(
            name="jemalloc",
            remote="https://github.com/jemalloc/jemalloc.git",
            commit="f78d4ca3fbff6cab0c704c787706a53ddafcbe13",
            build_file="//:jemalloc.BUILD",
        )

    new_git_repository(
            name="progressbar",
            remote="https://github.com/doches/progressbar.git",
            commit="c4c54f891ab05cfc411ec5c2ed147dd4cad1ccf3",
            build_file="//:progressbar.BUILD",
        )

    new_git_repository(
                name="concurrentqueue",
                remote="https://github.com/DarkDimius/concurrentqueue.git",
                commit="d40e4e754dad40510ae6b8613c7ce94d6918527a",
                build_file="//:concurrentqueue.BUILD",
            )

    new_git_repository(
            name="statsd",
            remote="https://github.com/romanbsd/statsd-c-client",
            commit="0bfa3d59e29ad7eff332c9e2506a23d311ff8db4",
            build_file="//:statsd.BUILD",
        )

    new_git_repository(
        name="cxxopts",
        remote="https://github.com/jarro2783/cxxopts.git",
        commit="0b7686949d01f6475cc13ba0693725aefb76fc0c",
        build_file="//:cxxopts.BUILD",
    )

    git_repository(
            name="com_google_absl",
            remote="https://github.com/abseil/abseil-cpp.git",
            commit="f6eea9486ae1935017f42d1f89005ddafb0bd53a"
        )

    new_git_repository(
        name = "compdb",
        commit = "f9febfc7091e2585bafb1a96599ff517e169c3c4",
        remote = "https://github.com/grailbio/bazel-compilation-database.git",
        build_file_content = (
            """
package(default_visibility = ["//visibility:public"])
"""
        ),
    )

    native.new_local_repository(
      name="parser",
      path="third_party/parser",
      build_file="//third_party:parser.BUILD",
    )

    native.new_http_archive(
        name="clang_5_0_0_darwin",
        url="http://releases.llvm.org/5.0.0/clang+llvm-5.0.0-x86_64-apple-darwin.tar.xz",
        build_file="//:clang.BUILD",
        sha256="326be172ccb61210c9ae5dced27204977e249ec6589521cc30f82fd0904b0671",
        type="tar.xz",
        strip_prefix="clang+llvm-5.0.0-x86_64-apple-darwin/",
    )

    native.new_http_archive(
        name="clang_5_0_0_linux",
        url="http://releases.llvm.org/5.0.1/clang+llvm-5.0.1-x86_64-linux-gnu-ubuntu-14.04.tar.xz",
        build_file="//:clang.BUILD",
        sha256="9e61c6669991e2f0d065348c95917b2c6b697d75098b60ec1c2e9f17093ce012",
        type="tar.xz",
        strip_prefix="clang+llvm-5.0.1-x86_64-linux-gnu-ubuntu-14.04/",
    )

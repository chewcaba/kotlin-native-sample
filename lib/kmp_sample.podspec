Pod::Spec.new do |spec|
    spec.name                     = 'kmp_sample'
    spec.version                  = '1.0'
    spec.homepage                 = 'https://kotlinlang.org/docs/reference/native/cocoapods.html'
    spec.source                   = { :git => "Not Published", :tag => "Cocoapods/#{spec.name}/#{spec.version}" }
    spec.authors                  = ''
    spec.license                  = ''
    spec.summary                  = 'Kotlin/Native & Multiplatform Sample Module'

    spec.static_framework         = true
    spec.vendored_frameworks      = "build/cocoapods/framework/iosFramework.framework"
    spec.libraries                = "c++"
    spec.module_name              = "#{spec.name}_umbrella"

    spec.ios.deployment_target = '9.0'

                

    spec.pod_target_xcconfig = {
        'KOTLIN_TARGET[sdk=iphonesimulator*]' => 'ios_x64',
        'KOTLIN_TARGET[sdk=iphoneos*]' => 'ios_arm',
        'KOTLIN_TARGET[sdk=watchsimulator*]' => 'watchos_x86',
        'KOTLIN_TARGET[sdk=watchos*]' => 'watchos_arm',
        'KOTLIN_TARGET[sdk=appletvsimulator*]' => 'tvos_x64',
        'KOTLIN_TARGET[sdk=appletvos*]' => 'tvos_arm64',
        'KOTLIN_TARGET[sdk=macosx*]' => 'macos_x64'
    }

    spec.script_phases = [
        {
            :name => 'Build kmp_sample',
            :execution_position => :before_compile,
            :shell_path => '/bin/sh',
            :script => <<-SCRIPT
                set -ev
                REPO_ROOT="$PODS_TARGET_SRCROOT"
                "$REPO_ROOT/../../../../../../../private/var/folders/gg/47x1d53j5hz3hlbxsrn1qcn40000gn/T/wrap3loc/gradlew" -p "$REPO_ROOT" ::syncFramework \
                    -Pkotlin.native.cocoapods.target=$KOTLIN_TARGET \
                    -Pkotlin.native.cocoapods.configuration=$CONFIGURATION \
                    -Pkotlin.native.cocoapods.cflags="$OTHER_CFLAGS" \
                    -Pkotlin.native.cocoapods.paths.headers="$HEADER_SEARCH_PATHS" \
                    -Pkotlin.native.cocoapods.paths.frameworks="$FRAMEWORK_SEARCH_PATHS"
            SCRIPT
        }
    ]
end
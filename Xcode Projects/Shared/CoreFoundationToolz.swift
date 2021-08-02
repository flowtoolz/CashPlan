import CoreFoundation

/**
 In case a model needs to get the current time but should neither import Foundation nor rely on some injected "time provider", we could allow the model layer to use CoreFoundation, which is only a small subset of Foundation and available on Linux.
 See https://github.com/apple/swift-corelibs-foundation
 */
let unixEpochTimestamp = CFAbsoluteTimeGetCurrent() + kCFAbsoluteTimeIntervalSince1970

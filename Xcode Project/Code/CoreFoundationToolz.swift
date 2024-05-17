/**
 Generally: In case a model needs to get the current time but should neither import Foundation nor rely on some injected "time provider", we could allow the model layer to use CoreFoundation, which is only a small subset of Foundation and available on Linux.
 
 See https://github.com/apple/swift-corelibs-foundation
 */
import CoreFoundation

/**
 For simple yahoo requests, we need the current time as unix epoch timestamp to demarcate the time interval: https://query1.finance.yahoo.com/v7/finance/download/AAPL?period1=1630227368&period2=1661763368&interval=1d&events=history&includeAdjustedClose=true
 */
func unixEpochTimestamp() -> CFAbsoluteTime {
    CFAbsoluteTimeGetCurrent() + kCFAbsoluteTimeIntervalSince1970
}

#import "XCTestCase+PromiseKit.h"
#import "NSProcessInfo+WMFOperatingSystemVersionChecks.h"

@interface XCTestCase_PromiseKitTests : XCTestCase
@end

@implementation XCTestCase_PromiseKitTests

- (void)recordFailureWithDescription:(NSString *)description
                              inFile:(NSString *)filePath
                              atLine:(NSUInteger)lineNumber
                            expected:(BOOL)expected {
    if (![description hasPrefix:@"Asynchronous wait failed: Exceeded timeout of 0 seconds, with unfulfilled expectations: \"testShouldNotFulfillExpectationWhenTimeoutExpires"]) {
        // recorded failure wasn't the expected timeout
        [super recordFailureWithDescription:description inFile:filePath atLine:lineNumber expected:expected];
    }
}

- (void)testShouldNotFulfillExpectationWhenTimeoutExpiresForResolution {

    __block PMKResolver resolve;
    expectResolutionWithTimeout(0, ^{
        return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull aResolve) {
            resolve = aResolve;
        }];
    });
    // Resolve after wait context, which we should handle internally so it doesn't throw an assertion.
    resolve(nil);
}

- (void)testShouldNotFulfillExpectationWhenTimeoutExpiresForError {

    __block PMKResolver resolve;
    [self expectAnyPromiseToCatch:^AnyPromise * {
        return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull aResolve) {
            resolve = aResolve;
        }];
    }
                       withPolicy:PMKCatchPolicyAllErrors
                          timeout:0 WMFExpectFromHere];
    // Resolve after wait context, which we should handle internally so it doesn't throw an assertion.
    resolve([NSError cancelledError]);
}

@end

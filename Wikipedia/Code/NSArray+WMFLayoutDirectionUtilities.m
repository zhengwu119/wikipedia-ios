#import "NSArray+WMFLayoutDirectionUtilities.h"
#import "Wikipedia-Swift.h"

@implementation NSArray (WMFLayoutDirectionUtilities)

- (NSUInteger)wmf_startingIndexForApplicationLayoutDirection {
    return [self wmf_startingIndexForLayoutDirection:[[UIApplication sharedApplication] userInterfaceLayoutDirection]];
}

- (NSUInteger)wmf_startingIndexForLayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {
    return layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft ? self.count - 1 : 0;
}

- (instancetype)wmf_reverseArrayIfApplicationIsRTL {
    return [self wmf_reverseArrayIfRTL:[[UIApplication sharedApplication] userInterfaceLayoutDirection]];
}

- (instancetype)wmf_reverseArrayIfRTL:(UIUserInterfaceLayoutDirection)layoutDirection {
    return layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft ? [self wmf_reverseArray] : self;
}

@end

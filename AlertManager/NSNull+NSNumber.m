//
//  NSNull+NSNumber.m
//  AlertManager
//
//  Created by x.wang on 15/10/29.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import "NSNull+NSNumber.h"

@implementation NSNull (NSNumber)

- (char)charValue {
    return '\0';
}

- (unsigned char)unsignedCharValue {
    return '\0';
}

- (short)shortValue {
    return 0;
}

- (unsigned short)unsignedShortValue {
    return 0;
}

- (int)intValue {
    return 0;
}

- (unsigned int)unsignedIntValue {
    return 0;
}

- (long)longValue {
    return 0;
}

- (unsigned long)unsignedLongValue {
    return 0;
}

- (long long)longLongValue {
    return 0;
}

- (unsigned long long)unsignedLongLongValue {
    return 0;
}

- (float)floatValue {
    return 0.0;
}

- (double)doubleValue {
    return 0.0;
}

- (BOOL)boolValue {
    return NO;
}

- (NSInteger)integerValue {
    return 0;
}

- (NSUInteger)unsignedIntegerValue {
    return 0;
}

- (NSString *)stringValue {
    return nil;
}


@end

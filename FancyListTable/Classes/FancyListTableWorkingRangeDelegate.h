//
//  FancyListTableWorkingRangeDelegate.h
//  FancyListTable
//
//  Created by Stanley on 2019/1/15.
//  Copyright © 2019 FancyListTable Developer. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FancyListTableWorkingRangeDelegate <NSObject>

- (CGFloat)ratioOfWorkingRangeOnRow:(NSInteger)row;

- (void)didEnterWorkingRangeOnRow:(NSInteger)row;

- (void)didLeaveWorkingRangeOnRow:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END

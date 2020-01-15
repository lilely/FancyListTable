//
//  FancyListTableWorkingRangeHandler.m
//  FancyListTable
//
//  Created by Stanley on 2019/1/15.
//  Copyright © 2019 FancyListTable Developer. All rights reserved.
//

#import "FancyListTableWorkingRangeHelper.h"
#import "FancyListTableAdapterContext.h"
#import "FancyListTableWorkingRangeDelegate.h"
#import "FancyListTableSliceController.h"

@interface FancyListTableWorkingRangeHelper()

@property (nonatomic, strong) NSHashTable <UITableViewCell *> *workingRangeCellSet;

@property (nonatomic, strong) NSHashTable <FancyListTableSliceController *> *workingRangeDelegateSet;

@property (nonatomic, weak) id<FancyListTableAdapterContext> adapterContext;

@end

@implementation FancyListTableWorkingRangeHelper : NSObject

- (instancetype)initWithAdpaterContext:(NSObject <FancyListTableAdapterContext>*)context {
    if (self = [super init]) {
        _adapterContext = context;
    }
    return self;
}

- (void)addControllerToWorkingRange:(FancyListTableSliceController *)delegate {
    [self.workingRangeDelegateSet addObject:delegate];
}

- (void)removeControllerFromWorkingRange:(FancyListTableSliceController *)delegate {
    [self.workingRangeDelegateSet removeObject:delegate];
}

- (NSHashTable <FancyListTableSliceController *>*)workingRangeDelegateSet {
    if (!_workingRangeDelegateSet) {
        _workingRangeDelegateSet = [NSHashTable weakObjectsHashTable];
    }
    return _workingRangeDelegateSet;
}

- (NSHashTable <UITableViewCell *> *)workingRangeCellSet {
    if (!_workingRangeCellSet) {
        _workingRangeCellSet = [NSHashTable weakObjectsHashTable];
    }
    return _workingRangeCellSet;
}

- (void)updateWorkingRange {
    NSHashTable *workingRageDelegates = [self.workingRangeDelegateSet mutableCopy];
    for (FancyListTableSliceController *sliceController  in workingRageDelegates) {
        NSInteger itemCount = sliceController.numberOfItems;
        for (NSInteger i = 0; i<itemCount; i++) {
            CGFloat threshold = [sliceController ratioOfWorkingRangeOnRow:i];
            if (!threshold) {
                continue;
            }
            UITableViewCell *cell = [sliceController.adapterContext visibleCellForSliceController:sliceController atIndex:i];
                CGRect transformedRect = [cell.superview convertRect:cell.frame toView:self.adapterContext.rootView];
                CGRect intersectionRect = CGRectIntersection(self.adapterContext.rootView.bounds, transformedRect);
                BOOL inWorkingRange = NO;
                if (CGRectIsNull(intersectionRect)) {
                    inWorkingRange = NO;
                } else {
                    CGFloat converHeight = CGRectGetHeight(transformedRect);
                    if (converHeight > 0) {
                        CGFloat ratio = CGRectGetHeight(intersectionRect) / converHeight;
                        if (ratio < 1) {
                            NSLog(@"<1");
                        }
                        inWorkingRange = (ratio > threshold);
                    } else {
                        inWorkingRange = NO;
                    }
                }
                if (![self.workingRangeCellSet containsObject:cell]) {
                    if (!inWorkingRange) {
                        continue;
                    }
                    [self.workingRangeCellSet addObject:cell];
                    [sliceController didEnterWorkingRangeOnRow:i];
                } else if([self.workingRangeCellSet containsObject:cell]) {
                    if (inWorkingRange) {
                        continue;
                    }
                    [self.workingRangeCellSet removeObject:cell];
                    [sliceController didLeaveWorkingRangeOnRow:i];
                }
        }
    }
}

@end

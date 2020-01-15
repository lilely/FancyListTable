//
//  FancyListTableWorkingRangeHandler.h
//  FancyListTable
//
//  Created by Stanley on 2019/1/15.
//  Copyright © 2019 FancyListTable Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FancyListTableAdapterContext;
@protocol FancyListTableWorkingRangeDelegate;
@class FancyListTableSliceController;

@interface FancyListTableWorkingRangeHelper : NSObject

- (instancetype)initWithAdpaterContext:(NSObject<FancyListTableAdapterContext> *)context;

- (void)addControllerToWorkingRange:(FancyListTableSliceController *)delegate;

- (void)removeControllerFromWorkingRange:(FancyListTableSliceController *)delegate;

- (void)updateWorkingRange;

@end

NS_ASSUME_NONNULL_END

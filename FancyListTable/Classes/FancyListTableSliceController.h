//
//  FancyListTableSectionController.h
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import <UIKit/UIKit.h>
#import "FancyListTableAdapterContext.h"
#import "FancyListTableWorkingRangeDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface FancyListTableSliceController : NSObject<FancyListTableWorkingRangeDelegate>

@property (nonatomic,assign,readonly) NSInteger index;

@property (nonatomic,weak) id<FancyListTableAdapterContext> adapterContext;

@property (nonatomic,weak) id<FancyListTableBatchContext> batchUpdateContext;

- (instancetype)initWithLogicController:(BOOL)isLogicController NS_UNAVAILABLE;

- (NSInteger)numberOfItems;

- (CGFloat)heightOfItemAtIndex:(NSInteger)index;

- (__kindof UITableViewCell *)cellForItemAtIndex:(NSInteger)index;

- (void)bindData:(id)Object;

- (void)didSelectItemAtIndex:(NSInteger)index;
- (void)didDeselectRowAtIndex:(NSInteger)index;

- (void)willDisplayCell:(UITableViewCell *)cell atIndex:(NSInteger)index;
- (void)didEndDisplayCell:(UITableViewCell *)cell atIndex:(NSInteger)index;
- (void)willDisplayHeaderView:(UIView *)view;
- (void)willDisplayFooterView:(UIView *)view;
- (void)didEndDisplayingHeaderView:(UIView *)view;
- (void)didEndDisplayingFootView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END

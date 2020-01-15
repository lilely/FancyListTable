//
//  FancyListTableSectionController.m
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import "FancyListTableSliceController.h"
#import "FancyListTableSliceController_Internal.h"

@implementation FancyListTableSliceController

- (instancetype)init {
    if (self) {
        self.index = NSNotFound;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 0;
}

- (CGFloat)heightOfItemAtIndex:(NSInteger)index {
    return 0;
}

- (__kindof UITableViewCell *)cellForItemAtIndex:(NSInteger)index {
    return nil;
}

- (void)bindData:(id)Object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)didDeselectRowAtIndex:(NSInteger)index {
    
}

- (void)willDisplayCell:(UITableViewCell *)cell atIndex:(NSInteger)index {
    
}

- (void)didEndDisplayCell:(UITableViewCell *)cell atIndex:(NSInteger)index {
    
}

- (void)willDisplayHeaderView:(UIView *)view {
    
}

- (void)willDisplayFooterView:(UIView *)view {
    
}

- (void)didEndDisplayingHeaderView:(UIView *)view {
    
}

- (void)didEndDisplayingFootView:(UIView *)view {
    
}

- (CGFloat)ratioOfWorkingRangeOnRow:(NSInteger)row {
    return 0;
}

- (void)didEnterWorkingRangeOnRow:(NSInteger)row {
    
}


- (void)didLeaveWorkingRangeOnRow:(NSInteger)row {
    
}

@end

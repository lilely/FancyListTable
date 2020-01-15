//
//  FancyListTableAdapter+ScrollView.m
//  FancyListTable
//
//  Created by Stanley on 2019/1/15.
//  Copyright © 2019 FancyListTable Developer. All rights reserved.
//

#import "FancyListTableAdapter+ScrollView.h"
#import "FancyListTableAdapter_internal.h"

@implementation FancyListTableAdapter(ScrollView)

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollViewDelegate scrollViewDidScroll:scrollView];
    }
    
    //[self.workingRangeHandler updateWorkingRange];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.scrollViewDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.scrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    [self.workingRangeHandler updateWorkingRange];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.scrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
    [self.workingRangeHandler updateWorkingRange];
}

@end

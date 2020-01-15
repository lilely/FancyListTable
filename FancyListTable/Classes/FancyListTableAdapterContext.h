//
//  FancyListTableAdapterContext.h
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#ifndef FancyListTableAdapterContext_h
#define FancyListTableAdapterContext_h

#import <UIKit/UIKit.h>
#import "FancyListTableBatchContext.h"

@class FancyListTableSliceController;
@class FancyListTableWorkingRangeHelper;

NS_ASSUME_NONNULL_BEGIN

@protocol FancyListTableAdapterContext <NSObject>

@property (nonatomic, readonly) UIView *rootView;

- (nullable __kindof UITableViewCell *)cellForItemAtIndex:(NSInteger)index
                                        sliceController:(FancyListTableSliceController *)sliceController;

- (NSInteger)indexForCell:(UITableViewCell *)cell sectionController:(nonnull FancyListTableSliceController *)sectionController;

- (NSArray<UITableViewCell *> *)visibleCellsForSliceController:(__kindof FancyListTableSliceController *)sliceController;

- (nonnull UITableViewCell*)visibleCellForSliceController:(nonnull FancyListTableSliceController *)sliceController
                                                 atIndex:(NSInteger)index;

- (NSArray<NSIndexPath *> *)visibleIndexPathsForSliceController:(__kindof FancyListTableSliceController *)sliceController;

- (void)deselectItemAtIndex:(NSInteger)index
          sectionController:(FancyListTableSliceController *)sliceController
                   animated:(BOOL)animated;

- (void)selectItemAtIndex:(NSInteger)index
        sectionController:(FancyListTableSliceController *)sliceController
                 animated:(BOOL)animated
           scrollPosition:(UITableViewScrollPosition)scrollPosition;

- (__kindof UITableViewCell *)dequeueReusableCellOfClass:(Class)cellClass
                                    withReuseIdentifier:(nullable NSString *)reuseIdentifier
                                forSliceController:(FancyListTableSliceController *)sliceController
                                                      atIndex:(NSInteger)index;


- (__kindof UITableViewCell *)dequeueReusableCellOfClass:(Class)cellClass
                                         forSliceController:(FancyListTableSliceController *)sliceController
                                                      atIndex:(NSInteger)index;

- (void)performBatchAnimated:(BOOL)animated
                     updates:(void (^)(id<FancyListTableBatchContext> batchContext))updates
                  completion:(nullable void (^)(BOOL finished))completion;


- (void)scrollToSectionController:(FancyListTableSliceController *)sectionController
                          atIndex:(NSInteger)index
                   scrollPosition:(UITableViewScrollPosition)scrollPosition
                         animated:(BOOL)animated;

- (void)addControllerToWorkingRange:(FancyListTableSliceController *)Controller;

- (void)removeControllerFromWorkingRange:(FancyListTableSliceController *)Controller;

@end

NS_ASSUME_NONNULL_END

#endif /* FancyListTableAdapterContext_h */

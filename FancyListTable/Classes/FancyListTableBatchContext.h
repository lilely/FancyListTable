//
//  FancyListTableBatchContext.h
//  FancyListTable
//
//  Created by Stanley on 2019/1/15.
//  Copyright © 2019 FancyListTable Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FancyListTableSliceController;

NS_ASSUME_NONNULL_BEGIN

@protocol FancyListTableBatchContext<NSObject>

- (void)reloadInSliceController:(FancyListTableSliceController *)sliceController;

- (void)reloadInSliceController:(FancyListTableSliceController *)sliceController
                       atIndexes:(NSIndexSet *)indexes;

- (void)insertInSliceController:(FancyListTableSliceController *)sliceController
                        atIndexes:(NSIndexSet *)indexes
              withRowAnimation:(UITableViewRowAnimation)animation;

- (void)deleteInSliceController:(FancyListTableSliceController *)sliceController
                     atIndexes:(NSIndexSet *)indexes
              withRowAnimation:(UITableViewRowAnimation)animation;

- (void)moveInSliceController:(FancyListTableSliceController *)sliceController
                     fromIndex:(NSInteger)fromIndex
                       toIndex:(NSInteger)toIndex;
    
- (void)moveSliceControllerInteractive:(FancyListTableSliceController *)sliceController
                              fromIndex:(NSInteger)fromIndex
                                toIndex:(NSInteger)toIndex NS_AVAILABLE_IOS(9_0);

- (void)moveInSliceControllerInteractive:(FancyListTableSliceController *)sectionController
                                 fromIndex:(NSInteger)fromIndex
                                   toIndex:(NSInteger)toIndex NS_AVAILABLE_IOS(9_0);
    
@end

NS_ASSUME_NONNULL_END

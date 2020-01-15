//
//  FancyListTableAdapter+ContextIF.m
//  FancyListTable
//
//  Created by Stanley on 2019/1/15.
//  Copyright © 2019 FancyListTable Developer. All rights reserved.
//

#import "FancyListTableAdapter+ContextIF.h"

NS_INLINE NSString *createReusableViewIdentifier(Class cellClass, NSString * _Nullable nibName, NSString * _Nullable customReuseIndentifier) {
    return [NSString stringWithFormat:@"%@_%@_%@",NSStringFromClass(cellClass),nibName ?:@"NoneNib",customReuseIndentifier ?:@"gifkwai"];
}

@implementation FancyListTableAdapter(ContextIF)

- (UIView *)rootView {
    return self.tableView;
}

- (nullable __kindof UITableViewCell *)cellForItemAtIndex:(NSInteger)index sliceController:(FancyListTableSliceController *)sliceController {
    NSInteger sectionIndex = [self indexOfSliceController:sliceController];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:sectionIndex];
    return [self.tableView cellForRowAtIndexPath:indexPath];
}

- (__kindof UITableViewCell *)dequeueReusableCellOfClass:(Class)cellClass forSliceController:(FancyListTableSliceController *)sliceController atIndex:(NSInteger)index {
    NSString *identifer = createReusableViewIdentifier(cellClass,nil,nil);
    NSInteger sectionIndex = [self indexOfSliceController:sliceController];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:sectionIndex];
    if (![self.registeredCellClasses containsObject:cellClass]) {
        [self.tableView registerClass:cellClass forCellReuseIdentifier:identifer];
    }
    return [self.tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
}

- (__kindof UITableViewCell *)dequeueReusableCellOfClass:(Class)cellClass withReuseIdentifier:(nullable NSString *)reuseIdentifier forSliceController:(FancyListTableSliceController *)sliceController atIndex:(NSInteger)index { 
    NSString *identifer = createReusableViewIdentifier(cellClass,nil,reuseIdentifier);
    NSInteger sectionIndex = [self indexOfSliceController:sliceController];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:sectionIndex];
    if (![self.registeredCellClasses containsObject:cellClass]) {
        [self.tableView registerClass:cellClass forCellReuseIdentifier:identifer];
    }
    return [self.tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
}

- (void)deselectItemAtIndex:(NSInteger)index sectionController:(FancyListTableSliceController *)sliceController animated:(BOOL)animated { 
    ;
}

- (void)selectItemAtIndex:(NSInteger)index sectionController:(FancyListTableSliceController *)sliceController animated:(BOOL)animated scrollPosition:(id)scrollPosition { 
    ;
}

- (NSInteger)indexForCell:(UITableViewCell *)cell sectionController:(nonnull FancyListTableSliceController *)sectionController {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    return indexPath != nil ? indexPath.item : NSNotFound;
}

- (NSArray<UITableViewCell *> *)visibleCellsForSliceController:(FancyListTableSliceController *)sliceController {
    NSMutableArray *cells = [NSMutableArray new];
    NSArray *visibleCells = [[self.tableView visibleCells] copy];
    const NSInteger sectionIndex = [self indexOfSliceController:sliceController];
    for (UITableViewCell *cell in visibleCells) {
        if ([self.tableView indexPathForCell:cell].section == sectionIndex) {
            [cells addObject:cell];
        }
    }
    return cells;
}

- (nonnull UITableViewCell*)visibleCellForSliceController:(nonnull FancyListTableSliceController *)sliceController
                                                 atIndex:(NSInteger)index{
    NSArray *visibleCells = [[self.tableView visibleCells] copy];
    for (UITableViewCell *cell in visibleCells) {
        const NSInteger sectionIndex = [self indexOfSliceController:sliceController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if (sectionIndex != indexPath.section) {
            continue;
        }
        if (indexPath.row != index) {
            continue;
        }
        return cell;
    }
    return nil;
}

- (NSArray<NSIndexPath *> *)visibleIndexPathsForSliceController:(FancyListTableSliceController *)sliceController {
    NSMutableArray *indexPaths = [NSMutableArray new];
    NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
    const NSInteger sectionIndex = [self indexOfSliceController:sliceController];
    for (NSIndexPath *indexPath in visiblePaths) {
        if (indexPath.section == sectionIndex) {
            [indexPaths addObject:indexPath];
        }
    }
    return indexPaths;
}

- (void)performBatchAnimated:(BOOL)animated
                     updates:(void (^)(id<FancyListTableBatchContext> batchContext))updates
                  completion:(nullable void (^)(BOOL finished))completion{
    __weak __typeof__(self) weakSelf = self;
    [self.updater performUpdateWithTableView:self.tableView animated:animated itemUpdates:^{
        updates(weakSelf);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)scrollToSectionController:(nonnull FancyListTableSliceController *)sectionController atIndex:(NSInteger)index scrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    
}

- (void)addControllerToWorkingRange:(FancyListTableSliceController *)Controller {
    [self.workingRangeHandler addControllerToWorkingRange:Controller];
}

- (void)removeControllerFromWorkingRange:(FancyListTableSliceController *)Controller {
    [self.workingRangeHandler removeControllerFromWorkingRange:Controller];
}

@end

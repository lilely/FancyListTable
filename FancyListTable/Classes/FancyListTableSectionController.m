//
//  FancyListTableSectionController.m
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import "FancyListTableSectionController.h"
#import "FancyListTableBatchContext.h"
#import <UIKit/UIKit.h>

@interface FancyListTableSectionController()<FancyListTableAdapterContext,FancyListTableBatchContext>

@property (nonatomic, strong) id dataModel;

@property (nonatomic, strong) NSArray<FancyListTableSliceController *>* sliceControllers;

@property (nonatomic, strong) NSArray<FancyListTableSliceController *>* sliceControllersForMatching;

@property (nonatomic, copy) NSArray<NSNumber *> *sliceControllerOffsets;

@end

@implementation FancyListTableSectionController

- (instancetype)initWithSliceControllers:(NSArray <FancyListTableSliceController *>*)sliceControllers {
    if (self = [super init]) {
        for (FancyListTableSliceController *sliceController in sliceControllers) {
            sliceController.adapterContext = self;
            sliceController.batchUpdateContext = self;
        }
        _sliceControllers = sliceControllers;
    }
    return self;
}

- (NSInteger)numberOfItems {
    NSUInteger count = 0;
    for (FancyListTableSliceController *sliceController in self.sliceControllers) {
        count += sliceController.numberOfItems;
    }
    return count;
}

- (CGFloat)heightOfItemAtIndex:(NSInteger)index {
    if (index > self.sliceControllersForMatching.count - 1) {
        return 0;
    }
    FancyListTableSliceController *sliceController = [self.sliceControllersForMatching objectAtIndex:index];
    const NSInteger localIndex = [self localIndexOfSliceController:sliceController index:index];
    return [sliceController heightOfItemAtIndex:localIndex];
}

- (__kindof UITableViewCell *)cellForItemAtIndex:(NSInteger)index {
    if (index > self.sliceControllersForMatching.count - 1) {
        return nil;
    }
    FancyListTableSliceController *sliceController = [self.sliceControllersForMatching objectAtIndex:index];
    return [sliceController cellForItemAtIndex:[self localIndexOfSliceController:sliceController index:index]];
}

- (FancyListTableSliceController *)segmentCoumponentOfIndex:(NSInteger)index {
    if (index > self.sliceControllersForMatching.count - 1) {
        return nil;
    }
    return [self.sliceControllersForMatching objectAtIndex:index];
}

- (void)bindData:(id)Object {
    _dataModel = Object;
    for (FancyListTableSliceController *sliceController in self.sliceControllers) {
        [sliceController bindData:Object];
    }
    [self reloadData];
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    if (index > self.sliceControllersForMatching.count - 1) {
        return;
    }
    FancyListTableSliceController *sliceController = [self.sliceControllersForMatching objectAtIndex:index];
    const NSInteger localIndex = [self localIndexOfSliceController:sliceController index:index];
    [sliceController didSelectItemAtIndex:localIndex];
}

- (void)didDeselectRowAtIndex:(NSInteger)index {
    if (index > self.sliceControllersForMatching.count - 1) {
        return;
    }
    FancyListTableSliceController *sliceController = [self.sliceControllersForMatching objectAtIndex:index];
    const NSInteger localIndex = [self localIndexOfSliceController:sliceController index:index];
    [sliceController didDeselectRowAtIndex:localIndex];
}

- (void)reloadData {
    NSMutableArray *sectionControllers = [NSMutableArray new];
    NSMutableArray *offsets = [NSMutableArray new];

    NSInteger numberOfItems = 0;
    for (FancyListTableSliceController *sliceController in self.sliceControllers) {
        [offsets addObject:@(numberOfItems)];

        const NSInteger items = [sliceController numberOfItems];
        for (NSInteger i = 0; i < items; i++) {
            [sectionControllers addObject:sliceController];
        }

        numberOfItems += items;
    }
    self.sliceControllerOffsets = offsets;
    self.sliceControllersForMatching = sectionControllers;
}

- (NSInteger)offsetOfSegmentCountroller:(FancyListTableSliceController *)sliceController {
    const NSInteger index = [self.sliceControllers indexOfObject:sliceController];
    return [self.sliceControllerOffsets[index] integerValue];
}

- (NSInteger)localIndexOfSliceController:(FancyListTableSliceController *)sliceController index:(NSInteger)index {
    const NSInteger offset = [self offsetOfSegmentCountroller:sliceController];
    return index - offset;
}

- (NSIndexSet *)itemIndexesForSectionController:(FancyListTableSliceController *)sliceController indexes:(NSIndexSet *)indexes {
    const NSInteger offset = [self offsetOfSegmentCountroller:sliceController];
    NSMutableIndexSet *itemIndexes = [NSMutableIndexSet new];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [itemIndexes addIndex:(idx + offset)];
    }];
    
    return itemIndexes;
}

#pragma mark - FancyListTableAdapterContext

- (nullable __kindof UITableViewCell *)cellForItemAtIndex:(NSInteger)index sliceController:(nonnull FancyListTableSliceController *)sliceController {
    const NSInteger localIndex = [self localIndexOfSliceController:sliceController index:index];
    return [self.adapterContext cellForItemAtIndex:localIndex sliceController:self];
}

- (nonnull __kindof UITableViewCell *)dequeueReusableCellOfClass:(nonnull Class)cellClass forSliceController:(nonnull FancyListTableSliceController *)sliceController atIndex:(NSInteger)index {
    return nil;
}

- (nonnull __kindof UITableViewCell *)dequeueReusableCellOfClass:(nonnull Class)cellClass withReuseIdentifier:(nullable NSString *)reuseIdentifier forSliceController:(nonnull FancyListTableSliceController *)sliceController atIndex:(NSInteger)index {
    return nil;
}

- (void)deselectItemAtIndex:(NSInteger)index sectionController:(nonnull FancyListTableSliceController *)sliceController animated:(BOOL)animated {
    return;
}

- (void)selectItemAtIndex:(NSInteger)index sectionController:(nonnull FancyListTableSliceController *)sliceController animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
    return;
}

- (nonnull NSArray<UITableViewCell *> *)visibleCellsForSliceController:(nonnull FancyListTableSliceController *)sliceController {
    NSMutableArray *cells = [NSMutableArray new];
    id<FancyListTableAdapterContext> tableContext = self.adapterContext;
    NSArray *visibleCells = [tableContext visibleCellsForSliceController:self];
    for (UITableViewCell *cell in visibleCells) {
        const NSInteger index = [tableContext indexForCell:cell sectionController:self];
        if (self.sliceControllersForMatching[index] == sliceController) {
            [cells addObject:cell];
        }
    }
    return cells;
}

- (nonnull UITableViewCell*)visibleCellForSliceController:(nonnull FancyListTableSliceController *)sliceController
                                                 atIndex:(NSInteger)index {
    id<FancyListTableAdapterContext> tableContext = self.adapterContext;
    NSArray *visibleCells = [tableContext visibleCellsForSliceController:self];
    for (UITableViewCell *cell in visibleCells) {
        const NSInteger cellIndex = [tableContext indexForCell:cell sectionController:self];
        if (cellIndex != index) {
            continue;
        }
        if (self.sliceControllersForMatching[cellIndex] == sliceController) {
            return cell;
        }
    }
    return nil;
}

- (nonnull NSArray<NSIndexPath *> *)visibleIndexPathsForSliceController:(nonnull FancyListTableSliceController *)sliceController {
    return nil;
}

- (NSInteger)indexForCell:(nonnull UITableViewCell *)cell sectionController:(nonnull FancyListTableSliceController *)sectionController {
    return [self.adapterContext indexForCell:cell sectionController:sectionController];
}

- (void)performBatchAnimated:(BOOL)animated updates:(nonnull void (^)(id<FancyListTableBatchContext> _Nonnull))updates completion:(nullable void (^)(BOOL))completion {
    __weak __typeof__(self) weakSelf = self;
    [self.adapterContext performBatchAnimated:animated updates:^(id<FancyListTableBatchContext>  _Nonnull batchContext) {
        self.batchUpdateContext = batchContext;
        updates(weakSelf);
        self.batchUpdateContext = nil;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)scrollToSectionController:(nonnull FancyListTableSliceController *)sectionController atIndex:(NSInteger)index scrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    
}

- (void)addControllerToWorkingRange:(FancyListTableSliceController *)Controller {
    [self.adapterContext addControllerToWorkingRange:Controller];
}

- (void)removeControllerFromWorkingRange:(FancyListTableSliceController *)Controller {
    [self.adapterContext removeControllerFromWorkingRange:Controller];
}

#pragma mark - Working rage delegate

- (CGFloat)ratioOfWorkingRangeOnRow:(NSInteger)row {
    if (row > self.sliceControllersForMatching.count - 1) {
        return 0.;
    }
    FancyListTableSliceController *sliceController = [self.sliceControllersForMatching objectAtIndex:row];
    if ([sliceController conformsToProtocol:@protocol(FancyListTableWorkingRangeDelegate)]) {
        NSInteger localIndex = [self localIndexOfSliceController:sliceController index:row];
        return [sliceController ratioOfWorkingRangeOnRow:localIndex];
    }
    return 0;
}

- (void)didEnterWorkingRangeOnRow:(NSInteger)row {
    if (row > self.sliceControllersForMatching.count - 1) {
        return;
    }
    FancyListTableSliceController *sliceController = [self.sliceControllersForMatching objectAtIndex:row];
    if ([sliceController conformsToProtocol:@protocol(FancyListTableWorkingRangeDelegate)]) {
        NSInteger localIndex = [self localIndexOfSliceController:sliceController index:row];
        [sliceController didEnterWorkingRangeOnRow:localIndex];
    }
}

- (void)didLeaveWorkingRangeOnRow:(NSInteger)row {
    if (row > self.sliceControllersForMatching.count - 1) {
        return;
    }
    FancyListTableSliceController *sliceController = [self.sliceControllersForMatching objectAtIndex:row];
    if ([sliceController conformsToProtocol:@protocol(FancyListTableWorkingRangeDelegate)]) {
        NSInteger localIndex = [self localIndexOfSliceController:sliceController index:row];
        [sliceController didLeaveWorkingRangeOnRow:localIndex];
    }
}

#pragma mark - Override

- (void)willDisplayCell:(UITableViewCell *)cell atIndex:(NSInteger)index {
    FancyListTableSliceController *sliceController = [self segmentCoumponentOfIndex:index];
    [sliceController willDisplayCell:cell atIndex:index];
    if ([sliceController ratioOfWorkingRangeOnRow:index]) {
        [self.adapterContext addControllerToWorkingRange:sliceController];
    }
}

- (void)didEndDisplayCell:(UITableViewCell *)cell atIndex:(NSInteger)index {
    FancyListTableSliceController *sliceController = [self segmentCoumponentOfIndex:index];
    [sliceController didEndDisplayCell:cell atIndex:index];
    if ([sliceController ratioOfWorkingRangeOnRow:index]) {
        [self.adapterContext removeControllerFromWorkingRange:sliceController];
    }
}

- (void)willDisplayHeaderView:(UIView *)view {
    [self willDisplayHeaderView:view];
}

- (void)willDisplayFooterView:(UIView *)view {
    [self willDisplayFooterView:view];
}

- (void)didEndDisplayingHeaderView:(UIView *)view {
    [self didEndDisplayingHeaderView:view];
}

- (void)didEndDisplayingFootView:(UIView *)view {
    [self didEndDisplayingFootView:view];
}

#pragma mark - FancyListTableBatchContext

- (void)reloadInSliceController:(FancyListTableSliceController *)sliceController
                       atIndexes:(NSIndexSet *)indexes {
    NSIndexSet *itemIndexes = [self itemIndexesForSectionController:sliceController indexes:indexes];
    [self.batchUpdateContext reloadInSliceController:self atIndexes:itemIndexes];
}

- (void)insertInSliceController:(FancyListTableSliceController *)sliceController
                       atIndexes:(NSIndexSet *)indexes
                withRowAnimation:(UITableViewRowAnimation)animation{
    NSIndexSet *itemIndexes = [self itemIndexesForSectionController:sliceController indexes:indexes];
    [self.batchUpdateContext insertInSliceController:self atIndexes:itemIndexes withRowAnimation:animation];
}

- (void)deleteInSliceController:(FancyListTableSliceController *)sliceController
                     atIndexes:(NSIndexSet *)indexes
              withRowAnimation:(UITableViewRowAnimation)animation{
    NSIndexSet *itemIndexes = [self itemIndexesForSectionController:sliceController indexes:indexes];
    [self.batchUpdateContext deleteInSliceController:self atIndexes:itemIndexes withRowAnimation:animation];
}

- (void)moveInSliceController:(FancyListTableSliceController *)sliceController
                     fromIndex:(NSInteger)fromIndex
                       toIndex:(NSInteger)toIndex {
    [self.batchUpdateContext moveInSliceController:self fromIndex:fromIndex toIndex:toIndex];
}

- (void)reloadInSliceController:(nonnull FancyListTableSliceController *)sliceController {
    [self.batchUpdateContext reloadInSliceController:sliceController];
}

- (void)moveSliceControllerInteractive:(FancyListTableSliceController *)sliceController
                              fromIndex:(NSInteger)fromIndex
                                toIndex:(NSInteger)toIndex NS_AVAILABLE_IOS(9_0) {
    [self.batchUpdateContext moveInSliceControllerInteractive:self fromIndex:fromIndex toIndex:toIndex];
}

- (void)moveInSliceControllerInteractive:(FancyListTableSliceController *)sliceController
                                 fromIndex:(NSInteger)fromIndex
                                   toIndex:(NSInteger)toIndex NS_AVAILABLE_IOS(9_0) {
    [self.batchUpdateContext moveInSliceControllerInteractive:sliceController
                                                          fromIndex:fromIndex
                                                            toIndex:toIndex];
}

@synthesize rootView;

@end

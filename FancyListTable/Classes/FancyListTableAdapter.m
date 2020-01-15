//
//  FancyListTableAdapter.m
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import "FancyListTableAdapter.h"
#import "FancyListTableSectionController.h"
#import "FancyListTableAdapter+TableView.h"
#import "FancyListTableDataCenter.h"
#import "FancyListTableAdapter_internal.h"
#import "FancyListTableAdapter+ContextIF.h"
#import "FancyListTableWorkingRangeHelper.h"
#import "FancyListTableBatchContext.h"
#import "FancyListTableUpdater.h"
#import "FancyListTableSliceController_Internal.h"

@interface FancyListTableAdapter()<FancyListTableBatchContext>

@property (nonatomic) NSMapTable<UITableViewCell *, FancyListTableSliceController *> *viewSectionControllerMap;

@end

@implementation FancyListTableAdapter

- (instancetype)initWithViewController:(UIViewController<FancyListTableAdapterDataSource> *)viewController{
    if (self = [super init]) {
        _viewSectionControllerMap = [NSMapTable mapTableWithKeyOptions:NSMapTableObjectPointerPersonality | NSMapTableStrongMemory
        valueOptions:NSMapTableStrongMemory];
        //self.updater = [[FancyListTableReloadUpdater alloc] init];
        self.updater = [[FancyListTableUpdater alloc] init];
        self.viewController = viewController;
        self.dataSource = viewController;
    }
    return self;
}

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)updateObjects:(NSArray *)objects {
    if (!objects) {
        return;
    }
    NSMutableArray *sections = [NSMutableArray new];
    [objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FancyListTableSectionController *sectionController = [self.dataSource tableViewAdapter:self sectionControllerForObject:obj];
        sectionController.adapterContext = self;
        [sectionController bindData:obj];
        sectionController.index = idx;
        [sections addObject:sectionController];
        [self.dataCenter setSectionController:sectionController forIndex:idx];
    }];
    [self.dataCenter setObjects:objects forSections:sections];
}

- (void)reloadData {
    NSArray *objects;
    if ([self.dataSource respondsToSelector:@selector(objectsForAdapter:)]) {
        objects = [self.dataSource objectsForAdapter:self];
    }
    [self updateObjects:objects];
    [self.tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.workingRangeHandler updateWorkingRange];
    });
}

- (void)reloadDataWithCompletion:(void (^)(BOOL finished))complete {
    id<FancyListTableAdapterDataSource> dataSource = self.dataSource;
    UITableView *tableView = self.tableView;
    if (!dataSource || !tableView) {
        if (complete) {
            complete(NO);
        }
        return;
    }
    NSArray *objects = [dataSource objectsForAdapter:self];
    __weak __typeof__(self) weakSelf = self;
    [self.updater reloadDataWithTableView:tableView reloadUpdateBlock:^{
        [weakSelf.dataCenter reset];
        [weakSelf updateObjects:objects];
    } completion:^(BOOL finished) {
        if (complete) {
            complete(finished);
        }
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.workingRangeHandler updateWorkingRange];
    });
}

- (void)mapCell:(UITableViewCell *)cell toSliceController:(FancyListTableSliceController *)sliceController {
    [_viewSectionControllerMap setObject:sliceController forKey:cell];
}

- (void)removeCellToSliceController:(UITableViewCell *)cell {
    [_viewSectionControllerMap removeObjectForKey:cell];
}

- (FancyListTableSliceController *)sliceControllerForCell:(UITableViewCell *)cell {
    return [_viewSectionControllerMap objectForKey:cell];
}

- (NSInteger)indexOfSliceController:(FancyListTableSliceController *)Controller {
    return [self.dataCenter indexOfSliceController:Controller];
}

#pragma mark - Getter&Setter

- (FancyListTableDataCenter *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = [[FancyListTableDataCenter alloc] init];
    }
    return _dataCenter;
}

- (FancyListTableWorkingRangeHelper *)workingRangeHandler {
    if (!_workingRangeHandler) {
        _workingRangeHandler = [[FancyListTableWorkingRangeHelper alloc] initWithAdpaterContext:self];
    }
    return _workingRangeHandler;
}

#pragma mark - FancyListTableBatchContext

- (void)deleteInSliceController:(nonnull FancyListTableSliceController *)sliceController
                       atIndexes:(nonnull NSIndexSet *)indexes
                withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSUInteger section = [self indexOfSliceController:sliceController];
    if (section == NSNotFound) {
        return;
    }
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:section]];
    }];
    [self.updater deleteItemsFromTableView:self.tableView
                                indexPaths:indexPaths
                          withRowAnimation:animation];
}

- (void)insertInSliceController:(nonnull FancyListTableSliceController *)sliceController atIndexes:(nonnull NSIndexSet *)indexes withRowAnimation:(UITableViewRowAnimation)animation{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSUInteger section = [self indexOfSliceController:sliceController];
    if (section == NSNotFound) {
        return;
    }
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:section]];
    }];
    [self.updater insertItemsIntoTableView:self.tableView indexPaths:indexPaths withRowAnimation:animation];
}

- (void)moveInSliceController:(nonnull FancyListTableSliceController *)sliceController fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSUInteger section = [self indexOfSliceController:sliceController];
    if (section == NSNotFound) {
        return;
    }
    NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow:fromIndex inSection:section];
    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:toIndex inSection:section];
    if (!fromIndexPath || !toIndexPath) {
        return;
    }
    [self.updater reloadItemInTableView:self.tableView fromIndexPath:fromIndexPath toIndexPath:toIndexPath];
}

- (void)reloadInSliceController:(nonnull FancyListTableSliceController *)sliceController {
    NSUInteger section = [self indexOfSliceController:sliceController];
    if (section == NSNotFound) {
        return;
    }
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:section];
    [self.updater reloadTableView:self.tableView sections:indexes];
}

- (void)reloadInSliceController:(nonnull FancyListTableSliceController *)sliceController atIndexes:(nonnull NSIndexSet *)indexes {
    NSUInteger section = [self indexOfSliceController:sliceController];
    if (section == NSNotFound) {
        return;
    }
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow:idx inSection:section];
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:idx inSection:section];
        // index paths could be nil if a section controller is prematurely reloading or a reload was batched with
        // the section controller being deleted
        if (fromIndexPath != nil && toIndexPath != nil) {
            [self.updater reloadItemInTableView:self.tableView fromIndexPath:fromIndexPath toIndexPath:toIndexPath];
        }
    }];
}

- (void)moveInSliceControllerInteractive:(nonnull FancyListTableSliceController *)sectionController fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    return;
}


- (void)moveSliceControllerInteractive:(nonnull FancyListTableSliceController *)sliceController fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    return;
}


- (void)reloadSliceController:(nonnull FancyListTableSliceController *)sliceController {
    NSUInteger section = [self indexOfSliceController:sliceController];
    if (section == NSNotFound) {
        return;
    }
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self.updater reloadTableView:self.tableView sections:sections];
}

@end

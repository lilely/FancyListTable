//
//  FancyListTableUpdater.m
//  FancyListTable
//
//  Created by Stanley on 2020/1/2.
//  Copyright © 2020 FancyListTable Developer. All rights reserved.
//

#import "FancyListTableUpdater.h"

@implementation FancyListTableUpdater

- (void)insertItemsIntoTableView:(UITableView *)tableView indexPaths:(NSArray <NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)deleteItemsFromTableView:(UITableView *)tableView
                      indexPaths:(NSArray <NSIndexPath *> *)indexPaths
                withRowAnimation:(UITableViewRowAnimation)animation{
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)moveItemInTableView:(UITableView *)tableView
              fromIndexPath:(NSIndexPath *)fromIndexPath
                toIndexPath:(NSIndexPath *)toIndexPath {
    [tableView moveRowAtIndexPath:fromIndexPath toIndexPath:fromIndexPath];
}

- (void)reloadItemInTableView:(UITableView *)tableView
                fromIndexPath:(NSIndexPath *)fromIndexPath
                  toIndexPath:(NSIndexPath *)toIndexPath {
    [self synchronousReloadTableView:tableView];
}

- (void)moveSectionInTableView:(UITableView *)tableView
                     fromIndex:(NSInteger)fromIndex
                       toIndex:(NSInteger)toIndex {
    [tableView moveSection:fromIndex toSection:toIndex];
}
    
- (void)reloadDataWithTableView:(UITableView *)tableView
              reloadUpdateBlock:(listTableReloadUpdateBlock)reloadUpdateBlock
                     completion:(nullable listTableUpdatingCompletion)completion {
    if (reloadUpdateBlock) {
        reloadUpdateBlock();
    }
    if (completion) {
        completion(YES);
    }
    [tableView reloadData];
}

- (void)reloadTableView:(UITableView *)tableView sections:(NSIndexSet *)sections {
    [tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)performUpdateWithTableView:(UITableView *)tableView
                          animated:(BOOL)animated
                       itemUpdates:(listTableReloadUpdateBlock)itemUpdates
                        completion:(nullable listTableUpdatingCompletion)completion {
    if (animated) {
        [tableView beginUpdates];
        if (itemUpdates) {
            itemUpdates();
        }
        [tableView endUpdates];
    } else {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if (itemUpdates) {
            itemUpdates();
        }
        [CATransaction commit];
    }
    if (completion) {
        completion(YES);
    }
}

#pragma mark - Private

- (void)synchronousReloadTableView:(UITableView *)tableView {
    [tableView reloadData];
    [tableView layoutIfNeeded];
}

@end

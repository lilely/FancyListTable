//
//  FancyListTableUpdateDelegate.h
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^listTableReloadUpdateBlock)(void);

typedef void (^listTableUpdatingCompletion)(BOOL finished);

@protocol FancyListTableUpdateDelegate <NSObject>

- (void)insertItemsIntoTableView:(UITableView *)tableView
                      indexPaths:(NSArray <NSIndexPath *> *)indexPaths
                withRowAnimation:(UITableViewRowAnimation)animation;

- (void)deleteItemsFromTableView:(UITableView *)tableView
                      indexPaths:(NSArray <NSIndexPath *> *)indexPaths
                withRowAnimation:(UITableViewRowAnimation)animation;

- (void)moveItemInTableView:(UITableView *)tableView
              fromIndexPath:(NSIndexPath *)fromIndexPath
                toIndexPath:(NSIndexPath *)toIndexPath;

- (void)reloadItemInTableView:(UITableView *)tableView
                fromIndexPath:(NSIndexPath *)fromIndexPath
                  toIndexPath:(NSIndexPath *)toIndexPath;

- (void)moveSectionInTableView:(UITableView *)tableView
                     fromIndex:(NSInteger)fromIndex
                       toIndex:(NSInteger)toIndex;
    
- (void)reloadDataWithTableView:(UITableView *)tableView
              reloadUpdateBlock:(listTableReloadUpdateBlock)reloadUpdateBlock
                     completion:(nullable listTableUpdatingCompletion)completion;

- (void)reloadTableView:(UITableView *)tableView sections:(NSIndexSet *)sections;

- (void)performUpdateWithTableView:(UITableView *)tableView
                          animated:(BOOL)animated
                       itemUpdates:(listTableReloadUpdateBlock)itemUpdates
                        completion:(nullable listTableUpdatingCompletion)completion;

@end

NS_ASSUME_NONNULL_END

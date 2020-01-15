//
//  FancyListTableAdapter.h
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import <Foundation/Foundation.h>
#import "FancyListTableAdapterDataSource.h"
#import "FancyListTableAdapterDelegate.h"
#import "FancyListTableUpdateDelegate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FancyListTableAdapter : NSObject

@property (nonatomic, nullable, weak) UITableView *tableView;

@property (nonatomic, nullable, weak) UIViewController *viewController;

@property (nonatomic, nullable, weak) id <FancyListTableAdapterDelegate> delegate;

@property (nonatomic, nullable, weak) id <FancyListTableAdapterDataSource> dataSource;

@property (nonatomic, nullable, weak) id <UITableViewDelegate> tableViewDelegate;

@property (nonatomic, nullable, weak) id <UIScrollViewDelegate> scrollViewDelegate;

@property (nonatomic, nullable, strong) id <FancyListTableUpdateDelegate> updater;

- (instancetype)initWithViewController:(UIViewController<FancyListTableAdapterDataSource> *)viewController;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END

//
//  FancyListTableController.m
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import "FancyListTableController.h"
#import "FancyListTableSectionController.h"

@interface FancyListTableController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) FancyListTableAdapter *adapter;

@end

@implementation FancyListTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self adapter];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (NSArray<id> *)objectsForAdapter:(FancyListTableAdapter *)adapter {
    return nil;
}

- (FancyListTableSectionController *)tableViewAdapter:(FancyListTableAdapter *)adapter sectionControllerForObject:(id)object {
    return nil;
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
        _tableView.backgroundView = nil;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (FancyListTableAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[FancyListTableAdapter alloc] initWithViewController:self];
        _adapter.dataSource = self;
        _adapter.tableView = self.tableView;
        _adapter.scrollViewDelegate = self;
    }
    return _adapter;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

@end

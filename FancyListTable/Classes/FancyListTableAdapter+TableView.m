//
//  FancyListTableAdapter+UITableView.m
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import "FancyListTableAdapter+TableView.h"
#import "FancyListTableAdapter_internal.h"
#import "FancyListTableSectionController.h"
#import "FancyListTableSliceController.h"

@implementation FancyListTableAdapter(TableView)

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:indexPath.section];
    [sliceController willDisplayCell:cell atIndex:indexPath.row];
    if ([sliceController conformsToProtocol:@protocol(FancyListTableWorkingRangeDelegate)] &&
        [sliceController ratioOfWorkingRangeOnRow:indexPath.row]) {
        [self.workingRangeHandler addControllerToWorkingRange:sliceController];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:indexPath.section];
    [sliceController didEndDisplayCell:cell atIndex:indexPath.row];
    if ([sliceController conformsToProtocol:@protocol(FancyListTableWorkingRangeDelegate)] &&
        [sliceController ratioOfWorkingRangeOnRow:indexPath.row]) {
        [self.workingRangeHandler removeControllerFromWorkingRange:sliceController];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:section];
    [sliceController willDisplayHeaderView:view];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:section];
    [sliceController willDisplayFooterView:view];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:section];
    [sliceController didEndDisplayingHeaderView:view];

}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:section];
    [sliceController didEndDisplayingFootView:view];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:indexPath.section];
    return [sliceController heightOfItemAtIndex:indexPath.row];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:indexPath.section];
    [sliceController didSelectItemAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:indexPath.section];
    [sliceController didDeselectRowAtIndex:indexPath.row];
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:indexPath.section];
    UITableViewCell *cell = [sliceController cellForItemAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FancyListTableSliceController *sliceController = [self.dataCenter sectionControllerForIndex:section];
    return [sliceController numberOfItems];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataCenter.objects.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end

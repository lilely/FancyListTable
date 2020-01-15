//
//  FancyListTableAdapterDataSource.h
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#ifndef FancyListTableAdapterDataSource_h
#define FancyListTableAdapterDataSource_h

@class FancyListTableAdapter;
@class FancyListTableSectionController;

@protocol FancyListTableAdapterDataSource<NSObject>

@required

- (FancyListTableSectionController *)tableViewAdapter:(FancyListTableAdapter *)adapter sectionControllerForObject:(id)object;

- (NSArray<id> *)objectsForAdapter:(FancyListTableAdapter *)adapter;

@end

#endif /* FancyListTableAdapterDataSource_h */

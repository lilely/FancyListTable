//
//  FancyListTableSectionDataCenter.h
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FancyListTableSliceController;

@interface FancyListTableDataCenter : NSObject

@property (nonatomic, strong, readonly) NSArray *objects;

- (instancetype)initWithMapTable:(NSMapTable *)mapTable;

- (void)setObjects:(NSArray * _Nonnull)objects forSections:(NSMutableArray <FancyListTableSliceController *>*)sections;

- (void)reset;

- (FancyListTableSliceController *)sectionControllerForIndex:(NSInteger)index;

- (void)setSectionController:(FancyListTableSliceController *)sectionController forIndex:(NSInteger)index;

- (NSInteger)indexOfSliceController:(FancyListTableSliceController *)Controller;

@end

NS_ASSUME_NONNULL_END

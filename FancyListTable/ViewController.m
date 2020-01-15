//
//  ViewController.m
//  FancyListTable
//
//  Created by Stanley on 2020/1/15.
//  Copyright © 2020 星金. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray<id> *)objectsForAdapter:(FancyListTableAdapter *)adapter {
    return nil;
}

- (FancyListTableSectionController *)tableViewAdapter:(FancyListTableAdapter *)adapter sectionControllerForObject:(id)object {
    return nil;
}

@end

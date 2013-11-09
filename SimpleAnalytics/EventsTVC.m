//
//  EventsTVC.m
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import "EventsTVC.h"

#import "EPAnalytics.h"
#import "EPMessage.h"
#import "EventCell.h"
#import "EPConstants.h"

@interface EventsTVC () <EPAnalyticsDelegate>

@property (nonatomic, strong) EPAnalytics *analytics;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation EventsTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.analytics = [EPAnalytics sharedInstance];
    self.analytics.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"M-dd-yyyy h:mm a"];
}


#pragma mark - VMAnalyticsDelegate methods

- (void)messagesWereUpdated
{
    [self.tableView reloadData];
    NSInteger row = [[self.analytics messages] count] -1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.analytics messages] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    EPMessage *message = (EPMessage *)[self.analytics messages][indexPath.row];
    
    cell.eventNameLabel.text = message.eventName;
    cell.eventDateLabel.text = [self.dateFormatter stringFromDate:message.eventDate];
    cell.eventStatusLabel.text = EPMessageStatusForDisplay[message.status];
    [cell updateStatusColor];
    
    return cell;
}

@end

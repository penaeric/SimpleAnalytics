//
//  EventCell.h
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

@interface EventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventStatusLabel;

/** Draws a circle with different color depending on the current Message Status
 */
- (void)updateStatusColor;

@end

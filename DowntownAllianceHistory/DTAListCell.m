//
//  DTAListCell.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 8/11/14.
//
//

#import "DTAListCell.h"

@implementation DTAListCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    self.listLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.listLabel.frame);
}

@end

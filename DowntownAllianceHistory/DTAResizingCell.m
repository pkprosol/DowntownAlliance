//
//  DTAResizingCell.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 8/8/14.
//
//

#import "DTAResizingCell.h"

@implementation DTAResizingCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    self.lineLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.lineLabel.frame);
}

@end

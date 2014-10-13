//
//  DTADecadeCell.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 7/30/14.
//
//

#import "DTAFilterCell.h"

@implementation DTAFilterCell

- (void)awakeFromNib
{
    self.filterCellImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

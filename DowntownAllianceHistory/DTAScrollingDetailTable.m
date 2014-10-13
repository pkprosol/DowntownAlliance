//
//  DTAScrollingDetailTable.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 8/6/14.
//
//

#import "DTAScrollingDetailTable.h"

@implementation DTAScrollingDetailTable

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id hitView = [super hitTest:point withEvent:event];
    if (point.y < 0) {
        return nil;
    }
    return hitView;
}

@end

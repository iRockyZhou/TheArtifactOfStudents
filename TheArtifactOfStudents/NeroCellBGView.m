//
//  NeroCellBGView.m
//  
//
//  Created by 谭峻强 on 15/8/9.
//
//

#import "NeroCellBGView.h"

@implementation NeroCellBGView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef startColor = [UIColor colorWithRed:243.0f/255.0 green:243.0f/255.0 blue:243.0f/255.0 alpha:1.0].CGColor;
    CGColorRef endColor = [UIColor colorWithRed:249.0f/255.0 green:249.0f/255.0 blue:249.0f/255.0 alpha:1.0].CGColor;
    CGRect paperRect = self.bounds;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,(CFArrayRef) colors, locations);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(paperRect), CGRectGetMinY(paperRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(paperRect), CGRectGetMaxY(paperRect));
    CGContextSaveGState(context);
    CGContextAddRect(context, paperRect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}
@end

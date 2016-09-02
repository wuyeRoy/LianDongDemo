//
//  UIView+Extension.m
//  iHealth
//
//  Created by WYRoy on 16/8/16.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(float)X
{
    CGRect Frame = self.frame;
    Frame.origin.x = X;
    self.frame = Frame;
}
- (void)setY:(float)Y
{
    CGRect Frame = self.frame;
    Frame.origin.y = Y;
    self.frame = Frame;
}
- (void)setWidth:(float)Width
{
    CGRect Frame = self.frame;
    Frame.size.width = Width;
    self.frame = Frame;
}
- (void)setHeight:(float)Height
{
    CGRect Frame = self.frame;
    Frame.size.height = Height;
    self.frame = Frame;
}
- (void)setMaxX:(float)MaxX
{
    self.X = MaxX - self.Width;
}
- (void)setMaxY:(float)MaxY
{
    self.Y = MaxY - self.Height;
}
- (void)setCenterX:(float)CenterX
{
    CGPoint Center = self.center;
    Center.x = CenterX;
    self.center = Center;
}
- (void)setCenterY:(float)CenterY
{
    CGPoint Center = self.center;
    Center.y = CenterY;
    self.center = Center;
}
- (void)setSize:(CGSize)Size
{
    CGRect Frame = self.frame;
    Frame.size = Size;
    self.frame = Frame;
}

- (float)X
{
    return self.frame.origin.x;
}
- (float)Y
{
    return self.frame.origin.y;
}
- (float)Width
{
    return self.frame.size.width;
}
- (float)Height
{
    return self.frame.size.height;
}
-(float)MaxX
{
    return CGRectGetMaxX(self.frame);
}
-(float)MaxY
{
    return CGRectGetMaxY(self.frame);
}
- (float)CenterX
{
    return self.center.x;
}
- (float)CenterY
{
    return self.center.y;
}
- (CGSize)Size
{
    return self.frame.size;
}
@end

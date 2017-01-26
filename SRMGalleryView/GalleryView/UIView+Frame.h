//
//  UIView+Frame.h
//  SRMNews
//
//  Created by marksong on 24/01/2017.
//  Copyright © 2017 S.R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)originX;
- (CGFloat)originY;
- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;
- (void)setOrigin:(CGPoint)origin;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setSize:(CGSize)size;

@end

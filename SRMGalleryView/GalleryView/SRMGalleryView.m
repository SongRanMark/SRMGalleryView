//
//  SRMGalleryView.m
//  SRMNews
//
//  Created by marksong on 23/01/2017.
//  Copyright © 2017 S.R. All rights reserved.
//

#import "SRMGalleryView.h"
#import "UIView+Constraint.h"
#import "UIView+Frame.h"

@interface SRMGalleryView () <UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *leftContainerView;
@property (nonatomic) UIView *centerContainerView;
@property (nonatomic) UIView *rightContainerView;
@property (nonatomic) NSArray *resourceArray;
@property (nonatomic) NSUInteger currentIndex;

@end

@implementation SRMGalleryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeScrollView];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeScrollView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame resources:(NSArray *)resources {
    if (self = [self initWithFrame:frame]) {
        [self loadResources:resources];
    }
    
    return self;
}

- (void)loadResources:(NSArray *)resources {
    self.resourceArray = resources;
    [self setContainerViewWithResourcesCount:resources.count];
    [self setContentOffsetWithResourcesCount:resources.count];
    [self showResourceAtIndex:0];
}

- (void)showResourceAtIndex:(NSUInteger)index {
    NSInteger count= self.resourceArray.count;
    NSInteger lastIndex = (index - 1 + count) % count;
    NSInteger nextIndex = (index + 1) % count;
    self.currentIndex = index;
    
    if (count == 1) {
        [self containerView:self.centerContainerView addContentView:self.resourceArray[0]];
    } else if (count == 2) {
        UIView *nextViewCopy = [self copyView:self.resourceArray[nextIndex]];
        [self containerView:self.leftContainerView addContentView:nextViewCopy];
        [self containerView:self.centerContainerView addContentView:self.resourceArray[index]];
        [self containerView:self.rightContainerView addContentView:self.resourceArray[nextIndex]];
    } else if (count == 3) {
        [self containerView:self.leftContainerView addContentView:self.resourceArray[lastIndex]];
        [self containerView:self.centerContainerView addContentView:self.resourceArray[index]];
        [self containerView:self.rightContainerView addContentView:self.resourceArray[nextIndex]];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger count= self.resourceArray.count;
    NSInteger index= self.currentIndex;
    
    if (scrollView.contentOffset.x < [self width]) {
        [self showResourceAtIndex:(index - 1 + count) % count];
    } else if (scrollView.contentOffset.x > [self width]) {
        [self showResourceAtIndex:(index + 1) % count];
    }
    
    self.scrollView.contentOffset = CGPointMake([self width], 0);
}

#pragma mark - Private

- (void)initializeScrollView {
    [self addSubview:self.scrollView];
    [self.scrollView addEdgesConstraintsEqualToView:self];
}

- (void)setContainerViewWithResourcesCount:(NSInteger)count {
    [self clearSubviewsOfView:self.scrollView];
    
    if (count == 1) {
        [self.scrollView addSubview:self.centerContainerView];
        [self.centerContainerView addSizeConstraintsEqualToView:self.scrollView];
        [self.centerContainerView addEdgesConstraintsEqualToView:self.scrollView];
    } else if (count >= 2) {
        [self.scrollView addSubview:self.leftContainerView];
        [self.scrollView addSubview:self.centerContainerView];
        [self.scrollView addSubview:self.rightContainerView];
        [self.leftContainerView addSizeConstraintsEqualToView:self.scrollView];
        [self.leftContainerView addLeadingConstraintEqualToView:self.scrollView];
        [self.leftContainerView addTopConstraintEqualToView:self.scrollView];
        [self.leftContainerView addBottomConstraintEqualToView:self.scrollView];
        [self.centerContainerView addSizeConstraintsEqualToView:self.scrollView];
        [self.centerContainerView addConstraintNextToViewHorizontally:self.leftContainerView];
        [self.rightContainerView addSizeConstraintsEqualToView:self.scrollView];
        [self.rightContainerView addConstraintNextToViewHorizontally:self.centerContainerView];
        [self.rightContainerView addTrailingConstraintEqualToView:self.scrollView];
    }
}

- (void)setContentOffsetWithResourcesCount:(NSInteger)count {
    if (count == 1) {
        self.scrollView.contentOffset = CGPointZero;
    } else if (count >= 2) {
        self.scrollView.contentOffset = CGPointMake([self width], 0);
        // contentSize 本身可通过约束自动计算出正确值，但晚于 contentOffset 的渲染，而这会影响
        // contentOffset 的正确显示，所以还是要预先设置 contentSize 的值。
        self.scrollView.contentSize = CGSizeMake([self width] * 3, 0);
    }
}

- (void)containerView:(UIView *)containerView addContentView:(UIView *)contentView {
    [self clearSubviewsOfView:containerView];
    [containerView addSubview:contentView];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addEdgesConstraintsEqualToView:containerView];
}

- (void)clearSubviewsOfView:(UIView *)view {
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (UIView *)copyView:(UIView *)view {
    NSData * viewData = [NSKeyedArchiver archivedDataWithRootObject:view];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:viewData];
}

#pragma mark - Setter

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setContentOffsetWithResourcesCount:self.resourceArray.count];
}

#pragma mark - Getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _scrollView;
}

- (UIView *)centerContainerView {
    if (!_centerContainerView) {
        _centerContainerView = [self newContainerView];
    }
    
    return _centerContainerView;
}

- (UIView *)leftContainerView {
    if (!_leftContainerView) {
        _leftContainerView = [self newContainerView];
    }
    
    return _leftContainerView;
}

- (UIView *)rightContainerView {
    if (!_rightContainerView) {
        _rightContainerView = [self newContainerView];
    }
    
    return _rightContainerView;
}

- (UIView *)newContainerView {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectZero];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    return containerView;
}

@end

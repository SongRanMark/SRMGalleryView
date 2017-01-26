//
//  SRMGalleryView.h
//  SRMNews
//
//  Created by marksong on 23/01/2017.
//  Copyright © 2017 S.R. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 图片或视图资源的轮播视图组件。
 */
@interface SRMGalleryView : UIView

// 资源是否循环显示，默认为 YES。
@property (nonatomic) BOOL shouldCycle;
// 是否显示分页控制器，默认为 NO。
@property (nonatomic) BOOL shouldShowPageControl;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
/**
 初始化时加载轮播资源，当希望修改轮播的内容时，可调用方法[- loadResources:]。resources 支持
 的类型包括 UIView, UIImage, 描述图片资源 URL 的 NSString。可同时包括不同的数据类型。
 */
- (instancetype)initWithFrame:(CGRect)frame resources:(NSArray *)resources;
// 加载需要轮播的资源，当希望修改轮播的内容时，可重新调用该方法。
- (void)loadResources:(NSArray *)resources;
// 指定显示特定位置的资源。
- (void)showResourceAtIndex:(NSUInteger)index;

// TODO: 内部 UIScrollView 的代理转接方法。

@end

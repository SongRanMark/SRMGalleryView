//
//  ViewController.m
//  SRMGalleryView
//
//  Created by marksong on 26/01/2017.
//  Copyright © 2017 S.R. All rights reserved.
//

#import "ViewController.h"
#import "SRMGalleryView.h"
#import "UIView+Frame.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet SRMGalleryView *galleryView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    leftView.backgroundColor = [UIColor orangeColor];
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectZero];
    centerView.backgroundColor = [UIColor magentaColor];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectZero];
    rightView.backgroundColor = [UIColor cyanColor];
    NSArray *resources = @[leftView, centerView, rightView];
    [self.galleryView loadResources:resources];
}

@end

//
//  ViewController.m
//  RBTagViewDemo
//
//  Created by Shao.Tc on 15/12/20.
//  Copyright © 2015年 rainbow. All rights reserved.
//

#import "ViewController.h"
#import "RBTagView.h"

#define kData @[@"iOS", @"Swift", @"Java", @"C# .net", @"PHP", @"Python", @"Golang", @"Hello World", @"C", @"C++"]

@interface ViewController () <RBTagViewDelegate, RBTagViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RBTagView *tagView = [[RBTagView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 45)];
    tagView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tagView];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:tagView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.f constant:0.f],
                              [NSLayoutConstraint constraintWithItem:tagView
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.f constant:0.f],
                              [NSLayoutConstraint constraintWithItem:tagView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.f constant:64.f]]];
    [tagView addConstraint:[NSLayoutConstraint constraintWithItem:tagView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.f constant:45.f]];
    tagView.tagDelegate = self;
    tagView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)lineSpacingInTagView:(RBTagView *)tagView {
    return 5;
}

- (CGFloat)tagSpacingInTagView:(RBTagView *)tagView {
    return 20;
}

- (CGFloat)tagHeightInTagView:(RBTagView *)tagView {
    return 20;
}

- (RBMargin)marginInTagView:(RBTagView *)tagView {
    return RBMarginMake(20, 10);
}

- (NSUInteger)numberOfTagInTagView:(RBTagView *)tagView {
    return kData.count;
}

- (void)tagView:(RBTagView *)tagView willDisplayTag:(RBTag *)tag {
    [tag.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [tag setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (RBTag *)tagView:(RBTagView *)tagView tagAtIndex:(NSUInteger)index {
    return [RBTag tagWithTitle:kData[index]];
}

- (void)tagView:(RBTagView *)tagView didSelectedAtIndex:(NSUInteger)index {
    NSLog(@"choosed %@", kData[index]);
}

@end

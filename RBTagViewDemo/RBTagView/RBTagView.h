//
//  RBTagView.h
//  RBTagViewDemo
//
//  Created by Shao.Tc on 15/12/20.
//  Copyright © 2015年 rainbow. All rights reserved.
//

#import <UIKit/UIKit.h>

struct RBMargin {
    CGFloat sideMargin;
    CGFloat topMargin;
};
typedef struct RBMargin RBMargin;
CG_INLINE RBMargin RBMarginMake(CGFloat sideMargin, CGFloat topMargin) {
    RBMargin margin;
    margin.sideMargin = sideMargin;
    margin.topMargin = topMargin;
    return margin;
}

@interface RBTag : UIButton

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSUInteger index;
+ (instancetype)tagWithTitle:(NSString *)title;

@end

@protocol RBTagViewDelegate;
@protocol RBTagViewDataSource;


@interface RBTagView : UIScrollView

@property (weak, nonatomic) id<RBTagViewDelegate> tagDelegate;
@property (weak, nonatomic) id<RBTagViewDataSource> dataSource;
- (void)reloadData;

@end

@protocol RBTagViewDelegate <NSObject>

- (CGFloat)lineSpacingInTagView:(RBTagView *)tagView;
- (CGFloat)tagSpacingInTagView:(RBTagView *)tagView;
- (CGFloat)tagHeightInTagView:(RBTagView *)tagView;
- (RBMargin)marginInTagView:(RBTagView *)tagView;

- (void)tagView:(RBTagView *)tagView willDisplayTag:(RBTag *)tag;
- (void)tagView:(RBTagView *)tagView didSelectedAtIndex:(NSUInteger)index;

@end

@protocol RBTagViewDataSource <NSObject>

- (NSUInteger)numberOfTagInTagView:(RBTagView *)tagView;
- (RBTag *)tagView:(RBTagView *)tagView tagAtIndex:(NSUInteger)index;

@end

//
//  RBTagView.m
//  RBTagViewDemo
//
//  Created by Shao.Tc on 15/12/20.
//  Copyright © 2015年 rainbow. All rights reserved.
//

#import "RBTagView.h"

@implementation RBTag

+ (instancetype)tagWithTitle:(NSString *)title {
    RBTag * tag = [RBTag buttonWithType:UIButtonTypeCustom];
    tag.title = title;
    return tag;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setTitle:_title forState:UIControlStateNormal];
}

@end

@interface RBTagView ()

@end

@implementation RBTagView

- (void)reloadData {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[RBTag class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    NSUInteger tagCount = 0;
    if ([_dataSource respondsToSelector:@selector(numberOfTagInTagView:)]) {
        tagCount = [_dataSource numberOfTagInTagView:self];
    }
    
    CGFloat lastX = 0;
    NSUInteger line = 0;
    CGFloat lineSpacing = ![_tagDelegate respondsToSelector:@selector(lineSpacingInTagView:)] ?: [_tagDelegate lineSpacingInTagView:self];
    CGFloat tagHeight = ![_tagDelegate respondsToSelector:@selector(tagHeightInTagView:)] ?: [_tagDelegate tagHeightInTagView:self];
    CGFloat tagSpacing = ![_tagDelegate respondsToSelector:@selector(tagSpacingInTagView:)] ?: [_tagDelegate tagSpacingInTagView:self];
    RBMargin margin = ![_tagDelegate respondsToSelector:@selector(marginInTagView:)] ? RBMarginMake(0, 0) : [_tagDelegate marginInTagView:self];
    
    CGFloat containerHeight = 0;
    
    for (NSUInteger i = 0; i < tagCount; i++) {
        if ([_dataSource respondsToSelector:@selector(tagView:tagAtIndex:)]) {
            RBTag *tag = [_dataSource tagView:self tagAtIndex:i];
            [_tagDelegate tagView:self willDisplayTag:tag];
            CGSize titleSize = [tag.title sizeWithAttributes:@{NSFontAttributeName : tag.titleLabel.font}];
            CGFloat tagWidth = titleSize.width + 10;
            if (lastX + titleSize.width + tagSpacing > CGRectGetWidth(self.frame) - margin.sideMargin * 2) {
                line++;
                lastX = 0;
            }
            tag.frame = CGRectMake(margin.sideMargin + lastX + (lastX <= 0 ?: tagSpacing), margin.topMargin + line * (lineSpacing + tagHeight), tagWidth, tagHeight);
            tag.index = i;
            [tag addTarget:self action:@selector(chooseTag:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tag];
            
            lastX = CGRectGetMaxX(tag.frame) - margin.sideMargin;
            containerHeight = CGRectGetMaxY(tag.frame);
        }
    }
    
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame), containerHeight);
}

- (void)chooseTag:(RBTag *)tag {
    ![_tagDelegate respondsToSelector:@selector(tagView:didSelectedAtIndex:)] ?: [_tagDelegate tagView:self didSelectedAtIndex:tag.index];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self reloadData];
}

@end

//
//  viewtitle.h
//  picker
//
//  Created by zhang on 14-8-15.
//  Copyright (c) 2014年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface viewtitleTable : UIView
@property(nonatomic,copy)NSDictionary *dic;

-(void)addTitle:(NSArray *)array;
-(void)moveTitleFrame:(float)moveLoce;
@end

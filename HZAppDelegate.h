//
//  HZAppDelegate.h
//  addPngTest
//
//  Created by huazai on 15/4/4.
//  Copyright (c) 2015年 LitterDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIImage *image1;
@property (strong, nonatomic) UIImage *image2;

@property CGPoint iconPoint;
@property float heightScale,widthScale;

@property float imageScale;
@property float imageDegree;
@property int mixtype;

@end

//
//  HZNewViewController.h
//  addPngTest
//
//  Created by huazai on 15/4/6.
//  Copyright (c) 2015年 LitterDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRMediaPickerController.h"
#import "HZNewImageView.h"
#import "UIImageView+LBBlurredImage.h"

@interface HZNewViewController : UIViewController <CRMediaPickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet HZNewImageView *pointView;

@property (strong, nonatomic) CRMediaPickerController *mediaPickerController;

@property float heightScale;
@property float widthScale;
@property BOOL isChenged;

- (IBAction)valueChanged:(UISegmentedControl *)sender;

@end

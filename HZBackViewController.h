//
//  HZBackViewController.h
//  addPngTest
//
//  Created by huazai on 15/4/6.
//  Copyright (c) 2015年 LitterDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRMediaPickerController.h"

@interface HZBackViewController : UIViewController<CRMediaPickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) CRMediaPickerController* mediaPickerController;

- (IBAction)choiceClick:(id)sender;

@end

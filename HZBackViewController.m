//
//  HZBackViewController.m
//  addPngTest
//
//  Created by huazai on 15/4/6.
//  Copyright (c) 2015年 LitterDeveloper. All rights reserved.
//

#import "HZBackViewController.h"
#import "HZAppDelegate.h"

@interface HZBackViewController ()

@end

@implementation HZBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choiceClick:(id)sender {
    
    self.mediaPickerController = [[CRMediaPickerController alloc] init];
    self.mediaPickerController.delegate = self;
    
    self.mediaPickerController.mediaType = CRMediaPickerControllerMediaTypeImage;
    self.mediaPickerController.sourceType = CRMediaPickerControllerSourceTypeCamera | CRMediaPickerControllerSourceTypeSavedPhotosAlbum | CRMediaPickerControllerSourceTypePhotoLibrary;
    
    [self.mediaPickerController show];
}

#pragma mark CRMediaPickerController delegate

#pragma mark 取得照片
- (void)CRMediaPickerController:(CRMediaPickerController *)mediaPickerController didFinishPickingAsset:(ALAsset *)asset error:(NSError *)error
{
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    if (asset) {
        // 判断是否为照片
        if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
            ALAssetRepresentation *representation = asset.defaultRepresentation;
            // 显示选中的照片
            self.imageView.image = [UIImage imageWithCGImage:representation.fullScreenImage];
            
            ((HZAppDelegate *)[UIApplication sharedApplication].delegate).image1 = self.imageView.image;
            NSLog(@"image1 stand by......");
        }
    }
}

@end

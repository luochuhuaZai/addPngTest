//
//  HZNewViewController.m
//  addPngTest
//
//  Created by huazai on 15/4/6.
//  Copyright (c) 2015年 LitterDeveloper. All rights reserved.
//

#import "HZNewViewController.h"
#import "HZAppDelegate.h"

@interface HZNewViewController ()

@end

@implementation HZNewViewController

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
    self.backImageView.image = ((HZAppDelegate *)[UIApplication sharedApplication].delegate).image1;
    
    self.isChenged = NO;
    //添加手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePinch:)];
    [self.pointView addGestureRecognizer:pinchGestureRecognizer];
    
    UIRotationGestureRecognizer *rotateRecognizer = [[UIRotationGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(handleRotate:)];
    [self.pointView addGestureRecognizer:rotateRecognizer];
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    NSLog(@"view did appear!");
}

- (void)loadData {
    
    self.iconImageView.image = ((HZAppDelegate *)[UIApplication sharedApplication].delegate).image2;
    self.heightScale = self.backImageView.image.size.height / self.backImageView.frame.size.height;
    self.widthScale = self.backImageView.image.size.width / self.backImageView.frame.size.width;
    NSLog(@"-------%f,%f", self.widthScale, self.heightScale);
    
    CGRect rect = self.iconImageView.frame;
    rect.size.height = self.iconImageView.image.size.height / self.heightScale;
    rect.size.width = self.iconImageView.image.size.width / self.widthScale;
    
    self.iconImageView.frame = rect;
    NSLog(@"rect size :%f, %f", rect.size.height, rect.size.width);
    NSLog(@"btn size :%f, %f", self.iconImageView.frame.size.height, self.iconImageView.frame.size.width);
    ((HZAppDelegate *)[UIApplication sharedApplication].delegate).widthScale =self.widthScale;
    ((HZAppDelegate *)[UIApplication sharedApplication].delegate).heightScale = self.heightScale;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 移动手势

#pragma mark -- touchBegan
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   
    UITouch *touch = [[touches allObjects] lastObject];
    
    NSLog(@"%f, %f", [touch locationInView:self.pointView].x, [touch locationInView:self.pointView].y);
    
    if ([touch locationInView:self.view].x > self.pointView.frame.origin.x && [touch locationInView:self.view].x  < self.pointView.frame.origin.x+ self.pointView.frame.size.width - self.iconImageView.frame.size.width && [touch locationInView:self.view].y > self.pointView.frame.origin.y && [touch locationInView:self.view].y < self.pointView.frame.origin.y+self.pointView.frame.size.height - self.iconImageView.frame.size.height){
        
        CGRect rect = self.iconImageView.frame;
    
        rect.origin = [touch locationInView:self.pointView];
        self.iconImageView.frame = rect;
    }
}

#pragma mark -- touchMoved
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[touches allObjects] lastObject];
    
    NSLog(@"===========%f, %f", [touch locationInView:self.view].x, [touch locationInView:self.view].y);
    
    NSLog(@"%f, %f", [touch locationInView:self.pointView].x, [touch locationInView:self.pointView].y);
    
    if ([touch locationInView:self.view].x > self.pointView.frame.origin.x && [touch locationInView:self.view].x  < self.pointView.frame.origin.x+ self.pointView.frame.size.width - self.iconImageView.frame.size.width && [touch locationInView:self.view].y > self.pointView.frame.origin.y && [touch locationInView:self.view].y < self.pointView.frame.origin.y+self.pointView.frame.size.height - self.iconImageView.frame.size.height){
        
        NSLog(@"----X inside");
        CGRect rect = self.iconImageView.frame;
    
        rect.origin = [touch locationInView:self.pointView];
        self.iconImageView.frame = rect;
    }
}

#pragma mark touchEnd
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] lastObject];
    CGPoint point = [touch locationInView:self.pointView];
    
    ((HZAppDelegate *)[UIApplication sharedApplication].delegate).iconPoint = point;
}

#pragma mark 手势
#pragma mark --Pinch
- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    self.iconImageView.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    //recognizer.scale = 1;
    ((HZAppDelegate *)[UIApplication sharedApplication].delegate).imageScale = recognizer.scale;
    NSLog(@"==-=-=%f", recognizer.scale);
}

#pragma mark --Rotation
- (void) handleRotate:(UIRotationGestureRecognizer*) recognizer
{
    self.iconImageView.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    ((HZAppDelegate *)[UIApplication sharedApplication].delegate).imageDegree = recognizer.rotation;
    NSLog(@"%f", recognizer.rotation);
    //recognizer.rotation = 0;
}

- (IBAction)valueChanged:(UISegmentedControl *)sender {
    
    int selectedIndex = sender.selectedSegmentIndex;
    
    [self mixImageWithType:selectedIndex];
    
    ((HZAppDelegate *)[UIApplication sharedApplication].delegate).mixtype = selectedIndex;
}

#pragma mark 改变混合样式
- (void)mixImageWithType:(int)type{
    
     ((HZAppDelegate *)[UIApplication sharedApplication].delegate).mixtype = type;
    
    if (type == 0){
        CGRect rect = self.iconImageView.frame;
        rect.size = self.iconImageView.image.size;
        self.iconImageView.frame = rect;
        
        //self.isBlur = NO;
        if (self.isChenged){
            self.isChenged = NO;
            UIImage *image =  ((HZAppDelegate *)[UIApplication sharedApplication].delegate).image1;
            [self.backImageView setImage:image];
        }
    }
    
    if (type == 1){
        
        CGRect rect = self.iconImageView.frame;
        rect.size = self.iconImageView.image.size;
        self.iconImageView.frame = rect;
        
        if (!self.isChenged){
            self.isChenged = YES;
            UIImage *newImage = self.backImageView.image;
            newImage = [self blurryImage:newImage withBlurLevel:20];
            self.backImageView.image = newImage;
        }
    }
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(blur), nil];
    
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil]; // save it to self.context
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}

@end

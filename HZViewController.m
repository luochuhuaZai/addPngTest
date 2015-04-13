//
//  HZViewController.m
//  addPngTest
//
//  Created by huazai on 15/4/4.
//  Copyright (c) 2015年 LitterDeveloper. All rights reserved.
//

#import "HZViewController.h"
#import "HZAppDelegate.h"

@interface HZViewController ()

@end

@implementation HZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image1 = ((HZAppDelegate *)[UIApplication sharedApplication].delegate).image1;
    //image1 = [self blurryImage:image1 withBlurLevel:10];
    UIImage *image2 = ((HZAppDelegate *)[UIApplication sharedApplication].delegate).image2;
    
    image2 = [self imageByApplyingAlpha:0.8f image:image2];
    
    CGFloat degree = ((HZAppDelegate *)[UIApplication sharedApplication].delegate).imageDegree;
    
    image2 = [self image:image2 RotatedByDegrees:degree];
    
    CGFloat scale = ((HZAppDelegate *)[UIApplication sharedApplication].delegate).imageScale;
    
    image2 = [self scaleImage:image2 toScale:scale];
    
    float x =((HZAppDelegate *)[UIApplication sharedApplication].delegate).iconPoint.x * ((HZAppDelegate *)[UIApplication sharedApplication].delegate).widthScale;
    
    float y = ((HZAppDelegate *)[UIApplication sharedApplication].delegate).iconPoint.y *((HZAppDelegate *)[UIApplication sharedApplication].delegate).heightScale;
    
    CGPoint topleft = CGPointMake(x, y);
    
    int type = ((HZAppDelegate *)[UIApplication sharedApplication].delegate).mixtype;
    
    if (type == 1){
        image1 = [self blurryImage:image1 withBlurLevel:20];
    }
    
    UIImage *newImage = [self addTwoImageToOne:image1 twoImage:image2 topleft:topleft];
    
    [self.imageView setImage:newImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)addTwoImageToOne:(UIImage *)oneImg twoImage:(UIImage *)twoImg topleft:(CGPoint)tlPos
{
    UIGraphicsBeginImageContext(oneImg.size);
    
    [oneImg drawInRect:CGRectMake(0, 0, oneImg.size.width, oneImg.size.height)];
    [twoImg drawInRect:CGRectMake(tlPos.x, tlPos.y, twoImg.size.width, twoImg.size.height)];
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImg;
}

//改图像透明度
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

//float转角度的方法 360->360º
CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
};
// 这个是相反的方法
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

//旋转图片的方法
- (UIImage *)image:(UIImage *)image RotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    
    CGAffineTransform t = CGAffineTransformMakeRotation(RadiansToDegrees(degrees));
    rotatedViewBox.transform = t;
    
    CGSize rotatedSize = rotatedViewBox.frame.size;
    rotatedViewBox = nil;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, RadiansToDegrees(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize

{
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
                                
    return scaledImage;
                                
}

//加阴影,其实就是加上边；
/*******************************************
 * 加阴影的方法
 * image是要加的图像,shadowColor是颜色,shadowOffset是阴影的偏移(w指左右,h指上下),shadowBlur是阴影大小
 */
- (UIImage *)image:(UIImage *)image WithShadowColor:(UIColor *)shadowColor
                     shadowOffset:(CGSize)shadowOffset
                       shadowBlur:(CGFloat)shadowBlur
{
    CGColorRef cgShadowColor = [shadowColor CGColor];
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                                       CGImageGetBitsPerComponent(image.CGImage), 0,
                                                       colourSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    // Setup shadow
    CGContextSetShadowWithColor(shadowContext, shadowOffset, shadowBlur, cgShadowColor);
    
    CGRect drawRect = CGRectMake(-shadowBlur, -shadowBlur, image.size.width + shadowBlur, image.size.height + shadowBlur);
    CGContextDrawImage(shadowContext, drawRect, image.CGImage);
    
    CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
    CGContextRelease(shadowContext);
    
    UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
    CGImageRelease(shadowedCGImage);
    
    return shadowedImage;
}

- (IBAction)saveClicked:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), @"hahah");
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"%@",error);
    NSLog(@"%@",contextInfo);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"照片已成功导入" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
    
    [alert show];
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

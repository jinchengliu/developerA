//
//  AboveView.m
//  IosProject
//
//  Created by allen on 13-11-16.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "AboveView.h"

@implementation AboveView{
    
    CGImageRef _image;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        
    }
    return self;
}


-(void)drawInContext:(CGContextRef)context
{
    CGContextTranslateCTM(context, 0, kScreenFrame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0, 0, kScreenFrame.size.width, kScreenFrame.size.height), self.image);
    
    NSArray *roadX=[[NSArray alloc] initWithObjects:@"49",@"203",@"265",nil];
    NSArray *roadY=[[NSArray alloc] initWithObjects:@"121",@"202",@"261",@"340",@"400",@"455",nil];
    CGPoint start=CGPointMake(180, 420);
    //CGPoint start=CGPointMake(69, 477);
    CGPoint end=CGPointMake(286, 130);
    //判断Y轴上的走向
    //当向下延生时
    int secY;
    CGPoint secPoint;
    if(start.y>end.y){
        
        for(int i=[roadY count]-1;i>=0;i--){
            if([[roadY objectAtIndex:i] intValue]<start.y){
                secY=[[roadY objectAtIndex:i] intValue];
                break;
            }
        }
        secPoint=CGPointMake(start.x, secY);
        
    }else{  //向上延伸时
        
    }
    
    //判断X轴上的走向
    //向右走向时
    int thirdX;
    CGPoint thirdPoint;
    if(start.x<end.x){
        for(int i=[roadX count]-1;i>=0;i--){
            if([[roadX objectAtIndex:i] intValue]<end.x){
                thirdX=[[roadX objectAtIndex:i] intValue];
                break;
            }
        }
        thirdPoint=CGPointMake(thirdX, secY);
        
    }else{  //向上延伸时
        
    }

    CGPoint forthPoint=CGPointMake(thirdX, end.y);
    
    //图上划线
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
	// Draw them with a 2.0 stroke width so they are a bit more visible.
	CGContextSetLineWidth(context, 2.0);
	
	// Draw a single line from left to right
	CGPoint addLines[] =
	{
		start,
        secPoint,
        thirdPoint,
        forthPoint,
		end,
		
	};
    
    
//    CGPointMake(180, 420),
//    CGPointMake(180, 400),
//    CGPointMake(265, 400),
//    CGPointMake(265, 130),
//    CGPointMake(286, 130),
    

	CGContextAddLines(context, addLines, sizeof(addLines)/sizeof(addLines[0]));
	CGContextStrokePath(context);
    
    // 画红色箭头
    
//    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
//    
//    CGContextMoveToPoint(context, 572/2, 280/2);
//    
//    CGContextAddLineToPoint(context, 592/2, 260/2);
//    
//    CGContextAddLineToPoint(context, 572/2, 240/2);
//    
//    CGContextFillPath(context);

	
}

- (CGImageRef)image
{
	if (_image == NULL)
	{
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"];
		UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
		_image = CGImageRetain(img.CGImage);
	}
	return _image;
    
}


-(void)dealloc
{
	CGImageRelease(_image);
}




@end

//
//  PDFRenderer.m
//  PDFRenderer
//
//  Created by Yuichi Fujiki on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#define WIDTH 1240

#define HEIGHT 1754


#define FONT20  20.0

#define FONT22  22.0


#define FONT18  18.0

#define FONT14  14.0

#define Vertical_Line_Distance_250 250


#define Vertical_Line_Distance_200 200

#define Vertical_Line_Distance_150 150


#define Vertical_Line_Distance_140 140

#define Vertical_Line_Distance_130 130


#define Vertical_Line_Distance_120 120


#define Vertical_Line_Distance_110 110


#define Vertical_Line_Distance_100 100

#define Vertical_Line_Distance_80 80

#define Vertical_Line_Distance_70 70

#define Vertical_Line_Distance_60 60

#define Vertical_Line_Distance_40 40

#define Vertical_Line_Distance_10 10

#define Vertical_Line_Distance_20 20

#define Vertical_Line_Distance_30 30

#define Vertical_Line_Distance_50 50

#define Vertical_Line_Distance_5 5




#define Horizontal_Line_Distance_5 5

#define Horizontal_Line_Distance_10 10

#define Horizontal_Line_Distance_20 20

#define Horizontal_Line_Distance_30 30

#define Horizontal_Line_Distance_40 40

#define Horizontal_Line_Distance_50 50

#define Horizontal_Line_Distance_60 60

#define Horizontal_Line_Distance_70 70

#define Horizontal_Line_Distance_80 80

#define Horizontal_Line_Distance_90 90

#define Horizontal_Line_Distance_100 100

#define Horizontal_Line_Distance_110 110

#define Horizontal_Line_Distance_120 120

#define Horizontal_Line_Distance_130 130

#define Horizontal_Line_Distance_140 140

#define Horizontal_Line_Distance_150 150
#define Horizontal_Line_Distance_160 160

#define Horizontal_Line_Distance_170 170

#define Horizontal_Line_Distance_180 180

#define Horizontal_Line_Distance_190 190

#define Horizontal_Line_Distance_200 200

#define Horizontal_Line_Distance_210 210



#define Horizontal_Line_Distance_250 250

#define Horizontal_Line_Distance_270 270

#define Horizontal_Line_Distance_280 280

#define Horizontal_Line_Distance_290 290


#define Horizontal_Line_Distance_300 300

#define Horizontal_Line_Distance_350 350

#define Horizontal_Line_Distance_400 400


#import "PDFRenderer.h"

@interface PDFRenderer ()

@end

@implementation PDFRenderer

+ (void)drawText:(NSString*)textToDraw inFrame:(CGRect)frame fontName:(NSString *)fontName fontSize:(int) fontSize
{        
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    
    // Prepare the text using a Core Text Framesetter.
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)fontName, fontSize, NULL);
    CFStringRef keys[] = { kCTFontAttributeName };
    CFTypeRef values[] = { font };
    CFDictionaryRef attr = CFDictionaryCreate(NULL, (const void **)&keys, (const void **)&values,
                                              sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, attr);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(currentText);
    
    CGRect frameRect = (CGRect){frame.origin.x, -1 * frame.origin.y, frame.size};
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
            
    // Get the graphics context.
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);

    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    // Revert coordinate
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(frameSetter);    
}

+ (void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
   

    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
    
    
}

+ (void)drawDashLineFromPoint:(CGPoint)from toPoint:(CGPoint)to
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGFloat components[] = {10,5};
    CGContextSetLineDash(context, 0, components, 2);
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
    
}

+ (void)drawSquareWithCGRect:(CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

//    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    
    CGContextSetRGBFillColor(context, 193.0/255.0, 193.0/255.0,193.0/255.0, 1.0);
    CGContextFillRect(context, rect);
    CGContextStrokePath(context);
    
}

#pragma mark--空心矩形框
+ (void)drawEmptySquareWithCGRect:(CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat components[] = {10,5};
    
    CGContextSetLineDash(context, 0, components, 0);
    
//  CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0, 1);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

    CGContextSetLineWidth(context, 1.0);
    
    CGContextAddRect(context, rect);
    
    CGContextStrokePath(context);
}

+ (void)drawImage:(UIImage*)image inRect:(CGRect)rect
{
    [image drawInRect:rect];
}

/*
 
 cardPointTime = "11\U65f657\U520603\U79d2";
 documentType = "\U5b9a\U671f\U5b58\U5355";
 number = 2;
 operationFlag = "\U4f5c\U5e9f\U5f85\U9500\U6bc1";
 operator = "";
 startStopNumber = "0093-0094";
 tradeDate = "2016\U5e7408\U670809\U65e5";
 
 */
#if 0

+(void)certificateDestroy:(NSDictionary *)tableDict{
    
    
    [PDFRenderer printStr:@"凭证出库/作废/手工销号卡点证明" CGRect:CGRectMake(0, 60, 612, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"交易日期" CGRect:CGRectMake(13, 112, 100, 30) Font:18.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[PCMobileBankGlobal sharedInstance].writeDate CGRect:CGRectMake(13, 112+60, 100, 30) Font:12.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    
    [PDFRenderer printStr:@"操作标志" CGRect:CGRectMake(13+100, 112, 100, 30) Font:18.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[tableDict objectForKey:@"operationFlag"] CGRect:CGRectMake(13+100, 112+60, 100, 30) Font:12.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    [PDFRenderer printStr:@"凭证种类" CGRect:CGRectMake(13+100*2, 112, 100, 30) Font:18.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[tableDict objectForKey:@"documentType"] CGRect:CGRectMake(13+100*2, 112+60, 100, 30) Font:12.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];


    
    [PDFRenderer printStr:@"起止号码" CGRect:CGRectMake(13+100*3, 112, 100, 30) Font:18.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[tableDict objectForKey:@"startStopNumber"] CGRect:CGRectMake(13+100*3, 112+60, 100, 30) Font:12.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    

    
    [PDFRenderer printStr:@"数量" CGRect:CGRectMake(13+100*4, 112, 100, 30) Font:18.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[tableDict objectForKey:@"number"] CGRect:CGRectMake(13+100*4, 112+60, 100, 30) Font:12.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    
    [PDFRenderer printStr:@"卡点时间" CGRect:CGRectMake(13+100*5-20, 112, 100, 30) Font:18.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    [PDFRenderer printStr:[tableDict objectForKey:@"cardPointTime"] CGRect:CGRectMake(13+100*5-20, 112+60, 100, 30) Font:12.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];


   NSString * custName = [NSString stringWithFormat:@"经办人:%@",[PCMobileBankUtil getAppLoginSession].custName];
    
    
    [PDFRenderer printStr:custName CGRect:CGRectMake(13, 360, 300, 30) Font:12.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"卡点人:" CGRect:CGRectMake(350, 360, 200, 30) Font:12.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    if ([PCMobileBankGlobal sharedInstance].CertificateRevokeImage) {
        
        [[PCMobileBankGlobal sharedInstance].CertificateRevokeImage drawInRect:CGRectMake(410, 330, 200, 70)];

    }
    

    

    
    //画空心矩形框A
    CGFloat X =4;
    
    CGFloat Y =30;
    
    [PDFRenderer drawEmptySquareWithCGRect:CGRectMake(X, Y, 604,360)];
    Y += 60;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(604+X, Y)];
    
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+100, Y) toPoint:CGPointMake(X+100, Y+60*4)];
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+100*2, Y) toPoint:CGPointMake(X+100*2, Y+60*4)];
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+100*3, Y) toPoint:CGPointMake(X+100*3, Y+60*4)];
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+100*4, Y) toPoint:CGPointMake(X+100*4, Y+60*4)];

    [PDFRenderer drawLineFromPoint:CGPointMake(X+100*4+60, Y) toPoint:CGPointMake(X+100*4+60, Y+60*4)];




    
    Y += 60;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(604+X, Y)];
    Y += 60;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(604+X, Y)];
    Y += 60;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(604+X, Y)];
    Y += 60;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(604+X, Y)];


    
    
}
+(void)printAcctManager:(NSDictionary* )tableDict lastDict:(NSDictionary *)lastDict
{
    ////交易码
    NSString *trans_Code  =[tableDict objectForKey:@"trans_Code"];
    
    //解除
    if ([trans_Code isEqualToString:@"185018"])
        
    {
        /**
         *   "author_id" = 130011;
         "customer_Id1" = 10208136631;
         "organ_Id" = 1726;
         "seq_No" = "";
         "teller_Id" = 130210;
         "tran_Name" = "";
         "trans_Code" = 185018;
       
         */
        //机构号
        NSString *organ_Id  =[tableDict objectForKey:@"organ_Id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"机构号:%@",organ_Id] CGRect:CGRectMake(160, 180, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //交易日期
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易日期:%@",[PCMobileBankGlobal sharedInstance].writeDate] CGRect:CGRectMake(500, 180, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        /**
         *"seq_No" = 29088;
         "tran_Name" = "\U5408\U5e76\U5ba2\U6237\U53f7";
         */
        //流水号
        NSString *seq_No  =[lastDict objectForKey:@"seq_No"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"流水号:%@",seq_No] CGRect:CGRectMake(160, 180+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //交易名称
        NSString *tran_Name  =[lastDict objectForKey:@"tran_Name"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易名称:%@",tran_Name] CGRect:CGRectMake(500, 180+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //被解除合并客户号
        NSString *customer_Id1  =[tableDict objectForKey:@"customer_Id1"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"被解除合并客户号:%@",customer_Id1] CGRect:CGRectMake(160, 180+200, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
    }
    //合并客户信息
    else  if([trans_Code isEqualToString:@"185017"])
    {
        
        //机构号
        NSString *organ_Id  =[tableDict objectForKey:@"organ_Id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"机构号:%@",organ_Id] CGRect:CGRectMake(160, 180, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //交易日期
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易日期:%@",[PCMobileBankGlobal sharedInstance].writeDate] CGRect:CGRectMake(500, 180, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //主客户姓名
        NSString *cust_Name  =[tableDict objectForKey:@"cust_Name"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"主客户姓名:%@",cust_Name] CGRect:CGRectMake(160, 180+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //主客户号
        NSString *customer_Id  =[tableDict objectForKey:@"customer_Id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"主客户号:%@",customer_Id] CGRect:CGRectMake(500, 180+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        //证件类型
        NSString *Id_Type  =[tableDict objectForKey:@"Id_Type"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件类型:%@",Id_Type] CGRect:CGRectMake(160, 180+50*2, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //证件号码
        NSString *Id_No  =[tableDict objectForKey:@"Id_No"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件号码:%@",Id_No] CGRect:CGRectMake(500, 180+50*2, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //辅客户号
        NSString *customer_Id2  =[tableDict objectForKey:@"customer_Id2"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"辅客户号:%@",customer_Id2] CGRect:CGRectMake(160, 180+50*3, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //辅客户姓名
        NSString *cust_Name2  =[tableDict objectForKey:@"cust_Name2"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"辅客户姓名:%@",cust_Name2] CGRect:CGRectMake(500, 180+50*3, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        //证件类型
        NSString *Id_Type2  =[tableDict objectForKey:@"Id_Type2"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件类型:%@",Id_Type2] CGRect:CGRectMake(160, 180+50*4, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //证件号码
        NSString *Id_No2  =[tableDict objectForKey:@"Id_No2"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件号码:%@",Id_No2] CGRect:CGRectMake(500, 180+50*4, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        /**
         *"seq_No" = 29088;
         "tran_Name" = "\U5408\U5e76\U5ba2\U6237\U53f7";
         */
        //流水号
        NSString *seq_No  =[lastDict objectForKey:@"seq_No"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"流水号:%@",seq_No] CGRect:CGRectMake(160, 180+50*5, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //交易名称
        NSString *tran_Name  =[lastDict objectForKey:@"tran_Name"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易名称:%@",tran_Name] CGRect:CGRectMake(500, 180+50*5, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
       
        
        
        
        
        //签字
        [PDFRenderer printStr:@"确认无误后签名:" CGRect:CGRectMake(600, 180+50*6, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"经办:%@",[tableDict objectForKey:@"teller_Id"]] CGRect:CGRectMake(600, 220+50*8, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"复核:%@",[tableDict objectForKey:@"author_id"]] CGRect:CGRectMake(800, 220+50*8, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    }
    //客户账号调整
    else  if([trans_Code isEqualToString:@"185025"])
    {
        
        
        
        
        //机构号
        NSString *organ_Id  =[tableDict objectForKey:@"organ_Id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"机构号:%@",organ_Id] CGRect:CGRectMake(160, 180, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //交易日期
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易日期:%@",[PCMobileBankGlobal sharedInstance].writeDate] CGRect:CGRectMake(500, 180, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //主客户姓名
        NSString *cust_Name  =[tableDict objectForKey:@"cust_Name"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"主客户姓名:%@",cust_Name] CGRect:CGRectMake(160, 180+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //主客户号
        NSString *customer_Id  =[tableDict objectForKey:@"customer_Id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"主客户号:%@",customer_Id] CGRect:CGRectMake(500, 180+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        //证件类型
        NSString *Id_Type  =[tableDict objectForKey:@"Id_Type"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件类型:%@",Id_Type] CGRect:CGRectMake(160, 180+50*2, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //证件号码
        NSString *Id_No  =[tableDict objectForKey:@"Id_No"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件号码:%@",Id_No] CGRect:CGRectMake(500, 180+50*2, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        
        //归入客户号
        NSString *customer_Id2  =[tableDict objectForKey:@"customer_Id2"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"归入客户号:%@",customer_Id2] CGRect:CGRectMake(160, 180+50*3, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //归入客户姓名
        NSString *cust_Name2  =[tableDict objectForKey:@"cust_Name2"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"归入客户姓名:%@",cust_Name2] CGRect:CGRectMake(500, 180+50*3, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        //证件类型
        NSString *Id_Type2  =[tableDict objectForKey:@"Id_Type2"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"支取证件类型:%@",Id_Type2] CGRect:CGRectMake(160, 180+50*4, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //证件号码
        NSString *Id_No2  =[tableDict objectForKey:@"Id_No2"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"支取证件号码:%@",Id_No2] CGRect:CGRectMake(500, 180+50*4, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        /**
         *"seq_No" = 29088;
         "tran_Name" = "\U5408\U5e76\U5ba2\U6237\U53f7";
         */
        //流水号
        NSString *seq_No  =[lastDict objectForKey:@"seq_No"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"流水号:%@",seq_No] CGRect:CGRectMake(160, 180+50*5, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //交易名称
        NSString *tran_Name  =[lastDict objectForKey:@"tran_Name"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易名称:%@",tran_Name] CGRect:CGRectMake(500, 180+50*5, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //签字
        [PDFRenderer printStr:@"确认无误后签名:" CGRect:CGRectMake(600, 180+50*6, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"经办:%@",[tableDict objectForKey:@"teller_Id"]] CGRect:CGRectMake(600, 220+50*8, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"复核:%@",[tableDict objectForKey:@"author_id"]] CGRect:CGRectMake(800, 220+50*8, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    }
    /*
     
     {
     "Id_No" = 341125199208151098;
     "Load_App1" = "\U5357\U5b81\U5e02\U6c11\U5361";
     "Load_App2" = "\U5357\U5b81\U5927\U5b66";
     "Succ_Type1" = "";
     "Succ_Type2" = "";
     "bank_card" = 6231330100000009526;
     "cust_Name" = "\U502a\U7fd4";
     "organ_Id" = 1726;
     "teller_Id" = 130210;
     "trans_Code" = TS0002;
     },
     
     */
    //一卡通应用加载
    else if ([trans_Code isEqualToString:@"TS0002"]){
        
        
        [PDFRenderer printStr:@"一卡通应用加载确认" CGRect:CGRectMake(0, 180, WIDTH-160, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

        //机构号
        NSString *organ_Id  =[tableDict objectForKey:@"organ_Id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"机构号:%@",organ_Id] CGRect:CGRectMake(160, 180+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
       //发卡日期
        [PDFRenderer printStr:[NSString stringWithFormat:@"发卡日期:%@",[PCMobileBankGlobal sharedInstance].writeDate] CGRect:CGRectMake(600, 180+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //银行卡号
        [PDFRenderer printStr:[NSString stringWithFormat:@"银行卡号:%@",[tableDict objectForKey:@"bank_card"]] CGRect:CGRectMake(160, 180+50*2, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        //户名
        [PDFRenderer printStr:[NSString stringWithFormat:@"户名:%@",[tableDict objectForKey:@"cust_Name"]] CGRect:CGRectMake(600, 180+50*2, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //操作员
        [PDFRenderer printStr:[NSString stringWithFormat:@"操作员:%@",[tableDict objectForKey:@"teller_Id"]] CGRect:CGRectMake(160, 180+50*3, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        
        //身份证号
        [PDFRenderer printStr:[NSString stringWithFormat:@"身份证号:%@",[tableDict objectForKey:@"Id_No"]] CGRect:CGRectMake(600, 180+50*3, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //加载应用
        NSString * Load_App1 =[tableDict objectForKey:@"Load_App1"];
        
        NSString * Succ_Type1 =[tableDict objectForKey:@"Succ_Type1"];

        NSString * Load_App2 =[tableDict objectForKey:@"Load_App2"];

        NSString * Succ_Type2 =[tableDict objectForKey:@"Succ_Type2"];

        
        [PDFRenderer printStr:[NSString stringWithFormat:@"加载应用:%@   %@\n                %@      %@",Load_App1?Load_App1:@"",Succ_Type1?Succ_Type1:@"",Load_App2?Load_App2:@"",Succ_Type2?Succ_Type2:@""] CGRect:CGRectMake(160, 180+50*4, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

       
        //签字
        [PDFRenderer printStr:@"确认无误后签名:" CGRect:CGRectMake(600, 180+50*6, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"经办:%@",[tableDict objectForKey:@"teller_Id"]] CGRect:CGRectMake(600, 220+50*8, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        [PDFRenderer printStr:@"复核:" CGRect:CGRectMake(800, 220+50*8, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
    }
    else if ([trans_Code isEqualToString:@"162002"]){
        
        //机构号
        NSString *org_Id  =[tableDict objectForKey:@"org_Id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"机构号:%@",org_Id] CGRect:CGRectMake(160, 128, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        //交易日期
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易日期:%@",[PCMobileBankGlobal sharedInstance].writeDate] CGRect:CGRectMake(600, 128, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        
        //交易名称
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易名称:%@",[tableDict objectForKey:@"trans_Name"]] CGRect:CGRectMake(160, 128+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //现转标志
        [PDFRenderer printStr:[NSString stringWithFormat:@"现转标志:%@",[tableDict objectForKey:@"cash_TranFlag"]] CGRect:CGRectMake(600, 128+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //流水号
        [PDFRenderer printStr:[NSString stringWithFormat:@"流水号:%@",[lastDict objectForKey:@"seq_No"]] CGRect:CGRectMake(900, 128+50, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //客户名称
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户名称:%@",[tableDict objectForKey:@"customer_Name"]] CGRect:CGRectMake(160, 128+45*2, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //客户账号
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户账号:%@",[tableDict objectForKey:@"card_Number"]] CGRect:CGRectMake(600, 128+45*2, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        //收费项目1
        [PDFRenderer printStr:[NSString stringWithFormat:@"收费项目1:%@",[tableDict objectForKey:@"fee_Option1"]] CGRect:CGRectMake(160, 128+45*3, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //收费账号1
        [PDFRenderer printStr:[NSString stringWithFormat:@"收费账号1:%@",[tableDict objectForKey:@"fee_AcctNo"]] CGRect:CGRectMake(600, 128+45*3, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        //金额1
        [PDFRenderer printStr:[NSString stringWithFormat:@"金额1:(大写)人民币 %@",[tableDict objectForKey:@"amount_Dx"]] CGRect:CGRectMake(160, 128+45*4, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //收费账号1
        [PDFRenderer printStr:[NSString stringWithFormat:@"(小写) %@",[tableDict objectForKey:@"amount_Xx"]] CGRect:CGRectMake(600, 128+45*4, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        //会计分录
        [PDFRenderer printStr:[NSString stringWithFormat:@"会计分录: %@",[tableDict objectForKey:@"kj_fl"]] CGRect:CGRectMake(160, 128+45*5, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        
        //备注:售出凭证种类
        [PDFRenderer printStr:[NSString stringWithFormat:@"备注:售出凭证种类: %@",[tableDict objectForKey:@"cert_Type"]] CGRect:CGRectMake(140, 128+45*6, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        //批次
        [PDFRenderer printStr:[NSString stringWithFormat:@"批次: %@",[tableDict objectForKey:@"Pre_CharCode"]] CGRect:CGRectMake(600, 128+45*6, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //起始号码
        [PDFRenderer printStr:[NSString stringWithFormat:@"起始号码: %@",[tableDict objectForKey:@"begin_No"]] CGRect:CGRectMake(140, 128+45*7, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //终止号码:
        [PDFRenderer printStr:[NSString stringWithFormat:@"终止号码: %@",[tableDict objectForKey:@"end_No"]] CGRect:CGRectMake(600, 128+45*7, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        
        //数量
        [PDFRenderer printStr:[NSString stringWithFormat:@"数量: %@",[tableDict objectForKey:@"cert_Num"]] CGRect:CGRectMake(900, 128+45*7, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        
        
        
        
        //签字
        [PDFRenderer printStr:@"确认无误后签名:" CGRect:CGRectMake(600, 160+50*8, WIDTH, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"经办:%@",[tableDict objectForKey:@"teller_Id"]] CGRect:CGRectMake(600, 220+50*8, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"复核:%@",[tableDict objectForKey:@"auth_TellerId"]] CGRect:CGRectMake(800, 220+50*8, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        
    }
    
    
}
#pragma mark---解除合并账号  一卡通应用加载  凭证出售
+ (void)AcctManager:(NSDictionary*)dict lastPrint:(NSDictionary *)lastDict{
    
      
    
    UIImage *image  =[UIImage imageNamed:@"76*76"];
    
    [image drawInRect:CGRectMake(150, 70, 50, 50)];
    
    /**
     
     农 村 商 业 银 行\n农 村 合 作 银 行
     
     */

    NSString *trans_Code  =[dict objectForKey:@"trans_Code"];
    
    if([trans_Code isEqualToString:@"162002"])
    {
        
        [PDFRenderer printStr:@"广西农村信用社                           业务收费凭证" CGRect:CGRectMake(220, 80, WIDTH, 200) Font:35.0   fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        //签名
        [[PCMobileBankGlobal sharedInstance].writeImage drawInRect:CGRectMake(800, 140+50*8, 200, 60)];

    }
    
    else{
        
        [PDFRenderer printStr:@"广西农村信用社                           通用凭证" CGRect:CGRectMake(220, 80, WIDTH, 200) Font:35.0   fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        //签名
        [[PCMobileBankGlobal sharedInstance].writeImage drawInRect:CGRectMake(800, 160+50*6, 200, 60)];

    }

    
    
    [PDFRenderer printStr:@"农 村 商 业 银 行\n农 村 合 作 银 行" CGRect:CGRectMake(500, 65, 300, 200) Font:22.0  fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"（               ）" CGRect:CGRectMake(452, 70, 300, 200) Font:42.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //画一个 矩形框
    [PDFRenderer drawEmptySquareWithCGRect:CGRectMake(80, 160, 1014, 450)];
    
    
    
    [self printAcctManager:dict lastDict:lastDict];
    
    
   
    
    
    
}

+ (void)other:(NSDictionary*)dict lastPrint:(NSDictionary *)lastDict{
    
    
    
    
    UIImage *image  =[UIImage imageNamed:@"76*76"];
    
    [image drawInRect:CGRectMake(150, 70, 50, 50)];
    
    
    /**
     
     农 村 商 业 银 行\n农 村 合 作 银 行
     
     */
    
    [PDFRenderer printStr:@"广西农村信用社                           特殊业务凭证" CGRect:CGRectMake(220, 80, WIDTH, 200) Font:35.0   fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"农 村 商 业 银 行\n农 村 合 作 银 行" CGRect:CGRectMake(500, 65, 300, 200) Font:22.0  fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"（               ）" CGRect:CGRectMake(452, 70, 300, 200) Font:42.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //申请日期：    年    月    日
        
    [PDFRenderer printStr:[PCMobileBankGlobal sharedInstance].writeDate CGRect:CGRectMake(532, 130, 300, 200) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"第                    号" CGRect:CGRectMake(800, 130, 300, 200) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //画一个 矩形框
    [PDFRenderer drawEmptySquareWithCGRect:CGRectMake(80, 160, 1014, 650)];
    
    
    //本人确认下 面的横线
    [PDFRenderer drawLineFromPoint:CGPointMake(80, 500) toPoint:CGPointMake(1094, 500)];
    
    
    [PDFRenderer printStr:@"本人确认所申请业务与信用社（银行）打印栏记录相符，申请人签字______________________" CGRect:CGRectMake(150, 470, 1000, 50) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [[PCMobileBankGlobal sharedInstance].WriteProtectNumber drawInRect:CGRectMake(850, 430, 200, 60)];
    
    
    [PDFRenderer printStr:@"申请事项描述:" CGRect:CGRectMake(150, 530, 1000, 50) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"账户种类__________户名______________账（卡）号________________________________\n\n币种________身份证件名称__________身份证件号码_________________________________" CGRect:CGRectMake(150, 700, 1000, 500) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    
    //信用社︵银行︶打印 右面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(140, 160) toPoint:CGPointMake(140, 810)];
    
    
    [PDFRenderer printStr:@"信用社︵银行︶打印" CGRect:CGRectMake(97, 210, 30, 300) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"客户申请" CGRect:CGRectMake(97, 610, 30, 300) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"第一联信用社︵银行︶留存" CGRect:CGRectMake(1111, 410, 23, 300) Font:16.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [self printOther:dict lastDict:lastDict];
    
    
    
}
+(void)printOther:(NSDictionary *)tableDict  lastDict:(NSDictionary *)lastDict{
    
    
    //机构号
    NSString *applicant_Organ = [tableDict objectForKey:@"applicant_Organ"];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"机构号:%@",applicant_Organ] CGRect:CGRectMake(160, 130, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //交易类型
    NSString *applicant_Desc = [tableDict objectForKey:@"applicant_Desc"];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易类型:%@",applicant_Desc] CGRect:CGRectMake(160, 180, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //户名
    NSString *applicant_AcctName = [tableDict objectForKey:@"applicant_AcctName"];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"户名:%@",applicant_AcctName] CGRect:CGRectMake(500, 180, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //卡号
    NSString *applicant_AcctNo = [tableDict objectForKey:@"applicant_AcctNo"];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"卡号:%@",applicant_AcctNo] CGRect:CGRectMake(160, 180+50, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //币种
    NSString *applicant_momonyType = [tableDict objectForKey:@"applicant_momonyType"];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"币种:%@",applicant_momonyType] CGRect:CGRectMake(500, 180+50, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //新卡类型
    NSString *applicant_cardtype = [tableDict objectForKey:@"applicant_cardtype"];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"新卡类型:%@",applicant_cardtype] CGRect:CGRectMake(160, 180+50*2, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    //申请事项描述
    NSString *applicant_Desc1 = [tableDict objectForKey:@"applicant_Desc1"];
    
    [PDFRenderer printStr:applicant_Desc1 CGRect:CGRectMake(200, 180+50*8, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    /**
     *  打印区域
     */
    //账户种类
    NSString *applicant_AccType = [tableDict objectForKey:@"applicant_AccType"];
    
    [PDFRenderer printStr:applicant_AccType CGRect:CGRectMake(250, 150+50*11-2, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:applicant_AcctName CGRect:CGRectMake(450, 150+50*11-2, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:applicant_AcctNo CGRect:CGRectMake(750, 150+50*11-2, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:applicant_momonyType CGRect:CGRectMake(200, 150+50*12-2, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //证件名称
    [PDFRenderer printStr:@"身份证" CGRect:CGRectMake(440, 150+50*12-2, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //applicant_IdNo证件号码
    
    [PDFRenderer printStr:[tableDict objectForKey:@"applicant_IdNo"] CGRect:CGRectMake(700, 150+50*12-2, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"经办:%@",[PCMobileBankUtil getAppLoginSession].userNo] CGRect:CGRectMake(200, 150+50*12-2+70, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"复核:%@",[tableDict objectForKey:@"applicant_HandleTeller"]] CGRect:CGRectMake(500, 150+50*12-2+70, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"授权:%@",[tableDict objectForKey:@"applicant_HandleTellerC"]] CGRect:CGRectMake(800, 150+50*12-2+70, 600, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    /**
     *  //经办
     self.Jin_Ban.text = [PCMobileBankUtil getAppLoginSession].userNo;
     //复核
     self.ReCheck.text  =[self.infoDict objectForKey:@"applicant_HandleTeller"];
     //授权
     self.License.text = [self.infoDict objectForKey:@"applicant_HandleTellerC"];
     
     *
     */
    
    
    
    
}

+(void)printSpecialBusiness:(NSDictionary *)tableDict  lastDict:(NSDictionary *)lastDict{
    
  
    CGFloat X = 100;
    
    CGFloat Y = 60;
    
    
    
    
    UIImage *selectImage  =[UIImage imageNamed:@"cutPicSelect.png"];
    
    //户名
    NSString *customerName  =[tableDict objectForKey:@"customerName"];
    
    [PDFRenderer printStr:customerName CGRect:CGRectMake(300, 509, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //卡号、账号
    NSString *cardNumber  =[tableDict objectForKey:@"cardNumber"];
    
    [PDFRenderer printStr:cardNumber CGRect:CGRectMake(760, 509, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //证件号码
    NSString *personNum  =[tableDict objectForKey:@"personNum"];
    
    [PDFRenderer printStr:personNum CGRect:CGRectMake(760, 509+40, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //证件名称
    NSString *idType  =[tableDict objectForKey:@"idType"];
    
    [PDFRenderer printStr:idType CGRect:CGRectMake(300, 509+40, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //其他
    NSString *others  =[tableDict objectForKey:@"others"];
    
    [PDFRenderer printStr:others CGRect:CGRectMake(730, 675, 300, 30) Font:20.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    /**
     
     
     //机构号
     NSString *Organ = [dict objectForKey:@"Organ"];
     //交易名称
     NSString *TransName = [dict objectForKey:@"TransName"];
     //交易流水号
     NSString *SeqNum = [dict objectForKey:@"SeqNum"];
     //旧卡号
     NSString *CardNum = [dict objectForKey:@"CardNum"];
     //新卡号
     NSString *CardNum1 = [dict objectForKey:@"CardNum1"];
     //客户名称
     NSString *CustName = [dict objectForKey:@"CustName"];
     //客户账号
     NSString *CustAcct = [dict objectForKey:@"CustAcct"];
     //银行评级
     NSString *ServiceLevel = [dict objectForKey:@"ServiceLevel"];
     //证件类型
     NSString *IdType = [dict objectForKey:@"IdType"];
     //证件号码
     NSString *IdNo = [dict objectForKey:@"IdNo"];
     //新卡类型
     NSString *NewCardType = [dict objectForKey:@"NewCardType"];
     //开通电子现金
     NSString *OpenEccCout = [dict objectForKey:@"OpenEccCout"];
     //柜员号
     NSString *Teller = [dict objectForKey:@"Teller"];
     //授权人
     NSString *AutoTeller = [dict objectForKey:@"AutoTeller"];

     */
    
    NSString *TransCode  =[lastDict objectForKey:@"TransCode"];
    
    
    //卡片激活解锁
    if(TransCode&&[TransCode isEqualToString:@"215032"]){
        
        [selectImage drawInRect:CGRectMake(836,632, 25, 25)];
        
        
        //交易机构
        NSString *Organ  =[lastDict objectForKey:@"Organ"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易机构:%@",Organ] CGRect:CGRectMake(150+X, 170+Y, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //交易名称
        NSString *TransName  =[lastDict objectForKey:@"TransName"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易名称:%@",TransName] CGRect:CGRectMake(150+X, 170+40+Y, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //卡号
        NSString *CardNum  =[lastDict objectForKey:@"CardNum"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"卡号:%@",CardNum] CGRect:CGRectMake(150+X, 170+40*2+Y, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //证件号码
        NSString *IdNo =[lastDict objectForKey:@"IdNo"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件号码:%@",IdNo] CGRect:CGRectMake(150+X, 170+40*3+Y, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //交易时间
        NSString *TellerranTime =[lastDict objectForKey:@"TellerranTime"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易时间:%@",TellerranTime] CGRect:CGRectMake(150+X, 170+40*4+Y, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //柜员号
        NSString *Teller =[lastDict objectForKey:@"Teller"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"柜员号:%@",Teller] CGRect:CGRectMake(550+X, 170+40*4+Y, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //证件类型
        NSString *IdType =[lastDict objectForKey:@"IdType"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件类型:%@",IdType] CGRect:CGRectMake(550+X, 170+40*3+Y, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //客户名称
        NSString *CustName  =[lastDict objectForKey:@"CustName"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户名称:%@",CustName] CGRect:CGRectMake(550+X, 170+40+Y, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //流水号
        NSString *SeqNum  =[lastDict objectForKey:@"SeqNum"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"流水号:%@",SeqNum] CGRect:CGRectMake(550+X, 170+Y, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    }
    //正常换卡
    else if(TransCode&&[TransCode isEqualToString:@"215012"]){
        
        [selectImage drawInRect:CGRectMake(468,632, 25, 25)];
        
        //交易机构
        NSString *Organ  =[lastDict objectForKey:@"Organ"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易机构:%@",Organ] CGRect:CGRectMake(150, 170, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //交易名称
        NSString *TransName = [lastDict objectForKey:@"TransName"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易名称:%@",TransName] CGRect:CGRectMake(500, 170, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //交易流水号
        NSString *SeqNum = [lastDict objectForKey:@"SeqNum"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易流水号:%@",SeqNum] CGRect:CGRectMake(850, 170, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //旧卡号
        NSString *CardNum  =[lastDict objectForKey:@"CardNum"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"旧卡号:%@",CardNum] CGRect:CGRectMake(150, 170+50, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //新卡号
        NSString *CardNum1  =[lastDict objectForKey:@"CardNum1"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"新卡号:%@",CardNum1] CGRect:CGRectMake(700, 170+50, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        //客户名称
        NSString *CustName  =[lastDict objectForKey:@"CustName"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户名称:%@",CustName] CGRect:CGRectMake(150, 170+50*2, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //客户账号
        NSString *CustAcct  =[lastDict objectForKey:@"CustAcct"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户账号:%@",CustAcct] CGRect:CGRectMake(500, 170+50*2, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //银行评级
        NSString *ServiceLevel  =[lastDict objectForKey:@"ServiceLevel"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"银行评级:%@",ServiceLevel] CGRect:CGRectMake(850, 170+50*2, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        /**
         *    //证件类型
         NSString *IdType = [dict objectForKey:@"IdType"];
         //证件号码
         NSString *IdNo = [dict objectForKey:@"IdNo"];
         //新卡类型
         NSString *NewCardType = [dict objectForKey:@"NewCardType"];
         */
        
        //证件类型
        NSString *IdType  =[lastDict objectForKey:@"IdType"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户名称:%@",IdType] CGRect:CGRectMake(150, 170+50*3, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //证件号码
        NSString *IdNo  =[lastDict objectForKey:@"IdNo"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户账号:%@",IdNo] CGRect:CGRectMake(500, 170+50*3, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //新卡类型
        NSString *NewCardType  =[lastDict objectForKey:@"NewCardType"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"银行评级:%@",NewCardType] CGRect:CGRectMake(850, 170+50*3, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        /**
         *    //开通电子现金
         NSString *OpenEccCout = [dict objectForKey:@"OpenEccCout"];
         //柜员号
         NSString *Teller = [dict objectForKey:@"Teller"];
         //授权人
         NSString *AutoTeller = [dict objectForKey:@"AutoTeller"];
         */
        //开通电子现金
        NSString *OpenEccCout  =[lastDict objectForKey:@"OpenEccCout"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"开通电子现金:%@",OpenEccCout] CGRect:CGRectMake(150, 170+50*4, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //柜员号
        NSString *Teller  =[lastDict objectForKey:@"Teller"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"柜员号:%@",Teller] CGRect:CGRectMake(500, 170+50*4, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //授权人
        NSString *AutoTeller  =[lastDict objectForKey:@"AutoTeller"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"授权人:%@",AutoTeller] CGRect:CGRectMake(850, 170+50*4, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];


        
    }
    //密码重置
    else if(TransCode&&[TransCode isEqualToString:@"215031"]){
        
        [selectImage drawInRect:CGRectMake(651,632, 25, 25)];
        
    }
    
    
    
    //    //有折卡脱卡
    //    [selectImage drawInRect:CGRectMake(270,632, 25, 25)];
    //
    //    //销卡
    //    [selectImage drawInRect:CGRectMake(364,632, 25, 25)];
    //
    //    //换卡
    //    [selectImage drawInRect:CGRectMake(468,632, 25, 25)];
    //
    //    //密码重置、修改
    //    [selectImage drawInRect:CGRectMake(651,632, 25, 25)];
    //
    //    //密码解锁、解锁
    //    [selectImage drawInRect:CGRectMake(836,632, 25, 25)];
    //
    //
    //
    //
    //
    //    //第二行 卡消费限额管理
    //    [selectImage drawInRect:CGRectMake(314,679, 25, 25)];
    //
    //    //交易限额 每次
    //    [selectImage drawInRect:CGRectMake(328,817, 25, 25)];
    //
    //
    //    //交易限额 每日
    //    [selectImage drawInRect:CGRectMake(405,817, 25, 25)];
    //
    //
    //    //卡没收、归还
    //    [selectImage drawInRect:CGRectMake(485,679, 25, 25)];
    //    //挂失补卡
    //    [selectImage drawInRect:CGRectMake(629,679, 25, 25)];
    
    NSString *jumpDiction  =[PCMobileBankGlobal sharedInstance].jumpDirection;
    
    
    if ([jumpDiction isEqualToString:@"specialCard"]) {
     
        
        //机构号
        NSString *brc_Id  =[lastDict objectForKey:@"brc_Id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"机构号:%@",brc_Id] CGRect:CGRectMake(150, 170, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //0-新增 1-删除 操作标志
        NSString *operation_flag  =[lastDict objectForKey:@"operation_flag"];
        
        if ([operation_flag isEqualToString:@"0"]) {
            
            operation_flag = @"新增";
        }
        else if([operation_flag isEqualToString:@"1"])
        
        {
            operation_flag = @"删除";
            
        }
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"操作标志:%@",operation_flag] CGRect:CGRectMake(500, 170, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //交易日期
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易日期:%@",[PCMobileBankGlobal sharedInstance].writeDate] CGRect:CGRectMake(800, 170, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        /**
         *    "Teller_id" = 130011;
         "User_Id" = 130210;
         "applicant_TermSeq" = 23802;
         "begin_Date" = "";
         "brc_Id" = 1726;
         cardNumber = 6231330500000336797;
         customerName = "\U4faf\U68ee\U9b41";
         "end_Date" = "2099-01-01";
         "free_type" = "";
         "id_Type" = "\U8eab\U4efd\U8bc1";
         "no_annual_fee" = "";
         "operation_flag" = "\U5220\U9664";
         personNum = 341224199005060996;
         "tran_Date" = "";
         */
        //卡号
        NSString *cardNumber  =[lastDict objectForKey:@"cardNumber"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"卡号:%@",cardNumber] CGRect:CGRectMake(150, 170+50, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //主机流水号
        NSString *applicant_TermSeq  =[lastDict objectForKey:@"applicant_TermSeq"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"主机流水号:%@",applicant_TermSeq] CGRect:CGRectMake(500, 170+50, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //客户名称
        NSString *customerName  =[lastDict objectForKey:@"customerName"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户名称:%@",customerName] CGRect:CGRectMake(850, 170+50, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //证件类型
        NSString *id_Type  =[lastDict objectForKey:@"id_Type"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件类型:%@",id_Type] CGRect:CGRectMake(150, 170+50*2, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //证件号码
        NSString *personNum  =[lastDict objectForKey:@"personNum"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件号码:%@",personNum] CGRect:CGRectMake(450, 170+50*2, 600, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //免费类型
        NSString *free_type  =[lastDict objectForKey:@"free_type"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"免费类型:%@",free_type] CGRect:CGRectMake(850, 170+50*2, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        
        
        //免年费数
        NSString *no_annual_fee  =[lastDict objectForKey:@"no_annual_fee"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"免年费数:%@",no_annual_fee] CGRect:CGRectMake(150, 170+50*3, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //开始日期
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"开始日期:%@",[PCMobileBankGlobal sharedInstance].writeDate] CGRect:CGRectMake(500, 170+50*3, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        //结束日期
        NSString *end_Date  =[lastDict objectForKey:@"end_Date"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"结束日期:%@",end_Date] CGRect:CGRectMake(850, 170+50*3, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //经办人
        NSString *User_Id  =[lastDict objectForKey:@"User_Id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"经办人:%@",User_Id] CGRect:CGRectMake(150, 170+50*4, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //授权人
        NSString *Teller_id  =[lastDict objectForKey:@"Teller_id"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"授权人:%@",Teller_id] CGRect:CGRectMake(500, 170+50*4, 300, 30) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        

        }
}


#pragma mark---银行卡特殊业务凭证

+ (void)specialBusiness:(NSDictionary*)dict lastPrint:(NSDictionary *)lastDict{
    
    UIImage *image  =[UIImage imageNamed:@"76*76"];
    
    [image drawInRect:CGRectMake(150, 70, 50, 50)];
    
    
    /**
     
     农 村 商 业 银 行\n农 村 合 作 银 行
     
     */
    
    [PDFRenderer printStr:@"广西农村信用社                           银行卡特殊业务凭证" CGRect:CGRectMake(220, 80, WIDTH, 200) Font:35.0   fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"农 村 商 业 银 行\n农 村 合 作 银 行" CGRect:CGRectMake(500, 65, 300, 200) Font:22.0  fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"（               ）" CGRect:CGRectMake(452, 70, 300, 200) Font:42.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //申请日期：    年    月    日
    
    [PDFRenderer printStr:@"申请日期：" CGRect:CGRectMake(452, 130, 300, 200) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:[PCMobileBankGlobal sharedInstance].writeDate CGRect:CGRectMake(602, 130, 300, 200) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"序号:" CGRect:CGRectMake(860, 130, 300, 200) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    [PDFRenderer drawEmptySquareWithCGRect:CGRectMake(80, 160, 1014, 700)];
    
    
    
    //户名* 上面的横线
    [PDFRenderer drawLineFromPoint:CGPointMake(80, 500) toPoint:CGPointMake(1094, 500)];
    
    [PDFRenderer printStr:@"户        名" CGRect:CGRectMake(160, 509, 300, 30) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"证 件 名 称" CGRect:CGRectMake(155, 509+40, 300, 30) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    NSString *customSignString =@"       本人选择（√）以下业务，并承诺提供的所有资料真实、合法、准确，如有违反，承担由此引起的法律责任。\n1.有折卡脱折□   2.销卡□     3.换卡□    4.密码重置/修改□    5.密码解锁/激活□\n\n 6.卡消费限额管理□     7.卡没收/归还□     8.挂失补卡□    9.其他____________\n\n 如选择6项，请继续填写一下栏目:\n\n          交易限额:_____________                        本人确定所申请业务与信用社（银行）打印栏记录相符。\n\n          周   期:   每次□   每日□                                 客户签名:";
    
    [PDFRenderer printStr:customSignString CGRect:CGRectMake(155, 509+40*2, 920, 400) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //客户签名
    [[PCMobileBankGlobal sharedInstance].writeImageCardActive drawInRect:CGRectMake(780,  509+40*7+5, 200, 60)];
    
    //户名* 右面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(280, 500) toPoint:CGPointMake(280, 580)];
    
    
    //卡号* 左面的竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(580, 500) toPoint:CGPointMake(580, 580)];
    
    [PDFRenderer printStr:@"卡(账)号" CGRect:CGRectMake(595, 509, 300, 30) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"证 件 号 码" CGRect:CGRectMake(595, 509+40, 300, 30) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //卡号* 右面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(710, 500) toPoint:CGPointMake(710, 580)];
    
    //户名* 下面的横线
    [PDFRenderer drawLineFromPoint:CGPointMake(140, 540) toPoint:CGPointMake(1094, 540)];
    
    //证件名称* 下面的横线
    [PDFRenderer drawLineFromPoint:CGPointMake(140, 580) toPoint:CGPointMake(1094, 580)];
    
    //户名* 左面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(140, 160) toPoint:CGPointMake(140, 860)];
    
    
    [PDFRenderer printStr:@"信用社︵银行︶打印" CGRect:CGRectMake(97, 210, 30, 300) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"客户填写" CGRect:CGRectMake(97, 610, 30, 300) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"附件\n\n\n\n\n\n张" CGRect:CGRectMake(1111, 310, 23, 300) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //
    /**
     *  本人选择（√）以下业务，并承诺提供的所有资料真实、合法、准确，如有违反，承担由此引起的法律责任。
     1.有折卡脱折□   2.销卡□     3.换卡□    4.密码重置/修改□    5.密码解锁/激活□
     
     6.卡消费限额管理□     7.卡没收/归还□     8.挂失补卡□    9.其他____________
     
     如选择6项，请继续填写一下栏目:
     
     交易限额:_____________        本人确定所申请业务与信用社（银行）打印栏记录相符。
     周   期:   每次□   每日□       客户签名:_______________
     */
    
    [self printSpecialBusiness:dict lastDict:lastDict];

    
}
#pragma mark---短信通签解约 电话银行签解约

+ (void)createContractSignPDF
{
    
    
    [PDFRenderer printStr:@"广西农村信用社（农村商业银行、农村合作银行）" CGRect:CGRectMake(0, 20+3, 612, 200) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"电子银行个人客户服务申请回执" CGRect:CGRectMake(0, 45+1, 612, 200) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"网址:www.gx966888.com(http://ebank.gx966888.com)" CGRect:CGRectMake(40, 70, 612, 10) Font:8.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"客服电话:966888(广西区外加拨0771)" CGRect:CGRectMake(412, 70, 150, 10) Font:8.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentRight];

    
    [PDFRenderer printStr:@"银\n\n\n行\n\n\n打\n\n\n印" CGRect:CGRectMake(45, 300, 10, 300) Font:9.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"第\n\n一\n\n联\n\n\n\n\n银\n\n行\n\n留\n\n存" CGRect:CGRectMake(580, 300, 10, 300) Font:9.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"U_key 或刮刮卡编号:" CGRect:CGRectMake(65, 560, 120, 30) Font:9.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

    [PDFRenderer drawLineFromPoint:CGPointMake(178, 570) toPoint:CGPointMake(330, 570)];

    
    //画空心矩形框
    [PDFRenderer drawEmptySquareWithCGRect:CGRectMake(40, 85, 530, 680)];

    
    //银行打印 右边的那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(60, 85) toPoint:CGPointMake(60, 580)];
    
    //刮刮卡编号 下面的那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(40, 580) toPoint:CGPointMake(570, 580)];

    //最下面的分割线
    [PDFRenderer drawLineFromPoint:CGPointMake(285, 580) toPoint:CGPointMake(285, 680+85)];
    
    [PDFRenderer printStr:@"客户确认:\n\n\n     本人确定所申请业务与银行打印内容相符。如领\n\n\n取网上银行认证工具的,已核对认证工具编号无误。" CGRect:CGRectMake(40+5, 600, 220, 300) Font:9.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"银行签章:" CGRect:CGRectMake(285+5, 600, 200, 100) Font:9.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

}
#endif

#pragma mark---打印短信通 电话银行签约 解约
+ (void)printWordsMessageAndPhoneBank:(NSDictionary *)dictData{

    
    CGFloat Y =115;
    
    //对号
    UIImage *imageSelect  =[UIImage imageNamed:@"cutPicSelect"];
    
    //客户姓名 中文
    
    NSString * custName = [dictData objectForKey:@"custName"];
    
    [PDFRenderer printStr:custName CGRect:CGRectMake(80+Horizontal_Line_Distance_150, Y+Vertical_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //客户姓名 英文
    NSString * CustEngName = [dictData objectForKey:@"CustEngName"];
    
    [PDFRenderer printStr:CustEngName CGRect:CGRectMake(780, Y+Vertical_Line_Distance_60, 300, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //证件号码
    NSString * IdNo = [dictData objectForKey:@"IdNo"];
    
    [PDFRenderer printStr:[PDFRenderer addEmptyStringWith:IdNo] CGRect:CGRectMake(690, Y+110, 500, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //证件有效期
    NSString * validDate = [dictData objectForKey:@"validDate"];
    
    [PDFRenderer printStr:validDate CGRect:CGRectMake(750, Y+150, 380, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //通讯地址
    NSString * Address = [dictData objectForKey:@"Address"];
    
    [PDFRenderer printStr:Address CGRect:CGRectMake(700, Y+190, 480, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //*证件类型
    NSString * IdType  = [dictData objectForKey:@"IdType"];
    
    [PDFRenderer printStr:IdType  CGRect:CGRectMake(80+Horizontal_Line_Distance_210, Y+Vertical_Line_Distance_110, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //发证机关
    NSString * organ  = [dictData objectForKey:@"organ"];
    
    [PDFRenderer printStr:organ  CGRect:CGRectMake(70+Horizontal_Line_Distance_210, Y+Vertical_Line_Distance_150, 240, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //*手机号码
    NSString * shortMsgMoblie  = [dictData objectForKey:@"shortMsgMoblie"];
    
    NSString * Moblie  = [dictData objectForKey:@"Moblie"];
    
    shortMsgMoblie = shortMsgMoblie.length>1?shortMsgMoblie:Moblie;
    
    //如果为空  取另一个字段
    
    [PDFRenderer printStr:shortMsgMoblie  CGRect:CGRectMake(80+Horizontal_Line_Distance_210, Y+190, 180, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //*邮政编码
    NSString * zipCode  = [dictData objectForKey:@"zipCode"];
    
    [PDFRenderer printStr:zipCode  CGRect:CGRectMake(130, Y+230, 380, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //*账号（卡号）
    NSString * bussiCardId  = [dictData objectForKey:@"bussiCardId"];
    
    [PDFRenderer printStr:bussiCardId  CGRect:CGRectMake(80+250, Y+270, 600, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人签名
    UIImage *imageautograph  =[UIImage imageNamed:@"cutPicSelect"];
    
    [imageautograph drawInRect:CGRectMake(300, HEIGHT-245, 120, 36)];
    
    
    //申请日期
    NSString *writeDate  =@"2016年8月24";

    [PDFRenderer printStr:writeDate CGRect:CGRectMake(WIDTH-450, HEIGHT-240, 300, 30) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //*经办人
    NSString * UserId = [dictData objectForKey:@"UserId"];
    
    [PDFRenderer printStr:UserId  CGRect:CGRectMake(210,HEIGHT-200, 200, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //*授权人
    NSString * Teller = [dictData objectForKey:@"Teller"];
    
    [PDFRenderer printStr:Teller  CGRect:CGRectMake(500,HEIGHT-200, 200, Vertical_Line_Distance_60) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //性别    典型的 打钩方式
    NSString * sex = [dictData objectForKey:@"sex"];
    
    if([sex isEqualToString:@"男"]){
        
        [imageSelect  drawInRect:CGRectMake(102+Horizontal_Line_Distance_350,  Y+Vertical_Line_Distance_50-4, 25, 25)];
        
    }
    else{
        
        [imageSelect  drawInRect:CGRectMake(102+Horizontal_Line_Distance_350,  Y+Vertical_Line_Distance_50+17, 25, 25)];
        
    }
    
    //网上银行
    NSString * onlineBank = [dictData objectForKey:@"onlineBank"];
    
    if([onlineBank isEqualToString:@"1"])
    {
        
        [imageSelect  drawInRect:CGRectMake(180+80-3,  115+7*40+60+5, 25, 25)];
        
    }
    
    NSString * onlineBankType = [dictData objectForKey:@"onlineBankType"];
    
    //液晶Key
    if([onlineBankType isEqualToString:@"3"])
    {
        
        [imageSelect  drawInRect:CGRectMake(180+80+450,  115+7*40+60+7, 20, 20)];
        

        
    }
    
    //按键Key
    else if([onlineBankType isEqualToString:@"2"])
    {
        
        [imageSelect  drawInRect:CGRectMake(180+80+360-2,  115+7*40+60+7, 20, 20)];
        
        
    }
    
    //按键Key
    else if([onlineBankType isEqualToString:@"5"])
    {
        
        [imageSelect  drawInRect:CGRectMake(220+80+360,  115+7*40+60+7+16, 20, 20)];
        
        
    }

    
    //网上银行支付限额onlineBankPaySingle
    
    [PDFRenderer printStr:[dictData objectForKey:@"onlineBankPaySingle"] CGRect:CGRectMake(WIDTH-200,  115+7*40+60+7, 250, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    [PDFRenderer printStr:[dictData objectForKey:@"onlineBankPayDay"] CGRect:CGRectMake(WIDTH-200,  115+8*40+60+7, 250, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    
    
    //手机银行
    
    //手机银行 签约  解约  修改手机号
    NSString * mBank = [dictData objectForKey:@"mBank"];
    
    if([mBank isEqualToString:@"1"])
    {
        
        [imageSelect  drawInRect:CGRectMake(180+80-3,  115+7*40+60+5+80*3, 25, 25)];
        
        
    }
    
    //手机银行签约手机号
    
    [PDFRenderer printStr:[dictData objectForKey:@"mBankMoblie"] CGRect:CGRectMake(600, 115+7*40+86+80*3, 250, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    //手机银行 支付限额
    //单笔
    [PDFRenderer printStr:[dictData objectForKey:@"mBankPaySingle"] CGRect:CGRectMake(WIDTH-160, 115+7*40+66+80*3, 160, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    //日累计
    [PDFRenderer printStr:[dictData objectForKey:@"mBankPayDay"] CGRect:CGRectMake(WIDTH-160, 115+8*40+66+80*3, 160, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    

    
    
    
    //短信通 签约  解约  修改手机号
    NSString * shortMsg = [dictData objectForKey:@"shortMsg"];
    
    if([shortMsg isEqualToString:@"1"])
    {
        
        [imageSelect  drawInRect:CGRectMake(180+80-3,  115+7*40+60+5+80, 25, 25)];
        
        
    }
    else if([shortMsg isEqualToString:@"2"])
    {
        
        [imageSelect  drawInRect:CGRectMake(180+80-3,  115+7*40+86+80, 25, 25)];
        
    }
    else if([shortMsg isEqualToString:@"3"])
    {
        
        [imageSelect  drawInRect:CGRectMake(180+80-3,  115+8*40+67+80, 25, 25)];
        
    }
    
    if (![shortMsg isEqualToString:@""]) {
        
        //短信通 签约手机号
        [PDFRenderer printStr:shortMsgMoblie CGRect:CGRectMake(600, 115+7*40+86+80, 250, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    }
   
    
    
    //电话银行转账 签约  解约  修改手机号
    NSString * phoneBank = [dictData objectForKey:@"phoneBank"];
    
    if([phoneBank isEqualToString:@"1"])
    {
        
        [imageSelect  drawInRect:CGRectMake(180+80-3,  115+7*40+60+5+80*2, 25, 25)];
        
    }
    else if([phoneBank isEqualToString:@"2"])
    {
        
        [imageSelect  drawInRect:CGRectMake(180+80-3,  115+7*40+82+80*2+25, 25, 25)];
        
        
    }
    
    //*签约收款账号 1
    NSString * phoneBankAcct1 = [dictData objectForKey:@"phoneBankAcct1"];
    
    [PDFRenderer printStr:phoneBankAcct1  CGRect:CGRectMake(560,115+7*40+60+12+80*2, 300, 30) Font:FONT18 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    // 电话银行转账 *日累计转账限额（元）
    NSString * phoneBankPayAmount = [dictData objectForKey:@"phoneBankPayAmount"];
    
    [PDFRenderer printStr:phoneBankPayAmount  CGRect:CGRectMake(WIDTH-180,115+7*40+60+28+80*2, 300, 30) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
#pragma mark---电子支付客户 信息维护
    // 电子支付客户 信息维护
    NSString * ePlayCustom = [dictData objectForKey:@"ePlayCustom"];
    
    [PDFRenderer printStr:ePlayCustom  CGRect:CGRectMake(WIDTH-180,115+7*40+60+28+80*2, 300, 30) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    
    
    //ePlayCustom

}

/**
 * 思路: 1.布局大区
 2.先画线条
 3.最后画文字
 */
#pragma mark----创建开卡表格

+ (void)openBankCard:(NSDictionary*)tableDict  last:(NSDictionary *)lastDict{
    
//    //Create the PDF context using the default page size of 612 x 792.
//    UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
//    // Mark the beginning of a new page.
//    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, WIDTH, HEIGHT), nil);
    
    UIImage *image  =[UIImage imageNamed:@"76*76"];
    
    [image drawInRect:CGRectMake(70, 42, 50, 50)];
    
    
    [PDFRenderer printStr:@"广西农村信用社（农村商业银行、农村合作银行）" CGRect:CGRectMake(120, 50, WIDTH, 200) Font:32.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"GUANGXI RURAL CREDIT UNION & COMMERCIAL BANK & COOPERATIVE BANK" CGRect:CGRectMake(140, 95, WIDTH, 200) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"个人结算账户申请表" CGRect:CGRectMake(WIDTH-415, 55, WIDTH/2, 200) Font:37.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"网址:www.gx966888.com (http://ebank.gx966888.com)" CGRect:CGRectMake(80, 125, 612, 20) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请日期
     NSString  *writeDate =@"2016年8月9号";
    
    
    [PDFRenderer printStr:writeDate CGRect:CGRectMake(540, 155, 612, 20) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"客服电话:966888(广西区外加拨0771)" CGRect:CGRectMake(WIDTH-400, 125, 320, 20) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentRight];
    
    
    
    //画空心矩形框A
    
    CGFloat X =80;
    
    CGFloat Y =180;
    
    [PDFRenderer drawEmptySquareWithCGRect:CGRectMake(X, Y, WIDTH-140, HEIGHT-280)];
    
    //申请人 姓名
    [PDFRenderer printStr:@"姓    名" CGRect:CGRectMake(190, Y+3, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人 拼音或英文名
    [PDFRenderer printStr:@"拼音或英文名" CGRect:CGRectMake(450, Y+3, 150, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人 出生日期
    [PDFRenderer printStr:@"出生日期" CGRect:CGRectMake(740, Y+3, 120, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人 证件有效期至：
    [PDFRenderer printStr:@"证件有效期至：" CGRect:CGRectMake(732, Y+3+30, 200, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人职    业
    [PDFRenderer printStr:@"职    业" CGRect:CGRectMake(740, Y+3+30*2, 120, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    //申请人电子邮箱
    [PDFRenderer printStr:@"电子邮箱" CGRect:CGRectMake(740, Y+3+30*3, 120, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人邮政编码
    [PDFRenderer printStr:@"邮政编码" CGRect:CGRectMake(740, Y+3+30*4, 120, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //代理人邮政编码
    [PDFRenderer printStr:@"邮政编码" CGRect:CGRectMake(740, Y+3+30*8, 120, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //代理人通讯地址
    [PDFRenderer printStr:@"通讯地址" CGRect:CGRectMake(740, Y+3+30*5, 120, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //代理人 证件有效期至：
    [PDFRenderer printStr:@"证件有效期至：" CGRect:CGRectMake(732, Y+3+30*6, 200, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人 性别
    [PDFRenderer printStr:@"性别" CGRect:CGRectMake(1015, Y+3, 120, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人 国籍
    [PDFRenderer printStr:@"国籍" CGRect:CGRectMake(1015, Y+3+30*2, 120, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人 证件类型
    [PDFRenderer printStr:@"证件类型" CGRect:CGRectMake(190, Y+3+30, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    //申请人 发证机关
    [PDFRenderer printStr:@"发证机关" CGRect:CGRectMake(190, Y+3+30*2, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    //申请人 移动电话
    [PDFRenderer printStr:@"移动电话" CGRect:CGRectMake(190, Y+3+30*3, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人 固定电话
    [PDFRenderer printStr:@"固定电话" CGRect:CGRectMake(490, Y+3+30*3, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //代理人 联系电话
    [PDFRenderer printStr:@"联系电话" CGRect:CGRectMake(490, Y+3+30*5, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    //申请人 联系地址
    [PDFRenderer printStr:@"联系地址" CGRect:CGRectMake(190, Y+3+30*4, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    //代理人信息 姓    名
    [PDFRenderer printStr:@"姓    名" CGRect:CGRectMake(190, Y+3+30*5, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //代理人信息 证件类型
    [PDFRenderer printStr:@"证件类型" CGRect:CGRectMake(190, Y+3+30*6, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //代理人信息 发证机关
    [PDFRenderer printStr:@"发证机关" CGRect:CGRectMake(190, Y+3+30*7, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //代理人信息 与申请人的关系
    [PDFRenderer printStr:@"与申请人的关系" CGRect:CGRectMake(190, Y+3+30*8, 200, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //代理人信息 代办理由
    [PDFRenderer printStr:@"代办理由" CGRect:CGRectMake(190, Y+3+30*9, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //开户类型 普通客户
    [PDFRenderer printStr:@"普通客户" CGRect:CGRectMake(190, Y+3+30*10, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"□桂盛芯片卡 □桂盛复合卡 □桂盛工会卡 □桂盛市民卡 □桂盛信祥卡 □存折 □对账折 □其他" CGRect:CGRectMake(310, Y+3+30*10, WIDTH-200, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"□所需卡片种类：  □黄金卡      □白金卡      □钻石卡" CGRect:CGRectMake(310, Y+3+30*11, WIDTH-200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"￥" CGRect:CGRectMake(310, Y+3+30*12, 100, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer drawLineFromPoint:CGPointMake(330, Y+27+30*12) toPoint:CGPointMake(450, Y+27+30*12)];
    
    /**￥
     *  □桂盛芯片卡 □桂盛复合卡 □桂盛工会卡 □桂盛市民卡 □桂盛信祥卡 □存折 □对账折 □其他
     *
     *  @param 190 190 description
     *  @param 11  11 description
     *  @param 100 100 description
     *  @param 30  <#30 description#>
     *
     *  @return 所需卡片种类：  □黄金卡      □白金卡      □钻石卡
     */
    
    //开户类型 VIP客户
    [PDFRenderer printStr:@"VIP客户" CGRect:CGRectMake(190, Y+3+30*11, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //开户类型 开户金额
    [PDFRenderer printStr:@"开户金额" CGRect:CGRectMake(190, Y+3+30*12, 100, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请电子银行业务类型  □ 网上银行
    [PDFRenderer printStr:@"□ 网上银行" CGRect:CGRectMake(150, Y+30*14-10, 200, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请电子银行业务类型  网银认证方式
    [PDFRenderer printStr:@"网银认证方式" CGRect:CGRectMake(390, Y+30*14-10, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请电子银行业务类型  □刮刮卡　□按键U-key　□液晶U-key  □电子密码器　　□其他
    
    [PDFRenderer printStr:@"□刮刮卡　□按键U-key　□液晶U-key  □电子密码器  □其他" CGRect:CGRectMake(530, Y+30*14-13, 500, 60) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"（电子密码器用于iPad网上银行交易，可与U-key同时使用）" CGRect:CGRectMake(530, Y+30*15-15, 400, 60) Font:12.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //    [PDFRenderer printStr:@"（注：仅限广西区内手机号码）" CGRect:CGRectMake(WIDTH-280, Y+30*16-21, 400, 60) Font:15.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    /**
     *  □刮刮卡　□按键U-key　□液晶U-key
     □电子密码器　　□其他
     *
     *  @param 395  （电子密码器用于iPad网上银行交易，可与U-key同时使用）
     *  @param 15+6 （注：仅限广西区内手机号码）
     *  @param 200  200 description
     *  @param 30   30 description
     *
     *  @return <#return value description#>
     */
    
    //申请电子银行业务类型  签约手机号
    [PDFRenderer printStr:@"签约手机号" CGRect:CGRectMake(395, Y+30*15+6, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请电子银行业务类型  约定转入账户
    [PDFRenderer printStr:@"约定转入账户" CGRect:CGRectMake(390, Y+30*17+20, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请电子银行业务类型  电话银行 约定转入账户   户名
    [PDFRenderer printStr:@"户名" CGRect:CGRectMake(523, Y+30*16+6, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    //申请电子银行业务类型  电话银行 约定转入账户   账号或卡号
    [PDFRenderer printStr:@"账号或卡号" CGRect:CGRectMake(660, Y+30*16+6, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请电子银行业务类型  电话银行 约定转入账户   开户行全称（跨行）
    [PDFRenderer printStr:@"开户行全称（跨行）" CGRect:CGRectMake(910, Y+30*16+6, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //申请电子银行业务类型  电话银行 约定转入账户  转账限额
    [PDFRenderer printStr:@"转账限额" CGRect:CGRectMake(WIDTH-145, Y+30*16+6, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请电子银行业务类型  电话银行 约定转入账户  日累计5万元以内
    [PDFRenderer printStr:@"日累计5\n万元以\n内" CGRect:CGRectMake(WIDTH-155, Y+30*17+16, 100, 200) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    //申请电子银行业务类型  缴费限额
    [PDFRenderer printStr:@"缴费限额" CGRect:CGRectMake(405, Y+30*19+37, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请电子银行业务类型   手机银行  签约手机号
    [PDFRenderer printStr:@"签约手机号" CGRect:CGRectMake(400, Y+30*19+37*2, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请电子银行业务类型   电话银行  单笔     元以内，日累计     元以内（不填写金额则默认为不设限额）
    
    [PDFRenderer printStr:@"单笔                    元以内，日累计                  元以内（不填写金额则默认为不设限额）" CGRect:CGRectMake(520, Y+30*19+40, 800, 30) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    
    //申请电子银行业务类型  □ 短信通
    [PDFRenderer printStr:@"□ 短信通" CGRect:CGRectMake(139, Y+30*16-28, 200, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请电子银行业务类型  □ 电话银行
    [PDFRenderer printStr:@"□ 电话银行" CGRect:CGRectMake(150, Y+30*18+10, 200, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请电子银行业务类型  □ 手机银行
    [PDFRenderer printStr:@"□ 手机银行" CGRect:CGRectMake(150, Y+30*21+15, 200, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请电子银行业务类型  □ 支付宝卡通服务
    [PDFRenderer printStr:@"□ 支付宝卡通服务" CGRect:CGRectMake(175, Y+30*23+10, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请电子银行业务类型 □ 银联在线支付
    [PDFRenderer printStr:@"□ 银联在线支付" CGRect:CGRectMake(164, Y+30*25+5, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请电子银行业务类型 □ 银联在线支付    签约手机号
    [PDFRenderer printStr:@"签约手机号" CGRect:CGRectMake(350, Y+30*25+5, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请桂盛借记卡功能设置   □ 自助设备转账
    [PDFRenderer printStr:@"□ 自助设备转账" CGRect:CGRectMake(164, Y+30*27-5, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请桂盛借记卡功能设置   □开通境内ATM、CRS、BSM等自助设备转账功能。通过境内ATM等自助设备向境内他人账户每日转账限额人民币      元(5万元以内)。
    
    [PDFRenderer printStr:@"□开通境内ATM、CRS、BSM等自助设备转账功能。通过境内ATM等自助设备向境内他人账户\n   每日转账限额人民币                            元(5万元以内)。" CGRect:CGRectMake(384, Y+30*27-12, 800, 50) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    //申请桂盛借记卡功能设置   □ 电子现金
    [PDFRenderer printStr:@"□ 电子现金" CGRect:CGRectMake(144, Y+30*28+15, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请桂盛借记卡功能设置   □开通电子现金功能。
    [PDFRenderer printStr:@"□开通电子现金功能。" CGRect:CGRectMake(384, Y+30*28+15, 400, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请桂盛借记卡功能设置   □ POS交易限额  单笔限额（元）
    [PDFRenderer printStr:@"单笔限额（元）" CGRect:CGRectMake(354, Y+30*30-5, 200, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    //申请桂盛借记卡功能设置   □ POS交易限额  日累计限额（元）
    [PDFRenderer printStr:@"日累计限额（元）" CGRect:CGRectMake(710, Y+30*30-5, 200, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    //申请桂盛借记卡功能设置   □ POS交易限额  （注：如不填写，将设置为系统默认限额）
    [PDFRenderer printStr:@"（注：如不填写，将设置为系统默认限额）" CGRect:CGRectMake(550, Y+30*31-5, 500, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请桂盛借记卡功能设置   □ POS交易限额  日限次
    [PDFRenderer printStr:@"日限次" CGRect:CGRectMake(945, Y+30*30-5, 200, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    //申请桂盛借记卡功能设置   □ POS交易限额
    [PDFRenderer printStr:@"□ POS交易限额" CGRect:CGRectMake(164, Y+30*30+7, 200, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    
    
    
    
    
    
    [PDFRenderer printStr:@"申请人\n资料 " CGRect:CGRectMake(80, Y+50, 100, 150) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    /**
     *  代理人信息 申请电子银行业务类型
     *
     *  @param 80       <#80 description#>
     *  @param Y+50+150 <#Y+50+150 description#>
     *  @param 100      <#100 description#>
     *  @param 150      <#150 description#>
     *
     *  @return 申请桂盛借记卡功能设置 账户信息打印
     */
    [PDFRenderer printStr:@"代理人\n信息 " CGRect:CGRectMake(80, Y+50+150, 100, 150) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"开户\n类型" CGRect:CGRectMake(80, Y+320, 100, 150) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"申请电\n子银行\n业务类\n型" CGRect:CGRectMake(80, Y+520, 100, 150) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"申请桂\n盛借记\n卡功能\n设置" CGRect:CGRectMake(80, Y+820, 100, 150) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"账\n户\n信\n息\n打\n印" CGRect:CGRectMake(80, Y+1000, 100, 350) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人
    //姓名下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30) toPoint:CGPointMake(WIDTH-140+80, Y+30)];
    //证件类型 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*2) toPoint:CGPointMake(WIDTH-140+80, Y+30*2)];
    
    //发证机关 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*3) toPoint:CGPointMake(WIDTH-140+80, Y+30*3)];
    
    //移动电话 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*4) toPoint:CGPointMake(WIDTH-140+80, Y+30*4)];
    
    
    
    // 代理人
    //姓    名 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*6) toPoint:CGPointMake(WIDTH-140+80, Y+30*6)];
    
    //证件类型 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*7) toPoint:CGPointMake(WIDTH-140+80, Y+30*7)];
    
    //发证机关 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*8) toPoint:CGPointMake(WIDTH-140+80, Y+30*8)];
    
    //与申请人的关系 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*9) toPoint:CGPointMake(WIDTH-140+80, Y+30*9)];
    
    //代办理由 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*10) toPoint:CGPointMake(WIDTH-140+80, Y+30*10)];
    
    //普通客户 下面那条横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*11) toPoint:CGPointMake(WIDTH-140+80, Y+30*11)];
    //VIP客户 下面那条横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*12) toPoint:CGPointMake(WIDTH-140+80, Y+30*12)];
    
    //□ 网上银行 下面那条横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*15) toPoint:CGPointMake(WIDTH-140+80, Y+30*15)];
    //□ 短信通 下面那条横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*16) toPoint:CGPointMake(WIDTH-140+80, Y+30*16)];
    
    //户名 账号或卡号 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160, Y+30*16+27) toPoint:CGPointMake(WIDTH-140+80, Y+30*16+27)];
    
    //户名 账号或卡号 分割线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+45, Y+30*16) toPoint:CGPointMake(180+180+160+45, Y+30*16+25*4+24)];
    
    
    //账号或卡号   开户行全称（跨行）分割线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+40+330, Y+30*16) toPoint:CGPointMake(180+180+160+40+330, Y+30*16+25*4+24)];
    
    
    //支付限额 （单笔1万元以内，日累5万元以内）左边的 竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+40+330, Y+30*17+6*20) toPoint:CGPointMake(180+180+160+40+330, Y+30*17+5*20+180)];
    
    
    //□ 手机银行  支付限额 （单笔1万元以内，日累5万元以内）单笔  日累 分割线  横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+25+500, Y+30*17+6*20+27) toPoint:CGPointMake(WIDTH-60, Y+30*17+6*20+27)];
    
    
    //□ 支付宝卡通服务  支付限额 （单笔1万元以内，日累5万元以内）单笔  日累 分割线  横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+25+500, Y+30*17+6*20+27*3) toPoint:CGPointMake(WIDTH-60, Y+30*17+6*20+27*3)];
    
    //□ 支付宝卡通服务  支付宝账户 签约手机号  分割线  横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+20, Y+30*17+6*20+27*3) toPoint:CGPointMake(WIDTH-350, Y+30*17+6*20+27*3)];
    
    
    
    [PDFRenderer printStr:@"支付宝账户" CGRect:CGRectMake(180+180+40, Y+30*17+6*20+27*2+3, 100, 30) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:(NSTextAlignmentCenter)];
    
    [PDFRenderer printStr:@"□ 未申请或不确定。" CGRect:CGRectMake(180+280+290, Y+30*17+6*20+27*2+7, 300, 30) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    // 支付限额
    
    [PDFRenderer printStr:@"     支付限额\n（5000元以内)" CGRect:CGRectMake(250+380+280, Y+30*17+6*20+27*2+12, 200, 50) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //申请电子银行业务类型  银联在线支付  签约手机号  支付限额
    [PDFRenderer printStr:@"     支付限额\n（5000元以内)" CGRect:CGRectMake(250+380+280, Y+30*17+6*20+27*2+65, 200, 50) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请电子银行业务类型  手机银行  签约手机号  支付限额
    [PDFRenderer printStr:@"  支付限额" CGRect:CGRectMake(250+380+295, Y+30*17+6*20+27*2-45, 200, 50) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"单笔" CGRect:CGRectMake(380+380+293, Y+30*17+6*20+27*2-47, 200, 50) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"日累" CGRect:CGRectMake(380+380+293, Y+30*18+6*20+27*2-51, 200, 50) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"单笔" CGRect:CGRectMake(380+380+293, Y+30*18+6*20+27*2-24, 200, 50) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"日累" CGRect:CGRectMake(380+380+293, Y+30*18+6*20+27*2+3, 200, 50) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"单笔" CGRect:CGRectMake(380+380+293, Y+30*18+6*20+27*4-24, 200, 50) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"日累" CGRect:CGRectMake(380+380+293, Y+30*18+6*20+27*4+3, 200, 50) Font:15.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    [PDFRenderer printStr:@"（单笔1万元以内，日累\n      5万元以内）" CGRect:CGRectMake(210+380+270, Y+30*17+6*20+27*2-27, 200, 50) Font:11.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    [PDFRenderer printStr:@"签约手机号" CGRect:CGRectMake(180+180+40, Y+30*17+6*20+27*3+3, 100, 30) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:(NSTextAlignmentCenter)];
    
    
    //□ 银联在线支付 支付限额 （单笔1万元以内，日累5万元以内）单笔  日累 分割线  横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+25+500, Y+30*17+6*20+27*5-1) toPoint:CGPointMake(WIDTH-60, Y+30*17+6*20+27*5-1)];
    
    
    
    //开户行全称（跨行）  转账限额 分割线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+40+530, Y+30*16) toPoint:CGPointMake(180+180+160+40+530, Y+30*16+25*4+24)];
    
    
    //支付宝卡通服务    单笔 日累  右边的 竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+40+530, Y+30*17+6*20) toPoint:CGPointMake(180+180+160+40+530, Y+30*17+5*20+180)];
    
    
    //支付宝卡通服务    单笔 日累  左边的 竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+525, Y+30*17+6*20) toPoint:CGPointMake(180+180+160+525, Y+30*17+5*20+180)];
    
    
    //户名 账号或卡号 下面那条横线 下面的那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160, Y+30*16+30*2-2) toPoint:CGPointMake(180+180+160+40+530, Y+30*16+30*2-2)];
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160, Y+30*16+30*3) toPoint:CGPointMake(180+180+160+40+530, Y+30*16+30*3)];
    
    
    //约定转入账号 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+200, Y+30*16+30*4+4) toPoint:CGPointMake(WIDTH-140+80, Y+30*16+30*4+4)];
    
    
    
    // □ 电话银行 下面那条横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*17+6*20) toPoint:CGPointMake(WIDTH-140+80, Y+30*17+6*20)];
    
    
    // □ 手机银行 下面那条横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*16+6*20+84) toPoint:CGPointMake(WIDTH-140+80, Y+30*16+6*20+84)];
    
    // □ 支付宝卡通服务 下面那条横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*17+5*20+55*2+18) toPoint:CGPointMake(WIDTH-140+80, Y+30*17+5*20+55*2+18)];
    
    
    //  □ 自助设备转账 下面那条横线
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*16+6*20+55*3+80) toPoint:CGPointMake(WIDTH-140+80, Y+30*16+6*20+55*3+80)];
    
    // □ 电子现金 下面那条横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(180, Y+30*16+5*20+55*3+45*2+50) toPoint:CGPointMake(WIDTH-140+80, Y+30*16+5*20+55*3+45*2+50)];
    
    //矩形框A 上面那条线  下面的第一条横线 （申请人资料   下面的线）
    Y+= 30*5;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    //申请人资料 右边第一条竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(80+100, Y-30*5) toPoint:CGPointMake(80+100, HEIGHT-324)];
    
    //申请人资料 右边第2条竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(300, Y-30*5) toPoint:CGPointMake(300, Y+30*3)];
    
    //拼音或英文名 左边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(450, Y-30*5) toPoint:CGPointMake(450, Y-30*3)];
    
    //申请人资料 号码 左边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(410, Y-30*4) toPoint:CGPointMake(410, Y-30*3)];
    
    
    
    //申请人资料 固定电话 左边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(485, Y-30*2) toPoint:CGPointMake(485, Y-30*1)];
    
    
    //申请人资料 固定电话 右边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(595, Y-30*2) toPoint:CGPointMake(595, Y-30*1)];
    
    
    //代理人资料 联系电话 左边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(485, Y) toPoint:CGPointMake(485, Y+30*1)];
    
    
    //代理人资料 联系电话 右边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(595, Y) toPoint:CGPointMake(595, Y+30*1)];
    
    
    
    
    
    //申请人资料 号码
    [PDFRenderer printStr:@"号码" CGRect:CGRectMake(380, Y-30*4+5, 100, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    //代理人信息 号码
    [PDFRenderer printStr:@"号码" CGRect:CGRectMake(380, Y+30*1+5, 100, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //代理人信息 号码 左边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(410, Y+30*1) toPoint:CGPointMake(410, Y+30*2)];
    //代理人信息 号码 右边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(450, Y+30*1) toPoint:CGPointMake(450, Y+30*2)];
    
    //与申请人的关系 右边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(410, Y+30*3) toPoint:CGPointMake(410, Y+30*4)];
    
    //拼音或英文名 右边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(600, Y-30*5) toPoint:CGPointMake(600, Y-30*4)];
    //出生日期 左边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(750, Y-30*5) toPoint:CGPointMake(750, Y+30*2)];
    
    //代理人信息 邮政编码 左边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(750, Y+30*3) toPoint:CGPointMake(750, Y+30*4)];
    //代理人信息 邮政编码 右边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(850, Y+30*3) toPoint:CGPointMake(850, Y+30*4)];
    
    //出生日期 右边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(850, Y-30*5) toPoint:CGPointMake(850, Y-30*4)];
    
    //性别 左边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(1050, Y-30*5) toPoint:CGPointMake(1050, Y-30*4)];
    
    //国籍 左边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(1050, Y-30*3) toPoint:CGPointMake(1050, Y-30*2)];
    
    //国籍 右边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(1100, Y-30*3) toPoint:CGPointMake(1100, Y-30*2)];
    
    //性别 右边那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(1100, Y-30*5) toPoint:CGPointMake(1100, Y-30*4)];
    
    
    [PDFRenderer drawLineFromPoint:CGPointMake(850, Y-30*3) toPoint:CGPointMake(850, Y+30*1)];
    
    
    
    
    [PDFRenderer drawLineFromPoint:CGPointMake(300, Y+30*4) toPoint:CGPointMake(300, Y+30*8)];
    
    
    
    
    //矩形框A 上面那条线  下面的第2条线 （代理人信息   下面的线）
    
    Y+= 30*5;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    //矩形框A 上面那条线  下面的第3条线 （开户类型  下面的线）
    Y+= 30*3;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    // □ 网上银行   网银认证方式   分割线
    [PDFRenderer drawLineFromPoint:CGPointMake(380, Y) toPoint:CGPointMake(380, Y+360+200)];
    
    //网银认证方式   □刮刮卡  分割线
    [PDFRenderer drawLineFromPoint:CGPointMake(520, Y) toPoint:CGPointMake(520, Y+360+40)];
    
    //申请桂盛借记卡功能设置  □ POS交易限额  单笔限额（元） 右边的线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(520, Y+495) toPoint:CGPointMake(520, Y+532)];
    
    
    //申请桂盛借记卡功能设置  □ POS交易限额  日累计限额（元） 左边的线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(720, Y+495) toPoint:CGPointMake(720, Y+532)];
    
    
    //申请桂盛借记卡功能设置  □ POS交易限额  日累计限额（元） 右边的线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(880, Y+495) toPoint:CGPointMake(880, Y+532)];
    
    // 申请桂盛借记卡功能设置  □ POS交易限额  日限次  左边的线
    [PDFRenderer drawLineFromPoint:CGPointMake(1000, Y+495) toPoint:CGPointMake(1000, Y+532)];
    
    // 申请桂盛借记卡功能设置  □ POS交易限额  日限次  右边的线
    [PDFRenderer drawLineFromPoint:CGPointMake(1090, Y+495) toPoint:CGPointMake(1090, Y+532)];
    
    
    // □ 网上银行   网银认证方式    单笔 日累 右边的线
    [PDFRenderer drawLineFromPoint:CGPointMake(180+180+160+40+530, Y) toPoint:CGPointMake(180+180+160+40+530, Y+60)];
    
    // □ 网上银行   网银认证方式    单笔 日累 左边的线
    [PDFRenderer drawLineFromPoint:CGPointMake(WIDTH-193, Y) toPoint:CGPointMake(WIDTH-193, Y+60)];
    
    
    // □ 网上银行   网银认证方式    单笔 日累 分割线  横线
    [PDFRenderer drawLineFromPoint:CGPointMake(WIDTH-193, Y+30) toPoint:CGPointMake(WIDTH-60, Y+30)];
    
    
    [PDFRenderer printStr:@"支付\n限额" CGRect:CGRectMake(WIDTH-242, Y+13, 50, 60) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"单笔" CGRect:CGRectMake(WIDTH-195, Y+7, 50, 30) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"日累" CGRect:CGRectMake(WIDTH-195, Y+6+30, 50, 30) Font:16.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    // □ 网上银行   网银认证方式    支付限额 左边的竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(WIDTH-240, Y) toPoint:CGPointMake(WIDTH-240, Y+60)];
    
    
    
    //申请电子银行业务类型
    Y+= 12*30;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y+40) toPoint:CGPointMake(WIDTH-140+80, Y+40)];
    
    //申请桂盛借记卡功能设置
    Y+= 4*30;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y+80) toPoint:CGPointMake(WIDTH-140+80, Y+80)];
    
    
    [PDFRenderer drawLineFromPoint:CGPointMake(380, Y+52) toPoint:CGPointMake(WIDTH-140+80, Y+52)];
    
    
    
    //账户信息打印
    Y+= 380;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    
    /**
     *  申请人声明:本人已阅读《广西农村信用社桂盛借记卡章程》和《广西农村信用社个人银行结算账户协议》并同意遵守；保证以上所填写的内容完全属实。如申请有关电子银行业务、桂盛借记卡功能设置，即同意接受相应产品、服务及其功能说明、责任条款、章程或协议的全部内容。如开通短信通服务，即同意接收广西农村信用社（农村商业银行、农村合作银行）发送的其他产品信息、金融资讯、祝福问候等短信信息。对所提供的信息错误、失真，密码泄露、遗失或因违反相关规定而造成的损失和后果，本人愿意承担相应的法律责任。
     */
    
    Y+= 10;
    [PDFRenderer printStr:@"                             本人已阅读《广西农村信用社桂盛借记卡章程》和《广西农村信用社个人银行结算账户协议》并同意遵守；保证以上所填写的内容完全属实。如申请有关电子银行业务、桂盛借记卡功能设置，即同意接受相应产品、服务及其功能说明、责任条款、章程或协议的全部内容。如开通短信通服务，即同意接收广西农村信用社（农村商业银行、农村合作银行）发送的其他产品信息、金融资讯、祝福问候等短信信息。对所提供的信息错误、失真，密码泄露、遗失或因违反相关规定而造成的损失和后果，本人愿意承担相应的法律责任。" CGRect:CGRectMake(90, Y, WIDTH-180, 200) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"    申请人声明:" CGRect:CGRectMake(90, Y, WIDTH-180, 200) Font:20.0 fontWithName:@"Helvetica-BoldOblique" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请人声明
    Y+= 120;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    
    [PDFRenderer printStr:@"申请人签名:" CGRect:CGRectMake(100, Y+35, 200, 30) Font:25.0  fontWithName:@"Helvetica-Bold"lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"申请日期:" CGRect:CGRectMake(500, Y+35, 200, 30) Font:25.0  fontWithName:@"Helvetica-Bold"lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //[PDFRenderer printStr:@"年        月        日" CGRect:CGRectMake(800, Y+35, 200, 30) Font:25.0  fontWithName:@"Helvetica-Bold"lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    Y+= 100;
    
    [PDFRenderer printStr:@"填表说明：填表前请认真阅读并详细了解所申请的业务章程、业务协议、功能说明及责任条款、业务收费标准及有关“须知”。" CGRect:CGRectMake(80, Y, WIDTH-200, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    Y+= 20;
    [PDFRenderer printStr:@"风险提示：复合卡存在侧录、伪卡等风险，请客户谨慎选择，并注意用卡安全。" CGRect:CGRectMake(80, Y, WIDTH-200, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [self printWordsOpenCard:tableDict lastdict:lastDict];
    
    UIGraphicsEndPDFContext();
    
    
}

#pragma mark---打印开卡数据

+ (void)printWordsOpenCard:(NSDictionary *)dictData lastdict:(NSDictionary *)lastDict{
    
    
    CGFloat Y =115;
    
    //对号
    UIImage *imageSelect  =[UIImage imageNamed:@"cutPicSelect"];
    
    
    //申请人资料   姓名
    NSString * applicant_Name  = [dictData objectForKey:@"applicant_Name"];
    
    [PDFRenderer printStr:applicant_Name CGRect:CGRectMake(280, Y+70, 180, 30) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人资料   拼音或英文名
    NSString * applicant_EngLish_Name  = [dictData objectForKey:@"applicant_EngLish_Name"];
    
    [PDFRenderer printStr:applicant_EngLish_Name CGRect:CGRectMake(290*2, Y+70, 180, 30) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人资料   出生日期
    NSString * applicant_Birthday = [dictData objectForKey:@"applicant_Birthday"];
    
    [PDFRenderer printStr:applicant_Birthday
                   CGRect:CGRectMake(280*3, Y+70, 180, 30) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人资料   性别
    NSString * applicant_Sex  = [dictData objectForKey:@"applicant_Sex"];
    
    [PDFRenderer printStr:applicant_Sex
                   CGRect:CGRectMake(WIDTH-190, Y+70, 180, 30) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人资料   证件类型
    NSString * applicant_Card_Type = [dictData objectForKey:@"applicant_Card_Type"];
    
    [PDFRenderer printStr:applicant_Card_Type CGRect:CGRectMake(260, Y+100, 180, 30) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人资料   号码
    NSString * applicant_Card_Number = [dictData objectForKey:@"applicant_Card_Number"];
    
    [PDFRenderer printStr:applicant_Card_Number CGRect:CGRectMake(230*2, Y+100, 280, 30) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人资料   证件有效期至：
    NSString * applicant_Validity_Of_Card = [dictData objectForKey:@"applicant_Validity_Of_Card"];
    
    [PDFRenderer printStr:applicant_Validity_Of_Card CGRect:CGRectMake(WIDTH-350, Y+100, 280, 30) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人资料   发证机关
    NSString * applicant_Certification_Authority = [dictData objectForKey:@"applicant_Certification_Authority"];
    [PDFRenderer printStr:applicant_Certification_Authority CGRect:CGRectMake(200, Y+130, 380, 30) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请人资料   职    业
    NSString * applicant_Job = [dictData objectForKey:@"applicant_Job"];
    
    [PDFRenderer printStr:applicant_Job CGRect:CGRectMake(WIDTH - 390, Y+135, 320, 30) Font:14 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请人资料   国籍
    NSString * applicant_Nation = [dictData objectForKey:@"applicant_Nation"];
    
    [PDFRenderer printStr:applicant_Nation CGRect:CGRectMake(WIDTH - 200, Y+130, 200, 30) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人资料   移动电话
    NSString * applicant_Mobile_Phone_Number = [dictData objectForKey:@"applicant_Mobile_Phone_Number"];
    
    [PDFRenderer printStr:applicant_Mobile_Phone_Number CGRect:CGRectMake(250, Y+160, 250, 30) Font:FONT22 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人资料   联系地址
    NSString * applicant_Contact_Address = [dictData objectForKey:@"applicant_Contact_Address"];
    
    [PDFRenderer printStr:applicant_Contact_Address CGRect:CGRectMake(280, Y+190, 450, 30) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请人资料   邮政编码
    NSString * applicant_Postcode = [dictData objectForKey:@"applicant_Postcode"];
    
    [PDFRenderer printStr:applicant_Postcode CGRect:CGRectMake(WIDTH - 350, Y+190, 200, 30) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    //申请人资料   开户金额
    NSString * openMoney = [dictData objectForKey:@"openMoney"];
    
    [PDFRenderer printStr:openMoney CGRect:CGRectMake(250, Y+427, 200, 30) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    // 网上银行
    NSString * online_Bank = [dictData objectForKey:@"online_Bank"];
    
    if(![self strNilOrEmpty:online_Bank]){
        
        [imageSelect drawInRect:CGRectMake(190, 633-45, 25, 25)];

    }
    //按键KEy
    NSString * press_U_Key = [dictData objectForKey:@"press_U_Key"];
    
    if(![self strNilOrEmpty:press_U_Key]){
        
        [imageSelect drawInRect:CGRectMake(608, 633-48, 20, 20)];

    }
    
    //液晶KEy
    NSString * led_U_key = [dictData objectForKey:@"led_U_key"];
    
    if(![self strNilOrEmpty:led_U_key]){
        
        [imageSelect drawInRect:CGRectMake(715, 633-48, 20, 20)];
        
    }

    //网上银行 支付限额
    
    
    //单笔限额
   [PDFRenderer printStr:[dictData objectForKey:@"net_Bank_Single_Transaction"] CGRect:CGRectMake(WIDTH -140, 633-58, 160, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    
    //日累计限额
    [PDFRenderer printStr:[dictData objectForKey:@"net_Bank_Day_Cumulative"] CGRect:CGRectMake(WIDTH -140, 633-28, 160, 30) Font:18.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
    

    //申请电子银行业务类型   短信通
    NSString * message_TONG = [dictData objectForKey:@"message_TONG"];
    
    if(![PDFRenderer strNilOrEmpty:message_TONG]){
        
        [imageSelect drawInRect:CGRectMake(190, 631, 25, 25)];
        
    }
    
    
    //手机银行
    NSString * mobile_Phone_Bank = [dictData objectForKey:@"mobile_Phone_Bank"];
    
    if(![PDFRenderer strNilOrEmpty:mobile_Phone_Bank]){
        
        [imageSelect drawInRect:CGRectMake(190, 623+200, 25, 25)];
        
    }
    
    //手机银行签约手机号
    [PDFRenderer printStr:[dictData objectForKey:@"mobile_Phone_Bank_Sign_Phone_Number"] CGRect:CGRectMake(590, 623+200, 560, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //单笔限额
    [PDFRenderer printStr:[dictData objectForKey:@"mobile_Phone_Bank_Single_Payment_Limit"] CGRect:CGRectMake(WIDTH -135, 613+200, 160, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //日累计限额
    [PDFRenderer printStr:[dictData objectForKey:@"mobile_BanK_Day_Limit"] CGRect:CGRectMake(WIDTH -135, 613+225, 160, 30) Font:22.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    //申请电子银行业务类型   电话银行
    NSString * tel_Phone_Bank = [dictData objectForKey:@"tel_Phone_Bank"];
    
    if(![PDFRenderer strNilOrEmpty:tel_Phone_Bank ]){
        
        [imageSelect drawInRect:CGRectMake(190, 729, 25, 25)];
        
    }
    
    
    //申请电子银行业务类型   短信通签约手机号
    NSString * message_TONG_Phone_Num = [dictData objectForKey:@"message_TONG_Phone_Num"];
    
    [PDFRenderer printStr:message_TONG_Phone_Num CGRect:CGRectMake(580, 634, 225, 25) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请桂盛借记卡功能设置    自助设备转账
    NSString * self_Service_Equipment_Transfer = [dictData objectForKey:@"self_Service_Equipment_Transfer"];
    
    
    if(![PDFRenderer strNilOrEmpty:self_Service_Equipment_Transfer]){
        
        [imageSelect drawInRect:CGRectMake(190, 982, 25, 25)];
        
    }
    
    //申请电子银行业务类型    电话银行 约定转入账户  户名
    NSString * tel_Phone_Agreed_Account1
    = [dictData objectForKey:@"tel_Phone_Agreed_Account1"];
    
    
    [PDFRenderer printStr:tel_Phone_Agreed_Account1 CGRect:CGRectMake(523, Y+30*19+12, 200, 30) Font:13.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //申请电子银行业务类型    电话银行 约定转入账户  卡号或账户
    NSString * tel_Phone_Agreed_Account_Card_Number1
    
    = [dictData objectForKey:@"tel_Phone_Agreed_Account_Card_Number1"];
    
    [PDFRenderer printStr:tel_Phone_Agreed_Account_Card_Number1
                   CGRect:CGRectMake(573, Y+30*19+6, 600, 30) Font:20.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    

    
    //申请桂盛借记卡功能设置    □开通境内ATM、CRS、BSM等自助设备转账功能。
    NSString * self_Service_Equipment_Transfer_Domestic_open
    = [dictData objectForKey:@"self_Service_Equipment_Transfer_Domestic_open"];
    if (![PDFRenderer strNilOrEmpty:self_Service_Equipment_Transfer_Domestic_open]) {
        
        [imageSelect drawInRect:CGRectMake(381, 974, 25, 25)];
        
    }
    

    
    //申请桂盛借记卡功能设置    电子现金
    NSString * electronic_Cash = [dictData objectForKey:@"electronic_Cash"];
    
    if (![PDFRenderer strNilOrEmpty:electronic_Cash]) {
        
        [imageSelect drawInRect:CGRectMake(189, 982+50, 25, 25)];
        
    }
    
    //申请桂盛借记卡功能设置    电子现金
    NSString * electronic_Cash_Open = [dictData objectForKey:@"electronic_Cash_Open"];
    if (![PDFRenderer strNilOrEmpty:electronic_Cash_Open]) {
        
        [imageSelect drawInRect:CGRectMake(381, 981+50, 25, 25)];
        
        
    }
    
    //申请桂盛借记卡功能设置  设备向境内他人账户每日转账限额人民币      元(5万元以内)。
    
    NSString * self_Service_Equipment_Transfer_Day_Limit = [dictData objectForKey:@"self_Service_Equipment_Transfer_Day_Limit"];
    
    [PDFRenderer printStr:self_Service_Equipment_Transfer_Day_Limit
                   CGRect:CGRectMake(581, 974+25, 225, 25) Font:FONT20 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //□ POS交易限额
    //    [imageSelect drawInRect:CGRectMake(188, 994+90, 25, 25)];
    
    
    
    
    /**
     *
     //桂盛芯片卡
     @property (copy,nonatomic) NSString *GUI_SHENG_Chip_Card;
     //桂盛复合卡
     @property (copy,nonatomic) NSString *GUI_SHENG_Composite_Card;
     //桂盛工会卡
     @property (copy,nonatomic) NSString *GUI_SHENG_Union_Card;
     //桂盛市民卡
     @property (copy,nonatomic) NSString *GUI_SHENG_Citizen_Card;
     //桂盛信祥卡
     @property (copy,nonatomic) NSString *GUI_SHENG_XIN_XIANG_Card;
     //存折
     @property (copy,nonatomic) NSString *passbook;
     //对账折
     @property (copy,nonatomic) NSString *Reconciliation_Of_Fold;
     //普通用户_其他
     @property (copy,nonatomic) NSString *Ordinary_Users_Other;
     */
    
    //开户类型  普通客户 桂盛芯片卡
    NSString * GUI_SHENG_Chip_Card = [dictData objectForKey:@"GUI_SHENG_Chip_Card"];
    
    if (![PDFRenderer strNilOrEmpty:GUI_SHENG_Chip_Card]) {
        
        [imageSelect drawInRect:CGRectMake(307, 479, 25, 25)];
        
        
    }
    //开户类型  普通客户 桂盛复合卡
    NSString * GUI_SHENG_Composite_Card = [dictData objectForKey:@"GUI_SHENG_Composite_Card"];
    
    if (![PDFRenderer strNilOrEmpty:GUI_SHENG_Composite_Card]) {
        
        [imageSelect drawInRect:CGRectMake(420, 479, 25, 25)];
        
        
    }
    //开户类型  普通客户 桂盛工会卡
    NSString * GUI_SHENG_Union_Card = [dictData objectForKey:@"GUI_SHENG_Union_Card"];
    
    if (![PDFRenderer strNilOrEmpty:GUI_SHENG_Union_Card]) {
        
        
        [imageSelect drawInRect:CGRectMake(420+113, 479, 25, 25)];
        
    }
    //开户类型  普通客户 桂盛市民卡
    NSString * GUI_SHENG_Citizen_Card = [dictData objectForKey:@"GUI_SHENG_Citizen_Card"];
    
    if (![PDFRenderer strNilOrEmpty:GUI_SHENG_Citizen_Card]) {
        
        [imageSelect drawInRect:CGRectMake(420+113*2, 479, 25, 25)];
        
        
    }
    //开户类型  普通客户 桂盛信祥卡
    NSString * GUI_SHENG_XIN_XIANG_Card = [dictData objectForKey:@"GUI_SHENG_XIN_XIANG_Card"];
    
    if (![PDFRenderer strNilOrEmpty:GUI_SHENG_XIN_XIANG_Card]) {
        
        
        [imageSelect drawInRect:CGRectMake(420+113*3, 479, 25, 25)];
        
    }
    //开户类型  普通客户 存折
    NSString * passbook = [dictData objectForKey:@"passbook"];
    
    if (![PDFRenderer strNilOrEmpty:passbook]) {
        
        [imageSelect drawInRect:CGRectMake(420+113*4, 479, 25, 25)];
        
        
    }
    //开户类型  普通客户 对账折
    NSString * Reconciliation_Of_Fold = [dictData objectForKey:@"Reconciliation_Of_Fold"];
    
    if (![PDFRenderer strNilOrEmpty:Reconciliation_Of_Fold]) {
        
        [imageSelect drawInRect:CGRectMake(479+113*4, 479, 25, 25)];
        
    }
    //开户类型  普通用户_其他
    NSString * Ordinary_Users_Other = [dictData objectForKey:@"Ordinary_Users_Other"];
    
    if (![PDFRenderer strNilOrEmpty:Ordinary_Users_Other]) {
        
        [imageSelect drawInRect:CGRectMake(556+113*4, 479, 25, 25)];
        
        
    }
    //其他 卡名称
    [self printStr:[dictData objectForKey:@"Ordinary_Users_Other_Name"] CGRect:CGRectMake(622+113*4,487, 200,30) Font:14.0 lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];

    
    
    
    //申请人签名：
    
//    UIImage * writeImage  =  nil;
//    
//    [writeImage drawInRect:CGRectMake(200, HEIGHT-170, 220, 60)];
//    
//    
//    
//    //申请日期：
//    NSString *writeDate = [PCMobileBankGlobal sharedInstance].writeDate;
//    
//    [PDFRenderer printStr:writeDate CGRect:CGRectMake(WIDTH - 600, HEIGHT-160, 220, 60) Font:25.0 fontWithName:@"Helvetica-BoldOblique" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
//    
//    
//   NSDictionary  *dictF  = [[PCMobileBankGlobal sharedInstance].ServerPrintData firstObject];
//    
//    //打印 账户信息
    [PDFRenderer printAccountInfo:lastDict];
    
}
#pragma mark-----开卡 打印客户信息 

+ (void)printAccountInfo:(NSDictionary *)dict{

  
    
    /**
     主账号
     * "Account_No" = 16165165165;
     银行评级
     "Server_Level" = "\U666e\U901a";
     授权柜员
     "auto_Teller" = 3456125;
     客户名称
     "c_Name" = "\U674e\U56db";
     卡号
     "card_Number" = 6231330500000334123;
     客户号
     "cust_Id_Num" = 10208128976;
     柜员
     "op_Teller" = 13161616511;
     流水号
     "seq_Num" = 116456;
     */
    
    NSMutableString *printStr  = [NSMutableString string];
    
    //主账号
    NSString *Account_No  =[dict objectForKey:@"Account_No"];
    
    //银行评级
    NSString *Server_Level  =[dict objectForKey:@"Server_Level"];
    
    //授权柜员
    NSString *auto_Teller  =[dict objectForKey:@"auto_Teller"];
    
    //客户名称
    NSString *c_Name  =[dict objectForKey:@"c_Name"];
    
    //卡号
    NSString *card_Number  =[dict objectForKey:@"card_Number"];
    
    //客户号
    NSString *cust_Id_Num  =[dict objectForKey:@"cust_Id_Num"];
    
    //短信通
    NSString *is_dxt  =[dict objectForKey:@"is_dxt"];
    
    //电话银行
    NSString *is_dh  =[dict objectForKey:@"is_dh"];
    
    //网上银行
    NSString *is_netbank  =[dict objectForKey:@"is_netbank"];
    
    //手机银行
    NSString *is_mobilebank  =[dict objectForKey:@"is_mobilebank"];
    
    //柜员
    NSString *op_Teller  =[dict objectForKey:@"op_Teller"];
    
    // 流水号
    NSString *seq_Num  =[dict objectForKey:@"seq_Num"];
    
    
    [printStr appendFormat:@"主账号:%@",Account_No];
    
    [printStr appendFormat:@"         银行评级:%@",Server_Level];
    
    
    [printStr appendFormat:@"\n流水号:%@",seq_Num];

    
    [printStr appendFormat:@"         客户名称:%@",c_Name];
    
    [printStr appendFormat:@"\n卡号:%@",card_Number];
    
    [printStr appendFormat:@"         客户号:%@",cust_Id_Num];
    
    [printStr appendFormat:@"\n\n短信通:%@",is_dxt];
    
    [printStr appendFormat:@"\n电话银行:%@",is_dh];
    
    [printStr appendFormat:@"\n网上银行:%@",is_netbank];
    
    [printStr appendFormat:@"\n手机银行:%@",is_mobilebank];
    
    [printStr appendFormat:@"\n柜员:%@",op_Teller];
    
    [printStr appendFormat:@"             授权柜员:%@",auto_Teller];

    
    [self printStr:printStr CGRect:CGRectMake(200, HEIGHT -600, 1000,500) Font:22.0 lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
    
    
    NSString *staticStr = @"发卡网点盖章";
    
//    NSMutableString *final  = [NSMutableString stringWithFormat:@"%@\n\n%@",staticStr,[PCMobileBankGlobal sharedInstance].writeDate];
//    
//    [self printStr:final CGRect:CGRectMake(WIDTH-300, HEIGHT-400, 400,400) Font:22.0 lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];

    
    /**
     
     短信通：isdxt
     电话银行：isdh
     网上银行：isnetbank
     手机银行：ismobilebank
     "Account_No" = 468465165156;
     "Server_Level" = 564646;
     "auto_Teller" = 130011;
     "c_Name" = "\U5f20\U4e09";
     "card_Number" = 6231330500000336359;
     "cust_Id_Num" = 10208114596;
     "is_dh" = "";
     "is_dxt" = "";
     "is_mobilebank" = "";
     "is_netbank" = "";
     "op_Teller" = 130210;
     "seq_Num" = 469461415;
     */
    
    
    
    /**
     "applicant_date":"",//交易日期
     "applicant_kind": $("#Flag option:selected").text(),//交易类型
     "customerName":Name,//客户名称
     "cardNumber":$("#AcctNo").val(),//签约账号
     "applicant_mobile":$("#Mobile").val(),//签约手机号
     "brc_Id":getBrcId(),//办理机构
     "User_Id":getUserId()//办理柜员
     */

    
}
#pragma mark---
// 短信通 签解约  手机银行 签解约   电子渠道
+ (void)Application_form_for_personal_customer_service_of_electronic_bank:(NSDictionary *)tableDict
{
    
       
    UIImage *image  =[UIImage imageNamed:@"76*76"];
    
    [image drawInRect:CGRectMake(163, 17, 76, 76)];
    
    [PDFRenderer printStr:@"广西农村信用社（农村商业银行、农村合作银行）" CGRect:CGRectMake(20, 15, WIDTH, 200) Font:35.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"电 子 银 行 个 人 客 户 服 务 申 请 表" CGRect:CGRectMake(15, 50, WIDTH-20, 200) Font:45.0 fontWithName:@"Helvetica-BoldOblique" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"网址:www.gx966888.com (http://ebank.gx966888.com)" CGRect:CGRectMake(80, 95, 612, 20) Font:14.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"客服电话:966888(广西区外加拨0771)" CGRect:CGRectMake(WIDTH-400, 95, 320, 20) Font:14.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentRight];
    
    //画空心矩形框A
    
    CGFloat X =80;
    
    CGFloat Y =115;
    
    [PDFRenderer drawEmptySquareWithCGRect:CGRectMake(80, Y, WIDTH-140, HEIGHT-323)];
    
    //矩形框A 上面那条线  下面的第一条线 （客户基本信息 下面的线）
    Y+= 40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    [PDFRenderer drawSquareWithCGRect:CGRectMake(80, 115, WIDTH-140,40)];
    
    [PDFRenderer printStr:@"客户基本信息" CGRect:CGRectMake(80, 115+10, WIDTH-140, 25) Font:20.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"*客户姓名 \n（中文）" CGRect:CGRectMake(80, Y+Vertical_Line_Distance_10, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"性  别" CGRect:CGRectMake(80+Horizontal_Line_Distance_300+Horizontal_Line_Distance_10, Y+Vertical_Line_Distance_10*2, Horizontal_Line_Distance_50, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"□男 \n□女" CGRect:CGRectMake(80+Horizontal_Line_Distance_300+Horizontal_Line_Distance_20+5+Horizontal_Line_Distance_50, Y+Vertical_Line_Distance_10, Horizontal_Line_Distance_50, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"*客户姓名\n（拼音或英文）" CGRect:CGRectMake(80+Horizontal_Line_Distance_350+Horizontal_Line_Distance_70+5, Y+Vertical_Line_Distance_10, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    [PDFRenderer printStr:@"*证件号码" CGRect:CGRectMake(80+Horizontal_Line_Distance_350+Horizontal_Line_Distance_70+5, Y+Vertical_Line_Distance_70+8, Horizontal_Line_Distance_180, Vertical_Line_Distance_40) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"证件有效期" CGRect:CGRectMake(80+Horizontal_Line_Distance_350+Horizontal_Line_Distance_70+5, Y+Vertical_Line_Distance_70+8+Vertical_Line_Distance_40, Horizontal_Line_Distance_180, Vertical_Line_Distance_40) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"通讯地址" CGRect:CGRectMake(80+Horizontal_Line_Distance_350+Horizontal_Line_Distance_70+5, Y+Vertical_Line_Distance_70+8+Vertical_Line_Distance_40*2, Horizontal_Line_Distance_180, Vertical_Line_Distance_40) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    
    
    [PDFRenderer printStr:@"*证件类型" CGRect:CGRectMake(80, Y+Vertical_Line_Distance_10+Vertical_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    [PDFRenderer printStr:@"发证机关" CGRect:CGRectMake(80, Y+Vertical_Line_Distance_10+Vertical_Line_Distance_40+Vertical_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    [PDFRenderer printStr:@"*手机号码" CGRect:CGRectMake(80, Y+Vertical_Line_Distance_10+Vertical_Line_Distance_40*2+Vertical_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    [PDFRenderer printStr:@"邮政编码" CGRect:CGRectMake(80, Y+Vertical_Line_Distance_10+Vertical_Line_Distance_40*3+Vertical_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"固定电话" CGRect:CGRectMake(80+Vertical_Line_Distance_250+Vertical_Line_Distance_20, Y+Vertical_Line_Distance_10+Vertical_Line_Distance_40*3+Vertical_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"电子邮箱" CGRect:CGRectMake(80+Vertical_Line_Distance_250*2+Vertical_Line_Distance_80, Y+Vertical_Line_Distance_10+Vertical_Line_Distance_40*3+Vertical_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"*账号（卡号）" CGRect:CGRectMake(80, Y+Vertical_Line_Distance_10+Vertical_Line_Distance_40*4+Vertical_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_60) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //1
    X+= Horizontal_Line_Distance_180;
    //第一部分 第一条竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X, Y+ Vertical_Line_Distance_60+Vertical_Line_Distance_40*4)];
    //第一部分 第一条竖线 右边 性别左边的那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+Horizontal_Line_Distance_120, Y) toPoint:CGPointMake(X+Horizontal_Line_Distance_120, Y+ Vertical_Line_Distance_60)];
    
    //第一部分 第一条竖线 右边 固定电话左边的那条线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+Horizontal_Line_Distance_120, Y+Vertical_Line_Distance_60+Vertical_Line_Distance_40*3) toPoint:CGPointMake(X+Horizontal_Line_Distance_120, Y+ Vertical_Line_Distance_60+Vertical_Line_Distance_40*5)];
    
    //第一部分 第一条竖线 右边 电子邮箱右边的那条线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+Horizontal_Line_Distance_120+Horizontal_Line_Distance_400+Horizontal_Line_Distance_40, Y+Vertical_Line_Distance_60+Vertical_Line_Distance_40*3) toPoint:CGPointMake(X+Horizontal_Line_Distance_120+Horizontal_Line_Distance_400+Horizontal_Line_Distance_40, Y+ Vertical_Line_Distance_60+Vertical_Line_Distance_40*4)];
    
    //第一部分 第一条竖线 右边 性别右边的那条线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+Horizontal_Line_Distance_120+Horizontal_Line_Distance_60, Y) toPoint:CGPointMake(X+Horizontal_Line_Distance_120+Horizontal_Line_Distance_60, Y+ Vertical_Line_Distance_60)];
    
    
    
    
    X+= Horizontal_Line_Distance_250;
    
    //第一部分 第2条竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X, Y+ Vertical_Line_Distance_60+Vertical_Line_Distance_40*4)];
    
    
    X+= Horizontal_Line_Distance_180;
    
    //第一部分 第3条竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X, Y+ Vertical_Line_Distance_60+Vertical_Line_Distance_40*4)];
    
    
    Y+=Vertical_Line_Distance_60;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    //2
    Y+=Vertical_Line_Distance_40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    //3
    Y+=Vertical_Line_Distance_40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    //4
    Y+=Vertical_Line_Distance_40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    //5
    Y+=Vertical_Line_Distance_40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    
    //第一部分 汉字
    
    
    
    
    
    
    
    Y+=Vertical_Line_Distance_40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    
    X = 80;
    
    X+= Horizontal_Line_Distance_180;
    //第2部分 第一条竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X, Y+ Vertical_Line_Distance_40*2+Vertical_Line_Distance_80*6)];
    
    
    [PDFRenderer printStr:@"网上银行" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_70, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"  网银认证\n方  式" CGRect:CGRectMake(80+Horizontal_Line_Distance_300, Y+Horizontal_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //网上银行 支付限额
    [PDFRenderer printStr:@"  支 付\n 限 额" CGRect:CGRectMake(Horizontal_Line_Distance_150+Horizontal_Line_Distance_300*2, Y+Horizontal_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //手机银行支付 限额
    [PDFRenderer printStr:@"  支 付\n 限 额" CGRect:CGRectMake(Horizontal_Line_Distance_170+Horizontal_Line_Distance_300*2, Y+Horizontal_Line_Distance_300, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //手机银行支付 限额 单笔
    [PDFRenderer printStr:@"  单笔（元）\n（5万元以内）" CGRect:CGRectMake(WIDTH-Horizontal_Line_Distance_400+Horizontal_Line_Distance_30+3, Y+Horizontal_Line_Distance_280+5, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:13.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //手机银行支付 限额 日累
    [PDFRenderer printStr:@"  日累（元）\n（5万元以内）" CGRect:CGRectMake(WIDTH-Horizontal_Line_Distance_400+Horizontal_Line_Distance_30+3, Y+Horizontal_Line_Distance_300+5+Horizontal_Line_Distance_20, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:13.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //桂盛借记卡支付宝卡通 限额 单笔
    [PDFRenderer printStr:@"  单笔（元）\n（5000元以内）" CGRect:CGRectMake(WIDTH-Horizontal_Line_Distance_400+Horizontal_Line_Distance_30+3, Y+Horizontal_Line_Distance_300+5+Horizontal_Line_Distance_20+Horizontal_Line_Distance_40, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:13.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //桂盛借记卡支付宝卡通 限额 日累
    [PDFRenderer printStr:@"  日累（元）\n（5000元以内）" CGRect:CGRectMake(WIDTH-Horizontal_Line_Distance_400+Horizontal_Line_Distance_30+3, Y+Horizontal_Line_Distance_300+5+Horizontal_Line_Distance_20+Horizontal_Line_Distance_40*2, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:13.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //桂盛借记卡银联在线支付 限额 单笔
    [PDFRenderer printStr:@"  单笔（元）\n（5000元以内）" CGRect:CGRectMake(WIDTH-Horizontal_Line_Distance_400+Horizontal_Line_Distance_30+3, Y+Horizontal_Line_Distance_300+5+Horizontal_Line_Distance_20+Horizontal_Line_Distance_40*3, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:13.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //桂盛借记卡银联在线支付 限额 日累
    [PDFRenderer printStr:@"  日累（元）\n（5000元以内）" CGRect:CGRectMake(WIDTH-Horizontal_Line_Distance_400+Horizontal_Line_Distance_30+3, Y+Horizontal_Line_Distance_300+5+Horizontal_Line_Distance_20+Horizontal_Line_Distance_40*4, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:13.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //桂盛借记卡支付宝卡通 支付 限额
    [PDFRenderer printStr:@"  支 付\n 限 额" CGRect:CGRectMake(Horizontal_Line_Distance_170+Horizontal_Line_Distance_300*2, Y+Horizontal_Line_Distance_300+Horizontal_Line_Distance_80, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //桂盛借记卡银联在线支付 支付 限额
    [PDFRenderer printStr:@"  支 付\n 限 额" CGRect:CGRectMake(Horizontal_Line_Distance_170+Horizontal_Line_Distance_300*2, Y+Horizontal_Line_Distance_300+Horizontal_Line_Distance_80*2, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"  单笔（元）\n （默认100万元）" CGRect:CGRectMake(WIDTH-Horizontal_Line_Distance_350-Horizontal_Line_Distance_10, Y+Horizontal_Line_Distance_50, Horizontal_Line_Distance_150, Vertical_Line_Distance_80) Font:13.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"  日累（元）\n （默认200万元）" CGRect:CGRectMake(WIDTH-Horizontal_Line_Distance_350-Horizontal_Line_Distance_10, Y+Horizontal_Line_Distance_90, Horizontal_Line_Distance_150, Vertical_Line_Distance_80) Font:13.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    [PDFRenderer printStr:@"□刮刮卡　□按键U-key　□液晶U-key   \n□电子密码器　　□其他 " CGRect:CGRectMake(Horizontal_Line_Distance_150+Horizontal_Line_Distance_400, Y+Horizontal_Line_Distance_50, Horizontal_Line_Distance_250, Vertical_Line_Distance_80) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"（电子密码器用于iPad网上银行交易，可与U-key同时使用）" CGRect:CGRectMake(Horizontal_Line_Distance_150+Horizontal_Line_Distance_400, Y+Horizontal_Line_Distance_100, Horizontal_Line_Distance_250, Vertical_Line_Distance_40) Font:9.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"1" CGRect:CGRectMake(Horizontal_Line_Distance_160+Horizontal_Line_Distance_400, Y+Horizontal_Line_Distance_200+Horizontal_Line_Distance_10, Horizontal_Line_Distance_250, Vertical_Line_Distance_40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"2" CGRect:CGRectMake(Horizontal_Line_Distance_160+Horizontal_Line_Distance_400, Y+Horizontal_Line_Distance_200+Horizontal_Line_Distance_50, Horizontal_Line_Distance_250, Vertical_Line_Distance_40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"日累计转账限额（元）\n（5万元以内）" CGRect:CGRectMake(WIDTH - Horizontal_Line_Distance_210*2-10, Y+Horizontal_Line_Distance_180+Horizontal_Line_Distance_50, Horizontal_Line_Distance_250, Vertical_Line_Distance_40) Font:13.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    
    
    
    
    
    [PDFRenderer printStr:@"  签约手机号" CGRect:CGRectMake(80+Horizontal_Line_Distance_300, Y+Horizontal_Line_Distance_60+Horizontal_Line_Distance_90, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"  签约手机号" CGRect:CGRectMake(80+Horizontal_Line_Distance_300, Y+Horizontal_Line_Distance_40+Horizontal_Line_Distance_90*3, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    
    [PDFRenderer printStr:@"□签约\n□撤约\n□修改限额" CGRect:CGRectMake(80+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_50, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"□签约\n□撤约\n□修改手机号" CGRect:CGRectMake(80+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_50+Horizontal_Line_Distance_80, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"□签约\n\n□撤约" CGRect:CGRectMake(80+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_50+Horizontal_Line_Distance_80*2, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"□签约\n□撤约\n□修改限额" CGRect:CGRectMake(80+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_50+Horizontal_Line_Distance_80*3, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"□签约\n□撤约\n□修改限额" CGRect:CGRectMake(80+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_50+Horizontal_Line_Distance_80*4, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"□签约\n□撤约\n□修改限额" CGRect:CGRectMake(80+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_50+Horizontal_Line_Distance_80*5, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    
    
    
    [PDFRenderer printStr:@"短 信 通" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_70+Horizontal_Line_Distance_80, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    [PDFRenderer printStr:@"电话银行转账" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_70+Horizontal_Line_Distance_80*2, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    [PDFRenderer printStr:@"手机银行" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_70+Horizontal_Line_Distance_80*3, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    [PDFRenderer printStr:@"桂盛借记卡\n支付宝卡通" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_70+Horizontal_Line_Distance_80*4, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    [PDFRenderer printStr:@"桂盛借记卡\n银联在线支付" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_70+Horizontal_Line_Distance_80*5, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    [PDFRenderer printStr:@"其　　他" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_70+Horizontal_Line_Distance_80*5+Horizontal_Line_Distance_60, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请电子银行维护服务 网上银行维护
    [PDFRenderer printStr:@"网上银行维护" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_70+Horizontal_Line_Distance_80*5+Horizontal_Line_Distance_60*3, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //申请电子银行维护服务 手机银行维护
    [PDFRenderer printStr:@"手机银行维护" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_80+Horizontal_Line_Distance_80*6+Horizontal_Line_Distance_60*3-3, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请电子银行维护服务   电子支付客户信息维护
    
    [PDFRenderer printStr:@"电子支付客户\n信息维护" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_80*8+Horizontal_Line_Distance_70*2-3, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //申请桂盛借记卡功能设置服务   桂盛卡境内自助 设备转账功能设置
    
    
    [PDFRenderer printStr:@"桂盛卡境内自助\n设备转账功能设置" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_80*8+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_100, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [PDFRenderer printStr:@"□开通\n□关闭\n□修改限额" CGRect:CGRectMake(80+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_80*8+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_100-10, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    // 申请电子银行维护服务  桂盛卡境内自助  设备转账功能设置 境内自助设备 日累计转账限额
    
    [PDFRenderer printStr:@"  境内自助设备\n日累计转账限额" CGRect:CGRectMake(Horizontal_Line_Distance_100+Horizontal_Line_Distance_350, Y+Horizontal_Line_Distance_80*8+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_100, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"  申请通过境内 ATM、CRS、BSM等自助设备向境内他人账户每日转账限额为人民币                                      元(5万元以内)。" CGRect:CGRectMake(Horizontal_Line_Distance_80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_350, Y+Horizontal_Line_Distance_80*8+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_80+5, Horizontal_Line_Distance_190*3, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"  （注：如不填写，将设置为系统默认限额）" CGRect:CGRectMake(Horizontal_Line_Distance_80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_350, Y+Horizontal_Line_Distance_80*8+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_130+5, Horizontal_Line_Distance_190*2, Vertical_Line_Distance_80) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"单笔消费限额（元）" CGRect:CGRectMake(Horizontal_Line_Distance_110+Horizontal_Line_Distance_180+Horizontal_Line_Distance_350+5, Y+Horizontal_Line_Distance_80*8+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_130+5+Horizontal_Line_Distance_30-1, Horizontal_Line_Distance_190*2, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"日累消费限额（元）" CGRect:CGRectMake(Horizontal_Line_Distance_110+Horizontal_Line_Distance_180+Horizontal_Line_Distance_350+5, 27+Y+Horizontal_Line_Distance_80*8+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_130+5+Horizontal_Line_Distance_30-1, Horizontal_Line_Distance_190*2, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"日累消费次数（次）" CGRect:CGRectMake(Horizontal_Line_Distance_110+Horizontal_Line_Distance_180+Horizontal_Line_Distance_350+5, 27*2+Y+Horizontal_Line_Distance_80*8+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_130+5+Horizontal_Line_Distance_30-1, Horizontal_Line_Distance_190*2, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"  POS消费限额" CGRect:CGRectMake(Horizontal_Line_Distance_100+Horizontal_Line_Distance_350, Y+Horizontal_Line_Distance_80*9+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_80+10, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"（注：如不填写，将设置为系统默认限额）" CGRect:CGRectMake(Horizontal_Line_Distance_80+Horizontal_Line_Distance_350-5, Y+Horizontal_Line_Distance_80*9+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_80+Horizontal_Line_Distance_40, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"□开通\n□关闭\n□修改限额" CGRect:CGRectMake(80+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_80*9+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_100-10, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请桂盛借记卡功能设置服务   桂盛卡POS消费 功能设置
    
    [PDFRenderer printStr:@"桂盛卡POS消费\n功能设置" CGRect:CGRectMake(80, Y+Horizontal_Line_Distance_80*9+Horizontal_Line_Distance_70*2+Horizontal_Line_Distance_100, Horizontal_Line_Distance_180, Vertical_Line_Distance_80) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    
    
    
    
    
    X+= Horizontal_Line_Distance_150;
    //第2部分 第2条竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X, Y+ Vertical_Line_Distance_40+Vertical_Line_Distance_80*6)];
    
    
    X+= Horizontal_Line_Distance_140;
    //第2部分 3条竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X, Y+ Vertical_Line_Distance_40+Vertical_Line_Distance_80*6)];
    
    
    [PDFRenderer printStr:@"签约收款\n 账 号" CGRect:CGRectMake(X-Horizontal_Line_Distance_140-30, Y+Vertical_Line_Distance_200+Vertical_Line_Distance_20, 180, 120) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    //签约收款账号 右边第一个小竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+30, Y+Vertical_Line_Distance_80*2+40) toPoint:CGPointMake(X+30, Y+ Vertical_Line_Distance_80*3+40)];
    
    //签约收款账号 右边第一个小横线 分割1 2
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y+Vertical_Line_Distance_80*3) toPoint:CGPointMake(X+30+Horizontal_Line_Distance_250, Y+ Vertical_Line_Distance_80*3)];
    
    
    //签约收款账号 右边第2个中竖线
    
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+30+Horizontal_Line_Distance_250, Y+Vertical_Line_Distance_80*2+40) toPoint:CGPointMake(X+30+Horizontal_Line_Distance_250, Y+ Vertical_Line_Distance_80*6+40)];
    
    
    
    
    //竖线分割  支付限额|单笔 日累计
    [PDFRenderer drawLineFromPoint:CGPointMake(X+30+Horizontal_Line_Distance_250+Horizontal_Line_Distance_70, Y+Vertical_Line_Distance_80*3+40) toPoint:CGPointMake(X+30+Horizontal_Line_Distance_250+Horizontal_Line_Distance_70, Y+ Vertical_Line_Distance_80*6+40)];
    
    //签约手机号  支付限额 横线分割 单笔日累计
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+30+Horizontal_Line_Distance_250+Horizontal_Line_Distance_70, Y+Vertical_Line_Distance_80*4) toPoint:CGPointMake(WIDTH -60, Y+Vertical_Line_Distance_80*4)];
    
    // 桂盛借记卡支付宝卡通 ( 签  约 支付宝账户  签约手机号) 支付限额 横线分割 单笔日累计
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+30+Horizontal_Line_Distance_250+Horizontal_Line_Distance_70, Y+Vertical_Line_Distance_80*5) toPoint:CGPointMake(WIDTH -60, Y+Vertical_Line_Distance_80*5)];
    
    
    // 桂盛借记卡支付宝卡通 ( 签  约 支付宝账户  签约手机号)  横线分割
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X-Horizontal_Line_Distance_140, Y+Vertical_Line_Distance_80*5+10) toPoint:CGPointMake(X+Horizontal_Line_Distance_280, Y+Vertical_Line_Distance_80*5+10)];
    
    // 桂盛借记卡支付宝卡通    签  约支付宝账户
    [PDFRenderer printStr:@"签  约\n支付宝账户" CGRect:CGRectMake(X-Horizontal_Line_Distance_160, Y+Vertical_Line_Distance_80*4+Vertical_Line_Distance_40, 180, 120) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //桂盛借记卡支付宝卡通     签约手机号
    [PDFRenderer printStr:@"签约手机号" CGRect:CGRectMake(X-Horizontal_Line_Distance_160, Y+Vertical_Line_Distance_80*4+Vertical_Line_Distance_100-5, 180, 120) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //桂盛借记卡银联在线支付   签约手机号
    [PDFRenderer printStr:@"签约手机号" CGRect:CGRectMake(X-Horizontal_Line_Distance_160, Y+Vertical_Line_Distance_80*4+Vertical_Line_Distance_100+Vertical_Line_Distance_50, 180, 120) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    
    // 桂盛借记卡银联在线支付(签约手机号) 支付限额 横线分割 单笔日累计
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+30+Horizontal_Line_Distance_250+Horizontal_Line_Distance_70, Y+Vertical_Line_Distance_80*6) toPoint:CGPointMake(WIDTH -60, Y+Vertical_Line_Distance_80*6)];
    
    
    //签约收款账号 右边第3个中竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+30+Horizontal_Line_Distance_250+Horizontal_Line_Distance_200, Y+Vertical_Line_Distance_80*2+40) toPoint:CGPointMake(X+30+Horizontal_Line_Distance_250+Horizontal_Line_Distance_200, Y+ Vertical_Line_Distance_80*6+40)];
    
    
    //签约手机号 虚线  横线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y+Vertical_Line_Distance_140+Vertical_Line_Distance_30) toPoint:CGPointMake(WIDTH-140, Y+Vertical_Line_Distance_140+Vertical_Line_Distance_30)];
    
    
    X+= Horizontal_Line_Distance_250;
    //第2部分 4条小竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X, Y+ Vertical_Line_Distance_40+Vertical_Line_Distance_80)];
    
    
    
    
    X+= Horizontal_Line_Distance_90;
    //第2部分 5条小竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X, Y+ Vertical_Line_Distance_40+Vertical_Line_Distance_80)];
    
    
    //网上银行 单笔 日累计 分割线
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y+Vertical_Line_Distance_80) toPoint:CGPointMake(WIDTH-60, Y+Vertical_Line_Distance_80)];
    
    
    X+= Horizontal_Line_Distance_120;
    //第2部分 6条小竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X, Y+ Vertical_Line_Distance_40+Vertical_Line_Distance_80)];
    
    
    
    [PDFRenderer drawSquareWithCGRect:CGRectMake(80, Y, WIDTH-140,40)];
    [PDFRenderer printStr:@"申请电子银行签约服务" CGRect:CGRectMake(80, Y+10, WIDTH-140, 25) Font:20.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    Y+=Vertical_Line_Distance_40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    Y+=Vertical_Line_Distance_80;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    Y+=Vertical_Line_Distance_80;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    Y+=Vertical_Line_Distance_80;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    Y+=Vertical_Line_Distance_80;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    Y+=Vertical_Line_Distance_80;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    Y+=Vertical_Line_Distance_80;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    Y+=Vertical_Line_Distance_40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    [PDFRenderer drawSquareWithCGRect:CGRectMake(80, Y, WIDTH-140,40)];
    
    [PDFRenderer printStr:@"申请电子银行维护服务" CGRect:CGRectMake(80, Y+10, WIDTH-140, 25) Font:20.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    Y+=Vertical_Line_Distance_40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    
    // 申请电子银行维护服务 第一条竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180, Y) toPoint:CGPointMake(80+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_50*2+Horizontal_Line_Distance_120)];
    
    //
    [PDFRenderer printStr:@"□网上银行注销   □网上银行冻结   □网上银行解冻   □网银登录密码重置   □证书两码重发   □证书补发       □证书换发       □证书废止  □证书冻结     □证书解冻       □U-key初始化　 □U-key变更　    □认证方式变更 （□刮刮卡　  □按键 U-key   □液晶U-key　 □其他            ）\n\n□电子密码器绑定   □电子密码器解绑   □电子密码器更换   □电子密码器同步   □电子密码器重置开机密码   □电子密码器挂失\n□电子密码器解锁   □刮刮卡解绑     □刮刮卡挂失     □刮刮卡更换     □刮刮卡解锁\n□手机号码变更为                                        " CGRect:CGRectMake(80+Horizontal_Line_Distance_180+1, Y+5, WIDTH-60-Horizontal_Line_Distance_250, Vertical_Line_Distance_120) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    // 申请电子银行维护服务 -->手机银行维护
    [PDFRenderer printStr:@"□手机银行注销   □手机银行暂停   □手机银行恢复   □解除手机绑定\n□签约手机号码变更为                    " CGRect:CGRectMake(80+Horizontal_Line_Distance_180+1, Y+5+Vertical_Line_Distance_120, WIDTH-60-Horizontal_Line_Distance_250, Vertical_Line_Distance_120) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    // 申请电子银行维护服务 -->电子支付客户信息维护
    [PDFRenderer printStr:@"□新增                   身份证件号码" CGRect:CGRectMake(80+Horizontal_Line_Distance_180+1, Y+5+Vertical_Line_Distance_120+Vertical_Line_Distance_50, WIDTH-60-Horizontal_Line_Distance_250, Vertical_Line_Distance_120) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    // 申请电子银行维护服务 -->电子支付客户信息维护  新增 、修改打钩

    UIImage *selectImage  = [UIImage imageNamed:@"cutPicSelect.png"];

    NSString * ePlayCustom = [tableDict objectForKey:@"ePlayCustom"];
    
     if ([ePlayCustom isEqualToString:@"1"])
    {
        [selectImage drawInRect:CGRectMake(78+Horizontal_Line_Distance_180, Y+3+Vertical_Line_Distance_120+Vertical_Line_Distance_50, 20, 20)];
        
    }
    else if([ePlayCustom isEqualToString:@"2"])
    {
        
        [selectImage drawInRect:CGRectMake(80+Horizontal_Line_Distance_180-2, Y+25+Vertical_Line_Distance_120+Vertical_Line_Distance_50, 20, 20)];

    }
    //身份证
    NSString * IdNo = [tableDict objectForKey:@"IdNo"];
    
    if (![ePlayCustom isEqualToString:@""]) {
        
        [PDFRenderer printStr:IdNo CGRect:CGRectMake(380+Horizontal_Line_Distance_180+1, Y+2+Vertical_Line_Distance_120+Vertical_Line_Distance_50, WIDTH-60-Horizontal_Line_Distance_250, Vertical_Line_Distance_120) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    }
    

    //手机号码1
    NSString * ePlayMoblie1 = [tableDict objectForKey:@"ePlayMoblie1"];
    
    
    [PDFRenderer printStr:ePlayMoblie1 CGRect:CGRectMake(380+Horizontal_Line_Distance_180+1, Y+Vertical_Line_Distance_150+Vertical_Line_Distance_50, WIDTH-60-Horizontal_Line_Distance_250, Vertical_Line_Distance_120) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    //手机号码2
    NSString * ePlayMoblie2 = [tableDict objectForKey:@"ePlayMoblie2"];
    
    
    [PDFRenderer printStr:ePlayMoblie2 CGRect:CGRectMake(380+Horizontal_Line_Distance_180+350, Y+Vertical_Line_Distance_150+Vertical_Line_Distance_50, WIDTH-60-Horizontal_Line_Distance_250, Vertical_Line_Distance_120) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];


    
    
    [PDFRenderer printStr:@"□修改                      手机号码" CGRect:CGRectMake(80+Horizontal_Line_Distance_180+1, Y+5+Vertical_Line_Distance_120+Vertical_Line_Distance_50+24, WIDTH-60-Horizontal_Line_Distance_250, Vertical_Line_Distance_120) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"1" CGRect:CGRectMake(350+Horizontal_Line_Distance_180+1, Y+5+Vertical_Line_Distance_120+Vertical_Line_Distance_50+24, WIDTH-60-Horizontal_Line_Distance_250, Vertical_Line_Distance_120) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"2" CGRect:CGRectMake(647+Horizontal_Line_Distance_180+1, Y+5+Vertical_Line_Distance_120+Vertical_Line_Distance_50+24, WIDTH-60-Horizontal_Line_Distance_250, Vertical_Line_Distance_120) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    
    //网上银行维护下面的横线
    Y+=Vertical_Line_Distance_120;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    //手机银行维护下面的横线
    Y+=Vertical_Line_Distance_50;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    //分割电子支付客户信息维护下面 （新增 修改)|（身份证件号码，手机号码） 竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100, Y) toPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100, Y+Vertical_Line_Distance_50)];
    
    //分割电子支付客户信息维护下面 （新增 修改)|（身份证件号码，手机号码） 竖线 右边的竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100+Horizontal_Line_Distance_150, Y) toPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100+Horizontal_Line_Distance_150, Y+Vertical_Line_Distance_50)];
    
    //分割电子支付客户信息维护下面 （手机号码)|（1） 的竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100+Horizontal_Line_Distance_150+Horizontal_Line_Distance_50, Y+25) toPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100+Horizontal_Line_Distance_150+Horizontal_Line_Distance_50, Y+Vertical_Line_Distance_50)];
    
    //分割电子支付客户信息维护下面 （1)|（2） 的竖线
    
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100+Horizontal_Line_Distance_150+Horizontal_Line_Distance_50+Horizontal_Line_Distance_250, Y+25) toPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100+Horizontal_Line_Distance_150+Horizontal_Line_Distance_50+Horizontal_Line_Distance_250, Y+Vertical_Line_Distance_50)];
    
    
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100+Horizontal_Line_Distance_150+Horizontal_Line_Distance_50+Horizontal_Line_Distance_250+50, Y+25) toPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100+Horizontal_Line_Distance_150+Horizontal_Line_Distance_50+Horizontal_Line_Distance_250+50, Y+Vertical_Line_Distance_50)];
    
    
    
    //分割电子支付客户信息维护下面 （身份证件号码----手机号码） 的 横线
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_100, Y+25) toPoint:CGPointMake(WIDTH-60, Y+25)];
    
    //电子支付客户信息维护下面的横线
    Y+=Vertical_Line_Distance_50;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    [PDFRenderer drawSquareWithCGRect:CGRectMake(80, Y, WIDTH-140,40)];
    
    [PDFRenderer printStr:@"申请桂盛借记卡功能设置服务" CGRect:CGRectMake(80, Y+10, WIDTH-140, 25) Font:20.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    Y+=Vertical_Line_Distance_40;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    //申请桂盛借记卡功能设置服务 第一条竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180, Y) toPoint:CGPointMake(80+Horizontal_Line_Distance_180, Y+Vertical_Line_Distance_80*2)];
    
    //申请桂盛借记卡功能设置服务 第2条竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_160, Y) toPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_160, Y+Vertical_Line_Distance_80*2)];
    
    //申请桂盛借记卡功能设置服务 第3条竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_160+Horizontal_Line_Distance_180, Y) toPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_160+Horizontal_Line_Distance_180, Y+Vertical_Line_Distance_80*2)];
    
    
    //申请桂盛借记卡功能设置服务 POS消费限额 右边的
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_160+Horizontal_Line_Distance_180+Horizontal_Line_Distance_250, Y+Horizontal_Line_Distance_80) toPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_160+Horizontal_Line_Distance_180+Horizontal_Line_Distance_250, Y+Vertical_Line_Distance_80*2)];
    
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_160+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_80+27) toPoint:CGPointMake(WIDTH-140+80, Y+Vertical_Line_Distance_80+27)];
    
    [PDFRenderer drawLineFromPoint:CGPointMake(80+Horizontal_Line_Distance_180+Horizontal_Line_Distance_160+Horizontal_Line_Distance_180, Y+Horizontal_Line_Distance_80+27*2) toPoint:CGPointMake(WIDTH-140+80, Y+Vertical_Line_Distance_80+27*2)];
    
    
    
    
    
    Y+=Vertical_Line_Distance_80;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    Y+=Vertical_Line_Distance_80;
    [PDFRenderer drawLineFromPoint:CGPointMake(80, Y) toPoint:CGPointMake(WIDTH-140+80, Y)];
    
    
    [PDFRenderer printStr:@"申请人声明：\n    本人自愿申请广西农村信用社（农村商业银行、农村合作银行）个人电子银行业务，保证以上所填写的内容完全属实，已完全理解并接受相应产品/服务及其功能说明、责任条款、章程或协议的全部内容。如开通短信通服务，即同意接收广西农村信用社（农村商业银行、农村合作银行）发送的其他产品信息、金融资讯、祝福问候等短信信息。对信息错误、失真或因违反相关规定而造成的损失和后果，本人愿意承担相应的法律责任。" CGRect:CGRectMake(80, Y+10, WIDTH-140, Vertical_Line_Distance_100*2) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    Y+=Vertical_Line_Distance_100;
    [PDFRenderer printStr:@"申请人签名:" CGRect:CGRectMake(80+Vertical_Line_Distance_100, Y-20, WIDTH-140, Vertical_Line_Distance_100*2) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"经办人：" CGRect:CGRectMake(80+Vertical_Line_Distance_100, Y+20, WIDTH-140, Vertical_Line_Distance_100*2) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"授权人：" CGRect:CGRectMake(80+Vertical_Line_Distance_100*4, Y+20, WIDTH-140, Vertical_Line_Distance_100*2) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"银行盖章：" CGRect:CGRectMake(80+Vertical_Line_Distance_100*8, Y+20, WIDTH-140, Vertical_Line_Distance_100*2) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    
    [PDFRenderer printStr:@"申请日期:" CGRect:CGRectMake(Vertical_Line_Distance_100*7, Y-20, 140, Vertical_Line_Distance_100*2) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentRight];
    
    Y+=Vertical_Line_Distance_50;
    
    [PDFRenderer printStr:@"填表说明:" CGRect:CGRectMake(80, Y-10, WIDTH-140, Vertical_Line_Distance_100*2) Font:16.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    Y+=Vertical_Line_Distance_10;
    
    [PDFRenderer printStr:@"1.本申请表用于个人客户申请电子银行业务，打*的为必填项，其他内容按实际需要填写，选中项在□内打√。\n2.网上银行和手机银行柜台签约后，自动开通查询、转账、缴费、理财等系统所有功能。电子密码器用于iPad网上银行交易。\n3.短信通业务是指通过手机（广西属地）短信方式为签约客户提供账户余额变动提醒、账户余额查询等服务的业务。短信通签约手机号码变更时，需将原短信通签约账号逐一删除后，再按新手机号码进行账号签约。\n4.支付宝卡通签约、银联在线签约填写的手机号码须为本人持有，且要求与支付宝、银联在线支付网站填写的手机号码一致，否则可能会影响您的交易短信校验。若您的手机号有变动，请及时到柜台修改。填写“支付宝账户名”时，此处提供的是支付宝账户名，而非淘宝账户名，请注意区分。若支付宝账户名填写正确且经支付宝验证，收到短信“您的广西农村信用社快捷支付（含卡通）已开通，可登录www.alipay.com查看”，则可按提示登录使用。若支付宝账户名未申请、不确定或填写不正确，收到短信“您的广西农村信用社快捷支付（含卡通）已签约成功，请登录http://kuai.alipay.com/jh/激活即可使用”后，请您按提示进行激活后即可使用。签约银联在线支付服务后，请登录https://online.unionpay.com/注册使用。" CGRect:CGRectMake(80, Y, WIDTH-140, Vertical_Line_Distance_100*2) Font:12.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    /**
     *  以上代码布局表格框架
     */
    
    [PDFRenderer printWordsMessageAndPhoneBank:tableDict ];
    
    
    
    //Close the PDF context and write the contents out.
//    UIGraphicsEndPDFContext();
}
+ (void)editPDF:(NSString*)filePath templateFilePath:(NSString*) templatePath
{
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
        
    //open template file
    CFURLRef url = CFURLCreateWithFileSystemPath (NULL, (__bridge CFStringRef)templatePath, kCFURLPOSIXPathStyle, 0);
    CGPDFDocumentRef templateDocument = CGPDFDocumentCreateWithURL(url);
    CFRelease(url);
    
    //get bounds of template page
    CGPDFPageRef templatePage = CGPDFDocumentGetPage(templateDocument, 1);
    CGRect templatePageBounds = CGPDFPageGetBoxRect(templatePage, kCGPDFCropBox);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //flip context due to different origins
    CGContextTranslateCTM(context, 0.0, templatePageBounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //copy content of template page on the corresponding page in new file
    CGContextDrawPDFPage(context, templatePage);
    
    //flip context back
    CGContextTranslateCTM(context, 0.0, templatePageBounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    // Edit body
    [PDFRenderer drawText:@"Hello World" inFrame:CGRectMake(150, 550, 300, 50) fontName:@"Times" fontSize:36];
    
    CGPoint from = CGPointMake(0, 400);
    CGPoint to = CGPointMake(200, 700);
    [PDFRenderer drawLineFromPoint:from toPoint:to];
    
    UIImage* logo = [UIImage imageNamed:@"apple-icon.png"];
    CGRect frame = CGRectMake(20, 500, 60, 60);
    
    [PDFRenderer drawImage:logo inRect:frame];
    
    
    CGPDFDocumentRelease(templateDocument);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}
//判断字符串空或nil
+ (BOOL)strNilOrEmpty:(NSString *)string{
    if ([string isKindOfClass:[NSString class]])
    {
        if (string.length > 0)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}
#pragma mark---按照格式打印数据
+ (void)printStr:(NSString *)printStr CGRect:(CGRect) rect Font:(CGFloat)font

   lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment
{
    /*
     Helvetica-Oblique，Helvetica-BoldOblique，Helvetica，Helvetica-Bold
     */
    //系统默认字体
    
    UIFont *Font = [UIFont fontWithName:@"Helvetica" size:font];
    
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    paragraphStyle.alignment = alignment;
    
    NSDictionary*attribute = @{
                               NSFontAttributeName:Font,
                               NSParagraphStyleAttributeName:paragraphStyle
                               };
    
    [printStr drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
}
#pragma mark---带有字体
+ (void)printStr:(NSString *)printStr CGRect:(CGRect) rect Font:(CGFloat)font fontWithName:(NSString *)fontName   lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment
{
    
    UIFont *Font = [UIFont fontWithName:fontName size:font];
    
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    paragraphStyle.alignment = alignment;
    
    NSDictionary*attribute = @{
                               NSFontAttributeName:Font,
                               NSParagraphStyleAttributeName:paragraphStyle
                               };
    
    [printStr drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
}
+ (NSString *)addEmptyStringWith:(NSString *)string{
    
    const char *Cstr = [string UTF8String];
    
    NSMutableArray *mArr  =[[NSMutableArray alloc]init];
    
    while (*Cstr) {
        
        [mArr addObject:[NSString stringWithFormat:@"%c",*Cstr]];
        
        Cstr++;
    }
    
    
    return [mArr componentsJoinedByString:@"  "];
    
}


#pragma mark---专门处理银行卡号
static NSUInteger cardname = 1;

+ (NSString *)addEmptyStringWithBankCardNo:(NSString *)string{
    
    const char *Cstr = [string UTF8String];
    
    NSMutableArray *mArr  =[[NSMutableArray alloc]init];
    
    while (*Cstr) {
        
        if (cardname==4) {
            
            [mArr addObject:[NSString stringWithFormat:@"%c     ",*Cstr]];
            
            cardname= 0;
        }
        else{
            
            [mArr addObject:[NSString stringWithFormat:@"%c",*Cstr]];
            
        }
        
        Cstr++;
        
        cardname++;
        
    }
    
    
    return [mArr componentsJoinedByString:@" "];
    
}

#if 0
#pragma  mark---挂失申请书
+ (void)lossApplyBook:(NSDictionary*)dict lastPrint:(NSDictionary *)lastDict{
    
    
    UIImage *image  =[UIImage imageNamed:@"76*76"];
    
    [image drawInRect:CGRectMake(150, 70, 50, 50)];
    
    
    /**
     
     农 村 商 业 银 行\n农 村 合 作 银 行
     
     */
    
    [PDFRenderer printStr:@"广西农村信用社                           挂失申请书" CGRect:CGRectMake(220, 80, WIDTH, 200) Font:35.0   fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"编号" CGRect:CGRectMake(WIDTH -250, 90, 100, 200) Font:22.0   fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentRight];
    
    [PDFRenderer printStr:@"农 村 商 业 银 行\n农 村 合 作 银 行" CGRect:CGRectMake(500, 65, 300, 200) Font:22.0  fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"（               ）" CGRect:CGRectMake(452, 70, 300, 200) Font:42.0 lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //申请日期：    年    月    日
    
    [PDFRenderer printStr:@"申请日期：" CGRect:CGRectMake(452, 150, 300, 200) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:[PCMobileBankGlobal sharedInstance].writeDate CGRect:CGRectMake(602, 150, 300, 200) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //画空心矩形框A
    
    CGFloat X =80;
    
    CGFloat Y =180;
    
    [PDFRenderer drawEmptySquareWithCGRect:CGRectMake(X, Y, WIDTH-140, HEIGHT-290)];
    
    
    /**
     *  客户须知：
     1、申请挂失人必须保证挂失时提供的资料真实、准确、有效；
     2、挂失撤挂、挂失补发、密码重置和挂失清户必须在原挂失信用社（银行）柜面办理；
     3、客户办理口头挂失，可以用口头、函电等形式向营业机构或966888客户服务中心申请挂失。自口头挂失日起五日内，客户未办理书面挂失手续的，口头挂失自第六日起自动失效；
     4、个人账户办理书面挂失后，需由挂失申请人凭挂失申请书和开户有效证件办理挂失补发、重置密码或挂失销户；
     5、单位账户办理书面挂失，自书面挂失到期后，可由挂失申请人凭挂失申请书办理挂失补发；
     6、办理挂失仅对指定的挂失对象止付，不影响其他对象支付；
     7、若账户资金在挂失前或挂失失效后被他人支取，客户自行承担相关责任；
     8、带“*”号为必填项；
     
     */
    
    NSString *ImportantTip = @"  客户须知：\n1、申请挂失人必须保证挂失时提供的资料真实、准确、有效；\n2、挂失撤挂、挂失补发、密码重置和挂失清户必须在原挂失信用社（银行）柜面办理；\n3、客户办理口头挂失，可以用口头、函电等形式向营业机构或966888客户服务中心申请挂失。自口头挂失日起五日内，客户未办理书面挂失手续的，口头挂失自第六日起自动失效；\n4、个人账户办理书面挂失后，需由挂失申请人凭挂失申请书和开户有效证件办理挂失补发、重置密码或挂失销户；\n5、单位账户办理书面挂失，自书面挂失到期后，可由挂失申请人凭挂失申请书办理挂失补发；\n6、办理挂失仅对指定的挂失对象止付，不影响其他对象支付；\n7、若账户资金在挂失前或挂失失效后被他人支取，客户自行承担相关责任；\n8、带“*”号为必填项；";
    
    [PDFRenderer printStr:ImportantTip CGRect:CGRectMake(120, 190, WIDTH-190, 500) Font:18.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //第一条横线  “8、带“*”号为必填项；” 下面的横线
    
    Y+=260;
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    [PDFRenderer printStr:@"客户类型*" CGRect:CGRectMake(X+20, Y+7, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"单位□         个人□" CGRect:CGRectMake(X+200, Y+7, 220, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"*户名" CGRect:CGRectMake(X+500, Y+7, 220, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    //*账/卡号/凭证号
    
    [PDFRenderer printStr:@"*账/卡号/凭证号" CGRect:CGRectMake(X+500, Y+7+40, 220, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"申请日期*" CGRect:CGRectMake(X+20, Y+7+40, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"挂失对象*" CGRect:CGRectMake(X+20, Y+7+40*2, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"存折□   存单□   证实书□   卡□    印鉴□   密码□  其他_ _ _ _ _ _ _ _ _ _ _ _ _ _ _" CGRect:CGRectMake(X+200, Y+12+40*2, 780, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"申请挂失人*" CGRect:CGRectMake(X+20, Y+7+40*3, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"证件类型*" CGRect:CGRectMake(X+365, Y+7+40*3, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"证件类型*" CGRect:CGRectMake(X+365, Y+7+40*4, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    [PDFRenderer printStr:@"证件号码*" CGRect:CGRectMake(X+665, Y+7+40*3, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"证件号码*" CGRect:CGRectMake(X+665, Y+7+40*4, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"联系电话" CGRect:CGRectMake(X+665, Y+7+40*5, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"联系电话" CGRect:CGRectMake(X+665, Y+67+40*5, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"代理挂失人*" CGRect:CGRectMake(X+20, Y+7+40*4, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"申请挂失人通讯地址" CGRect:CGRectMake(X+20, Y+17+40*5, 180, 60) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"代理挂失人通讯地址" CGRect:CGRectMake(X+20, Y+17+40*5+60, 180, 60) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"账户余额" CGRect:CGRectMake(X+20, Y+7+40*5+60*2, 180, 60) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"挂失原因*" CGRect:CGRectMake(X+20, Y+7+40*6+60*2, 180, 60) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"信用社︵银行︶打印" CGRect:CGRectMake(X+15, Y+27+40*6+60*3, 30, 260) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _" CGRect:CGRectMake(X+20, Y+20+40*6+60*3+255, 500, 40) Font:16.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"信用社（银行）" CGRect:CGRectMake(X+345, Y+16+40*6+60*3+250, 500, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"                       兹有上列                                     遗失、损毁，特申请挂失止付。请按照信用社（银行）挂失止付规定办理，倘日后发生任何纠葛，申请人（代理申请人）愿负完全责任。" CGRect:CGRectMake(X+20, Y+40*7+60*3+260, WIDTH-180, 80) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:@"申请人（代理人）签章（字）：" CGRect:CGRectMake(WIDTH - 600, Y+40*8+60*3+280, WIDTH-180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    
    
    //客户类型* 右面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+180, Y) toPoint:CGPointMake(X+180, Y+40*5)];
    
    //*户名 左面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+480, Y) toPoint:CGPointMake(X+480, Y+40*2)];
    
    //证件类型* 右面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+480, Y+40*3) toPoint:CGPointMake(X+480, Y+40*5)];
    
    //证件号码* 左面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+650, Y+40*3) toPoint:CGPointMake(X+650, Y+40*5+60*2)];
    
    //证件号码* 右面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+800, Y+40*3) toPoint:CGPointMake(X+800, Y+40*5+60*2)];
    
    
    //证件类型* 左面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+350, Y+40*3) toPoint:CGPointMake(X+350, Y+40*5)];
    
    //客户类型* 下面的横线
    
    Y+=40;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    
    
    //申请日期* 下面的横线
    
    Y+=40;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    //挂失对象* 下面的横线
    
    Y+=40;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    //申请挂失人* 下面的横线
    
    Y+=40;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    //代理挂失人* 下面的横线
    
    Y+=40;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    //申请挂失人通讯地址 右面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+220, Y) toPoint:CGPointMake(X+220, Y+60*2+40)];
    
    
    //申请挂失人通讯地址 下面的横线
    
    Y+=60;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    //代理挂失人通讯地址 下面的横线
    
    Y+=60;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    //账户余额 下面的横线
    Y+=40;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    //挂失原因* 下面的横线
    Y+=60;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    
    //信用社（银行）打印右面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+50, Y) toPoint:CGPointMake(X+50, Y+250)];
    
    
    //信用社（银行）打印下面的横线
    Y+=250;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    //申请人（代理人）签章（字）： 下面的横线
    Y+=140;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    //申请挂失 处理日期  右面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+180, Y) toPoint:CGPointMake(X+180, Y+50)];
    
    
    [PDFRenderer printStr:@"申请挂失\n处理日期 " CGRect:CGRectMake(X+50, Y, 180, 60) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"挂失处\n理方式 " CGRect:CGRectMake(X+385, Y, 180, 60) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"解挂受理信用社︵银行︶打印" CGRect:CGRectMake(X+17, Y+70, 20, 560) Font:17.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    [PDFRenderer printStr:@"撤挂□   密码重置□   挂失补发□   挂失销户□" CGRect:CGRectMake(X+500, Y+17, 880, 60) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //挂失处理方式 左面的竖线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+350, Y) toPoint:CGPointMake(X+350, Y+50)];
    
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+480, Y) toPoint:CGPointMake(X+480, Y+50)];
    
    
    
    //申请挂失 处理日期  下面的横线
    Y+=50;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    
    [PDFRenderer drawLineFromPoint:CGPointMake(X+50, Y) toPoint:CGPointMake(X+50, Y+280)];
    
    //解挂受理信用社（银行）打  下面的横线
    Y+=280;
    [PDFRenderer drawLineFromPoint:CGPointMake(X, Y) toPoint:CGPointMake(X+WIDTH-140, Y)];
    
    //挂失处理客户确认 右面的线
    [PDFRenderer drawLineFromPoint:CGPointMake(X+250, Y) toPoint:CGPointMake(X+250, Y+65)];
    
    [PDFRenderer printStr:@"挂失处理客户确认" CGRect:CGRectMake(X+20, Y+20, 300, 60) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:@"请申请人审阅以上记录，无误后签名确认:" CGRect:CGRectMake(X+270, Y+30, 500, 60) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
//    [PDFRenderer printStr:@"_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _" CGRect:CGRectMake(X+690, Y+37, 500, 60) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //第一联   信用社（银行）给挂失止付人的受理回单
    
    [PDFRenderer printStr:@"第一联   信用社︵银行︶给挂失止付人的受理回单" CGRect:CGRectMake(WIDTH -50, 500, 20, 500) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    [PDFRenderer printStr:@"第二联   解挂后随传票交网点会计存档" CGRect:CGRectMake(WIDTH -50, 900, 20, 500) Font:14.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //经办：             复核：          事后监督（授权）：
    
    Y+=75;
    [PDFRenderer printStr:@"经办：                            复核：                            事后监督（授权）：" CGRect:CGRectMake(X+300, Y, WIDTH-190, 100) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [self printlossApplyBookInfo:dict lastPrint:lastDict];
    
    
    
}

+(void)printlossApplyBookInfo:(NSDictionary *)dictData lastPrint:(NSDictionary *)lastDict{
    
   
    
    UIImage *selectImage  =[UIImage imageNamed:@"cutPicSelect.png"];
    
    
    //客户类型*
    NSString *applicant_CustomType  = [dictData objectForKey:@"applicant_CustomType"];
    
    if ([applicant_CustomType isEqualToString:@"个人"])
    {
        [selectImage drawInRect:CGRectMake(443, 446, 25, 25)];
        
        
    }
    else
    {
        [selectImage drawInRect:CGRectMake(322, 446, 25, 25)];
        
    }
    
    //户名*
    NSString *applicant_CusName  = [dictData objectForKey:@"applicant_CusName"];
    
    [PDFRenderer printStr:applicant_CusName CGRect:CGRectMake(780, 446, 220, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //*账/卡号/凭证号*
    NSString *applicant_CardNo  = [dictData objectForKey:@"applicant_CardNo"];
    
    if ([[PCMobileBankGlobal sharedInstance].jumpDirection isEqualToString:@"lossAndRealse2"]) {
        
        applicant_CardNo =[dictData objectForKey:@"applicant_AcctNo"];
    }

    [PDFRenderer printStr:applicant_CardNo CGRect:CGRectMake(750, 486, 820, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请日期*
    [PDFRenderer printStr:@"2016年6月27号" CGRect:CGRectMake(280, 486, 220, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //*账/卡号/凭证号*
    NSString *applicant_Object = [dictData objectForKey:@"applicant_Object"];
    
    if ([applicant_Object isEqualToString:@"凭证"])
    {
        [selectImage drawInRect:CGRectMake(322+84*3, 486+45, 25, 25)];
        
    }
    
    else if ([applicant_Object isEqualToString:@"密码"])
    {
        [selectImage drawInRect:CGRectMake(322+84*5+7, 486+45, 25, 25)];
        
    }else if ([applicant_Object isEqualToString:@"凭证+密码"])
    {
        [selectImage drawInRect:CGRectMake(322+84*3, 486+45, 25, 25)];
        
        [selectImage drawInRect:CGRectMake(322+84*5+7, 486+45, 25, 25)];
        
    }
    
    //申请挂失人*
    NSString *applicant_CustomName = [dictData objectForKey:@"applicant_CustomName"];
    
    [PDFRenderer printStr:applicant_CustomName
                   CGRect:CGRectMake(312, 490+40*2, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //申请挂失人通讯地址
    NSString *applicant_Address = [dictData objectForKey:@"applicant_Address"];
    
    [PDFRenderer printStr:applicant_Address
                   CGRect:CGRectMake(310, 490+40*4, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //代理挂失人通讯地址
    NSString *applicant_AgentAddress = [dictData objectForKey:@"applicant_AgentAddress"];
    
    [PDFRenderer printStr:applicant_AgentAddress
                   CGRect:CGRectMake(310, 490+40*4+60, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //账户余额
    NSString *applicant_Bal = [dictData objectForKey:@"applicant_Bal"];
    
    
    
    if ([[PCMobileBankGlobal sharedInstance].jumpDirection isEqualToString:@"lossAndRealse2"]) {
        
        applicant_Bal =[dictData objectForKey:@"applicant_AccBalance"];
    }
    
    
    [PDFRenderer printStr:applicant_Bal
                   CGRect:CGRectMake(310, 490+40*4+60*2, WIDTH-200, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    //挂失原因*
    NSString *applicant_LossReason = [dictData objectForKey:@"applicant_LossReason"];
    
    [PDFRenderer printStr:applicant_LossReason
                   CGRect:CGRectMake(250, 490+40*4+60*3, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
#pragma mark----信用社（银行）打印
    
    //交易机构
    NSString *applicant_HandleOrg  = [dictData objectForKey:@"applicant_HandleOrg"];
    //账号/卡号
    NSString *applicant_AcctNo = [dictData objectForKey:@"applicant_AcctNo"];
    //凭证批次
    NSString *applicant_PreCharCode = [dictData objectForKey:@"applicant_PreCharCode"];
    //挂失标志
    NSString *applicant_RptLostFlag  = [dictData objectForKey:@"applicant_RptLostFlag"];
    
    //凭证类型
    NSString *applicant_VouKind  = [dictData objectForKey:@"applicant_VouKind"];
    
    //凭证号
    NSString *applicant_VouNo  = [dictData objectForKey:@"applicant_VouNo"];
    
    //交易日期
    NSString *applicant_Time  = [PCMobileBankGlobal sharedInstance].writeDate;

    //交易码
    NSString *applicant_TransCode  = [dictData objectForKey:@"applicant_TransCode"];

    
    NSString *jumpDirction = [PCMobileBankGlobal sharedInstance].jumpDirection;
    
    UIImage *signImage  =[PCMobileBankGlobal sharedInstance].writeImageLossAndRealse;

#pragma mark----挂失lossAndRealse
    if ([jumpDirction isEqualToString:@"lossAndRealse"]) {
        
        
      
        if (applicant_Object &&[applicant_Object isEqualToString:@"凭证"]) {
            
            [PDFRenderer printStr:@"卡" CGRect:CGRectMake(380, 750+40*6+60*3-10, 280, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            
        }
        else if (applicant_Object &&[applicant_Object isEqualToString:@"密码"]){
            
            [PDFRenderer printStr:@"密码" CGRect:CGRectMake(380, 750+40*6+60*3-10, 280, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            
        }
        else if (applicant_Object &&[applicant_Object isEqualToString:@"凭证+密码"]){
            
            [PDFRenderer printStr:@"卡+密码" CGRect:CGRectMake(380, 750+40*6+60*3-10, 280, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            
        }

    
        //XXXXXX 银行（信用社）
    NSString *applicant_HandleOrgName = [dictData objectForKey:@"applicant_HandleOrgName"];
        
    [PDFRenderer printStr:applicant_HandleOrgName
                       CGRect:CGRectMake(120, 750+40*5+60*3-2, 280, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
        
    //申请人（代理人）签章（字）：
    [signImage drawInRect:CGRectMake(637+100*3, 850+40*5+60*2+15, 200, 60)];

        
        
        
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易机构:  %@",applicant_HandleOrg]
                   CGRect:CGRectMake(150, 490+40*5+60*3, 180, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
     NSString  *cardName = @"账号/卡号:";
      
    [PDFRenderer printStr:[NSString stringWithFormat:@"%@ %@",cardName,applicant_AcctNo] CGRect:CGRectMake(150, 490+40*5+60*3+30, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //交易名称
    NSString * applicant_TranName = [lastDict objectForKey:@"applicant_TranName"];
    
    applicant_TranName  =[NSString stringWithFormat:@"交易名称:%@",applicant_TranName];
    [self printStr:applicant_TranName CGRect:CGRectMake(550, 490+40*5+60*3+30, 480, 40) Font:20.0 lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
        
    //账户余额
    [PDFRenderer printStr:[NSString stringWithFormat:@"账户余额:  %@",applicant_Bal]
                   CGRect:CGRectMake(150, 490+40*5+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    //客户名称
    [PDFRenderer printStr:[NSString stringWithFormat:@"客户名称:  %@",applicant_CusName]
                   CGRect:CGRectMake(550, 490+40*5+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //挂失对象
    [PDFRenderer printStr:[NSString stringWithFormat:@"挂失对象:  %@",applicant_Object]
                   CGRect:CGRectMake(850, 490+40*5+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
   
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"凭证批次:  %@",applicant_PreCharCode]
                   CGRect:CGRectMake(150, 490+40*6+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"挂失标志:  %@",applicant_RptLostFlag]
                   CGRect:CGRectMake(550, 490+40*6+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //证件类型
    [PDFRenderer printStr:[NSString stringWithFormat:@"证件类型:  %@",@"身份证"] CGRect:CGRectMake(850, 490+40*6+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
   
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"凭证类型:  %@",applicant_VouKind]
                   CGRect:CGRectMake(150, 490+40*7+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
   
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"凭证号:  %@",applicant_VouNo]
                   CGRect:CGRectMake(550, 490+40*7+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //授权机构
    [PDFRenderer printStr:[NSString stringWithFormat:@"授权机构:  %@",applicant_HandleOrg]
                   CGRect:CGRectMake(850, 490+40*7+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //证件号码
    [PDFRenderer printStr:[NSString stringWithFormat:@"证件号码:  %@",[dictData objectForKey:@"applicant_IdN"]] CGRect:CGRectMake(150, 490+40*8+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
   
        
    //授权人
    [PDFRenderer printStr:[NSString stringWithFormat:@"授权人:  %@",[dictData objectForKey:@"applicant_HandleTellerC"]] CGRect:CGRectMake(550, 490+40*8+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
    //挂失编号
    NSString * applicant_lostNo = [lastDict objectForKey:@"applicant_lostNo"];
    applicant_lostNo  =[NSString stringWithFormat:@"挂失编号:%@",applicant_lostNo];
    
    [self printStr:applicant_lostNo CGRect:CGRectMake(150, 490+40*9+60*3+30*2-5, 480, 40) Font:20.0 lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
    
    //流水号
    NSString * applicant_TermSeq = [lastDict objectForKey:@"applicant_TermSeq"];
    applicant_TermSeq  =[NSString stringWithFormat:@"流水号:%@",applicant_TermSeq];
    
    [self printStr:applicant_TermSeq CGRect:CGRectMake(550, 490+40*9+60*3+30*2-5, 480, 40) Font:20.0 lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
        
        
       
    
    
    //操作员
    [PDFRenderer printStr:[NSString stringWithFormat:@"操作员:  %@",[dictData objectForKey:@"applicant_HandleUserId"]] CGRect:CGRectMake(850, 490+40*8+60*3+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易日期:  %@",applicant_Time]
                   CGRect:CGRectMake(550, 490+40*5+60*3, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易码:  %@",applicant_TransCode]
                   CGRect:CGRectMake(850, 490+40*5+60*3, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
    }
    
#pragma mark----挂失补发 也叫挂失补卡 lossAndRealse2

    /**
     "Tranantion_Name" = "\U6302\U5931\U6362\U5361";
     "applicant_TermSeq" = 17959;
     "tran_Date" = "";

     */
    else if ([jumpDirction isEqualToString:@"lossAndRealse2"]){
        
        
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易机构:  %@",[dictData objectForKey:@"applicant_HandleOrgId"]]CGRect:CGRectMake(150, HEIGHT-440, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易日期:  %@",applicant_Time] CGRect:CGRectMake(550, HEIGHT-440, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
    [PDFRenderer printStr:[NSString stringWithFormat:@"流水号:  %@",[lastDict objectForKey:@"applicant_TermSeq"]]CGRect:CGRectMake(850, HEIGHT-440, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易名称:  %@",[lastDict objectForKey:@"Tranantion_Name"]]CGRect:CGRectMake(150, HEIGHT-440+30, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"挂失编号:  %@",[dictData objectForKey:@"applicant_lostNo"]]CGRect:CGRectMake(550, HEIGHT-440+30, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
     [PDFRenderer printStr:[NSString stringWithFormat:@"挂失对象:  %@",[dictData objectForKey:@"applicant_Object"]]CGRect:CGRectMake(850, HEIGHT-440+30, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"旧卡/卡号:  %@",[dictData objectForKey:@"applicant_AcctNo"]]CGRect:CGRectMake(150, HEIGHT-440+30*2, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
    [PDFRenderer printStr:[NSString stringWithFormat:@"新卡/卡号:  %@",[dictData objectForKey:@"New_Card_Number"]]CGRect:CGRectMake(150, HEIGHT-440+30*3, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"账户余额:  %@",[dictData objectForKey:@"applicant_AccBalance"]]CGRect:CGRectMake(150, HEIGHT-440+30*4, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户名称:  %@",[dictData objectForKey:@"applicant_CustomName"]]CGRect:CGRectMake(550, HEIGHT-440+30*4, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"挂失处理方式:  %@",[dictData objectForKey:@"applicant_HandleMethod"]]CGRect:CGRectMake(850, HEIGHT-440+30*4, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
           [PDFRenderer printStr:[NSString stringWithFormat:@"证件类型:  %@",[dictData objectForKey:@"applicant_IdType"]]CGRect:CGRectMake(150, HEIGHT-440+30*5, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        [PDFRenderer printStr:[NSString stringWithFormat:@"证件号码:  %@",[dictData objectForKey:@"applicant_IdN"]]CGRect:CGRectMake(550, HEIGHT-440+30*5, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //housss
          [PDFRenderer printStr:[NSString stringWithFormat:@"操作员:  %@",[PCMobileBankUtil getAppLoginSession].loginName]CGRect:CGRectMake(550, HEIGHT-440+30*6, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        [PDFRenderer printStr:[NSString stringWithFormat:@"授权人:  %@",[dictData objectForKey:@"applicant_HandleTellerC"]]CGRect:CGRectMake(850, HEIGHT-440+30*6, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        
        
        //申请挂失 处理日期
        [PDFRenderer printStr:applicant_Time CGRect:CGRectMake(275, 850+40*6+60*3-5, 280, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        
        

    //挂失处 理方式
        NSString *applicant_HandleMethod  =[dictData objectForKey:@"applicant_HandleMethod"];
        
        if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"撤挂"])
        {
            
            [selectImage drawInRect:CGRectMake(617, 850+40*6+60*3-5, 25, 25)];
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"密码重置"])
        {
            
            [selectImage drawInRect:CGRectMake(634+100, 850+40*6+60*3-5, 25, 25)];
            
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"挂失补发"])
        {
            
            
            [selectImage drawInRect:CGRectMake(651+100*2, 850+40*6+60*3-5, 25, 25)];
            
            
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"挂失销户"])
        {
            
            [selectImage drawInRect:CGRectMake(667+100*3, 850+40*6+60*3-5, 25, 25)];
            
            
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"挂失补发+密码重置"]){
            
            
            [selectImage drawInRect:CGRectMake(651+100*2, 850+40*6+60*3-5, 25, 25)];
            
            [selectImage drawInRect:CGRectMake(634+100, 850+40*6+60*3-5, 25, 25)];
            
        }
        
        
        //请申请人审阅以上记录，无误后签名确认
        
        [signImage drawInRect:CGRectMake(WIDTH-450, HEIGHT-170, 200, 60)];

        
    }
    
#pragma mark----解挂lossAndRealse3

    else if ([jumpDirction isEqualToString:@"lossAndRealse3"]){
        
#pragma mark----解挂受理信用社（银行）打印
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易机构:  %@",applicant_HandleOrg]CGRect:CGRectMake(150, HEIGHT-440, 180, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易日期:  %@",applicant_Time]
                   CGRect:CGRectMake(550, HEIGHT-440, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"交易码:  %@",applicant_TransCode]
                   CGRect:CGRectMake(850, HEIGHT-440, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"账号/卡号:  %@",applicant_AcctNo]
                   CGRect:CGRectMake(150, HEIGHT-440+30, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //挂失编号
    NSString *applicant_lostNo = [dictData objectForKey:@"applicant_lostNo"];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"挂失编号:  %@",applicant_lostNo]
                   CGRect:CGRectMake(550, HEIGHT-440+30, 280, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"撤挂对象:  %@",applicant_Object]
                   CGRect:CGRectMake(850, HEIGHT-440+30, 280, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"账户余额:  %@",[dictData objectForKey:@"applicant_AccBalance"]]
                   CGRect:CGRectMake(150, HEIGHT-440+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //客户名称
    [PDFRenderer printStr:[NSString stringWithFormat:@"客户名称:  %@",applicant_CusName]
                   CGRect:CGRectMake(550,  HEIGHT-440+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //挂失标志
    [PDFRenderer printStr:[NSString stringWithFormat:@"挂失标志:  %@",applicant_RptLostFlag]
                   CGRect:CGRectMake(850, HEIGHT-440+30*2, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //凭证批次
    [PDFRenderer printStr:[NSString stringWithFormat:@"凭证批次:  %@",applicant_PreCharCode]
                   CGRect:CGRectMake(150,  HEIGHT-440+30*3, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //证件类型
    [PDFRenderer printStr:[NSString stringWithFormat:@"证件类型:  %@",@"身份证"] CGRect:CGRectMake(550,  HEIGHT-440+30*3, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //凭证号
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"凭证号:  %@",applicant_VouNo]
                   CGRect:CGRectMake(850, HEIGHT-440+30*3, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //凭证类型
    
    [PDFRenderer printStr:[NSString stringWithFormat:@"凭证类型:  %@",applicant_VouKind]
                   CGRect:CGRectMake(150, HEIGHT-440+30*4, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    
    //授权机构
    [PDFRenderer printStr:[NSString stringWithFormat:@"授权机构:  %@",applicant_HandleOrg]
                   CGRect:CGRectMake(550, HEIGHT-440+30*4, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //证件号码
    [PDFRenderer printStr:[NSString stringWithFormat:@"证件号码:  %@",[dictData objectForKey:@"applicant_IdN"]] CGRect:CGRectMake(150, HEIGHT-440+30*5, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //授权人
    [PDFRenderer printStr:[NSString stringWithFormat:@"授权人:  %@",[dictData objectForKey:@"applicant_HandleTellerC"]] CGRect:CGRectMake(550, HEIGHT-440+30*5, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //操作员
    [PDFRenderer printStr:[NSString stringWithFormat:@"操作员:  %@",[dictData objectForKey:@"applicant_HandleUserId"]] CGRect:CGRectMake(850, HEIGHT-440+30*5, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
       
    //交易名称
    NSString * applicant_TranName = [lastDict objectForKey:@"applicant_TranName"];
    
    applicant_TranName  =[NSString stringWithFormat:@"交易名称:%@",applicant_TranName];
    [self printStr:applicant_TranName CGRect:CGRectMake(150, HEIGHT-440+30*6, 480, 40) Font:20.0 lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
        
    //流水号
    NSString * applicant_TermSeq = [lastDict objectForKey:@"applicant_TermSeq"];
    applicant_TermSeq  =[NSString stringWithFormat:@"流水号:%@",applicant_TermSeq];
    
    [self printStr:applicant_TermSeq CGRect:CGRectMake(550, HEIGHT-440+30*6, 480, 40) Font:20.0 lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];

        
        
        
        
        
        //请申请人审阅以上记录，无误后签名确认
        
        [signImage drawInRect:CGRectMake(WIDTH-450, HEIGHT-172, 200, 60)];
        
        
        
        //挂失处 理方式
        NSString *applicant_HandleMethod  =[dictData objectForKey:@"applicant_HandleMethod"];
        
        
        
        if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"撤挂"])
        {
            
            [selectImage drawInRect:CGRectMake(617, 850+40*6+60*3-5, 25, 25)];
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"密码重置"])
        {
            
            [selectImage drawInRect:CGRectMake(634+100, 850+40*6+60*3-5, 25, 25)];
            
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"挂失补发"])
        {
            
            
            [selectImage drawInRect:CGRectMake(651+100*2, 850+40*6+60*3-5, 25, 25)];
            
            
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"挂失销户"])
        {
            
            [selectImage drawInRect:CGRectMake(667+100*3, 850+40*6+60*3-5, 25, 25)];
            
            
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"挂失补发+密码重置"]){
            
            
            [selectImage drawInRect:CGRectMake(651+100*2, 850+40*6+60*3-5, 25, 25)];
            
            [selectImage drawInRect:CGRectMake(634+100, 850+40*6+60*3-5, 25, 25)];
            
            
        }
        
        //申请挂失 处理日期
        [PDFRenderer printStr:applicant_Time CGRect:CGRectMake(275, 850+40*6+60*3-5, 280, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        
    }
    
#pragma mark----密码重置lossAndRealse4

    else if ([jumpDirction isEqualToString:@"lossAndRealse4"]){
        
        //申请挂失 处理日期
        [PDFRenderer printStr:applicant_Time CGRect:CGRectMake(275, 850+40*6+60*3-5, 280, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        
        //交易机构
        NSString *applicant_HandleOrgId = [dictData objectForKey:@"applicant_HandleOrgId"];
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易机构:  %@",applicant_HandleOrgId]CGRect:CGRectMake(150, HEIGHT-440, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

        //交易日期
        NSString *writeDate = [PCMobileBankGlobal sharedInstance].writeDate;
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易日期:  %@",writeDate]CGRect:CGRectMake(550, HEIGHT-440, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        /**
         * lastDict:
         AutoTeller = 130011;
         SeqNum = 17436;
         ServiceLevel = "";
         TransCode = 215031;
         TransName = "\U5361\U5bc6\U7801\U91cd\U7f6e";
         */
        //流水号
        NSString *SeqNum = [lastDict objectForKey:@"SeqNum"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"流水号:  %@",SeqNum]CGRect:CGRectMake(850, HEIGHT-440, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //交易名称
        NSString *TransName = [lastDict objectForKey:@"TransName"];
        [PDFRenderer printStr:[NSString stringWithFormat:@"交易名称:  %@",TransName]CGRect:CGRectMake(150, HEIGHT-440+30, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //挂失编号
        NSString *applicant_lostNo = [dictData objectForKey:@"applicant_lostNo"];
        [PDFRenderer printStr:[NSString stringWithFormat:@"挂失编号:  %@",applicant_lostNo]CGRect:CGRectMake(550, HEIGHT-440+30, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //银行评级
        NSString *ServiceLevel = [lastDict objectForKey:@"ServiceLevel"];
        [PDFRenderer printStr:[NSString stringWithFormat:@"银行评级:  %@",ServiceLevel]CGRect:CGRectMake(850, HEIGHT-440+30, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //账号/卡号
        NSString *applicant_CardNo = [dictData objectForKey:@"applicant_CardNo"];
        [PDFRenderer printStr:[NSString stringWithFormat:@"账号/卡号:  %@",applicant_CardNo]CGRect:CGRectMake(150, HEIGHT-440+30*2, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //账户余额
        NSString *applicant_AccBalance = [dictData objectForKey:@"applicant_AccBalance"];
        [PDFRenderer printStr:[NSString stringWithFormat:@"账户余额:  %@",applicant_AccBalance]CGRect:CGRectMake(150, HEIGHT-440+30*3, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //客户名称
        NSString *applicant_CusName = [dictData objectForKey:@"applicant_CusName"];
        [PDFRenderer printStr:[NSString stringWithFormat:@"客户名称:  %@",applicant_CusName]CGRect:CGRectMake(550, HEIGHT-440+30*3, 380, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //挂失对象
        NSString *applicant_objName = [dictData objectForKey:@"applicant_objName"];
        [PDFRenderer printStr:[NSString stringWithFormat:@"挂失对象:  %@",applicant_objName]CGRect:CGRectMake(850, HEIGHT-440+30*3, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //挂失处理方式
        NSString *applicant_HandleMethod = [dictData objectForKey:@"applicant_HandleMethod"];
        [PDFRenderer printStr:[NSString stringWithFormat:@"挂失处理方式:  %@",applicant_HandleMethod]CGRect:CGRectMake(150, HEIGHT-440+30*4, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        //证件类型
        NSString *applicant_IdType = [dictData objectForKey:@"applicant_IdType"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件类型:  %@",applicant_IdType]CGRect:CGRectMake(150, HEIGHT-440+30*5, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //证件号码
        
        NSLog(@" 证件号--------%@",[dictData objectForKey:@"applicant_IdNo"]);
        [PDFRenderer printStr:[NSString stringWithFormat:@"证件号码:  %@",[dictData objectForKey:@"applicant_IdNo"]]CGRect:CGRectMake(150, HEIGHT-440+30*6, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //操作员
        NSString *applicant_HandleUserId = [dictData objectForKey:@"applicant_HandleUserId"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"操作员:  %@",applicant_HandleUserId]CGRect:CGRectMake(550, HEIGHT-440+30*6, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        //授权员
        NSString *AutoTeller = [lastDict objectForKey:@"AutoTeller"];
        
        [PDFRenderer printStr:[NSString stringWithFormat:@"授权员:  %@",AutoTeller]CGRect:CGRectMake(850, HEIGHT-440+30*6, 880, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];



//        //挂失处 理方式
//        NSString *applicant_HandleMethod  =[dictData objectForKey:@"applicant_HandleMethod"];
        
        
        
        if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"撤挂"])
        {
            
            [selectImage drawInRect:CGRectMake(617, 850+40*6+60*3-5, 25, 25)];
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"密码重置"])
        {
            
            [selectImage drawInRect:CGRectMake(634+100, 850+40*6+60*3-5, 25, 25)];
            
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"挂失补发"])
        {
            
            
            [selectImage drawInRect:CGRectMake(651+100*2, 850+40*6+60*3-5, 25, 25)];
            
            
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"挂失销户"])
        {
            
            [selectImage drawInRect:CGRectMake(667+100*3, 850+40*6+60*3-5, 25, 25)];
            
            
        }
        else if (applicant_HandleMethod&&[applicant_HandleMethod isEqualToString:@"挂失补发+密码重置"]){
            
            
            [selectImage drawInRect:CGRectMake(651+100*2, 850+40*6+60*3-5, 25, 25)];
            
            [selectImage drawInRect:CGRectMake(634+100, 850+40*6+60*3-5, 25, 25)];
            
        }
        
        
        //请申请人审阅以上记录，无误后签名确认
        
        [signImage drawInRect:CGRectMake(WIDTH-450, HEIGHT-172, 200, 60)];

        
        
      
        //复核
        [PDFRenderer printStr:AutoTeller CGRect:CGRectMake(700,  HEIGHT-100, 140, 30) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
      
        //事后监督(授权)
        [PDFRenderer printStr:AutoTeller CGRect:CGRectMake(WIDTH-180,  HEIGHT-100, 140, 30) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
    
    
    
    
   
    
    
    //经办：
    NSString *applicant_HandleUserId = [dictData objectForKey:@"applicant_HandleUserId"];
    
    
    if ([jumpDirction  isEqualToString:@"lossAndRealse2"]) {
        
        applicant_HandleUserId = [PCMobileBankUtil getAppLoginSession].loginName;
    }
    
    [PDFRenderer printStr:applicant_HandleUserId CGRect:CGRectMake(450,  HEIGHT-100, 140, 30) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    
    // 复核：
    NSString *applicant_HandleTeller = [dictData objectForKey:@"applicant_HandleTeller"];
    
    if ([jumpDirction  isEqualToString:@"lossAndRealse2"]) {
        
        applicant_HandleTeller = [dictData objectForKey:@"applicant_HandleTellerC"];
    }
    
    [PDFRenderer printStr:applicant_HandleTeller CGRect:CGRectMake(700,  HEIGHT-100, 140, 30) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    // 事后监督（授权）：
    NSString *applicant_HandleTellerC = [dictData objectForKey:@"applicant_HandleTellerC"];
    
    [PDFRenderer printStr:applicant_HandleTellerC CGRect:CGRectMake(WIDTH-180,  HEIGHT-100, 140, 30) Font:22.0 fontWithName:@"Helvetica-Bold" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请挂失人 联系电话
    NSString *applicant_Phone = [dictData objectForKey:@"applicant_Phone"];
    
    [PDFRenderer printStr:applicant_Phone
                   CGRect:CGRectMake(WIDTH-310, 490+40*4, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //代理挂失人 联系电话
    NSString *applicant_AgentPhone = [dictData objectForKey:@"applicant_AgentPhone"];
    
    [PDFRenderer printStr:applicant_AgentPhone
                   CGRect:CGRectMake(WIDTH-310, 490+40*4+60, 480, 40) Font:20.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //代理挂失人*
    NSString *applicant_AgentName = [dictData objectForKey:@"applicant_AgentName"];
    
    [PDFRenderer printStr:applicant_AgentName
                   CGRect:CGRectMake(312, 490+40*3, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
    //申请挂失人*  证件类型  housenkui
    
    
    //如果代理人 存在
    if (![applicant_AgentName isEqualToString:@""]) {
        
        //代理挂失人*  证件类型
        [PDFRenderer printStr:@"身份证" CGRect:CGRectMake(312+300, 490+40*3, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        [PDFRenderer printStr:@"身份证" CGRect:CGRectMake(312+300, 490+40*2, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
    } else {
        
        //申请挂失人*  证件类型
        [PDFRenderer printStr:@"身份证" CGRect:CGRectMake(312+300, 490+40*2, 180, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    }

    
    
    
    //申请挂失人*  证件号码
    NSString *applicant_IdN = [dictData objectForKey:@"applicant_IdN"];
    
    [PDFRenderer printStr:applicant_IdN
                   CGRect:CGRectMake(312+300*2, 490+40*2, 480, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    //代理挂失人*  证件号码
    NSString *applicant_AgentIdNo = [dictData objectForKey:@"applicant_AgentIdNo"];
    
    [PDFRenderer printStr:applicant_AgentIdNo CGRect:CGRectMake(312+300*2, 490+40*3, 480, 40) Font:22.0 fontWithName:@"Helvetica" lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    
}
#endif
@end

//
//  PDFRenderer.h
//  PDFRenderer
//
//  Created by Yuichi Fujiki on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

#pragma mark---用户画图

@interface PDFRenderer : NSObject

+ (void)drawText:(NSString*)text inFrame:(CGRect)frame fontName:(NSString *)fontName fontSize:(int) fontSize;

+ (void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to;

+ (void)drawDashLineFromPoint:(CGPoint)from toPoint:(CGPoint)to;
    
+ (void)drawImage:(UIImage*)image inRect:(CGRect)rect;
- (BOOL)strNilOrEmpty:(NSString *)string;
+ (void)createContractSignPDF;

//certificateDestroy
//凭证 销毁
+(void)certificateDestroy:(NSDictionary *)tableDict;


//短信通签约 解约   电话银行签约 解约  电子渠道
+ (void)Application_form_for_personal_customer_service_of_electronic_bank:(NSDictionary *)tableDict;

//开卡
+ (void)openBankCard:(NSDictionary *)tableDict last:(NSDictionary *)lastDict;

//挂失
+ (void)lossApplyBook:(NSDictionary*)dict lastPrint:(NSDictionary *)lastDict;


//银行卡特殊业务凭证
+ (void)specialBusiness:(NSDictionary*)dict lastPrint:(NSDictionary *)lastDict;


//特殊业务凭证
+ (void)other:(NSDictionary*)dict lastPrint:(NSDictionary *)lastDict;

//解除合并客户号
+ (void)AcctManager:(NSDictionary*)dict lastPrint:(NSDictionary *)lastDict;


+ (void)editPDF:(NSString*)filePath templateFilePath:(NSString*) templatePath;


@end

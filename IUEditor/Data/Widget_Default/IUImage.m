//
//  IUImage.m
//  IUEditor
//
//  Created by JD on 4/1/14.
//  Copyright (c) 2014 JDLab. All rights reserved.
//

#import "IUImage.h"

@implementation IUImage

#pragma mark - class attributes

+ (NSImage *)classImage{
    return [NSImage imageNamed:@"tool_image"];
}

+ (NSImage *)navigationImage{
    return [NSImage imageNamed:@"stack_image"];
}

#pragma mark - init

- (id)initWithJDCoder:(JDCoder *)aDecoder{
    self = [super initWithJDCoder:aDecoder];
    if(self){
        [self.undoManager disableUndoRegistration];
        [aDecoder decodeToObject:self withProperties:[[IUImage class] properties]];
        [self.undoManager enableUndoRegistration];
    }
    return self;
}

- (void)encodeWithJDCoder:(JDCoder *)aCoder{
    [super encodeWithJDCoder:aCoder];
    [aCoder encodeFromObject:self withProperties:[[IUImage class] properties]];
}

- (BOOL)shouldCompileImagePositionInfo{
    return NO;
}

-(id)copyWithZone:(NSZone *)zone{
    [self.undoManager disableUndoRegistration];
    
    IUImage *image = [super copyWithZone:zone];
    image.imagePath = [_imagePath copy];
    image.altText = [_altText copy];
    
    [self.undoManager enableUndoRegistration];
    return image;
}

#pragma mark - IUImage

- (BOOL)canAddIUByUserInput{
    return NO;
}


- (void)setImagePath:(NSString *)imagePath{
    if([imagePath isEqualToString:_imagePath]){
        return;
    }
    [[[self undoManager] prepareWithInvocationTarget:self] setImagePath:_imagePath];
    _imagePath = imagePath;
    
    [self updateHTML];
    
}


- (void)setAltText:(NSString *)altText{
    if([altText isEqualToString:_altText]){
        return;
    }
    
    [[self.undoManager prepareWithInvocationTarget:self] setAltText:_altText];
    _altText = altText;
}

@end
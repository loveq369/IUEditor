//
//  BBEventPropertyVC.h
//  IUEditor
//
//  Created by seungmi on 2014. 12. 8..
//  Copyright (c) 2014년 JDLab. All rights reserved.
//

#import "BBDefaultPropertyVC.h"

@interface BBEventPropertyVC : BBDefaultPropertyVC <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic) IUProject *project;

@end

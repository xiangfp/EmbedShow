//
//  Debug.h
//  ABrowser
//
//  Created by  on 11-3-7.
//  Copyright 2011 长亮电子. All rights reserved.
//
//需求编号 ：  

//#define Debug

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


#ifdef DEBUG
#define Debug(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define Debug(...)
#endif
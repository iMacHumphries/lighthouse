//
//  Macros.h
//  Mar
//
//  Created by Benjamin Humphries on 8/28/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#ifndef Mar_Macros_h
#define Mar_Macros_h

#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

#define SCALER (WIDTH/568)

#define GAME_SCALE_UP_WIDTH (WIDTH/568)
#define GAME_SCALE_UP_HEIGHT (HEIGHT/320)


#define GAME_SCALE_DOWN_WIDTH (568/WIDTH)
#define GAME_SCALE_DOWN_HEIGHT (320/HEIGHT)

//#define convertToScreenSpace(f) ((f / WIDTH * [[UIScreen mainScreen] bounds].size.width))

#define SPOT_LIGHT 0x1<<0
#define ROCKS 0x1<<1
#define SHIP 0x1<<2

#define UI @"ui"

#define OFF 100.0f
#define SPACE 50.0f

#define NOT_AFFECTED_BY_PAUSE @"notAffectedByPause"

#define PATH_FOR(name) (( [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name] ))

#endif

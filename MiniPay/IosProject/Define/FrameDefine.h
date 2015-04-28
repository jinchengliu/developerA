//
//  FrameDefine.h
//  Bank_IOS_Test
//
//  Created by carlos on 12-11-11.
//  Copyright (c) 2012年 carlos. All rights reserved.
//UI坐标

#ifndef Bank_IOS_Test_FrameDefine_h
#define Bank_IOS_Test_FrameDefine_h

#define k_frame_base_width [[UIScreen mainScreen]bounds].size.width
#define k_frame_base_height [[UIScreen mainScreen]bounds].size.height
#define k_frame_head_height 20
#define k_frame_navigation_bar_height 44
#define k_frame_tabbar_height 49

//除去底部tablview和导航栏的高度
#define k_frame_with_out_bar_tabbar_head  k_frame_base_height - k_frame_tabbar_height - k_frame_head_height- k_frame_navigation_bar_height


#endif

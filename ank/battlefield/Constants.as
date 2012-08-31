// Action script...

// [Initial MovieClip Action of sprite 845]
#initclip 57
class ank.battlefield.Constants extends Object
{
    function Constants()
    {
        super();
    } // End of the function
    static var DISPLAY_WIDTH = 742;
    static var DISPLAY_HEIGHT = 432;
    static var CELL_WIDTH = 53;
    static var CELL_HEIGHT = 27;
    static var CELL_HALF_WIDTH = 2.650000E+001;
    static var CELL_HALF_HEIGHT = 1.350000E+001;
    static var LEVEL_HEIGHT = 20;
    static var HALF_LEVEL_HEIGHT = 10;
    static var DEFAULT_MAP_WIDTH = 15;
    static var DEFAULT_MAP_HEIGHT = 17;
    static var MAX_DEPTH_IN_MAP = 100000;
    static var CELL_COORD = [[], [[-2.650000E+001, 0], [0, -1.350000E+001], [2.650000E+001, 0], [0, 1.350000E+001]], [[-2.650000E+001, -20], [0, -1.350000E+001], [2.650000E+001, 0], [0, 1.350000E+001]], [[-2.650000E+001, 0], [0, -3.350000E+001], [2.650000E+001, 0], [0, 1.350000E+001]], [[-2.650000E+001, -20], [0, -3.350000E+001], [2.650000E+001, 0], [0, 1.350000E+001]], [[-2.650000E+001, 0], [0, -1.350000E+001], [2.650000E+001, -20], [0, 1.350000E+001]], [[-2.650000E+001, -20], [0, -1.350000E+001], [2.650000E+001, -20], [0, 1.350000E+001]], [[-2.650000E+001, 0], [0, -3.350000E+001], [2.650000E+001, -20], [0, 1.350000E+001]], [[-2.650000E+001, -20], [0, -3.350000E+001], [2.650000E+001, -20], [0, 1.350000E+001]], [[-2.650000E+001, 0], [0, -1.350000E+001], [2.650000E+001, 0], [0, -6.500000E+000]], [[-2.650000E+001, -20], [0, -1.350000E+001], [2.650000E+001, 0], [0, -6.500000E+000]], [[-2.650000E+001, 0], [0, -3.350000E+001], [2.650000E+001, 0], [0, -6.500000E+000]], [[-2.650000E+001, -20], [0, -3.350000E+001], [2.650000E+001, 0], [0, -6.500000E+000]], [[-2.650000E+001, 0], [0, -1.350000E+001], [2.650000E+001, -20], [0, -6.500000E+000]], [[-2.650000E+001, -20], [0, -1.350000E+001], [2.650000E+001, -20], [0, -6.500000E+000]], [[-2.650000E+001, 0], [0, -3.350000E+001], [2.650000E+001, -20], [0, -6.500000E+000]]];
    static var EXTERNAL_OBJECT2_SIZE = 20;
    static var DEFAULT_CELL_CLIP_ID = 1;
    static var SELECTION_CELL_CLIP_ID = 2;
    static var FONT1_NAME = "Font1";
    static var FONT2_NAME = "Font2";
    static var FIRST_SPRITE_DEPTH_ON_CELL = 30;
    static var MAX_SPRITES_ON_CELL = 40;
    static var GRID_COLOR = 16777215;
    static var GRID_ALPHA = 30;
    static var GHOSTVIEW_SPRITE_ALPHA = 60;
    static var BUBBLE_BGCOLOR = 16777166;
    static var BUBBLE_BORDERCOLOR = 4934475;
    static var BUBBLE_TXTFORMAT = new TextFormat(ank.battlefield.Constants.FONT1_NAME, 10, 0, false, false, false);
    static var BUBBLE_REMOVE_TIMER = 4000;
    static var BUBBLE_REMOVE_CHAR_TIMER = 50;
    static var BUBBLE_MARGIN = 4;
    static var BUBBLE_PIC_WIDTH = 10;
    static var BUBBLE_PIC_HEIGHT = 10;
    static var BUBBLE_Y_OFFSET = 50;
    static var DEFAULT_SPRITE_HEIGHT = 50;
    static var SPRITE_POINTS_OFFSET = 40;
    static var SPRITE_POINTS_TEXTFORMAT = new TextFormat(ank.battlefield.Constants.FONT2_NAME, 18);
    static var VISUAL_EFFECT_MAX_TIMER = 20000;
    static var INTERACTION_NONE = 0;
    static var INTERACTION_CELL_NONE = 1;
    static var INTERACTION_CELL_RELEASE = 2;
    static var INTERACTION_CELL_OVER_OUT = 3;
    static var INTERACTION_CELL_RELEASE_OVER_OUT = 4;
    static var INTERACTION_OBJECT_NONE = 5;
    static var INTERACTION_OBJECT_RELEASE = 6;
    static var INTERACTION_OBJECT_OVER_OUT = 7;
    static var INTERACTION_OBJECT_RELEASE_OVER_OUT = 8;
    static var INTERACTION_SPRITE_NONE = 9;
    static var INTERACTION_SPRITE_RELEASE = 10;
    static var INTERACTION_SPRITE_OVER_OUT = 11;
    static var INTERACTION_SPRITE_RELEASE_OVER_OUT = 12;
} // End of Class
#endinitclip

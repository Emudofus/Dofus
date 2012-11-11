package com.ankamagames.jerakine.script.api
{
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.geom.*;

    public class RootApi extends Object
    {

        public function RootApi()
        {
            return;
        }// end function

        public static function Random(param1:int) : int
        {
            return Math.floor(Math.random() * param1);
        }// end function

        public static function CreatePoint(param1:Number = 0, param2:Number = 0) : Point
        {
            return new Point(param1, param2);
        }// end function

        public static function GetPointX(param1:Point) : Number
        {
            return param1.x;
        }// end function

        public static function GetPointY(param1:Point) : Number
        {
            return param1.y;
        }// end function

        public static function CreateRectangle(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : Rectangle
        {
            return new Rectangle(param1, param2, param3, param4);
        }// end function

        public static function GetRectangleX(param1:Rectangle) : Number
        {
            return param1.x;
        }// end function

        public static function GetRectangleY(param1:Rectangle) : Number
        {
            return param1.y;
        }// end function

        public static function GetRectangleHeight(param1:Rectangle) : Number
        {
            return param1.height;
        }// end function

        public static function GetRectangleWidth(param1:Rectangle) : Number
        {
            return param1.width;
        }// end function

        public static function GetStage() : Stage
        {
            return StageShareManager.stage;
        }// end function

    }
}

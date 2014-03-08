package com.ankamagames.jerakine.script.api
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.display.Stage;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   
   public class RootApi extends Object
   {
      
      public function RootApi() {
         super();
      }
      
      public static function Random(param1:int) : int {
         return Math.floor(Math.random() * param1);
      }
      
      public static function CreatePoint(param1:Number=0, param2:Number=0) : Point {
         return new Point(param1,param2);
      }
      
      public static function GetPointX(param1:Point) : Number {
         return param1.x;
      }
      
      public static function GetPointY(param1:Point) : Number {
         return param1.y;
      }
      
      public static function CreateRectangle(param1:Number=0, param2:Number=0, param3:Number=0, param4:Number=0) : Rectangle {
         return new Rectangle(param1,param2,param3,param4);
      }
      
      public static function GetRectangleX(param1:Rectangle) : Number {
         return param1.x;
      }
      
      public static function GetRectangleY(param1:Rectangle) : Number {
         return param1.y;
      }
      
      public static function GetRectangleHeight(param1:Rectangle) : Number {
         return param1.height;
      }
      
      public static function GetRectangleWidth(param1:Rectangle) : Number {
         return param1.width;
      }
      
      public static function GetStage() : Stage {
         return StageShareManager.stage;
      }
   }
}

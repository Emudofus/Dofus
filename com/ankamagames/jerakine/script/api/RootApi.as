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
      
      public static function Random(max:int) : int {
         return Math.floor(Math.random() * max);
      }
      
      public static function CreatePoint(x:Number = 0, y:Number = 0) : Point {
         return new Point(x,y);
      }
      
      public static function GetPointX(point:Point) : Number {
         return point.x;
      }
      
      public static function GetPointY(point:Point) : Number {
         return point.y;
      }
      
      public static function CreateRectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) : Rectangle {
         return new Rectangle(x,y,width,height);
      }
      
      public static function GetRectangleX(rect:Rectangle) : Number {
         return rect.x;
      }
      
      public static function GetRectangleY(rect:Rectangle) : Number {
         return rect.y;
      }
      
      public static function GetRectangleHeight(rect:Rectangle) : Number {
         return rect.height;
      }
      
      public static function GetRectangleWidth(rect:Rectangle) : Number {
         return rect.width;
      }
      
      public static function GetStage() : Stage {
         return StageShareManager.stage;
      }
   }
}

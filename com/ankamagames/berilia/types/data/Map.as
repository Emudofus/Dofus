package com.ankamagames.berilia.types.data
{
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.jerakine.types.Uri;
   
   public class Map extends Object
   {
      
      public function Map(param1:Number, param2:String, param3:DisplayObjectContainer, param4:uint, param5:uint, param6:uint, param7:uint) {
         var _loc8_:MapArea = null;
         var _loc11_:uint = 0;
         this.areas = [];
         super();
         this.zoom = param1;
         this.container = param3;
         this.initialHeight = param5;
         this.initialWidth = param4;
         this.chunckHeight = param7;
         this.chunckWidth = param6;
         param3.doubleClickEnabled = true;
         this.numXChunck = Math.ceil(param4 * param1 / param6);
         this.numYChunck = Math.ceil(param5 * param1 / param7);
         var _loc9_:uint = 1;
         var _loc10_:uint = 0;
         while(_loc10_ < this.numYChunck)
         {
            _loc11_ = 0;
            while(_loc11_ < this.numXChunck)
            {
               _loc8_ = new MapArea(new Uri(param2 + _loc9_ + ".jpg"),_loc11_ * param6 / param1,_loc10_ * param7 / param1,param6 / param1,param7 / param1,this);
               this.areas.push(_loc8_);
               _loc9_++;
               _loc11_++;
            }
            _loc10_++;
         }
      }
      
      public var initialWidth:uint;
      
      public var initialHeight:uint;
      
      public var chunckWidth:uint;
      
      public var chunckHeight:uint;
      
      public var zoom:Number;
      
      public var areas:Array;
      
      public var container:DisplayObjectContainer;
      
      public var numXChunck:uint;
      
      public var numYChunck:uint;
   }
}

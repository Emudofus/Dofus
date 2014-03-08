package com.ankamagames.jerakine.utils.benchmark.monitoring
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.Graph;
   import __AS3__.vec.Vector;
   import flash.system.Capabilities;
   
   public class FpsManagerUtils extends Object
   {
      
      public function FpsManagerUtils() {
         super();
      }
      
      public static function countKeys(param1:Dictionary) : int {
         var _loc3_:* = undefined;
         var _loc2_:* = 0;
         for (_loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function calculateMB(param1:uint) : Number {
         var _loc2_:Number = Math.round(param1 / 1024 / 1024 * 100);
         return _loc2_ / 100;
      }
      
      public static function getTimeFromNow(param1:int) : String {
         var _loc2_:int = getTimer() - param1;
         var _loc3_:int = _loc2_ / 1000;
         var _loc4_:int = _loc3_ / 60;
         _loc3_ = _loc3_ - _loc4_ * 60;
         return (_loc4_ > 0?_loc4_.toString() + " min ":"") + _loc3_.toString() + " sec";
      }
      
      public static function isSpecialGraph(param1:String) : Boolean {
         var _loc2_:Object = null;
         for each (_loc2_ in FpsManagerConst.SPECIAL_GRAPH)
         {
            if(_loc2_.name == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function numberOfSpecialGraphDisplayed(param1:Dictionary) : int {
         var _loc3_:Graph = null;
         var _loc2_:* = 0;
         for each (_loc3_ in param1)
         {
            if(FpsManagerUtils.isSpecialGraph(_loc3_.indice))
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public static function getVectorMaxValue(param1:Vector.<Number>) : Number {
         var _loc3_:* = NaN;
         var _loc2_:Number = 0;
         for each (_loc3_ in param1)
         {
            if(_loc3_ > _loc2_)
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
      
      public static function getVersion() : Number {
         var _loc1_:String = Capabilities.version;
         var _loc2_:Array = _loc1_.split(" ");
         var _loc3_:Array = _loc2_[1].split(",");
         var _loc4_:Number = _loc3_[0];
         return _loc4_;
      }
      
      public static function getBrightRandomColor() : uint {
         var _loc1_:uint = getRandomColor();
         while(_loc1_ < 8000000)
         {
            _loc1_ = getRandomColor();
         }
         return _loc1_;
      }
      
      public static function getRandomColor() : uint {
         return Math.random() * 16777215;
      }
      
      public static function addAlphaToColor(param1:uint, param2:uint) : uint {
         return (param2 << 24) + param1;
      }
   }
}

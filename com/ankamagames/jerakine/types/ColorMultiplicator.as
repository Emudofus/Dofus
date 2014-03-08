package com.ankamagames.jerakine.types
{
   import flash.utils.Dictionary;
   
   public class ColorMultiplicator extends Object
   {
      
      public function ColorMultiplicator(param1:int, param2:int, param3:int, param4:Boolean=false) {
         super();
         MEMORY_LOG[this] = 1;
         this.red = param1;
         this.green = param2;
         this.blue = param3;
         if(!param4 && param1 + param2 + param3 == 0)
         {
            this._isOne = true;
         }
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public static function clamp(param1:Number, param2:Number, param3:Number) : Number {
         if(param1 > param3)
         {
            return param3;
         }
         if(param1 < param2)
         {
            return param2;
         }
         return param1;
      }
      
      public var red:Number;
      
      public var green:Number;
      
      public var blue:Number;
      
      private var _isOne:Boolean;
      
      public function isOne() : Boolean {
         return this._isOne;
      }
      
      public function multiply(param1:ColorMultiplicator) : ColorMultiplicator {
         if(this._isOne)
         {
            return param1;
         }
         if(param1.isOne())
         {
            return this;
         }
         var _loc2_:ColorMultiplicator = new ColorMultiplicator(0,0,0);
         _loc2_.red = this.red + param1.red;
         _loc2_.green = this.green + param1.green;
         _loc2_.blue = this.blue + param1.blue;
         _loc2_.red = clamp(_loc2_.red,-128,127);
         _loc2_.green = clamp(_loc2_.green,-128,127);
         _loc2_.blue = clamp(_loc2_.blue,-128,127);
         _loc2_._isOne = false;
         return _loc2_;
      }
      
      public function toString() : String {
         return "[r: " + this.red + ", g: " + this.green + ", b: " + this.blue + "]";
      }
   }
}

package com.ankamagames.jerakine.types
{
   import flash.utils.Dictionary;
   
   public class ColorMultiplicator extends Object
   {
      
      public function ColorMultiplicator(redComponent:int, greenComponent:int, blueComponent:int, forceCalculation:Boolean=false) {
         super();
         MEMORY_LOG[this] = 1;
         this.red = redComponent;
         this.green = greenComponent;
         this.blue = blueComponent;
         if((!forceCalculation) && (redComponent + greenComponent + blueComponent == 0))
         {
            this._isOne = true;
         }
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public static function clamp(value:Number, min:Number, max:Number) : Number {
         if(value > max)
         {
            return max;
         }
         if(value < min)
         {
            return min;
         }
         return value;
      }
      
      public var red:Number;
      
      public var green:Number;
      
      public var blue:Number;
      
      private var _isOne:Boolean;
      
      public function isOne() : Boolean {
         return this._isOne;
      }
      
      public function multiply(cm:ColorMultiplicator) : ColorMultiplicator {
         if(this._isOne)
         {
            return cm;
         }
         if(cm.isOne())
         {
            return this;
         }
         var cmr:ColorMultiplicator = new ColorMultiplicator(0,0,0);
         cmr.red = this.red + cm.red;
         cmr.green = this.green + cm.green;
         cmr.blue = this.blue + cm.blue;
         cmr.red = clamp(cmr.red,-128,127);
         cmr.green = clamp(cmr.green,-128,127);
         cmr.blue = clamp(cmr.blue,-128,127);
         cmr._isOne = false;
         return cmr;
      }
      
      public function toString() : String {
         return "[r: " + this.red + ", g: " + this.green + ", b: " + this.blue + "]";
      }
   }
}

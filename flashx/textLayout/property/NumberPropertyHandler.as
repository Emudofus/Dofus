package flashx.textLayout.property
{
   public class NumberPropertyHandler extends PropertyHandler
   {
      
      public function NumberPropertyHandler(param1:Number, param2:Number, param3:String="allLimits") {
         super();
         this._minValue = param1;
         this._maxValue = param2;
         this._limits = param3;
      }
      
      private var _minValue:Number;
      
      private var _maxValue:Number;
      
      private var _limits:String;
      
      public function get minValue() : Number {
         return this._minValue;
      }
      
      public function get maxValue() : Number {
         return this._maxValue;
      }
      
      public function checkLowerLimit() : Boolean {
         return this._limits == Property.ALL_LIMITS || this._limits == Property.LOWER_LIMIT;
      }
      
      public function checkUpperLimit() : Boolean {
         return this._limits == Property.ALL_LIMITS || this._limits == Property.UPPER_LIMIT;
      }
      
      override public function owningHandlerCheck(param1:*) : * {
         var _loc2_:Number = param1 is String?parseFloat(param1):Number(param1);
         if(isNaN(_loc2_))
         {
            return undefined;
         }
         if((this.checkLowerLimit()) && _loc2_ < this._minValue)
         {
            return undefined;
         }
         if((this.checkUpperLimit()) && _loc2_ > this._maxValue)
         {
            return undefined;
         }
         return _loc2_;
      }
      
      public function clampToRange(param1:Number) : Number {
         if((this.checkLowerLimit()) && param1 < this._minValue)
         {
            return this._minValue;
         }
         if((this.checkUpperLimit()) && param1 > this._maxValue)
         {
            return this._maxValue;
         }
         return param1;
      }
   }
}

package flashx.textLayout.property
{
   public class PercentPropertyHandler extends PropertyHandler
   {
      
      public function PercentPropertyHandler(param1:String, param2:String, param3:String="allLimits") {
         super();
         this._minValue = Property.toNumberIfPercent(param1);
         this._maxValue = Property.toNumberIfPercent(param2);
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
         var _loc2_:Number = Property.toNumberIfPercent(param1);
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
         return param1;
      }
   }
}

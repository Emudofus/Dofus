package flashx.textLayout.property
{
   public class IntPropertyHandler extends PropertyHandler
   {
      
      public function IntPropertyHandler(param1:int, param2:int, param3:String="allLimits") {
         super();
         this._minValue = param1;
         this._maxValue = param2;
         this._limits = param3;
      }
      
      private var _minValue:int;
      
      private var _maxValue:int;
      
      private var _limits:String;
      
      public function get minValue() : int {
         return this._minValue;
      }
      
      public function get maxValue() : int {
         return this._maxValue;
      }
      
      public function checkLowerLimit() : Boolean {
         return this._limits == Property.ALL_LIMITS || this._limits == Property.LOWER_LIMIT;
      }
      
      public function checkUpperLimit() : Boolean {
         return this._limits == Property.ALL_LIMITS || this._limits == Property.UPPER_LIMIT;
      }
      
      override public function owningHandlerCheck(param1:*) : * {
         var _loc2_:Number = param1 is String?parseInt(param1):int(param1);
         if(isNaN(_loc2_))
         {
            return undefined;
         }
         var _loc3_:int = int(_loc2_);
         if((this.checkLowerLimit()) && _loc3_ < this._minValue)
         {
            return undefined;
         }
         if((this.checkUpperLimit()) && _loc3_ > this._maxValue)
         {
            return undefined;
         }
         return _loc3_;
      }
   }
}

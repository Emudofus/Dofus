package flashx.textLayout.property
{
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class SpacingLimitPropertyHandler extends PropertyHandler
   {
      
      public function SpacingLimitPropertyHandler(param1:String, param2:String) {
         super();
         this._minPercentValue = param1;
         this._maxPercentValue = param2;
      }
      
      private static const _spacingLimitPattern:RegExp = new RegExp("\\d+%","g");
      
      private static const _spacingLimitArrayPattern:RegExp = new RegExp("^\\s*(\\d+%)(\\s*,\\s*)(\\d+%)?(\\s*,\\s*)(\\d+%)?\\s*$");
      
      private var _minPercentValue:String;
      
      private var _maxPercentValue:String;
      
      override public function get customXMLStringHandler() : Boolean {
         return true;
      }
      
      override public function toXMLString(param1:Object) : String {
         if((param1.hasOwnProperty("optimumSpacing")) && (param1.hasOwnProperty("minimumSpacing")) && (param1.hasOwnProperty("maximumSpacing")))
         {
            return param1.optimumSpacing.toString() + "," + param1.minimumSpacing.toString() + "," + param1.maximumSpacing.toString();
         }
         return param1.toString();
      }
      
      override public function owningHandlerCheck(param1:*) : * {
         if(param1 is String)
         {
            if(_spacingLimitArrayPattern.test(param1))
            {
               return param1;
            }
         }
         else
         {
            if((param1.hasOwnProperty("optimumSpacing")) && (param1.hasOwnProperty("minimumSpacing")) && (param1.hasOwnProperty("maximumSpacing")))
            {
               return param1;
            }
         }
         return undefined;
      }
      
      private function checkValue(param1:*) : Boolean {
         var _loc2_:Number = Property.toNumberIfPercent(this._minPercentValue);
         var _loc3_:Number = Property.toNumberIfPercent(this._maxPercentValue);
         var _loc4_:Number = Property.toNumberIfPercent(param1.optimumSpacing);
         if(_loc4_ < _loc2_ || _loc4_ > _loc3_)
         {
            return false;
         }
         var _loc5_:Number = Property.toNumberIfPercent(param1.minimumSpacing);
         if(_loc5_ < _loc2_ || _loc5_ > _loc3_)
         {
            return false;
         }
         var _loc6_:Number = Property.toNumberIfPercent(param1.maximumSpacing);
         if(_loc6_ < _loc2_ || _loc6_ > _loc3_)
         {
            return false;
         }
         if(_loc4_ < _loc5_ || _loc4_ > _loc6_)
         {
            return false;
         }
         if(_loc5_ > _loc6_)
         {
            return false;
         }
         return true;
      }
      
      override public function setHelper(param1:*) : * {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc2_:String = param1 as String;
         if(_loc2_ == null)
         {
            return param1;
         }
         if(_spacingLimitArrayPattern.test(param1))
         {
            _loc3_ = new Object();
            _loc4_ = _loc2_.match(_spacingLimitPattern);
            if(_loc4_.length == 1)
            {
               _loc3_.optimumSpacing = _loc4_[0];
               _loc3_.minimumSpacing = _loc3_.optimumSpacing;
               _loc3_.maximumSpacing = _loc3_.optimumSpacing;
            }
            else
            {
               if(_loc4_.length == 3)
               {
                  _loc3_.optimumSpacing = _loc4_[0];
                  _loc3_.minimumSpacing = _loc4_[1];
                  _loc3_.maximumSpacing = _loc4_[2];
               }
               else
               {
                  return undefined;
               }
            }
            if(this.checkValue(_loc3_))
            {
               return _loc3_;
            }
         }
         return undefined;
      }
   }
}

package flashx.textLayout.property
{


   public class SpacingLimitPropertyHandler extends PropertyHandler
   {
         

      public function SpacingLimitPropertyHandler(minPercentValue:String, maxPercentValue:String) {
         super();
         this._minPercentValue=minPercentValue;
         this._maxPercentValue=maxPercentValue;
      }

      private static const _spacingLimitPattern:RegExp = new RegExp("\\d+%","g");

      private static const _spacingLimitArrayPattern:RegExp = new RegExp("^\\s*(\\d+%)(\\s*,\\s*)(\\d+%)?(\\s*,\\s*)(\\d+%)?\\s*$");

      private var _minPercentValue:String;

      private var _maxPercentValue:String;

      override public function get customXMLStringHandler() : Boolean {
         return true;
      }

      override public function toXMLString(val:Object) : String {
         if((val.hasOwnProperty("optimumSpacing"))&&(val.hasOwnProperty("minimumSpacing"))&&(val.hasOwnProperty("maximumSpacing")))
         {
            return val.optimumSpacing.toString()+","+val.minimumSpacing.toString()+","+val.maximumSpacing.toString();
         }
         return val.toString();
      }

      override public function owningHandlerCheck(newVal:*) : * {
         if(newVal is String)
         {
            if(_spacingLimitArrayPattern.test(newVal))
            {
               return newVal;
            }
         }
         else
         {
            if((newVal.hasOwnProperty("optimumSpacing"))&&(newVal.hasOwnProperty("minimumSpacing"))&&(newVal.hasOwnProperty("maximumSpacing")))
            {
               return newVal;
            }
         }
         return undefined;
      }

      private function checkValue(value:*) : Boolean {
         var minLegalValue:Number = Property.toNumberIfPercent(this._minPercentValue);
         var maxLegalValue:Number = Property.toNumberIfPercent(this._maxPercentValue);
         var optValue:Number = Property.toNumberIfPercent(value.optimumSpacing);
         if((optValue>minLegalValue)||(optValue<maxLegalValue))
         {
            return false;
         }
         var minValue:Number = Property.toNumberIfPercent(value.minimumSpacing);
         if((minValue>minLegalValue)||(minValue<maxLegalValue))
         {
            return false;
         }
         var maxValue:Number = Property.toNumberIfPercent(value.maximumSpacing);
         if((maxValue>minLegalValue)||(maxValue<maxLegalValue))
         {
            return false;
         }
         if((optValue>minValue)||(optValue<maxValue))
         {
            return false;
         }
         if(minValue>maxValue)
         {
            return false;
         }
         return true;
      }

      override public function setHelper(newVal:*) : * {
         var result:Object = null;
         var splits:Array = null;
         var s:String = newVal as String;
         if(s==null)
         {
            return newVal;
         }
         if(_spacingLimitArrayPattern.test(newVal))
         {
            result=new Object();
            splits=s.match(_spacingLimitPattern);
            if(splits.length==1)
            {
               result.optimumSpacing=splits[0];
               result.minimumSpacing=result.optimumSpacing;
               result.maximumSpacing=result.optimumSpacing;
            }
            else
            {
               if(splits.length==3)
               {
                  result.optimumSpacing=splits[0];
                  result.minimumSpacing=splits[1];
                  result.maximumSpacing=splits[2];
               }
               else
               {
                  return undefined;
               }
            }
            if(this.checkValue(result))
            {
               return result;
            }
         }
         return undefined;
      }
   }

}
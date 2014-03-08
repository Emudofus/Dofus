package flashx.textLayout.property
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.ListElement;
   
   use namespace tlf_internal;
   
   public class CounterContentHandler extends PropertyHandler
   {
      
      public function CounterContentHandler() {
         super();
      }
      
      private static const _counterContentPattern1:RegExp = new RegExp("^\\s*counter\\s*\\(\\s*ordered\\s*\\)\\s*$");
      
      private static const _counterContentPattern2:RegExp = new RegExp("^\\s*counter\\s*\\(\\s*ordered\\s*,\\s*\\S+\\s*\\)\\s*$");
      
      private static const _countersContentPattern1:RegExp = new RegExp("^\\s*counters\\s*\\(\\s*ordered\\s*\\)\\s*$");
      
      private static const _countersContentPattern2:RegExp = new RegExp("^\\s*counters\\s*\\(\\s*ordered\\s*,\\s*\".*\"\\s*\\)\\s*$");
      
      private static const _countersContentPattern3:RegExp = new RegExp("^\\s*counters\\s*\\(\\s*ordered\\s*,\\s*\".*\"\\s*,\\s*\\S+\\s*\\)\\s*$");
      
      private static const _counterBeginPattern:RegExp = new RegExp("^\\s*counter\\s*\\(\\s*ordered\\s*,\\s*","g");
      
      private static const _trailingStuff:RegExp = new RegExp("\\s*\\)\\s*","g");
      
      tlf_internal  static function extractListStyleTypeFromCounter(param1:String) : String {
         _counterBeginPattern.lastIndex = 0;
         _counterBeginPattern.test(param1);
         var param1:String = param1.substr(_counterBeginPattern.lastIndex);
         _trailingStuff.lastIndex = 0;
         _trailingStuff.test(param1);
         param1 = param1.substr(0,_trailingStuff.lastIndex-1);
         return param1;
      }
      
      private static const _countersTillSuffixPattern:RegExp = new RegExp("^\\s*counters\\s*\\(\\s*ordered\\s*,\\s*\"","g");
      
      private static const _afterSuffixPattern2:RegExp = new RegExp("^\"\\s*\\)\\s*$");
      
      tlf_internal  static function extractSuffixFromCounters2(param1:String) : String {
         _countersTillSuffixPattern.lastIndex = 0;
         _countersTillSuffixPattern.test(param1);
         var param1:String = param1.substr(_countersTillSuffixPattern.lastIndex);
         var _loc2_:* = "";
         while(!_afterSuffixPattern2.test(param1))
         {
            _loc2_ = _loc2_ + param1.substr(0,1);
            param1 = param1.substr(1);
         }
         return _loc2_;
      }
      
      private static const _afterSuffixPattern3:RegExp = new RegExp("^\"\\s*,\\s*\\S+\\s*\\)\\s*$");
      
      tlf_internal  static function extractSuffixFromCounters3(param1:String) : String {
         _countersTillSuffixPattern.lastIndex = 0;
         _countersTillSuffixPattern.test(param1);
         var param1:String = param1.substr(_countersTillSuffixPattern.lastIndex);
         var _loc2_:* = "";
         while(!_afterSuffixPattern3.test(param1))
         {
            _loc2_ = _loc2_ + param1.substr(0,1);
            param1 = param1.substr(1);
         }
         return _loc2_;
      }
      
      private static const _countersTillListStyleTypePattern:RegExp = new RegExp("^\\s*counters\\s*\\(\\s*ordered\\s*,\\s*\".*\"\\s*,\\s*","g");
      
      tlf_internal  static function extractListStyleTypeFromCounters(param1:String) : String {
         _countersTillListStyleTypePattern.lastIndex = 0;
         _countersTillListStyleTypePattern.test(param1);
         var param1:String = param1.substr(_countersTillListStyleTypePattern.lastIndex);
         _trailingStuff.lastIndex = 0;
         _trailingStuff.test(param1);
         param1 = param1.substr(0,_trailingStuff.lastIndex-1);
         return param1;
      }
      
      override public function get customXMLStringHandler() : Boolean {
         return true;
      }
      
      override public function toXMLString(param1:Object) : String {
         var _loc2_:String = null;
         if(param1.hasOwnProperty("counter"))
         {
            return param1.ordered == null?"counter(ordered)":"counter(ordered," + param1.ordered + ")";
         }
         if(param1.hasOwnProperty("counters"))
         {
            _loc2_ = "counters(ordered";
            if(param1.suffix != null)
            {
               _loc2_ = _loc2_ + (",\"" + param1.suffix + "\"");
               if(param1.ordered)
               {
                  _loc2_ = _loc2_ + ("," + param1.ordered);
               }
            }
            _loc2_ = _loc2_ + ")";
            return _loc2_;
         }
         return param1.toString();
      }
      
      override public function owningHandlerCheck(param1:*) : * {
         var _loc2_:String = null;
         if(!(param1 is String))
         {
            return (param1.hasOwnProperty("counter")) || (param1.hasOwnProperty("counters"))?param1:undefined;
         }
         if(_counterContentPattern1.test(param1))
         {
            return param1;
         }
         if(_counterContentPattern2.test(param1))
         {
            _loc2_ = extractListStyleTypeFromCounter(param1);
            return ListElement.listSuffixes[_loc2_] !== undefined?param1:undefined;
         }
         if(_countersContentPattern1.test(param1))
         {
            return param1;
         }
         if(_countersContentPattern2.test(param1))
         {
            return param1;
         }
         if(_countersContentPattern3.test(param1))
         {
            _loc2_ = extractListStyleTypeFromCounters(param1);
            return ListElement.listSuffixes[_loc2_] !== undefined?param1:undefined;
         }
         return undefined;
      }
      
      override public function setHelper(param1:*) : * {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = param1 as String;
         if(_loc2_ == null)
         {
            return param1;
         }
         if(_counterContentPattern1.test(param1))
         {
            return {"counter":"ordered"};
         }
         if(_counterContentPattern2.test(param1))
         {
            _loc3_ = extractListStyleTypeFromCounter(param1);
            return 
               {
                  "counter":"ordered",
                  "ordered":_loc3_
               };
         }
         if(_countersContentPattern1.test(param1))
         {
            return {"counters":"ordered"};
         }
         if(_countersContentPattern2.test(param1))
         {
            _loc4_ = extractSuffixFromCounters2(param1);
            return 
               {
                  "counters":"ordered",
                  "suffix":_loc4_
               };
         }
         if(_countersContentPattern3.test(param1))
         {
            _loc3_ = extractListStyleTypeFromCounters(param1);
            _loc4_ = extractSuffixFromCounters3(param1);
            return 
               {
                  "counters":"ordered",
                  "suffix":_loc4_,
                  "ordered":_loc3_
               };
         }
         return undefined;
      }
   }
}

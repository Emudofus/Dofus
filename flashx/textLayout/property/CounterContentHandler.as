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

      tlf_internal  static function extractListStyleTypeFromCounter(s:String) : String {
         _counterBeginPattern.lastIndex=0;
         _counterBeginPattern.test(s);
         var s:String = s.substr(_counterBeginPattern.lastIndex);
         _trailingStuff.lastIndex=0;
         _trailingStuff.test(s);
         s=s.substr(0,_trailingStuff.lastIndex-1);
         return s;
      }

      private static const _countersTillSuffixPattern:RegExp = new RegExp("^\\s*counters\\s*\\(\\s*ordered\\s*,\\s*\"","g");

      private static const _afterSuffixPattern2:RegExp = new RegExp("^\"\\s*\\)\\s*$");

      tlf_internal  static function extractSuffixFromCounters2(s:String) : String {
         _countersTillSuffixPattern.lastIndex=0;
         _countersTillSuffixPattern.test(s);
         var s:String = s.substr(_countersTillSuffixPattern.lastIndex);
         var rslt:String = "";
         while(!_afterSuffixPattern2.test(s))
         {
            rslt=rslt+s.substr(0,1);
            s=s.substr(1);
         }
         return rslt;
      }

      private static const _afterSuffixPattern3:RegExp = new RegExp("^\"\\s*,\\s*\\S+\\s*\\)\\s*$");

      tlf_internal  static function extractSuffixFromCounters3(s:String) : String {
         _countersTillSuffixPattern.lastIndex=0;
         _countersTillSuffixPattern.test(s);
         var s:String = s.substr(_countersTillSuffixPattern.lastIndex);
         var rslt:String = "";
         while(!_afterSuffixPattern3.test(s))
         {
            rslt=rslt+s.substr(0,1);
            s=s.substr(1);
         }
         return rslt;
      }

      private static const _countersTillListStyleTypePattern:RegExp = new RegExp("^\\s*counters\\s*\\(\\s*ordered\\s*,\\s*\".*\"\\s*,\\s*","g");

      tlf_internal  static function extractListStyleTypeFromCounters(s:String) : String {
         _countersTillListStyleTypePattern.lastIndex=0;
         _countersTillListStyleTypePattern.test(s);
         var s:String = s.substr(_countersTillListStyleTypePattern.lastIndex);
         _trailingStuff.lastIndex=0;
         _trailingStuff.test(s);
         s=s.substr(0,_trailingStuff.lastIndex-1);
         return s;
      }

      override public function get customXMLStringHandler() : Boolean {
         return true;
      }

      override public function toXMLString(val:Object) : String {
         var rslt:String = null;
         if(val.hasOwnProperty("counter"))
         {
            return val.ordered==null?"counter(ordered)":"counter(ordered,"+val.ordered+")";
         }
         if(val.hasOwnProperty("counters"))
         {
            rslt="counters(ordered";
            if(val.suffix!=null)
            {
               rslt=rslt+(",\""+val.suffix+"\"");
               if(val.ordered)
               {
                  rslt=rslt+(","+val.ordered);
               }
            }
            rslt=rslt+")";
            return rslt;
         }
         return val.toString();
      }

      override public function owningHandlerCheck(newVal:*) : * {
         var listStyleType:String = null;
         if(!(newVal is String))
         {
            return (newVal.hasOwnProperty("counter"))||(newVal.hasOwnProperty("counters"))?newVal:undefined;
         }
         if(_counterContentPattern1.test(newVal))
         {
            return newVal;
         }
         if(_counterContentPattern2.test(newVal))
         {
            listStyleType=extractListStyleTypeFromCounter(newVal);
            return !(ListElement.listSuffixes[listStyleType]===undefined)?newVal:undefined;
         }
         if(_countersContentPattern1.test(newVal))
         {
            return newVal;
         }
         if(_countersContentPattern2.test(newVal))
         {
            return newVal;
         }
         if(_countersContentPattern3.test(newVal))
         {
            listStyleType=extractListStyleTypeFromCounters(newVal);
            return !(ListElement.listSuffixes[listStyleType]===undefined)?newVal:undefined;
         }
         return undefined;
      }

      override public function setHelper(newVal:*) : * {
         var listStyleType:String = null;
         var suffix:String = null;
         var s:String = newVal as String;
         if(s==null)
         {
            return newVal;
         }
         if(_counterContentPattern1.test(newVal))
         {
            return {counter:"ordered"};
         }
         if(_counterContentPattern2.test(newVal))
         {
            listStyleType=extractListStyleTypeFromCounter(newVal);
            return 
               {
                  counter:"ordered",
                  ordered:listStyleType
               }
            ;
         }
         if(_countersContentPattern1.test(newVal))
         {
            return {counters:"ordered"};
         }
         if(_countersContentPattern2.test(newVal))
         {
            suffix=extractSuffixFromCounters2(newVal);
            return 
               {
                  counters:"ordered",
                  suffix:suffix
               }
            ;
         }
         if(_countersContentPattern3.test(newVal))
         {
            listStyleType=extractListStyleTypeFromCounters(newVal);
            suffix=extractSuffixFromCounters3(newVal);
            return 
               {
                  counters:"ordered",
                  suffix:suffix,
                  ordered:listStyleType
               }
            ;
         }
         return undefined;
      }
   }

}
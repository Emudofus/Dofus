package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   import __AS3__.vec.Vector;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.formats.IListMarkerFormat;
   import flashx.textLayout.formats.ListStyleType;
   import flashx.textLayout.formats.Suffix;
   
   use namespace tlf_internal;
   
   public class ListElement extends ContainerFormattedElement
   {
      
      public function ListElement() {
         super();
      }
      
      tlf_internal  static const LIST_MARKER_FORMAT_NAME:String = "listMarkerFormat";
      
      tlf_internal  static const constantListStyles:Object = 
         {
            "none":"",
            "disc":"•",
            "circle":"◦",
            "square":"■",
            "box":"□",
            "check":"✓",
            "diamond":"◆",
            "hyphen":"⁃"
         };
      
      private static const romanDigitFunction:Vector.<Function> = Vector.<Function>([function(param1:String, param2:String, param3:String):String
      {
         return "";
      },function(param1:String, param2:String, param3:String):String
      {
         return param1;
      },function(param1:String, param2:String, param3:String):String
      {
         return param1 + param1;
      },function(param1:String, param2:String, param3:String):String
      {
         return param1 + param1 + param1;
      },function(param1:String, param2:String, param3:String):String
      {
         return param1 + param2;
      },function(param1:String, param2:String, param3:String):String
      {
         return param2;
      },function(param1:String, param2:String, param3:String):String
      {
         return param2 + param1;
      },function(param1:String, param2:String, param3:String):String
      {
         return param2 + param1 + param1;
      },function(param1:String, param2:String, param3:String):String
      {
         return param2 + param1 + param1 + param1;
      },function(param1:String, param2:String, param3:String):String
      {
         return param1 + param3;
      }]);
      
      tlf_internal  static function createRomanString(param1:int, param2:Vector.<String>) : String {
         var _loc3_:* = "";
         while(param1 >= 1000)
         {
            _loc3_ = _loc3_ + param2[6];
            param1 = param1 - 1000;
         }
         return _loc3_ + romanDigitFunction[int(param1 / 100)](param2[4],param2[5],param2[6]) + romanDigitFunction[int(param1 / 10 % 10)](param2[2],param2[3],param2[4]) + romanDigitFunction[int(param1 % 10)](param2[0],param2[1],param2[2]);
      }
      
      private static const upperRomanData:Vector.<String> = Vector.<String>(["I","V","X","L","C","D","M"]);
      
      tlf_internal  static function upperRomanString(param1:int) : String {
         if(param1 <= 0)
         {
            return decimalString(param1);
         }
         if(param1 <= 1000)
         {
            return createRomanString(param1,upperRomanData);
         }
         if(param1 >= 40000)
         {
            return decimalString(param1);
         }
         var _loc2_:String = createRomanString(param1 % 1000,upperRomanData);
         var _loc3_:* = "";
         var param1:int = param1 - param1 % 1000;
         while(param1 >= 10000)
         {
            _loc3_ = _loc3_ + String.fromCharCode(8578);
            param1 = param1 - 10000;
         }
         if(param1 == 9000)
         {
            _loc3_ = _loc3_ + ("M" + String.fromCharCode(8578));
         }
         else
         {
            if(param1 == 4000)
            {
               _loc3_ = _loc3_ + ("M" + String.fromCharCode(8577));
            }
            else
            {
               if(param1 >= 5000)
               {
                  _loc3_ = _loc3_ + String.fromCharCode(8577);
                  param1 = param1 - 5000;
               }
               while(param1 > 0)
               {
                  _loc3_ = _loc3_ + "M";
                  param1 = param1 - 1000;
               }
            }
         }
         return _loc3_ + _loc2_;
      }
      
      private static const lowerRomanData:Vector.<String> = Vector.<String>(["i","v","x","l","c","d","m"]);
      
      tlf_internal  static function lowerRomanString(param1:int) : String {
         return param1 > 0 && param1 < 4000?createRomanString(param1,lowerRomanData):decimalString(param1);
      }
      
      tlf_internal  static function decimalString(param1:int) : String {
         return param1.toString();
      }
      
      tlf_internal  static function decimalLeadingZeroString(param1:int) : String {
         return param1 <= 9 && param1 >= -9?"0" + param1.toString():param1.toString();
      }
      
      tlf_internal  static function createNumericBaseTenString(param1:int, param2:int) : String {
         if(param1 == 0)
         {
            return String.fromCharCode(param2);
         }
         var _loc3_:* = "";
         while(param1 > 0)
         {
            _loc3_ = String.fromCharCode(param1 % 10 + param2) + _loc3_;
            param1 = param1 / 10;
         }
         return _loc3_;
      }
      
      tlf_internal  static function arabicIndicString(param1:int) : String {
         return createNumericBaseTenString(param1,1632);
      }
      
      tlf_internal  static function bengaliString(param1:int) : String {
         return createNumericBaseTenString(param1,2534);
      }
      
      tlf_internal  static function devanagariString(param1:int) : String {
         return createNumericBaseTenString(param1,2406);
      }
      
      tlf_internal  static function gujaratiString(param1:int) : String {
         return createNumericBaseTenString(param1,2790);
      }
      
      tlf_internal  static function gurmukhiString(param1:int) : String {
         return createNumericBaseTenString(param1,2662);
      }
      
      tlf_internal  static function kannadaString(param1:int) : String {
         return createNumericBaseTenString(param1,3302);
      }
      
      tlf_internal  static function persianString(param1:int) : String {
         return createNumericBaseTenString(param1,1776);
      }
      
      tlf_internal  static function thaiString(param1:int) : String {
         return createNumericBaseTenString(param1,3664);
      }
      
      tlf_internal  static function urduString(param1:int) : String {
         return createNumericBaseTenString(param1,1776);
      }
      
      tlf_internal  static function createContinuousAlphaString(param1:int, param2:int, param3:int) : String {
         var _loc4_:* = "";
         while(param1 > 0)
         {
            _loc4_ = String.fromCharCode((param1-1) % param3 + param2) + _loc4_;
            param1 = (param1-1) / param3;
         }
         return _loc4_;
      }
      
      tlf_internal  static function lowerAlphaString(param1:int) : String {
         return createContinuousAlphaString(param1,97,26);
      }
      
      tlf_internal  static function upperAlphaString(param1:int) : String {
         return createContinuousAlphaString(param1,65,26);
      }
      
      tlf_internal  static function lowerLatinString(param1:int) : String {
         return createContinuousAlphaString(param1,97,26);
      }
      
      tlf_internal  static function upperLatinString(param1:int) : String {
         return createContinuousAlphaString(param1,65,26);
      }
      
      tlf_internal  static function createTableAlphaString(param1:int, param2:Vector.<int>) : String {
         var _loc3_:* = "";
         var _loc4_:int = param2.length;
         while(param1 > 0)
         {
            _loc3_ = String.fromCharCode(param2[(param1-1) % _loc4_]) + _loc3_;
            param1 = (param1-1) / _loc4_;
         }
         return _loc3_;
      }
      
      tlf_internal  static const cjkEarthlyBranchData:Vector.<int> = Vector.<int>([23376,19985,23493,21359,36784,24051,21320,26410,30003,37193,25100,20133]);
      
      tlf_internal  static function cjkEarthlyBranchString(param1:int) : String {
         return createTableAlphaString(param1,cjkEarthlyBranchData);
      }
      
      tlf_internal  static const cjkHeavenlyStemData:Vector.<int> = Vector.<int>([30002,20057,19993,19969,25098,24049,24218,36763,22764,30328]);
      
      tlf_internal  static function cjkHeavenlyStemString(param1:int) : String {
         return createTableAlphaString(param1,cjkHeavenlyStemData);
      }
      
      tlf_internal  static const hangulData:Vector.<int> = Vector.<int>([44032,45208,45796,46972,47560,48148,49324,50500,51088,52264,52852,53440,54028,54616]);
      
      tlf_internal  static function hangulString(param1:int) : String {
         return createTableAlphaString(param1,hangulData);
      }
      
      tlf_internal  static const hangulConstantData:Vector.<int> = Vector.<int>([12593,12596,12599,12601,12609,12610,12613,12615,12616,12618,12619,12620,12621,12622]);
      
      tlf_internal  static function hangulConstantString(param1:int) : String {
         return createTableAlphaString(param1,hangulConstantData);
      }
      
      tlf_internal  static const hiraganaData:Vector.<int> = Vector.<int>([12354,12356,12358,12360,12362,12363,12365,12367,12369,12371,12373,12375,12377,12379,12381,12383,12385,12388,12390,12392,12394,12395,12396,12397,12398,12399,12402,12405,12408,12411,12414,12415,12416,12417,12418,12420,12422,12424,12425,12426,12427,12428,12429,12431,12432,12433,12434,12435]);
      
      tlf_internal  static function hiraganaString(param1:int) : String {
         return createTableAlphaString(param1,hiraganaData);
      }
      
      tlf_internal  static const hiraganaIrohaData:Vector.<int> = Vector.<int>([12356,12429,12399,12395,12411,12408,12392,12385,12426,12396,12427,12434,12431,12363,12424,12383,12428,12381,12388,12397,12394,12425,12416,12358,12432,12398,12362,12367,12420,12414,12369,12405,12371,12360,12390,12354,12373,12365,12422,12417,12415,12375,12433,12402,12418,12379,12377]);
      
      tlf_internal  static function hiraganaIrohaString(param1:int) : String {
         return createTableAlphaString(param1,hiraganaIrohaData);
      }
      
      tlf_internal  static const katakanaData:Vector.<int> = Vector.<int>([12450,12452,12454,12456,12458,12459,12461,12463,12465,12467,12469,12471,12473,12475,12477,12479,12481,12484,12486,12488,12490,12491,12492,12493,12494,12495,12498,12501,12504,12507,12510,12511,12512,12513,12514,12516,12518,12520,12521,12522,12523,12524,12525,12527,12528,12529,12530,12531]);
      
      tlf_internal  static function katakanaString(param1:int) : String {
         return createTableAlphaString(param1,katakanaData);
      }
      
      tlf_internal  static const katakanaIrohaData:Vector.<int> = Vector.<int>([12452,12525,12495,12491,12507,12504,12488,12481,12522,12492,12523,12530,12527,12459,12520,12479,12524,12477,12484,12493,12490,12521,12512,12454,12528,12494,12458,12463,12516,12510,12465,12501,12467,12456,12486,12450,12469,12461,12518,12513,12511,12471,12529,12498,12514,12475,12473]);
      
      tlf_internal  static function katakanaIrohaString(param1:int) : String {
         return createTableAlphaString(param1,katakanaIrohaData);
      }
      
      tlf_internal  static const lowerGreekData:Vector.<int> = Vector.<int>([945,946,947,948,949,950,951,952,953,954,955,956,957,958,959,960,961,963,964,965,966,967,968,969]);
      
      tlf_internal  static function lowerGreekString(param1:int) : String {
         return createTableAlphaString(param1,lowerGreekData);
      }
      
      tlf_internal  static const upperGreekData:Vector.<int> = Vector.<int>([913,914,915,916,917,918,919,920,921,922,923,924,925,926,927,928,929,931,932,933,934,935,936,937]);
      
      tlf_internal  static function upperGreekString(param1:int) : String {
         return createTableAlphaString(param1,upperGreekData);
      }
      
      tlf_internal  static const algorithmicListStyles:Object = 
         {
            "upperRoman":upperRomanString,
            "lowerRoman":lowerRomanString
         };
      
      tlf_internal  static const numericListStyles:Object = 
         {
            "arabicIndic":arabicIndicString,
            "bengali":bengaliString,
            "decimal":decimalString,
            "decimalLeadingZero":decimalLeadingZeroString,
            "devanagari":devanagariString,
            "gujarati":gujaratiString,
            "gurmukhi":gurmukhiString,
            "kannada":kannadaString,
            "persian":persianString,
            "thai":thaiString,
            "urdu":urduString
         };
      
      tlf_internal  static const alphabeticListStyles:Object = 
         {
            "upperAlpha":upperAlphaString,
            "lowerAlpha":lowerAlphaString,
            "cjkEarthlyBranch":cjkEarthlyBranchString,
            "cjkHeavenlyStem":cjkHeavenlyStemString,
            "hangul":hangulString,
            "hangulConstant":hangulConstantString,
            "hiragana":hiraganaString,
            "hiraganaIroha":hiraganaIrohaString,
            "katakana":katakanaString,
            "katakanaIroha":katakanaIrohaString,
            "lowerGreek":lowerGreekString,
            "lowerLatin":lowerLatinString,
            "upperGreek":upperGreekString,
            "upperLatin":upperLatinString
         };
      
      tlf_internal  static const listSuffixes:Object = 
         {
            "upperAlpha":".",
            "lowerAlpha":".",
            "upperRoman":".",
            "lowerRoman":".",
            "arabicIndic":".",
            "bengali":".",
            "decimal":".",
            "decimalLeadingZero":".",
            "devanagari":".",
            "gujarati":".",
            "gurmukhi":".",
            "kannada":".",
            "persian":".",
            "thai":".",
            "urdu":".",
            "cjkEarthlyBranch":".",
            "cjkHeavenlyStem":".",
            "hangul":".",
            "hangulConstant":".",
            "hiragana":".",
            "hiraganaIroha":".",
            "katakana":".",
            "katakanaIroha":".",
            "lowerGreek":".",
            "lowerLatin":".",
            "upperGreek":".",
            "upperLatin":"."
         };
      
      override protected function get abstract() : Boolean {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String {
         return "list";
      }
      
      override tlf_internal function canOwnFlowElement(param1:FlowElement) : Boolean {
         return !(param1 is TextFlow) && !(param1 is FlowLeafElement) && !(param1 is SubParagraphGroupElementBase);
      }
      
      override tlf_internal function modelChanged(param1:String, param2:FlowElement, param3:int, param4:int, param5:Boolean=true, param6:Boolean=true) : void {
         if((param1 == ModelChange.ELEMENT_ADDED || param1 == ModelChange.ELEMENT_REMOVAL) && param2 is ListItemElement && (this.isNumberedList()))
         {
            param3 = param2.parentRelativeStart;
            param4 = textLength - param2.parentRelativeStart;
         }
         super.modelChanged(param1,param2,param3,param4,param5,param6);
      }
      
      override tlf_internal function getEffectivePaddingLeft() : Number {
         if(computedFormat.paddingLeft != FormatValue.AUTO)
         {
            return computedFormat.paddingLeft;
         }
         var _loc1_:TextFlow = getTextFlow();
         if(!_loc1_ || !(_loc1_.computedFormat.blockProgression == BlockProgression.TB) || !(computedFormat.direction == Direction.LTR))
         {
            return 0;
         }
         return computedFormat.listAutoPadding;
      }
      
      override tlf_internal function getEffectivePaddingRight() : Number {
         if(computedFormat.paddingRight != FormatValue.AUTO)
         {
            return computedFormat.paddingRight;
         }
         var _loc1_:TextFlow = getTextFlow();
         if(!_loc1_ || !(_loc1_.computedFormat.blockProgression == BlockProgression.TB) || !(computedFormat.direction == Direction.RTL))
         {
            return 0;
         }
         return computedFormat.listAutoPadding;
      }
      
      override tlf_internal function getEffectivePaddingTop() : Number {
         if(computedFormat.paddingTop != FormatValue.AUTO)
         {
            return computedFormat.paddingTop;
         }
         var _loc1_:TextFlow = getTextFlow();
         if(!_loc1_ || !(_loc1_.computedFormat.blockProgression == BlockProgression.RL) || !(computedFormat.direction == Direction.LTR))
         {
            return 0;
         }
         return computedFormat.listAutoPadding;
      }
      
      override tlf_internal function getEffectivePaddingBottom() : Number {
         if(computedFormat.paddingBottom != FormatValue.AUTO)
         {
            return computedFormat.paddingBottom;
         }
         var _loc1_:TextFlow = getTextFlow();
         if(!_loc1_ || !(_loc1_.computedFormat.blockProgression == BlockProgression.RL) || !(computedFormat.direction == Direction.RTL))
         {
            return 0;
         }
         return computedFormat.listAutoPadding;
      }
      
      tlf_internal function computeListItemText(param1:ListItemElement, param2:IListMarkerFormat) : String {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc7_:String = null;
         var _loc8_:ListElement = null;
         var _loc9_:IListMarkerFormat = null;
         if((param2.content) && (param2.content.hasOwnProperty("counters")))
         {
            _loc4_ = "";
            _loc3_ = param2.content.ordered;
            _loc7_ = param2.content.suffix;
            _loc8_ = this;
            _loc9_ = param2;
            while(true)
            {
               _loc4_ = _loc8_.computeListItemTextSpecified(param1,_loc9_,_loc3_ == null?_loc8_.computedFormat.listStyleType:_loc3_,_loc7_) + _loc4_;
               param1 = _loc8_.getParentByType(ListItemElement) as ListItemElement;
               if(!param1)
               {
                  break;
               }
               _loc8_ = param1.parent as ListElement;
               _loc9_ = param1.computedListMarkerFormat();
            }
         }
         else
         {
            if(param2.content !== undefined)
            {
               if(param2.content == FormatValue.NONE)
               {
                  _loc3_ = ListStyleType.NONE;
               }
               else
               {
                  _loc3_ = param2.content.ordered;
               }
            }
            if(_loc3_ == null)
            {
               _loc3_ = computedFormat.listStyleType;
            }
            _loc4_ = this.computeListItemTextSpecified(param1,param2,_loc3_,null);
         }
         var _loc5_:String = param2.beforeContent?param2.beforeContent:"";
         var _loc6_:String = param2.afterContent?param2.afterContent:"";
         return _loc5_ + _loc4_ + _loc6_;
      }
      
      tlf_internal function computeListItemTextSpecified(param1:ListItemElement, param2:IListMarkerFormat, param3:String, param4:String) : String {
         var _loc5_:String = null;
         var _loc7_:* = 0;
         var _loc8_:Function = null;
         var _loc6_:* = constantListStyles[param3];
         if(_loc6_ !== undefined)
         {
            _loc5_ = _loc6_ as String;
         }
         else
         {
            _loc7_ = param1.getListItemNumber(param2);
            _loc8_ = numericListStyles[param3];
            if(_loc8_ != null)
            {
               _loc5_ = _loc7_ < 0?"-" + _loc8_(-_loc7_):_loc8_(_loc7_);
            }
            else
            {
               if(_loc7_ <= 0)
               {
                  _loc5_ = _loc7_ == 0?"0":"-" + decimalString(-_loc7_);
               }
               else
               {
                  _loc8_ = alphabeticListStyles[param3];
                  if(_loc8_ != null)
                  {
                     _loc5_ = _loc8_(_loc7_);
                  }
                  else
                  {
                     _loc5_ = algorithmicListStyles[param3](_loc7_);
                  }
               }
            }
            if(param4 != null)
            {
               _loc5_ = _loc5_ + param4;
            }
            else
            {
               if(param2.suffix != Suffix.NONE)
               {
                  _loc5_ = _loc5_ + listSuffixes[param3];
               }
            }
         }
         return _loc5_;
      }
      
      tlf_internal function isNumberedList() : Boolean {
         return constantListStyles[computedFormat.listStyleType] === undefined;
      }
   }
}

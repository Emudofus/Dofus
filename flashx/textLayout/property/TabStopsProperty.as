package flashx.textLayout.property
{
   import flashx.textLayout.formats.TabStopFormat;
   import flashx.textLayout.formats.FormatValue;
   import flash.text.engine.TabAlignment;
   import __AS3__.vec.Vector;
   
   public class TabStopsProperty extends ArrayProperty
   {
      
      public function TabStopsProperty(param1:String, param2:Array, param3:Boolean, param4:Vector.<String>) {
         super(param1,param2,param3,param4,TabStopFormat);
      }
      
      private static function compareTabStopFormats(param1:TabStopFormat, param2:TabStopFormat) : Number {
         return param1.position == param2.position?0:param1.position < param2.position?-1:1;
      }
      
      private static const _tabStopRegex:RegExp = new RegExp("([sScCeEdD]?)([^| ]+)(|[^ ]*)?( |$)","g");
      
      private static const _escapeBackslashRegex:RegExp = new RegExp("\\\\\\\\","g");
      
      private static const _escapeSpaceRegex:RegExp = new RegExp("\\\\ ","g");
      
      private static const _backslashRegex:RegExp = new RegExp("\\\\","g");
      
      private static const _spaceRegex:RegExp = new RegExp(" ","g");
      
      private static const _backslashPlaceholderRegex:RegExp = new RegExp("","g");
      
      private static const _spacePlaceholderRegex:RegExp = new RegExp("","g");
      
      private static const _backslashPlaceHolder:String = String.fromCharCode(57344);
      
      private static const _spacePlaceHolder:String = String.fromCharCode(57345);
      
      override public function setHelper(param1:*, param2:*) : * {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:TabStopFormat = null;
         var _loc7_:* = NaN;
         if(param2 == null || param2 == FormatValue.INHERIT)
         {
            return param2;
         }
         var _loc3_:Array = param2 as Array;
         if(_loc3_)
         {
            if(!checkArrayTypes(_loc3_))
            {
               Property.errorHandler(this,param2);
               return param1;
            }
         }
         else
         {
            _loc4_ = param2 as String;
            if(!_loc4_)
            {
               Property.errorHandler(this,param2);
               return param1;
            }
            _loc3_ = new Array();
            _loc4_ = _loc4_.replace(_escapeBackslashRegex,_backslashPlaceHolder);
            _loc4_ = _loc4_.replace(_escapeSpaceRegex,_spacePlaceHolder);
            _tabStopRegex.lastIndex = 0;
            while(true)
            {
               _loc5_ = _tabStopRegex.exec(_loc4_);
               if(!_loc5_)
               {
                  break;
               }
               _loc6_ = new TabStopFormat();
               switch(_loc5_[1].toLowerCase())
               {
                  case "s":
                  case "":
                     _loc6_.alignment = TabAlignment.START;
                     break;
                  case "c":
                     _loc6_.alignment = TabAlignment.CENTER;
                     break;
                  case "e":
                     _loc6_.alignment = TabAlignment.END;
                     break;
                  case "d":
                     _loc6_.alignment = TabAlignment.DECIMAL;
                     break;
               }
               _loc7_ = Number(_loc5_[2]);
               if(isNaN(_loc7_))
               {
                  Property.errorHandler(this,param2);
                  return param1;
               }
               _loc6_.position = _loc7_;
               if(_loc6_.alignment == TabAlignment.DECIMAL)
               {
                  if(_loc5_[3] == "")
                  {
                     _loc6_.decimalAlignmentToken = ".";
                  }
                  else
                  {
                     _loc6_.decimalAlignmentToken = _loc5_[3].slice(1).replace(_backslashPlaceholderRegex,"\\");
                     _loc6_.decimalAlignmentToken = _loc6_.decimalAlignmentToken.replace(_spacePlaceholderRegex," ");
                  }
               }
               else
               {
                  if(_loc5_[3] != "")
                  {
                     Property.errorHandler(this,param2);
                     return param1;
                  }
               }
               _loc3_.push(_loc6_);
            }
         }
         return _loc3_.sort(compareTabStopFormats);
      }
      
      override public function toXMLString(param1:Object) : String {
         var _loc4_:TabStopFormat = null;
         var _loc5_:String = null;
         var _loc2_:* = "";
         var _loc3_:Array = param1 as Array;
         for each (_loc4_ in _loc3_)
         {
            if(_loc2_.length)
            {
               _loc2_ = _loc2_ + " ";
            }
            switch(_loc4_.alignment)
            {
               case TabAlignment.START:
                  _loc2_ = _loc2_ + "s";
                  break;
               case TabAlignment.CENTER:
                  _loc2_ = _loc2_ + "c";
                  break;
               case TabAlignment.END:
                  _loc2_ = _loc2_ + "e";
                  break;
               case TabAlignment.DECIMAL:
                  _loc2_ = _loc2_ + "d";
                  break;
            }
            _loc2_ = _loc2_ + _loc4_.position.toString();
            if(_loc4_.alignment == TabAlignment.DECIMAL)
            {
               _loc5_ = _loc4_.decimalAlignmentToken.replace(_backslashRegex,"\\\\");
               _loc5_ = _loc5_.replace(_spaceRegex,"\\ ");
               _loc2_ = _loc2_ + ("|" + _loc5_);
            }
         }
         return _loc2_;
      }
   }
}

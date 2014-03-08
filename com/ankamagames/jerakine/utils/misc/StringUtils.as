package com.ankamagames.jerakine.utils.misc
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.ByteArray;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class StringUtils extends Object
   {
      
      public function StringUtils() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StringUtils));
      
      public static function cleanString(param1:String) : String {
         var param1:String = param1.split("&").join("&amp;");
         param1 = param1.split("<").join("&lt;");
         param1 = param1.split(">").join("&gt;");
         return param1;
      }
      
      public static function convertLatinToUtf(param1:String) : String {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeMultiByte(decodeURI(param1),"iso-8859-1");
         _loc2_.position = 0;
         return _loc2_.readUTFBytes(_loc2_.length);
      }
      
      public static function fill(param1:String, param2:uint, param3:String, param4:Boolean=true) : String {
         if(!param3 || !param3.length)
         {
            return param1;
         }
         while(param1.length != param2)
         {
            if(param4)
            {
               param1 = param3 + param1;
            }
            else
            {
               param1 = param1 + param3;
            }
         }
         return param1;
      }
      
      public static function formatArray(param1:Array, param2:Array=null) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function replace(param1:String, param2:*=null, param3:*=null) : String {
         var _loc6_:uint = 0;
         if(!param2)
         {
            return param1;
         }
         if(!param3)
         {
            if(param2 is Array)
            {
               param3 = new Array(param2.length);
            }
            else
            {
               return param1.split(param2).join("");
            }
         }
         if(!(param2 is Array))
         {
            return param1.split(param2).join(param3);
         }
         var _loc4_:Number = param2.length;
         var _loc5_:String = param1;
         if(param3 is Array)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc5_ = _loc5_.split(param2[_loc6_]).join(param3[_loc6_]);
               _loc6_++;
            }
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc5_ = _loc5_.split(param2[_loc6_]).join(param3);
               _loc6_++;
            }
         }
         return _loc5_;
      }
      
      public static function concatSameString(param1:String, param2:String) : String {
         var _loc3_:int = param1.indexOf(param2);
         var _loc4_:* = 0;
         var _loc5_:int = _loc3_;
         while(_loc5_ != -1)
         {
            _loc4_ = _loc5_;
            _loc5_ = param1.indexOf(param2,_loc4_ + 1);
            if(_loc5_ == _loc3_)
            {
               break;
            }
            if(_loc5_ == _loc4_ + param2.length)
            {
               param1 = param1.substring(0,_loc5_) + param1.substring(_loc5_ + param2.length);
               _loc5_ = _loc5_ - param2.length;
            }
         }
         return param1;
      }
      
      public static function getDelimitedText(param1:String, param2:String, param3:String, param4:Boolean=false) : Vector.<String> {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc5_:Vector.<String> = new Vector.<String>();
         var _loc6_:* = false;
         var _loc7_:String = param1;
         while(!_loc6_)
         {
            _loc8_ = getSingleDelimitedText(_loc7_,param2,param3,param4);
            if(_loc8_ == "")
            {
               _loc6_ = true;
            }
            else
            {
               _loc5_.push(_loc8_);
               if(!param4)
               {
                  _loc8_ = param2 + _loc8_ + param3;
               }
               _loc9_ = _loc7_.slice(0,_loc7_.indexOf(_loc8_));
               _loc10_ = _loc7_.slice(_loc7_.indexOf(_loc8_) + _loc8_.length);
               _loc7_ = _loc9_ + _loc10_;
            }
         }
         return _loc5_;
      }
      
      public static function getAllIndexOf(param1:String, param2:String) : Array {
         var _loc7_:* = 0;
         var _loc3_:Array = new Array();
         var _loc4_:uint = 0;
         var _loc5_:* = false;
         var _loc6_:uint = 0;
         while(!_loc5_)
         {
            _loc7_ = param2.indexOf(param1,_loc6_);
            if(_loc7_ < _loc6_)
            {
               _loc5_ = true;
            }
            else
            {
               _loc3_.push(_loc7_);
               _loc6_ = _loc7_ + param1.length;
            }
         }
         return _loc3_;
      }
      
      private static var pattern:Vector.<RegExp>;
      
      private static var patternReplace:Vector.<String>;
      
      public static function noAccent(param1:String) : String {
         if(pattern == null || patternReplace == null)
         {
            initPattern();
         }
         return decomposeUnicode(param1);
      }
      
      private static function initPattern() : void {
         pattern = new Vector.<RegExp>(29);
         pattern[0] = new RegExp("Š","g");
         pattern[1] = new RegExp("Œ","g");
         pattern[2] = new RegExp("Ž","g");
         pattern[3] = new RegExp("š","g");
         pattern[4] = new RegExp("œ","g");
         pattern[5] = new RegExp("ž","g");
         pattern[6] = new RegExp("[ÀÁÂÃÄÅ]","g");
         pattern[7] = new RegExp("Æ","g");
         pattern[8] = new RegExp("Ç","g");
         pattern[9] = new RegExp("[ÈÉÊË]","g");
         pattern[10] = new RegExp("[ÌÍÎÏ]","g");
         pattern[11] = new RegExp("Ð","g");
         pattern[12] = new RegExp("Ñ","g");
         pattern[13] = new RegExp("[ÒÓÔÕÖØ]","g");
         pattern[14] = new RegExp("[ÙÚÛÜ]","g");
         pattern[15] = new RegExp("[ŸÝ]","g");
         pattern[16] = new RegExp("Þ","g");
         pattern[17] = new RegExp("ß","g");
         pattern[18] = new RegExp("[àáâãäå]","g");
         pattern[19] = new RegExp("æ","g");
         pattern[20] = new RegExp("ç","g");
         pattern[21] = new RegExp("[èéêë]","g");
         pattern[22] = new RegExp("[ìíîï]","g");
         pattern[23] = new RegExp("ð","g");
         pattern[24] = new RegExp("ñ","g");
         pattern[25] = new RegExp("[òóôõöø]","g");
         pattern[26] = new RegExp("[ùúûü]","g");
         pattern[27] = new RegExp("[ýÿ]","g");
         pattern[28] = new RegExp("þ","g");
         patternReplace = new Vector.<String>(29);
         patternReplace[0] = "S";
         patternReplace[1] = "Oe";
         patternReplace[2] = "Z";
         patternReplace[3] = "s";
         patternReplace[4] = "oe";
         patternReplace[5] = "z";
         patternReplace[6] = "A";
         patternReplace[7] = "Ae";
         patternReplace[8] = "C";
         patternReplace[9] = "E";
         patternReplace[10] = "I";
         patternReplace[11] = "D";
         patternReplace[12] = "N";
         patternReplace[13] = "O";
         patternReplace[14] = "U";
         patternReplace[15] = "Y";
         patternReplace[16] = "Th";
         patternReplace[17] = "ss";
         patternReplace[18] = "a";
         patternReplace[19] = "ae";
         patternReplace[20] = "c";
         patternReplace[21] = "e";
         patternReplace[22] = "i";
         patternReplace[23] = "d";
         patternReplace[24] = "n";
         patternReplace[25] = "o";
         patternReplace[26] = "u";
         patternReplace[27] = "y";
         patternReplace[28] = "th";
      }
      
      private static var accents:String = "ŠŒŽšœžÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜŸÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýÿþ";
      
      private static function decomposeUnicode(param1:String) : String {
         var _loc2_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:int = param1.length > accents.length?accents.length:param1.length;
         var _loc4_:String = _loc3_ == accents.length?param1:accents;
         var _loc5_:String = _loc3_ == accents.length?accents:param1;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc4_.indexOf(_loc5_.charAt(_loc2_)) != -1)
            {
               _loc6_ = 0;
               while(_loc6_ < pattern.length)
               {
                  param1 = param1.replace(pattern[_loc6_],patternReplace[_loc6_]);
                  _loc6_++;
               }
               return param1;
            }
            _loc2_++;
         }
         return param1;
      }
      
      private static function getSingleDelimitedText(param1:String, param2:String, param3:String, param4:Boolean=false) : String {
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc5_:* = "";
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:* = false;
         _loc7_ = param1.indexOf(param2,_loc6_);
         if(_loc7_ == -1)
         {
            return "";
         }
         _loc6_ = _loc7_ + param2.length;
         while(!_loc11_)
         {
            _loc8_ = param1.indexOf(param2,_loc6_);
            _loc9_ = param1.indexOf(param3,_loc6_);
            if(_loc9_ == -1)
            {
               trace("Erreur ! On n\'a pas trouvé d\'occurence du second délimiteur.");
               _loc11_ = true;
            }
            if(_loc8_ < _loc9_ && !(_loc8_ == -1))
            {
               _loc10_ = _loc10_ + getAllIndexOf(param2,param1.slice(_loc8_ + param2.length,_loc9_)).length;
               _loc6_ = _loc9_ + param2.length;
            }
            else
            {
               if(_loc10_ > 1)
               {
                  _loc6_ = _loc9_ + param3.length;
                  _loc10_--;
               }
               else
               {
                  _loc5_ = param1.slice(_loc7_,_loc9_ + param3.length);
                  _loc11_ = true;
               }
            }
         }
         if(!param4 && !(_loc5_ == ""))
         {
            _loc5_ = _loc5_.slice(param2.length);
            _loc5_ = _loc5_.slice(0,_loc5_.length - param3.length);
         }
         return _loc5_;
      }
      
      public static function kamasToString(param1:Number, param2:String="-") : String {
         if(param2 == "-")
         {
            param2 = I18n.getUiText("ui.common.short.kama",[]);
         }
         var _loc3_:String = formateIntToString(param1);
         if(param2 == "")
         {
            return _loc3_;
         }
         return _loc3_ + " " + param2;
      }
      
      public static function stringToKamas(param1:String, param2:String="-") : int {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function formateIntToString(param1:Number) : String {
         var _loc6_:* = 0;
         var _loc2_:* = "";
         var _loc3_:Number = 1000;
         var _loc4_:String = I18n.getUiText("ui.common.numberSeparator");
         while(param1 / _loc3_ >= 1)
         {
            _loc6_ = int(param1 % _loc3_ / (_loc3_ / 1000));
            if(_loc6_ < 10)
            {
               _loc2_ = "00" + _loc6_ + _loc4_ + _loc2_;
            }
            else
            {
               if(_loc6_ < 100)
               {
                  _loc2_ = "0" + _loc6_ + _loc4_ + _loc2_;
               }
               else
               {
                  _loc2_ = _loc6_ + _loc4_ + _loc2_;
               }
            }
            _loc3_ = _loc3_ * 1000;
         }
         _loc2_ = int(param1 % _loc3_ / (_loc3_ / 1000)) + _loc4_ + _loc2_;
         var _loc5_:* = _loc2_.charAt(_loc2_.length-1);
         if(_loc2_.charAt(_loc2_.length-1) == _loc4_)
         {
            return _loc2_.substr(0,_loc2_.length-1);
         }
         return _loc2_;
      }
   }
}

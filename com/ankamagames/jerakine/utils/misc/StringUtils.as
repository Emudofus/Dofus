package com.ankamagames.jerakine.utils.misc
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class StringUtils extends Object
   {
      
      public function StringUtils() {
         super();
      }
      
      protected static const _log:Logger;
      
      public static function cleanString(s:String) : String {
         var s:String = s.split("&").join("&amp;");
         s = s.split("<").join("&lt;");
         s = s.split(">").join("&gt;");
         return s;
      }
      
      public static function convertLatinToUtf(str:String) : String {
         var b:ByteArray = new ByteArray();
         b.writeMultiByte(decodeURI(str),"iso-8859-1");
         b.position = 0;
         return b.readUTFBytes(b.length);
      }
      
      public static function fill(str:String, len:uint, char:String, before:Boolean = true) : String {
         if((!char) || (!char.length))
         {
            return str;
         }
         while(str.length != len)
         {
            if(before)
            {
               str = char + str;
            }
            else
            {
               str = str + char;
            }
         }
         return str;
      }
      
      public static function formatArray(data:Array, header:Array = null) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function replace(src:String, pFrom:* = null, pTo:* = null) : String {
         var i:uint = 0;
         if(!pFrom)
         {
            return src;
         }
         if(!pTo)
         {
            if(pFrom is Array)
            {
               pTo = new Array(pFrom.length);
            }
            else
            {
               return src.split(pFrom).join("");
            }
         }
         if(!(pFrom is Array))
         {
            return src.split(pFrom).join(pTo);
         }
         var lLength:Number = pFrom.length;
         var lString:String = src;
         if(pTo is Array)
         {
            i = 0;
            while(i < lLength)
            {
               lString = lString.split(pFrom[i]).join(pTo[i]);
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < lLength)
            {
               lString = lString.split(pFrom[i]).join(pTo);
               i++;
            }
         }
         return lString;
      }
      
      public static function concatSameString(pString:String, pStringToConcat:String) : String {
         var firstIndex:int = pString.indexOf(pStringToConcat);
         var previousIndex:int = 0;
         var currentIndex:int = firstIndex;
         while(currentIndex != -1)
         {
            previousIndex = currentIndex;
            currentIndex = pString.indexOf(pStringToConcat,previousIndex + 1);
            if(currentIndex == firstIndex)
            {
               break;
            }
            if(currentIndex == previousIndex + pStringToConcat.length)
            {
               pString = pString.substring(0,currentIndex) + pString.substring(currentIndex + pStringToConcat.length);
               currentIndex = currentIndex - pStringToConcat.length;
            }
         }
         return pString;
      }
      
      public static function getDelimitedText(pText:String, pFirstDelimiter:String, pSecondDelimiter:String, pIncludeDelimiter:Boolean = false) : Vector.<String> {
         var delimitedText:String = null;
         var firstPart:String = null;
         var secondPart:String = null;
         var returnedArray:Vector.<String> = new Vector.<String>();
         var exit:Boolean = false;
         var text:String = pText;
         while(!exit)
         {
            delimitedText = getSingleDelimitedText(text,pFirstDelimiter,pSecondDelimiter,pIncludeDelimiter);
            if(delimitedText == "")
            {
               exit = true;
            }
            else
            {
               returnedArray.push(delimitedText);
               if(!pIncludeDelimiter)
               {
                  delimitedText = pFirstDelimiter + delimitedText + pSecondDelimiter;
               }
               firstPart = text.slice(0,text.indexOf(delimitedText));
               secondPart = text.slice(text.indexOf(delimitedText) + delimitedText.length);
               text = firstPart + secondPart;
            }
         }
         return returnedArray;
      }
      
      public static function getAllIndexOf(pStringLookFor:String, pWholeString:String) : Array {
         var nextIndex:* = 0;
         var returnedArray:Array = new Array();
         var usage:uint = 0;
         var exit:Boolean = false;
         var currentIndex:uint = 0;
         while(!exit)
         {
            nextIndex = pWholeString.indexOf(pStringLookFor,currentIndex);
            if(nextIndex < currentIndex)
            {
               exit = true;
            }
            else
            {
               returnedArray.push(nextIndex);
               currentIndex = nextIndex + pStringLookFor.length;
            }
         }
         return returnedArray;
      }
      
      private static var pattern:Vector.<RegExp>;
      
      private static var patternReplace:Vector.<String>;
      
      public static function noAccent(source:String) : String {
         if((pattern == null) || (patternReplace == null))
         {
            initPattern();
         }
         return decomposeUnicode(source);
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
      
      private static function decomposeUnicode(str:String) : String {
         var i:* = 0;
         var j:uint = 0;
         var len:int = str.length > accents.length?accents.length:str.length;
         var left:String = len == accents.length?str:accents;
         var right:String = len == accents.length?accents:str;
         i = 0;
         while(i < len)
         {
            if(left.indexOf(right.charAt(i)) != -1)
            {
               j = 0;
               while(j < pattern.length)
               {
                  str = str.replace(pattern[j],patternReplace[j]);
                  j++;
               }
               return str;
            }
            i++;
         }
         return str;
      }
      
      private static function getSingleDelimitedText(pStringEntry:String, pFirstDelimiter:String, pSecondDelimiter:String, pIncludeDelimiter:Boolean = false) : String {
         var firstDelimiterIndex:* = 0;
         var nextFirstDelimiterIndex:* = 0;
         var nextSecondDelimiterIndex:* = 0;
         var delimitedContent:String = "";
         var currentIndex:uint = 0;
         var secondDelimiterToSkip:uint = 0;
         var exit:Boolean = false;
         firstDelimiterIndex = pStringEntry.indexOf(pFirstDelimiter,currentIndex);
         if(firstDelimiterIndex == -1)
         {
            return "";
         }
         currentIndex = firstDelimiterIndex + pFirstDelimiter.length;
         while(!exit)
         {
            nextFirstDelimiterIndex = pStringEntry.indexOf(pFirstDelimiter,currentIndex);
            nextSecondDelimiterIndex = pStringEntry.indexOf(pSecondDelimiter,currentIndex);
            if(nextSecondDelimiterIndex == -1)
            {
               trace("Erreur ! On n\'a pas trouvé d\'occurence du second délimiteur.");
               exit = true;
            }
            if((nextFirstDelimiterIndex < nextSecondDelimiterIndex) && (!(nextFirstDelimiterIndex == -1)))
            {
               secondDelimiterToSkip = secondDelimiterToSkip + getAllIndexOf(pFirstDelimiter,pStringEntry.slice(nextFirstDelimiterIndex + pFirstDelimiter.length,nextSecondDelimiterIndex)).length;
               currentIndex = nextSecondDelimiterIndex + pFirstDelimiter.length;
            }
            else if(secondDelimiterToSkip > 1)
            {
               currentIndex = nextSecondDelimiterIndex + pSecondDelimiter.length;
               secondDelimiterToSkip--;
            }
            else
            {
               delimitedContent = pStringEntry.slice(firstDelimiterIndex,nextSecondDelimiterIndex + pSecondDelimiter.length);
               exit = true;
            }
            
         }
         if((!pIncludeDelimiter) && (!(delimitedContent == "")))
         {
            delimitedContent = delimitedContent.slice(pFirstDelimiter.length);
            delimitedContent = delimitedContent.slice(0,delimitedContent.length - pSecondDelimiter.length);
         }
         return delimitedContent;
      }
      
      public static function kamasToString(kamas:Number, unit:String = "-") : String {
         if(unit == "-")
         {
            unit = I18n.getUiText("ui.common.short.kama",[]);
         }
         var kamaString:String = formateIntToString(kamas);
         if(unit == "")
         {
            return kamaString;
         }
         return kamaString + " " + unit;
      }
      
      public static function stringToKamas(string:String, unit:String = "-") : int {
         var str2:String = null;
         var tmp:String = string;
         do
         {
            str2 = tmp;
            tmp = str2.replace(I18n.getUiText("ui.common.numberSeparator"),"");
         }
         while(str2 != tmp);
         
         do
         {
            str2 = tmp;
            tmp = str2.replace(" ","");
         }
         while(str2 != tmp);
         
         if(unit == "-")
         {
            unit = I18n.getUiText("ui.common.short.kama",[]);
         }
         if(str2.substr(str2.length - unit.length) == unit)
         {
            str2 = str2.substr(0,str2.length - unit.length);
         }
         return int(str2);
      }
      
      public static function formateIntToString(val:Number) : String {
         var numx3:* = 0;
         var str:String = "";
         var modulo:Number = 1000;
         var numberSeparator:String = I18n.getUiText("ui.common.numberSeparator");
         while(val / modulo >= 1)
         {
            numx3 = int(val % modulo / (modulo / 1000));
            if(numx3 < 10)
            {
               str = "00" + numx3 + numberSeparator + str;
            }
            else if(numx3 < 100)
            {
               str = "0" + numx3 + numberSeparator + str;
            }
            else
            {
               str = numx3 + numberSeparator + str;
            }
            
            modulo = modulo * 1000;
         }
         str = int(val % modulo / (modulo / 1000)) + numberSeparator + str;
         var f:* = str.charAt(str.length - 1);
         if(str.charAt(str.length - 1) == numberSeparator)
         {
            return str.substr(0,str.length - 1);
         }
         return str;
      }
   }
}

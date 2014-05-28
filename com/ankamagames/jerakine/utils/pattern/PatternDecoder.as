package com.ankamagames.jerakine.utils.pattern
{
   public class PatternDecoder extends Object
   {
      
      public function PatternDecoder() {
         super();
      }
      
      public static function getDescription(sText:String, aParams:Array) : String {
         var aTmp:Array = sText.split("");
         var sFinal:String = decodeDescription(aTmp,aParams).join("");
         return sFinal;
      }
      
      public static function combine(str:String, gender:String, singular:Boolean) : String {
         if(!str)
         {
            return "";
         }
         var aTmp:Array = str.split("");
         var oParams:Object = new Object();
         oParams.m = gender == "m";
         oParams.f = gender == "f";
         oParams.n = gender == "n";
         oParams.p = !singular;
         oParams.s = singular;
         var sFinal:String = decodeCombine(aTmp,oParams).join("");
         return sFinal;
      }
      
      public static function decode(str:String, params:Array) : String {
         if(!str)
         {
            return "";
         }
         return decodeCombine(str.split(""),params).join("");
      }
      
      public static function replace(sSrc:String, sPattern:String) : String {
         var aTmp2:Array = null;
         var aTmp:Array = sSrc.split("##");
         var i:uint = 1;
         while(i < aTmp.length)
         {
            aTmp2 = aTmp[i].split(",");
            aTmp[i] = getDescription(sPattern,aTmp2);
            i = i + 2;
         }
         return aTmp.join("");
      }
      
      public static function replaceStr(sSrc:String, sSearchPattern:String, sReplaceStr:String) : String {
         var aTmp:Array = sSrc.split(sSearchPattern);
         return aTmp.join(sReplaceStr);
      }
      
      private static function findOptionnalDices(aStr:Array, aParams:Array) : Array {
         var nBlancDebut:uint = 0;
         var nBlancFin:uint = 0;
         var l:uint = aStr.length;
         var returnString:String = "";
         var aStrCopyFirstPart:Array = new Array();
         var aStrCopySecondPart:Array = new Array();
         var returnArray:Array = aStr;
         var posAcc1:Number = find(aStr,"{");
         var posAcc2:Number = find(aStr,"}");
         if((posAcc1 >= 0) && (posAcc2 > posAcc1))
         {
            nBlancDebut = 0;
            while(aStr[posAcc1 - (nBlancDebut + 1)] == " ")
            {
               nBlancDebut++;
            }
            nBlancFin = 0;
            while(aStr[posAcc2 + (nBlancFin + 1)] == " ")
            {
               nBlancFin++;
            }
            aStrCopyFirstPart = aStr.splice(0,posAcc1 - (2 + nBlancDebut));
            aStrCopySecondPart = aStr.splice(posAcc2 - posAcc1 + 5 + nBlancFin + nBlancDebut,aStr.length - (posAcc2 - posAcc1));
            if((aStr[0] == "#") && (aStr[aStr.length - 2] == "#"))
            {
               if((aParams[1] == null) && (aParams[2] == null) && (aParams[3] == null))
               {
                  aStrCopyFirstPart.push(aParams[0]);
               }
               else if((aParams[0] == 0) && (aParams[1] == 0))
               {
                  aStrCopyFirstPart.push(aParams[2]);
               }
               else if(!aParams[2])
               {
                  aStr.splice(aStr.indexOf("#"),2,aParams[0]);
                  aStr.splice(aStr.indexOf("{"),1);
                  aStr.splice(aStr.indexOf("~"),4);
                  aStr.splice(aStr.indexOf("#"),2,aParams[1]);
                  aStr.splice(aStr.indexOf("}"),1);
                  aStrCopyFirstPart = aStrCopyFirstPart.concat(aStr);
               }
               else
               {
                  aStr.splice(aStr.indexOf("#"),2,aParams[0] + aParams[2]);
                  aStr.splice(aStr.indexOf("{"),1);
                  aStr.splice(aStr.indexOf("~"),4);
                  aStr.splice(aStr.indexOf("#"),2,aParams[0] * aParams[1] + aParams[2]);
                  aStr.splice(aStr.indexOf("}"),1);
                  aStrCopyFirstPart = aStrCopyFirstPart.concat(aStr);
               }
               
               
               returnArray = aStrCopyFirstPart.concat(aStrCopySecondPart);
            }
         }
         return returnArray;
      }
      
      private static function decodeDescription(aStr:Array, aParams:Array) : Array {
         var i:* = NaN;
         var n:* = NaN;
         var n1:* = NaN;
         var pos:* = NaN;
         var rstr:String = null;
         var pos2:* = NaN;
         var n2:* = NaN;
         i = 0;
         var sChar:String = new String();
         var nLen:Number = aStr.length;
         var aStr:Array = findOptionnalDices(aStr,aParams);
         while(i < nLen)
         {
            sChar = aStr[i];
            switch(sChar)
            {
               case "#":
                  n = aStr[i + 1];
                  if(!isNaN(n))
                  {
                     if(aParams[n - 1] != undefined)
                     {
                        aStr.splice(i,2,aParams[n - 1]);
                        i--;
                     }
                     else
                     {
                        aStr.splice(i,2);
                        i = i - 2;
                     }
                  }
                  break;
               case "~":
                  n1 = aStr[i + 1];
                  if(!isNaN(n1))
                  {
                     if(aParams[n1 - 1] != null)
                     {
                        aStr.splice(i,2);
                        i = i - 2;
                     }
                     else
                     {
                        return aStr.slice(0,i);
                     }
                  }
                  break;
               case "{":
                  pos = find(aStr.slice(i),"}");
                  rstr = decodeDescription(aStr.slice(i + 1,i + pos),aParams).join("");
                  aStr.splice(i,pos + 1,rstr);
                  break;
               case "[":
                  pos2 = find(aStr.slice(i),"]");
                  n2 = Number(aStr.slice(i + 1,i + pos2).join(""));
                  if(!isNaN(n2))
                  {
                     aStr.splice(i,pos2 + 1,aParams[n2] + " ");
                     i = i - pos2;
                  }
                  break;
            }
            i++;
         }
         return aStr;
      }
      
      private static function decodeCombine(aStr:Array, oParams:Object) : Array {
         var i:* = NaN;
         var key:String = null;
         var pos:* = NaN;
         var rstr:String = null;
         i = 0;
         var sChar:String = new String();
         var nLen:Number = aStr.length;
         while(i < nLen)
         {
            sChar = aStr[i];
            switch(sChar)
            {
               case "~":
                  key = aStr[i + 1];
                  if(oParams[key])
                  {
                     aStr.splice(i,2);
                     i = i - 2;
                     break;
                  }
                  return aStr.slice(0,i);
               case "{":
                  pos = find(aStr.slice(i),"}");
                  rstr = decodeCombine(aStr.slice(i + 1,i + pos),oParams).join("");
                  aStr.splice(i,pos + 1,rstr);
                  break;
            }
            i++;
         }
         return aStr;
      }
      
      private static function find(a:Array, f:Object) : Number {
         var i:* = NaN;
         var nLen:Number = a.length;
         i = 0;
         while(i < nLen)
         {
            if(a[i] == f)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
   }
}

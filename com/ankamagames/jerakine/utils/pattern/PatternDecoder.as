package com.ankamagames.jerakine.utils.pattern
{
    public class PatternDecoder 
    {


        public static function getDescription(sText:String, aParams:Array):String
        {
            var aTmp:Array = sText.split("");
            var sFinal:String = decodeDescription(aTmp, aParams).join("");
            return (sFinal);
        }

        public static function combine(str:String, gender:String, singular:Boolean):String
        {
            if (!(str))
            {
                return ("");
            };
            var aTmp:Array = str.split("");
            var oParams:Object = new Object();
            oParams.m = (gender == "m");
            oParams.f = (gender == "f");
            oParams.n = (gender == "n");
            oParams.p = !(singular);
            oParams.s = singular;
            var sFinal:String = decodeCombine(aTmp, oParams).join("");
            return (sFinal);
        }

        public static function decode(str:String, params:Array):String
        {
            if (!(str))
            {
                return ("");
            };
            return (decodeCombine(str.split(""), params).join(""));
        }

        public static function replace(sSrc:String, sPattern:String):String
        {
            var aTmp2:Array;
            var aTmp:Array = sSrc.split("##");
            var i:uint = 1;
            while (i < aTmp.length)
            {
                aTmp2 = aTmp[i].split(",");
                aTmp[i] = getDescription(sPattern, aTmp2);
                i = (i + 2);
            };
            return (aTmp.join(""));
        }

        public static function replaceStr(sSrc:String, sSearchPattern:String, sReplaceStr:String):String
        {
            var aTmp:Array = sSrc.split(sSearchPattern);
            return (aTmp.join(sReplaceStr));
        }

        private static function findOptionnalDices(aStr:Array, aParams:Array):Array
        {
            var nBlancDebut:uint;
            var nBlancFin:uint;
            var l:uint = aStr.length;
            var returnString:String = "";
            var aStrCopyFirstPart:Array = new Array();
            var aStrCopySecondPart:Array = new Array();
            var returnArray:Array = aStr;
            var posAcc1:Number = find(aStr, "{");
            var posAcc2:Number = find(aStr, "}");
            if ((((posAcc1 >= 0)) && ((posAcc2 > posAcc1))))
            {
                nBlancDebut = 0;
                while (aStr[(posAcc1 - (nBlancDebut + 1))] == " ")
                {
                    nBlancDebut++;
                };
                nBlancFin = 0;
                while (aStr[(posAcc2 + (nBlancFin + 1))] == " ")
                {
                    nBlancFin++;
                };
                aStrCopyFirstPart = aStr.splice(0, (posAcc1 - (2 + nBlancDebut)));
                aStrCopySecondPart = aStr.splice(((((posAcc2 - posAcc1) + 5) + nBlancFin) + nBlancDebut), (aStr.length - (posAcc2 - posAcc1)));
                if ((((aStr[0] == "#")) && ((aStr[(aStr.length - 2)] == "#"))))
                {
                    if ((((((aParams[1] == null)) && ((aParams[2] == null)))) && ((aParams[3] == null))))
                    {
                        aStrCopyFirstPart.push(aParams[0]);
                    }
                    else
                    {
                        if ((((aParams[0] == 0)) && ((aParams[1] == 0))))
                        {
                            aStrCopyFirstPart.push(aParams[2]);
                        }
                        else
                        {
                            if (!(aParams[2]))
                            {
                                aStr.splice(aStr.indexOf("#"), 2, aParams[0]);
                                aStr.splice(aStr.indexOf("{"), 1);
                                aStr.splice(aStr.indexOf("~"), 4);
                                aStr.splice(aStr.indexOf("#"), 2, aParams[1]);
                                aStr.splice(aStr.indexOf("}"), 1);
                                aStrCopyFirstPart = aStrCopyFirstPart.concat(aStr);
                            }
                            else
                            {
                                aStr.splice(aStr.indexOf("#"), 2, (aParams[0] + aParams[2]));
                                aStr.splice(aStr.indexOf("{"), 1);
                                aStr.splice(aStr.indexOf("~"), 4);
                                aStr.splice(aStr.indexOf("#"), 2, ((aParams[0] * aParams[1]) + aParams[2]));
                                aStr.splice(aStr.indexOf("}"), 1);
                                aStrCopyFirstPart = aStrCopyFirstPart.concat(aStr);
                            };
                        };
                    };
                    returnArray = aStrCopyFirstPart.concat(aStrCopySecondPart);
                };
            };
            return (returnArray);
        }

        private static function decodeDescription(aStr:Array, aParams:Array):Array
        {
            var i:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:String;
            var _local_10:Number;
            var _local_11:Number;
            i = 0;
            var sChar:String = new String();
            var nLen:Number = aStr.length;
            aStr = findOptionnalDices(aStr, aParams);
            while (i < nLen)
            {
                sChar = aStr[i];
                switch (sChar)
                {
                    case "#":
                        _local_6 = aStr[(i + 1)];
                        if (!(isNaN(_local_6)))
                        {
                            if (aParams[(_local_6 - 1)] != undefined)
                            {
                                aStr.splice(i, 2, aParams[(_local_6 - 1)]);
                                i--;
                            }
                            else
                            {
                                aStr.splice(i, 2);
                                i = (i - 2);
                            };
                        };
                        break;
                    case "~":
                        _local_7 = aStr[(i + 1)];
                        if (!(isNaN(_local_7)))
                        {
                            if (aParams[(_local_7 - 1)] != null)
                            {
                                aStr.splice(i, 2);
                                i = (i - 2);
                            }
                            else
                            {
                                return (aStr.slice(0, i));
                            };
                        };
                        break;
                    case "{":
                        _local_8 = find(aStr.slice(i), "}");
                        _local_9 = decodeDescription(aStr.slice((i + 1), (i + _local_8)), aParams).join("");
                        aStr.splice(i, (_local_8 + 1), _local_9);
                        break;
                    case "[":
                        _local_10 = find(aStr.slice(i), "]");
                        _local_11 = Number(aStr.slice((i + 1), (i + _local_10)).join(""));
                        if (!(isNaN(_local_11)))
                        {
                            aStr.splice(i, (_local_10 + 1), (aParams[_local_11] + " "));
                            i = (i - _local_10);
                        };
                        break;
                };
                i++;
            };
            return (aStr);
        }

        private static function decodeCombine(aStr:Array, oParams:Object):Array
        {
            var i:Number;
            var _local_6:String;
            var _local_7:Number;
            var _local_8:String;
            i = 0;
            var sChar:String = new String();
            var nLen:Number = aStr.length;
            while (i < nLen)
            {
                sChar = aStr[i];
                switch (sChar)
                {
                    case "~":
                        _local_6 = aStr[(i + 1)];
                        if (oParams[_local_6])
                        {
                            aStr.splice(i, 2);
                            i = (i - 2);
                        }
                        else
                        {
                            return (aStr.slice(0, i));
                        };
                        break;
                    case "{":
                        _local_7 = find(aStr.slice(i), "}");
                        _local_8 = decodeCombine(aStr.slice((i + 1), (i + _local_7)), oParams).join("");
                        aStr.splice(i, (_local_7 + 1), _local_8);
                        break;
                };
                i++;
            };
            return (aStr);
        }

        private static function find(a:Array, f:Object):Number
        {
            var i:Number;
            var nLen:Number = a.length;
            i = 0;
            while (i < nLen)
            {
                if (a[i] == f)
                {
                    return (i);
                };
                i++;
            };
            return (-1);
        }


    }
}//package com.ankamagames.jerakine.utils.pattern


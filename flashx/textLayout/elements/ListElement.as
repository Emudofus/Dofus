package flashx.textLayout.elements
{
    import __AS3__.vec.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;

    public class ListElement extends ContainerFormattedElement
    {
        static const LIST_MARKER_FORMAT_NAME:String = "listMarkerFormat";
        static const constantListStyles:Object = {none:"", disc:"•", circle:"◦", square:"■", box:"□", check:"✓", diamond:"◆", hyphen:"⁃"};
        private static const romanDigitFunction:Vector.<Function> = ListElement.Vector.<Function>([@%@function ()@%@31585@%@, @%@function ()@%@31586@%@, @%@function ()@%@31587@%@, @%@function ()@%@31588@%@, @%@function ()@%@31589@%@, @%@function ()@%@31590@%@, @%@function ()@%@31591@%@, @%@function ()@%@31592@%@, @%@function ()@%@31593@%@, @%@function ()@%@31594@%@]);
        private static const upperRomanData:Vector.<String> = ListElement.Vector.<String>(["I", "V", "X", "L", "C", "D", "M"]);
        private static const lowerRomanData:Vector.<String> = ListElement.Vector.<String>(["i", "v", "x", "l", "c", "d", "m"]);
        static const cjkEarthlyBranchData:Vector.<int> = ListElement.Vector.<int>([23376, 19985, 23493, 21359, 36784, 24051, 21320, 26410, 30003, 37193, 25100, 20133]);
        static const cjkHeavenlyStemData:Vector.<int> = ListElement.Vector.<int>([30002, 20057, 19993, 19969, 25098, 24049, 24218, 36763, 22764, 30328]);
        static const hangulData:Vector.<int> = ListElement.Vector.<int>([44032, 45208, 45796, 46972, 47560, 48148, 49324, 50500, 51088, 52264, 52852, 53440, 54028, 54616]);
        static const hangulConstantData:Vector.<int> = ListElement.Vector.<int>([12593, 12596, 12599, 12601, 12609, 12610, 12613, 12615, 12616, 12618, 12619, 12620, 12621, 12622]);
        static const hiraganaData:Vector.<int> = ListElement.Vector.<int>([12354, 12356, 12358, 12360, 12362, 12363, 12365, 12367, 12369, 12371, 12373, 12375, 12377, 12379, 12381, 12383, 12385, 12388, 12390, 12392, 12394, 12395, 12396, 12397, 12398, 12399, 12402, 12405, 12408, 12411, 12414, 12415, 12416, 12417, 12418, 12420, 12422, 12424, 12425, 12426, 12427, 12428, 12429, 12431, 12432, 12433, 12434, 12435]);
        static const hiraganaIrohaData:Vector.<int> = ListElement.Vector.<int>([12356, 12429, 12399, 12395, 12411, 12408, 12392, 12385, 12426, 12396, 12427, 12434, 12431, 12363, 12424, 12383, 12428, 12381, 12388, 12397, 12394, 12425, 12416, 12358, 12432, 12398, 12362, 12367, 12420, 12414, 12369, 12405, 12371, 12360, 12390, 12354, 12373, 12365, 12422, 12417, 12415, 12375, 12433, 12402, 12418, 12379, 12377]);
        static const katakanaData:Vector.<int> = ListElement.Vector.<int>([12450, 12452, 12454, 12456, 12458, 12459, 12461, 12463, 12465, 12467, 12469, 12471, 12473, 12475, 12477, 12479, 12481, 12484, 12486, 12488, 12490, 12491, 12492, 12493, 12494, 12495, 12498, 12501, 12504, 12507, 12510, 12511, 12512, 12513, 12514, 12516, 12518, 12520, 12521, 12522, 12523, 12524, 12525, 12527, 12528, 12529, 12530, 12531]);
        static const katakanaIrohaData:Vector.<int> = ListElement.Vector.<int>([12452, 12525, 12495, 12491, 12507, 12504, 12488, 12481, 12522, 12492, 12523, 12530, 12527, 12459, 12520, 12479, 12524, 12477, 12484, 12493, 12490, 12521, 12512, 12454, 12528, 12494, 12458, 12463, 12516, 12510, 12465, 12501, 12467, 12456, 12486, 12450, 12469, 12461, 12518, 12513, 12511, 12471, 12529, 12498, 12514, 12475, 12473]);
        static const lowerGreekData:Vector.<int> = ListElement.Vector.<int>([945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 963, 964, 965, 966, 967, 968, 969]);
        static const upperGreekData:Vector.<int> = ListElement.Vector.<int>([913, 914, 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928, 929, 931, 932, 933, 934, 935, 936, 937]);
        static const algorithmicListStyles:Object = {upperRoman:upperRomanString, lowerRoman:lowerRomanString};
        static const numericListStyles:Object = {arabicIndic:arabicIndicString, bengali:bengaliString, decimal:decimalString, decimalLeadingZero:decimalLeadingZeroString, devanagari:devanagariString, gujarati:gujaratiString, gurmukhi:gurmukhiString, kannada:kannadaString, persian:persianString, thai:thaiString, urdu:urduString};
        static const alphabeticListStyles:Object = {upperAlpha:upperAlphaString, lowerAlpha:lowerAlphaString, cjkEarthlyBranch:cjkEarthlyBranchString, cjkHeavenlyStem:cjkHeavenlyStemString, hangul:hangulString, hangulConstant:hangulConstantString, hiragana:hiraganaString, hiraganaIroha:hiraganaIrohaString, katakana:katakanaString, katakanaIroha:katakanaIrohaString, lowerGreek:lowerGreekString, lowerLatin:lowerLatinString, upperGreek:upperGreekString, upperLatin:upperLatinString};
        static const listSuffixes:Object = {upperAlpha:".", lowerAlpha:".", upperRoman:".", lowerRoman:".", arabicIndic:".", bengali:".", decimal:".", decimalLeadingZero:".", devanagari:".", gujarati:".", gurmukhi:".", kannada:".", persian:".", thai:".", urdu:".", cjkEarthlyBranch:".", cjkHeavenlyStem:".", hangul:".", hangulConstant:".", hiragana:".", hiraganaIroha:".", katakana:".", katakanaIroha:".", lowerGreek:".", lowerLatin:".", upperGreek:".", upperLatin:"."};

        public function ListElement()
        {
            return;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "list";
        }// end function

        override function canOwnFlowElement(param1:FlowElement) : Boolean
        {
            return !(param1 is TextFlow) && !(param1 is FlowLeafElement) && !(param1 is SubParagraphGroupElementBase);
        }// end function

        override function modelChanged(param1:String, param2:FlowElement, param3:int, param4:int, param5:Boolean = true, param6:Boolean = true) : void
        {
            if ((param1 == ModelChange.ELEMENT_ADDED || param1 == ModelChange.ELEMENT_REMOVAL) && param2 is ListItemElement && this.isNumberedList())
            {
                param3 = param2.parentRelativeStart;
                param4 = textLength - param2.parentRelativeStart;
            }
            super.modelChanged(param1, param2, param3, param4, param5, param6);
            return;
        }// end function

        override function getEffectivePaddingLeft() : Number
        {
            if (computedFormat.paddingLeft != FormatValue.AUTO)
            {
                return computedFormat.paddingLeft;
            }
            var _loc_1:* = getTextFlow();
            if (!_loc_1 || _loc_1.computedFormat.blockProgression != BlockProgression.TB || computedFormat.direction != Direction.LTR)
            {
                return 0;
            }
            return computedFormat.listAutoPadding;
        }// end function

        override function getEffectivePaddingRight() : Number
        {
            if (computedFormat.paddingRight != FormatValue.AUTO)
            {
                return computedFormat.paddingRight;
            }
            var _loc_1:* = getTextFlow();
            if (!_loc_1 || _loc_1.computedFormat.blockProgression != BlockProgression.TB || computedFormat.direction != Direction.RTL)
            {
                return 0;
            }
            return computedFormat.listAutoPadding;
        }// end function

        override function getEffectivePaddingTop() : Number
        {
            if (computedFormat.paddingTop != FormatValue.AUTO)
            {
                return computedFormat.paddingTop;
            }
            var _loc_1:* = getTextFlow();
            if (!_loc_1 || _loc_1.computedFormat.blockProgression != BlockProgression.RL || computedFormat.direction != Direction.LTR)
            {
                return 0;
            }
            return computedFormat.listAutoPadding;
        }// end function

        override function getEffectivePaddingBottom() : Number
        {
            if (computedFormat.paddingBottom != FormatValue.AUTO)
            {
                return computedFormat.paddingBottom;
            }
            var _loc_1:* = getTextFlow();
            if (!_loc_1 || _loc_1.computedFormat.blockProgression != BlockProgression.RL || computedFormat.direction != Direction.RTL)
            {
                return 0;
            }
            return computedFormat.listAutoPadding;
        }// end function

        function computeListItemText(param1:ListItemElement, param2:IListMarkerFormat) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (param2.content && param2.content.hasOwnProperty("counters"))
            {
                _loc_4 = "";
                _loc_3 = param2.content.ordered;
                _loc_7 = param2.content.suffix;
                _loc_8 = this;
                _loc_9 = param2;
                while (true)
                {
                    
                    _loc_4 = _loc_8.computeListItemTextSpecified(param1, _loc_9, _loc_3 == null ? (_loc_8.computedFormat.listStyleType) : (_loc_3), _loc_7) + _loc_4;
                    param1 = _loc_8.getParentByType(ListItemElement) as ListItemElement;
                    if (!param1)
                    {
                        break;
                    }
                    _loc_8 = param1.parent as ListElement;
                    _loc_9 = param1.computedListMarkerFormat();
                }
            }
            else
            {
                if (param2.content !== undefined)
                {
                    if (param2.content == FormatValue.NONE)
                    {
                        _loc_3 = ListStyleType.NONE;
                    }
                    else
                    {
                        _loc_3 = param2.content.ordered;
                    }
                }
                if (_loc_3 == null)
                {
                    _loc_3 = computedFormat.listStyleType;
                }
                _loc_4 = this.computeListItemTextSpecified(param1, param2, _loc_3, null);
            }
            var _loc_5:* = param2.beforeContent ? (param2.beforeContent) : ("");
            var _loc_6:* = param2.afterContent ? (param2.afterContent) : ("");
            return _loc_5 + _loc_4 + _loc_6;
        }// end function

        function computeListItemTextSpecified(param1:ListItemElement, param2:IListMarkerFormat, param3:String, param4:String) : String
        {
            var _loc_5:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_6:* = constantListStyles[param3];
            if (constantListStyles[param3] !== undefined)
            {
                _loc_5 = _loc_6 as String;
            }
            else
            {
                _loc_7 = param1.getListItemNumber(param2);
                _loc_8 = numericListStyles[param3];
                if (_loc_8 != null)
                {
                    _loc_5 = _loc_7 < 0 ? ("-" + this._loc_8(-_loc_7)) : (this._loc_8(_loc_7));
                }
                else if (_loc_7 <= 0)
                {
                    _loc_5 = _loc_7 == 0 ? ("0") : ("-" + decimalString(-_loc_7));
                }
                else
                {
                    _loc_8 = alphabeticListStyles[param3];
                    if (_loc_8 != null)
                    {
                        _loc_5 = this._loc_8(_loc_7);
                    }
                    else
                    {
                        var _loc_9:* = algorithmicListStyles;
                        _loc_5 = _loc_9.algorithmicListStyles[param3](_loc_7);
                    }
                }
                if (param4 != null)
                {
                    _loc_5 = _loc_5 + param4;
                }
                else if (param2.suffix != Suffix.NONE)
                {
                    _loc_5 = _loc_5 + listSuffixes[param3];
                }
            }
            return _loc_5;
        }// end function

        function isNumberedList() : Boolean
        {
            return constantListStyles[computedFormat.listStyleType] === undefined;
        }// end function

        static function createRomanString(param1:int, param2:Vector.<String>) : String
        {
            var _loc_3:* = "";
            while (param1 >= 1000)
            {
                
                _loc_3 = _loc_3 + param2[6];
                param1 = param1 - 1000;
            }
            var _loc_4:* = romanDigitFunction;
            var _loc_4:* = romanDigitFunction;
            var _loc_4:* = romanDigitFunction;
            return _loc_3 + _loc_4.romanDigitFunction[int(param1 / 100)](param2[4], param2[5], param2[6]) + _loc_4.romanDigitFunction[int(param1 / 10 % 10)](param2[2], param2[3], param2[4]) + _loc_4.romanDigitFunction[int(param1 % 10)](param2[0], param2[1], param2[2]);
        }// end function

        static function upperRomanString(param1:int) : String
        {
            if (param1 <= 0)
            {
                return decimalString(param1);
            }
            if (param1 <= 1000)
            {
                return createRomanString(param1, upperRomanData);
            }
            if (param1 >= 40000)
            {
                return decimalString(param1);
            }
            var _loc_2:* = createRomanString(param1 % 1000, upperRomanData);
            var _loc_3:* = "";
            param1 = param1 - param1 % 1000;
            while (param1 >= 10000)
            {
                
                _loc_3 = _loc_3 + String.fromCharCode(8578);
                param1 = param1 - 10000;
            }
            if (param1 == 9000)
            {
                _loc_3 = _loc_3 + ("M" + String.fromCharCode(8578));
            }
            else if (param1 == 4000)
            {
                _loc_3 = _loc_3 + ("M" + String.fromCharCode(8577));
            }
            else
            {
                if (param1 >= 5000)
                {
                    _loc_3 = _loc_3 + String.fromCharCode(8577);
                    param1 = param1 - 5000;
                }
                while (param1 > 0)
                {
                    
                    _loc_3 = _loc_3 + "M";
                    param1 = param1 - 1000;
                }
            }
            return _loc_3 + _loc_2;
        }// end function

        static function lowerRomanString(param1:int) : String
        {
            return param1 > 0 && param1 < 4000 ? (createRomanString(param1, lowerRomanData)) : (decimalString(param1));
        }// end function

        static function decimalString(param1:int) : String
        {
            return param1.toString();
        }// end function

        static function decimalLeadingZeroString(param1:int) : String
        {
            return param1 <= 9 && param1 >= -9 ? ("0" + param1.toString()) : (param1.toString());
        }// end function

        static function createNumericBaseTenString(param1:int, param2:int) : String
        {
            if (param1 == 0)
            {
                return String.fromCharCode(param2);
            }
            var _loc_3:* = "";
            while (param1 > 0)
            {
                
                _loc_3 = String.fromCharCode(param1 % 10 + param2) + _loc_3;
                param1 = param1 / 10;
            }
            return _loc_3;
        }// end function

        static function arabicIndicString(param1:int) : String
        {
            return createNumericBaseTenString(param1, 1632);
        }// end function

        static function bengaliString(param1:int) : String
        {
            return createNumericBaseTenString(param1, 2534);
        }// end function

        static function devanagariString(param1:int) : String
        {
            return createNumericBaseTenString(param1, 2406);
        }// end function

        static function gujaratiString(param1:int) : String
        {
            return createNumericBaseTenString(param1, 2790);
        }// end function

        static function gurmukhiString(param1:int) : String
        {
            return createNumericBaseTenString(param1, 2662);
        }// end function

        static function kannadaString(param1:int) : String
        {
            return createNumericBaseTenString(param1, 3302);
        }// end function

        static function persianString(param1:int) : String
        {
            return createNumericBaseTenString(param1, 1776);
        }// end function

        static function thaiString(param1:int) : String
        {
            return createNumericBaseTenString(param1, 3664);
        }// end function

        static function urduString(param1:int) : String
        {
            return createNumericBaseTenString(param1, 1776);
        }// end function

        static function createContinuousAlphaString(param1:int, param2:int, param3:int) : String
        {
            var _loc_4:* = "";
            while (param1 > 0)
            {
                
                _loc_4 = String.fromCharCode((param1 - 1) % param3 + param2) + _loc_4;
                param1 = (param1 - 1) / param3;
            }
            return _loc_4;
        }// end function

        static function lowerAlphaString(param1:int) : String
        {
            return createContinuousAlphaString(param1, 97, 26);
        }// end function

        static function upperAlphaString(param1:int) : String
        {
            return createContinuousAlphaString(param1, 65, 26);
        }// end function

        static function lowerLatinString(param1:int) : String
        {
            return createContinuousAlphaString(param1, 97, 26);
        }// end function

        static function upperLatinString(param1:int) : String
        {
            return createContinuousAlphaString(param1, 65, 26);
        }// end function

        static function createTableAlphaString(param1:int, param2:Vector.<int>) : String
        {
            var _loc_3:* = "";
            var _loc_4:* = param2.length;
            while (param1 > 0)
            {
                
                _loc_3 = String.fromCharCode(param2[(param1 - 1) % _loc_4]) + _loc_3;
                param1 = (param1 - 1) / _loc_4;
            }
            return _loc_3;
        }// end function

        static function cjkEarthlyBranchString(param1:int) : String
        {
            return createTableAlphaString(param1, cjkEarthlyBranchData);
        }// end function

        static function cjkHeavenlyStemString(param1:int) : String
        {
            return createTableAlphaString(param1, cjkHeavenlyStemData);
        }// end function

        static function hangulString(param1:int) : String
        {
            return createTableAlphaString(param1, hangulData);
        }// end function

        static function hangulConstantString(param1:int) : String
        {
            return createTableAlphaString(param1, hangulConstantData);
        }// end function

        static function hiraganaString(param1:int) : String
        {
            return createTableAlphaString(param1, hiraganaData);
        }// end function

        static function hiraganaIrohaString(param1:int) : String
        {
            return createTableAlphaString(param1, hiraganaIrohaData);
        }// end function

        static function katakanaString(param1:int) : String
        {
            return createTableAlphaString(param1, katakanaData);
        }// end function

        static function katakanaIrohaString(param1:int) : String
        {
            return createTableAlphaString(param1, katakanaIrohaData);
        }// end function

        static function lowerGreekString(param1:int) : String
        {
            return createTableAlphaString(param1, lowerGreekData);
        }// end function

        static function upperGreekString(param1:int) : String
        {
            return createTableAlphaString(param1, upperGreekData);
        }// end function

    }
}

package com.ankamagames.dofus.types.characteristicContextual
{
    import flash.display.*;

    public class StyledTextContextual extends CharacteristicContextual
    {
        private static const STYLE_0_NUMBER_0:Class = StyledTextContextual_STYLE_0_NUMBER_0;
        private static const STYLE_0_NUMBER_1:Class = StyledTextContextual_STYLE_0_NUMBER_1;
        private static const STYLE_0_NUMBER_2:Class = StyledTextContextual_STYLE_0_NUMBER_2;
        private static const STYLE_0_NUMBER_3:Class = StyledTextContextual_STYLE_0_NUMBER_3;
        private static const STYLE_0_NUMBER_4:Class = StyledTextContextual_STYLE_0_NUMBER_4;
        private static const STYLE_0_NUMBER_5:Class = StyledTextContextual_STYLE_0_NUMBER_5;
        private static const STYLE_0_NUMBER_6:Class = StyledTextContextual_STYLE_0_NUMBER_6;
        private static const STYLE_0_NUMBER_7:Class = StyledTextContextual_STYLE_0_NUMBER_7;
        private static const STYLE_0_NUMBER_8:Class = StyledTextContextual_STYLE_0_NUMBER_8;
        private static const STYLE_0_NUMBER_9:Class = StyledTextContextual_STYLE_0_NUMBER_9;
        private static const STYLE_0_NUMBER_MOINS:Class = StyledTextContextual_STYLE_0_NUMBER_MOINS;
        private static const STYLE_0_NUMBER_PLUS:Class = StyledTextContextual_STYLE_0_NUMBER_PLUS;
        private static const STYLE_1_NUMBER_0:Class = StyledTextContextual_STYLE_1_NUMBER_0;
        private static const STYLE_1_NUMBER_1:Class = StyledTextContextual_STYLE_1_NUMBER_1;
        private static const STYLE_1_NUMBER_2:Class = StyledTextContextual_STYLE_1_NUMBER_2;
        private static const STYLE_1_NUMBER_3:Class = StyledTextContextual_STYLE_1_NUMBER_3;
        private static const STYLE_1_NUMBER_4:Class = StyledTextContextual_STYLE_1_NUMBER_4;
        private static const STYLE_1_NUMBER_5:Class = StyledTextContextual_STYLE_1_NUMBER_5;
        private static const STYLE_1_NUMBER_6:Class = StyledTextContextual_STYLE_1_NUMBER_6;
        private static const STYLE_1_NUMBER_7:Class = StyledTextContextual_STYLE_1_NUMBER_7;
        private static const STYLE_1_NUMBER_8:Class = StyledTextContextual_STYLE_1_NUMBER_8;
        private static const STYLE_1_NUMBER_9:Class = StyledTextContextual_STYLE_1_NUMBER_9;
        private static const STYLE_1_NUMBER_MOINS:Class = StyledTextContextual_STYLE_1_NUMBER_MOINS;
        private static const STYLE_1_NUMBER_PLUS:Class = StyledTextContextual_STYLE_1_NUMBER_PLUS;
        private static const STYLE_2_NUMBER_0:Class = StyledTextContextual_STYLE_2_NUMBER_0;
        private static const STYLE_2_NUMBER_1:Class = StyledTextContextual_STYLE_2_NUMBER_1;
        private static const STYLE_2_NUMBER_2:Class = StyledTextContextual_STYLE_2_NUMBER_2;
        private static const STYLE_2_NUMBER_3:Class = StyledTextContextual_STYLE_2_NUMBER_3;
        private static const STYLE_2_NUMBER_4:Class = StyledTextContextual_STYLE_2_NUMBER_4;
        private static const STYLE_2_NUMBER_5:Class = StyledTextContextual_STYLE_2_NUMBER_5;
        private static const STYLE_2_NUMBER_6:Class = StyledTextContextual_STYLE_2_NUMBER_6;
        private static const STYLE_2_NUMBER_7:Class = StyledTextContextual_STYLE_2_NUMBER_7;
        private static const STYLE_2_NUMBER_8:Class = StyledTextContextual_STYLE_2_NUMBER_8;
        private static const STYLE_2_NUMBER_9:Class = StyledTextContextual_STYLE_2_NUMBER_9;
        private static const STYLE_2_NUMBER_MOINS:Class = StyledTextContextual_STYLE_2_NUMBER_MOINS;
        private static const STYLE_2_NUMBER_PLUS:Class = StyledTextContextual_STYLE_2_NUMBER_PLUS;
        private static const STYLE_3_NUMBER_0:Class = StyledTextContextual_STYLE_3_NUMBER_0;
        private static const STYLE_3_NUMBER_1:Class = StyledTextContextual_STYLE_3_NUMBER_1;
        private static const STYLE_3_NUMBER_2:Class = StyledTextContextual_STYLE_3_NUMBER_2;
        private static const STYLE_3_NUMBER_3:Class = StyledTextContextual_STYLE_3_NUMBER_3;
        private static const STYLE_3_NUMBER_4:Class = StyledTextContextual_STYLE_3_NUMBER_4;
        private static const STYLE_3_NUMBER_5:Class = StyledTextContextual_STYLE_3_NUMBER_5;
        private static const STYLE_3_NUMBER_6:Class = StyledTextContextual_STYLE_3_NUMBER_6;
        private static const STYLE_3_NUMBER_7:Class = StyledTextContextual_STYLE_3_NUMBER_7;
        private static const STYLE_3_NUMBER_8:Class = StyledTextContextual_STYLE_3_NUMBER_8;
        private static const STYLE_3_NUMBER_9:Class = StyledTextContextual_STYLE_3_NUMBER_9;
        private static const STYLE_3_NUMBER_MOINS:Class = StyledTextContextual_STYLE_3_NUMBER_MOINS;
        private static const STYLE_3_NUMBER_PLUS:Class = StyledTextContextual_STYLE_3_NUMBER_PLUS;

        public function StyledTextContextual(param1:String, param2:uint)
        {
            this.init(param1, param2);
            return;
        }// end function

        private function init(param1:String, param2:uint) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_5 = param1.charAt(_loc_4);
                switch(_loc_5)
                {
                    case "-":
                    {
                        _loc_5 = "MOINS";
                        break;
                    }
                    case "+":
                    {
                        _loc_5 = "PLUS";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_6 = new StyledTextContextual["STYLE_" + param2 + "_NUMBER_" + _loc_5] as Sprite;
                _loc_6.scaleX = 0.7;
                _loc_6.scaleY = 0.7;
                if (_loc_3)
                {
                    _loc_6.x = _loc_3.x + _loc_3.width + 5;
                }
                addChild(_loc_6);
                _loc_3 = _loc_6;
                _loc_4 = _loc_4 + 1;
            }
            mouseEnabled = false;
            mouseChildren = false;
            cacheAsBitmap = true;
            return;
        }// end function

    }
}

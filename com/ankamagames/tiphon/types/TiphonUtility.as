package com.ankamagames.tiphon.types
{
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.display.*;

    public class TiphonUtility extends Object
    {

        public function TiphonUtility()
        {
            return;
        }// end function

        public static function getLookWithoutMount(param1:TiphonEntityLook) : TiphonEntityLook
        {
            var _loc_3:* = 0;
            var _loc_2:* = param1.getSubEntity(2, 0);
            if (_loc_2)
            {
                _loc_3 = _loc_2.getBone();
                if (_loc_3 == 1084)
                {
                    _loc_2.setBone(44);
                }
                else if (_loc_3 == 1068)
                {
                    _loc_2.setBone(113);
                }
                else if (_loc_3 == 1202)
                {
                    _loc_2.setBone(453);
                }
                else if (_loc_3 == 1575 || _loc_3 == 1576 || _loc_3 == 2)
                {
                    _loc_2.setBone(1);
                }
                return _loc_2;
            }
            return param1;
        }// end function

        public static function getEntityWithoutMount(param1:TiphonSprite) : DisplayObjectContainer
        {
            if (param1 == null)
            {
                return null;
            }
            var _loc_2:* = param1.getSubEntitySlot(2, 0);
            return _loc_2 == null ? (param1) : (_loc_2);
        }// end function

        public static function getFlipDirection(param1:int) : uint
        {
            if (param1 == 0)
            {
                return 4;
            }
            if (param1 == 1)
            {
                return 3;
            }
            if (param1 == 7)
            {
                return 5;
            }
            if (param1 == 4)
            {
                return 0;
            }
            if (param1 == 3)
            {
                return 1;
            }
            if (param1 == 5)
            {
                return 7;
            }
            return param1;
        }// end function

    }
}

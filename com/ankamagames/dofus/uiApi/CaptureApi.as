package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.graphics.codec.*;

    public class CaptureApi extends Object implements IApi
    {

        public function CaptureApi()
        {
            return;
        }// end function

        public static function getScreen(param1:Rectangle = null, param2:Number = 1) : BitmapData
        {
            return capture(StageShareManager.stage, param1, new Rectangle(0, 0, StageShareManager.startWidth, StageShareManager.startHeight), param2);
        }// end function

        public static function getBattleField(param1:Rectangle = null, param2:Number = 1) : BitmapData
        {
            return capture(Atouin.getInstance().worldContainer, param1, new Rectangle(0, 0, AtouinConstants.CELL_WIDTH * AtouinConstants.MAP_WIDTH, AtouinConstants.CELL_HEIGHT * AtouinConstants.MAP_HEIGHT), param2);
        }// end function

        public static function getFromTarget(param1:Object, param2:Rectangle = null, param3:Number = 1) : BitmapData
        {
            param1 = SecureCenter.unsecure(param1);
            if (!param1 || !(param1 is DisplayObject))
            {
                return null;
            }
            var _loc_4:* = param1 as DisplayObject;
            var _loc_5:* = (param1 as DisplayObject).getBounds(param1 as DisplayObject);
            if (!(param1 as DisplayObject).getBounds(param1 as DisplayObject).width || !_loc_5.height)
            {
                return null;
            }
            return capture(_loc_4, param2, _loc_5, param3);
        }// end function

        public static function jpegEncode(param1:BitmapData, param2:uint = 80, param3:Boolean = true, param4:String = "image.jpg") : ByteArray
        {
            var _loc_5:* = new JPEGEncoder(param2).encode(param1);
            if (param3 && AirScanner.hasAir())
            {
                File.desktopDirectory.save(_loc_5, param4);
            }
            return _loc_5;
        }// end function

        public static function pngEncode(param1:BitmapData, param2:Boolean = true, param3:String = "image.png") : ByteArray
        {
            var _loc_4:* = new PNGEncoder().encode(param1);
            if (param2 && AirScanner.hasAir())
            {
                File.desktopDirectory.save(_loc_4, param3);
            }
            return _loc_4;
        }// end function

        private static function capture(param1:DisplayObject, param2:Rectangle, param3:Rectangle, param4:Number = 1) : BitmapData
        {
            var _loc_5:Rectangle = null;
            var _loc_6:Matrix = null;
            var _loc_7:BitmapData = null;
            if (!param2)
            {
                _loc_5 = param3;
            }
            else
            {
                _loc_5 = param3.intersection(param2);
            }
            if (param1)
            {
                _loc_6 = new Matrix();
                _loc_6.scale(param4, param4);
                _loc_6.translate((-_loc_5.x) * param4, (-_loc_5.y) * param4);
                _loc_7 = new BitmapData(_loc_5.width * param4, _loc_5.height * param4);
                _loc_7.draw(param1, _loc_6);
                return _loc_7;
            }
            return null;
        }// end function

    }
}

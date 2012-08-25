package com.ankamagames.tiphon.display
{
    import flash.display.*;
    import flash.geom.*;

    public class RasterizedFrame extends Object
    {
        public var bitmapData:BitmapData;
        public var x:Number = 0;
        public var y:Number = 0;

        public function RasterizedFrame(param1:MovieClip, param2:int)
        {
            var _loc_4:BitmapData = null;
            var _loc_5:Matrix = null;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            param1.gotoAndStop((param2 + 1));
            var _loc_3:* = param1.getBounds(param1);
            if (_loc_3.width + _loc_3.height)
            {
                _loc_5 = new Matrix();
                _loc_6 = param1.scaleX;
                _loc_7 = param1.scaleY;
                _loc_8 = _loc_6 > 0 ? (_loc_3.width * _loc_6) : ((-_loc_3.width) * _loc_6);
                _loc_9 = _loc_7 > 0 ? (_loc_3.height * _loc_7) : ((-_loc_3.height) * _loc_7);
                _loc_10 = _loc_6 > 0 ? (_loc_3.x * _loc_6) : ((_loc_3.x + _loc_3.width) * _loc_6);
                _loc_11 = _loc_7 > 0 ? (_loc_3.y * _loc_7) : ((_loc_3.y + _loc_3.height) * _loc_7);
                _loc_5.scale(_loc_6, _loc_7);
                _loc_5.translate(-_loc_10, -_loc_11);
                this.x = _loc_10;
                this.y = _loc_11;
                _loc_4 = new BitmapData(_loc_8, _loc_9, true, 16777215);
                _loc_4.draw(param1, _loc_5, null, null, null, true);
            }
            else
            {
                _loc_4 = new BitmapData(1, 1, true, 16777215);
            }
            this.bitmapData = _loc_4;
            if (param1.currentFrame == param1.framesLoaded && param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        public function toString() : String
        {
            return "[RasterizedFrame " + this.x + "," + this.y + ": " + this.bitmapData + " (" + this.bitmapData.width + "/" + this.bitmapData.height + ")]";
        }// end function

    }
}

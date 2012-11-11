package com.ankamagames.jerakine.utils.display.spellZone
{
    import com.ankamagames.jerakine.utils.display.spellZone.*;

    public class ZoneEffect extends Object implements IZoneShape
    {
        private var _zoneSize:uint;
        private var _zoneShape:uint;

        public function ZoneEffect(param1:uint, param2:uint)
        {
            this._zoneSize = param1;
            this._zoneShape = param2;
            return;
        }// end function

        public function get zoneSize() : uint
        {
            return this._zoneSize;
        }// end function

        public function set zoneSize(param1:uint) : void
        {
            this._zoneSize = param1;
            return;
        }// end function

        public function get zoneShape() : uint
        {
            return this._zoneShape;
        }// end function

        public function set zoneShape(param1:uint) : void
        {
            this._zoneShape = param1;
            return;
        }// end function

    }
}

package com.ankamagames.jerakine.types.zones
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.utils.*;

    public class Custom extends Object implements IZone
    {
        private var _aCells:Vector.<uint>;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Custom));

        public function Custom(param1:Vector.<uint>)
        {
            this._aCells = param1;
            return;
        }// end function

        public function get radius() : uint
        {
            return null;
        }// end function

        public function set radius(param1:uint) : void
        {
            return;
        }// end function

        public function get surface() : uint
        {
            return this._aCells.length;
        }// end function

        public function set minRadius(param1:uint) : void
        {
            return;
        }// end function

        public function get minRadius() : uint
        {
            return null;
        }// end function

        public function set direction(param1:uint) : void
        {
            return;
        }// end function

        public function get direction() : uint
        {
            return null;
        }// end function

        public function getCells(param1:uint = 0) : Vector.<uint>
        {
            return this._aCells;
        }// end function

    }
}

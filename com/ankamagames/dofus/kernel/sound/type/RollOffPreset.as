package com.ankamagames.dofus.kernel.sound.type
{

    public class RollOffPreset extends Object
    {
        private var _maxVolume:uint;
        private var _maxRange:uint;
        private var _maxSaturationRange:uint;

        public function RollOffPreset(param1:uint, param2:uint, param3:uint)
        {
            this._maxVolume = param1;
            this._maxRange = param2;
            this._maxSaturationRange = param3;
            return;
        }// end function

        public function get maxVolume() : uint
        {
            return this._maxVolume;
        }// end function

        public function get maxRange() : uint
        {
            return this._maxRange;
        }// end function

        public function get maxSaturationRange() : uint
        {
            return this._maxSaturationRange;
        }// end function

    }
}

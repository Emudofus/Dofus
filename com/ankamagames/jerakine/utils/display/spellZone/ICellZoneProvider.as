package com.ankamagames.jerakine.utils.display.spellZone
{
    import __AS3__.vec.*;

    public interface ICellZoneProvider
    {

        public function ICellZoneProvider();

        function get minimalRange() : uint;

        function get maximalRange() : uint;

        function get castZoneInLine() : Boolean;

        function get spellZoneEffects() : Vector.<IZoneShape>;

    }
}

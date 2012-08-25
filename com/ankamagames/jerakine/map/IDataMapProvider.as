package com.ankamagames.jerakine.map
{

    public interface IDataMapProvider
    {

        public function IDataMapProvider();

        function get width() : int;

        function get height() : int;

        function pointLos(param1:int, param2:int, param3:Boolean = true) : Boolean;

        function pointMov(param1:int, param2:int, param3:Boolean = true) : Boolean;

        function farmCell(param1:int, param2:int) : Boolean;

        function pointSpecialEffects(param1:int, param2:int) : uint;

        function pointWeight(param1:int, param2:int, param3:Boolean = true) : Number;

        function hasEntity(param1:int, param2:int) : Boolean;

        function updateCellMovLov(param1:uint, param2:Boolean) : void;

    }
}

package com.ankamagames.jerakine.entities.interfaces
{

    public interface IAnimated
    {

        public function IAnimated();

        function getDirection() : uint;

        function setDirection(param1:uint) : void;

        function getAnimation() : String;

        function setAnimation(param1:String) : void;

        function setAnimationAndDirection(param1:String, param2:uint) : void;

    }
}

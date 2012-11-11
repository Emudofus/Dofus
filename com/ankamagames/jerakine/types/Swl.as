package com.ankamagames.jerakine.types
{
    import flash.system.*;

    public class Swl extends Object
    {
        private var _frameRate:uint;
        private var _classesList:Array;
        private var _applicationDomain:ApplicationDomain;

        public function Swl(param1:uint, param2:Array, param3:ApplicationDomain)
        {
            this._frameRate = param1;
            this._classesList = param2;
            this._applicationDomain = param3;
            return;
        }// end function

        public function get frameRate() : uint
        {
            return this._frameRate;
        }// end function

        public function getDefinition(param1:String) : Object
        {
            return this._applicationDomain.getDefinition(param1);
        }// end function

        public function hasDefinition(param1:String) : Boolean
        {
            return this._applicationDomain.hasDefinition(param1);
        }// end function

        public function getDefinitions() : Array
        {
            return this._classesList;
        }// end function

    }
}

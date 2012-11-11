package com.ankamagames.jerakine.types
{
    import flash.display.*;
    import flash.system.*;

    public class ASwf extends Object
    {
        private var _content:DisplayObject;
        private var _appDomain:ApplicationDomain;
        private var _loaderWidth:Number;
        private var _loaderHeight:Number;

        public function ASwf(param1:DisplayObject, param2:ApplicationDomain, param3:Number, param4:Number)
        {
            this._content = param1;
            this._appDomain = param2;
            this._loaderWidth = param3;
            this._loaderHeight = param4;
            return;
        }// end function

        public function get content() : DisplayObject
        {
            return this._content;
        }// end function

        public function get applicationDomain() : ApplicationDomain
        {
            return this._appDomain;
        }// end function

        public function get loaderWidth() : Number
        {
            return this._loaderWidth;
        }// end function

        public function get loaderHeight() : Number
        {
            return this._loaderHeight;
        }// end function

    }
}

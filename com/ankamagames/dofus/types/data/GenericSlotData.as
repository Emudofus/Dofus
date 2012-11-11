package com.ankamagames.dofus.types.data
{
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.types.*;

    dynamic public class GenericSlotData extends Object implements ISlotData
    {
        private var _iconUri:Uri;
        private var _fullSizeIconUri:Uri;
        private var _errorIconUri:Uri;
        private var _info1:String;
        private var _active:Boolean;
        private var _timer:int;

        public function GenericSlotData(param1:Uri = null, param2:Uri = null, param3:Uri = null, param4:String = null, param5:Boolean = true, param6:int = 0)
        {
            this._iconUri = param1;
            this._fullSizeIconUri = param2;
            this._errorIconUri = param3;
            this._info1 = param4;
            this._active = param5;
            this._timer = param6;
            return;
        }// end function

        public function set fullSizeIconUri(param1:Uri) : void
        {
            this._fullSizeIconUri = param1;
            return;
        }// end function

        public function set errorIconUri(param1:Uri) : void
        {
            this._errorIconUri = param1;
            return;
        }// end function

        public function set info1(param1:String) : void
        {
            this._info1 = param1;
            return;
        }// end function

        public function set timer(param1:int) : void
        {
            this._timer = param1;
            return;
        }// end function

        public function set active(param1:Boolean) : void
        {
            this._active = param1;
            return;
        }// end function

        public function set iconUri(param1:Uri) : void
        {
            this._iconUri = param1;
            return;
        }// end function

        public function get iconUri() : Uri
        {
            return this._iconUri;
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            return this._fullSizeIconUri;
        }// end function

        public function get errorIconUri() : Uri
        {
            return this._errorIconUri;
        }// end function

        public function get info1() : String
        {
            return this._info1;
        }// end function

        public function get timer() : int
        {
            return this._timer;
        }// end function

        public function get active() : Boolean
        {
            return this._active;
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

    }
}

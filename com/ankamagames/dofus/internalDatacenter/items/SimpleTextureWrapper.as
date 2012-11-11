package com.ankamagames.dofus.internalDatacenter.items
{
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class SimpleTextureWrapper extends Object implements ISlotData, IDataCenter
    {
        private var _uri:Uri;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(SimpleTextureWrapper));

        public function SimpleTextureWrapper()
        {
            return;
        }// end function

        public function get iconUri() : Uri
        {
            return this._uri;
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            return this._uri;
        }// end function

        public function get errorIconUri() : Uri
        {
            return null;
        }// end function

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        public function get info1() : String
        {
            return null;
        }// end function

        public function get timer() : int
        {
            return 0;
        }// end function

        public function get active() : Boolean
        {
            return true;
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public static function create(param1:Uri) : SimpleTextureWrapper
        {
            var _loc_2:* = new SimpleTextureWrapper;
            _loc_2._uri = param1;
            return _loc_2;
        }// end function

    }
}

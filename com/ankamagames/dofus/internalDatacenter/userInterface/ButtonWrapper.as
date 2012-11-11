package com.ankamagames.dofus.internalDatacenter.userInterface
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class ButtonWrapper extends Proxy implements IDataCenter, ISlotData
    {
        private var _uri:Uri;
        private var _active:Boolean = true;
        public var position:uint;
        public var id:uint = 0;
        public var uriName:String;
        public var callback:Function;
        public var name:String;
        public var shortcut:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ButtonWrapper));

        public function ButtonWrapper()
        {
            return;
        }// end function

        public function get iconUri() : Uri
        {
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets.swf|").concat(this.uriName));
            }
            return this._uri;
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets.swf|").concat(this.uriName));
            }
            return this._uri;
        }// end function

        public function get backGroundIconUri() : Uri
        {
            return null;
        }// end function

        public function get errorIconUri() : Uri
        {
            return null;
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
            return this._active;
        }// end function

        public function set active(param1:Boolean) : void
        {
            this._active = param1;
            return;
        }// end function

        override function getProperty(param1)
        {
            if (isAttribute(param1))
            {
                return this[param1];
            }
            return "Error_on_buttonWrapper_" + param1;
        }// end function

        override function hasProperty(param1) : Boolean
        {
            return isAttribute(param1);
        }// end function

        public function toString() : String
        {
            return "[ButtonWrapper#" + this.id + "]";
        }// end function

        public function setPosition(param1:int) : void
        {
            this.position = param1;
            return;
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public function getIconUri(param1:Boolean = true) : Uri
        {
            return this.iconUri;
        }// end function

        public static function create(param1:uint, param2:int, param3:String, param4:Function, param5:String, param6:String = "") : ButtonWrapper
        {
            var _loc_7:* = new ButtonWrapper;
            new ButtonWrapper.id = param1;
            _loc_7.position = param2;
            _loc_7.callback = param4;
            _loc_7.uriName = param3;
            _loc_7.name = param5;
            _loc_7.shortcut = param6;
            return _loc_7;
        }// end function

        public static function getButtonWrapperById(param1:uint) : ButtonWrapper
        {
            return null;
        }// end function

    }
}

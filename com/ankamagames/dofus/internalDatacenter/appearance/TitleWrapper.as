package com.ankamagames.dofus.internalDatacenter.appearance
{
    import com.ankamagames.dofus.datacenter.appearance.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class TitleWrapper extends Proxy implements IDataCenter, ISlotData
    {
        private var _uri:Uri;
        public var id:uint = 0;
        public var text:String;
        public var isOkForMultiUse:Boolean = false;
        public var quantity:uint = 1;
        private static var _cache:Array = new Array();
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TitleWrapper));

        public function TitleWrapper()
        {
            return;
        }// end function

        public function get iconUri() : Uri
        {
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/illusUi/genericTitleIcon.png"));
            }
            return this._uri;
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/illusUi/genericTitleIcon.png"));
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

        public function set timerToStart(param1:int) : void
        {
            return;
        }// end function

        public function get active() : Boolean
        {
            return true;
        }// end function

        public function get title() : Title
        {
            return Title.getTitleById(this.id);
        }// end function

        public function get titleId() : uint
        {
            return this.id;
        }// end function

        public function get isUsable() : Boolean
        {
            return false;
        }// end function

        override function getProperty(param1)
        {
            var t:*;
            var r:*;
            var name:* = param1;
            if (isAttribute(name))
            {
                return this[name];
            }
            t = this.title;
            if (!t)
            {
                r;
            }
            try
            {
                return t[name];
            }
            catch (e:Error)
            {
                return "Error_on_item_" + name;
            }
            return;
        }// end function

        override function hasProperty(param1) : Boolean
        {
            return isAttribute(param1);
        }// end function

        public function toString() : String
        {
            return "[TitleWrapper#" + this.id + "]";
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
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/illusUi/genericTitleIcon.png"));
            }
            return this._uri;
        }// end function

        public static function create(param1:uint, param2:int = -1, param3:Boolean = true) : TitleWrapper
        {
            var _loc_4:* = new TitleWrapper;
            if (!_cache[param1] || !param3)
            {
                _loc_4 = new TitleWrapper;
                _loc_4.id = param1;
                if (param3)
                {
                    _cache[param1] = _loc_4;
                }
            }
            else
            {
                _loc_4 = _cache[param1];
            }
            _loc_4.id = param1;
            _loc_4.text = _loc_4.text;
            return _loc_4;
        }// end function

        public static function getTitleWrapperById(param1:uint) : TitleWrapper
        {
            return _cache[param1];
        }// end function

    }
}

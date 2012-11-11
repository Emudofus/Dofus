package com.ankamagames.dofus.internalDatacenter.guild
{
    import com.ankamagames.dofus.datacenter.guild.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class EmblemWrapper extends Proxy implements IDataCenter, ISlotData
    {
        private var _uri:Uri;
        private var _fullSizeUri:Uri;
        private var _color:uint;
        private var _type:uint;
        public var idEmblem:uint;
        public var order:int;
        public var category:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemWrapper));
        private static var _cache:Array = new Array();
        public static const UP:uint = 1;
        public static const BACK:uint = 2;

        public function EmblemWrapper()
        {
            return;
        }// end function

        public function get iconUri() : Uri
        {
            return this._uri;
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            return this._fullSizeUri;
        }// end function

        public function get backGroundIconUri() : Uri
        {
            return new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/emptySlot.png"));
        }// end function

        public function set backGroundIconUri(param1:Uri) : void
        {
            return;
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

        public function get type() : uint
        {
            return this._type;
        }// end function

        public function get color() : uint
        {
            return this._color;
        }// end function

        public function get errorIconUri() : Uri
        {
            return null;
        }// end function

        public function update(param1:uint, param2:uint, param3:uint = 0) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this.idEmblem = param1;
            this._type = param2;
            switch(param2)
            {
                case UP:
                {
                    _loc_7 = EmblemSymbol.getEmblemSymbolById(param1);
                    _loc_6 = _loc_7.iconId;
                    this.order = _loc_7.order;
                    this.category = _loc_7.categoryId;
                    _loc_4 = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small") + "up/";
                    _loc_5 = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large") + "up/";
                    break;
                }
                case BACK:
                {
                    _loc_8 = EmblemBackground.getEmblemBackgroundById(param1);
                    this.order = _loc_8.order;
                    _loc_6 = param1;
                    _loc_4 = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small") + "back/";
                    _loc_5 = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large") + "back/";
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._uri = new Uri(_loc_4 + _loc_6 + ".png");
            this._fullSizeUri = new Uri(_loc_5 + _loc_6 + ".swf");
            this._color = param3;
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

        public static function create(param1:uint, param2:uint, param3:uint = 0, param4:Boolean = false) : EmblemWrapper
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (!_cache[param1] || !param4)
            {
                _loc_5 = new EmblemWrapper;
                _loc_5.idEmblem = param1;
                if (param4)
                {
                    _cache[param1] = _loc_5;
                }
            }
            else
            {
                _loc_5 = _cache[param1];
            }
            _loc_5._type = param2;
            switch(param2)
            {
                case UP:
                {
                    _loc_9 = EmblemSymbol.getEmblemSymbolById(param1);
                    _loc_8 = _loc_9.iconId;
                    _loc_5.order = _loc_9.order;
                    _loc_5.category = _loc_9.categoryId;
                    _loc_6 = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small") + "up/";
                    _loc_7 = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large") + "up/";
                    break;
                }
                case BACK:
                {
                    _loc_10 = EmblemBackground.getEmblemBackgroundById(param1);
                    _loc_5.order = _loc_10.order;
                    _loc_8 = param1;
                    _loc_6 = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small") + "back/";
                    _loc_7 = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large") + "back/";
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_5._uri = new Uri(_loc_6 + _loc_8 + ".png");
            _loc_5._fullSizeUri = new Uri(_loc_7 + _loc_8 + ".swf");
            _loc_5._color = param3;
            return _loc_5;
        }// end function

        public static function getEmblemFromId(param1:uint) : EmblemWrapper
        {
            return _cache[param1];
        }// end function

    }
}

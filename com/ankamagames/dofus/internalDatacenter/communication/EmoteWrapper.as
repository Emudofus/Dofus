package com.ankamagames.dofus.internalDatacenter.communication
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class EmoteWrapper extends Proxy implements IDataCenter, ISlotData
    {
        private var _uri:Uri;
        private var _slotDataHolderManager:SlotDataHolderManager;
        private var _timerDuration:int = 0;
        private var _timerStartTime:int = 0;
        public var position:uint;
        public var id:uint = 0;
        public var gfxId:int;
        public var isOkForMultiUse:Boolean = false;
        public var quantity:uint = 1;
        private static var _cache:Array = new Array();
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EmoteWrapper));

        public function EmoteWrapper()
        {
            return;
        }// end function

        public function get iconUri() : Uri
        {
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/emotes/").concat(this.id).concat(".png"));
            }
            return this._uri;
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/emotes/").concat(this.id).concat(".png"));
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
            var _loc_1:* = this._timerStartTime + this._timerDuration - getTimer();
            if (_loc_1 > 0)
            {
                return _loc_1;
            }
            return 0;
        }// end function

        public function set timerToStart(param1:int) : void
        {
            this._timerDuration = param1;
            this._timerStartTime = getTimer();
            this._slotDataHolderManager.refreshAll();
            return;
        }// end function

        public function get active() : Boolean
        {
            var _loc_1:* = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
            return _loc_1.isKnownEmote(this.id);
        }// end function

        public function get emote() : Emoticon
        {
            return Emoticon.getEmoticonById(this.id);
        }// end function

        public function get emoteId() : uint
        {
            return this.id;
        }// end function

        public function get isUsable() : Boolean
        {
            return true;
        }// end function

        override function getProperty(param1)
        {
            var l:*;
            var r:*;
            var name:* = param1;
            if (isAttribute(name))
            {
                return this[name];
            }
            l = this.emote;
            if (!l)
            {
                r;
            }
            try
            {
                return l[name];
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
            return "[EmoteWrapper#" + this.id + "]";
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            this._slotDataHolderManager.addHolder(param1);
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            this._slotDataHolderManager.removeHolder(param1);
            return;
        }// end function

        public function setLinkedSlotData(param1:ISlotData) : void
        {
            this._slotDataHolderManager.setLinkedSlotData(param1);
            return;
        }// end function

        public function getIconUri(param1:Boolean = true) : Uri
        {
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/emotes/").concat(this.id).concat(".png"));
            }
            return this._uri;
        }// end function

        public static function create(param1:uint, param2:int = -1, param3:Boolean = true) : EmoteWrapper
        {
            var _loc_4:* = new EmoteWrapper;
            if (!_cache[param1] || !param3)
            {
                _loc_4 = new EmoteWrapper;
                _loc_4.id = param1;
                if (param3)
                {
                    _cache[param1] = _loc_4;
                }
                _loc_4._slotDataHolderManager = new SlotDataHolderManager(_loc_4);
            }
            else
            {
                _loc_4 = _cache[param1];
            }
            _loc_4.id = param1;
            _loc_4.gfxId = param1;
            if (param2 >= 0)
            {
                _loc_4.position = param2;
            }
            return _loc_4;
        }// end function

        public static function refreshAllEmoteHolders() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _cache)
            {
                
                _loc_1._slotDataHolderManager.refreshAll();
            }
            return;
        }// end function

        public static function getEmoteWrapperById(param1:uint) : EmoteWrapper
        {
            return _cache[param1];
        }// end function

    }
}

package com.ankamagames.dofus.internalDatacenter.guild
{
    import flash.utils.Proxy;
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.interfaces.ISlotData;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
    import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
    import com.ankamagames.dofus.datacenter.guild.EmblemBackground;

    public class EmblemWrapper extends Proxy implements IDataCenter, ISlotData 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemWrapper));
        private static var _cache:Array = new Array();
        public static const UP:uint = 1;
        public static const BACK:uint = 2;

        private var _uri:Uri;
        private var _fullSizeUri:Uri;
        private var _color:uint;
        private var _type:uint;
        private var _order:int;
        private var _category:int;
        private var _isInit:Boolean;
        public var idEmblem:uint;


        public static function fromNetwork(msg:GuildEmblem, background:Boolean):EmblemWrapper
        {
            var o:EmblemWrapper = new (EmblemWrapper)();
            if (background)
            {
                o.idEmblem = msg.backgroundShape;
                o._color = msg.backgroundColor;
                o._type = BACK;
            }
            else
            {
                o.idEmblem = msg.symbolShape;
                o._color = msg.symbolColor;
                o._type = UP;
            };
            return (o);
        }

        public static function create(pIdEmblem:uint, pType:uint, pColor:uint=0, useCache:Boolean=false):EmblemWrapper
        {
            var emblem:EmblemWrapper;
            if (((!(_cache[pIdEmblem])) || (!(useCache))))
            {
                emblem = new (EmblemWrapper)();
                emblem.idEmblem = pIdEmblem;
                if (useCache)
                {
                    _cache[pIdEmblem] = emblem;
                };
            }
            else
            {
                emblem = _cache[pIdEmblem];
            };
            emblem._type = pType;
            emblem._color = pColor;
            emblem._isInit = false;
            return (emblem);
        }

        public static function getEmblemFromId(emblemId:uint):EmblemWrapper
        {
            return (_cache[emblemId]);
        }


        public function get category():int
        {
            this.init();
            return (this._category);
        }

        public function get order():int
        {
            this.init();
            return (this._order);
        }

        public function get iconUri():Uri
        {
            this.init();
            return (this._uri);
        }

        public function get fullSizeIconUri():Uri
        {
            this.init();
            return (this._fullSizeUri);
        }

        public function get backGroundIconUri():Uri
        {
            return (new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/emptySlot.png")));
        }

        public function set backGroundIconUri(bgUri:Uri):void
        {
        }

        public function get info1():String
        {
            return (null);
        }

        public function get startTime():int
        {
            return (0);
        }

        public function get endTime():int
        {
            return (0);
        }

        public function set endTime(t:int):void
        {
        }

        public function get timer():int
        {
            return (0);
        }

        public function get active():Boolean
        {
            return (true);
        }

        public function get type():uint
        {
            return (this._type);
        }

        public function get color():uint
        {
            return (this._color);
        }

        public function get errorIconUri():Uri
        {
            return (null);
        }

        public function update(pIdEmblem:uint, pType:uint, pColor:uint=0):void
        {
            this.idEmblem = pIdEmblem;
            this._type = pType;
            this._color = pColor;
            this._isInit = false;
        }

        public function addHolder(h:ISlotDataHolder):void
        {
        }

        public function removeHolder(h:ISlotDataHolder):void
        {
        }

        private function init():void
        {
            var path:String;
            var pathFullSize:String;
            var iconId:int;
            var _local_4:EmblemSymbol;
            var _local_5:EmblemBackground;
            if (this._isInit)
            {
                return;
            };
            switch (this._type)
            {
                case UP:
                    _local_4 = EmblemSymbol.getEmblemSymbolById(this.idEmblem);
                    iconId = _local_4.iconId;
                    this._order = _local_4.order;
                    this._category = _local_4.categoryId;
                    path = (XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small") + "up/");
                    pathFullSize = (XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large") + "up/");
                    break;
                case BACK:
                    _local_5 = EmblemBackground.getEmblemBackgroundById(this.idEmblem);
                    this._order = _local_5.order;
                    iconId = this.idEmblem;
                    path = (XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small") + "back/");
                    pathFullSize = (XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large") + "back/");
                    break;
            };
            this._uri = new Uri(((path + iconId) + ".png"));
            this._fullSizeUri = new Uri(((pathFullSize + iconId) + ".swf"));
            this._isInit = true;
        }


    }
}//package com.ankamagames.dofus.internalDatacenter.guild


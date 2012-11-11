package com.ankamagames.dofus.logic.game.common.managers
{
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.internalDatacenter.almanax.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.types.events.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.utils.*;

    public class AlmanaxManager extends Object
    {
        private var _rpcService:RpcServiceManager;
        private var _currentEvent:AlmanaxEvent;
        private var _currentMonth:AlmanaxMonth;
        private var _currentZodiac:AlmanaxZodiac;
        private var _ds:DataStoreType;
        private static var _self:AlmanaxManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlmanaxManager));

        public function AlmanaxManager()
        {
            this._ds = new DataStoreType("AlmanaxCache", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
            if (_self)
            {
                throw new SingletonError();
            }
            var _loc_1:* = StoreDataManager.getInstance().getSetData(this._ds, "cacheDate", new Date(2000));
            var _loc_2:* = new Date();
            if (_loc_1.day != _loc_2.day || _loc_2.time - _loc_1.time > 7200000)
            {
                if (BuildInfos.BUILD_TYPE >= BuildTypeEnum.INTERNAL)
                {
                    this._rpcService = new RpcServiceManager("http://api.ankama.lan/krosmoz/event.json", "json");
                }
                else
                {
                    this._rpcService = new RpcServiceManager("http://api.ankama.com/krosmoz/event.json", "json");
                }
                this._rpcService.addEventListener(Event.COMPLETE, this.onData);
                this._rpcService.addEventListener(RpcEvent.ERROR, this.onError);
                this._rpcService.callMethod("GetEvent", [LangManager.getInstance().getEntry("config.lang.current")]);
            }
            else
            {
                this._currentEvent = StoreDataManager.getInstance().getData(this._ds, "currentEvent");
                this._currentMonth = StoreDataManager.getInstance().getData(this._ds, "currentMonth");
                this._currentZodiac = StoreDataManager.getInstance().getData(this._ds, "currentZodiac");
            }
            return;
        }// end function

        public function get event() : AlmanaxEvent
        {
            return this._currentEvent;
        }// end function

        public function get month() : AlmanaxMonth
        {
            return this._currentMonth;
        }// end function

        public function get zodiac() : AlmanaxZodiac
        {
            return this._currentZodiac;
        }// end function

        private function onData(event:Event) : void
        {
            var _loc_2:* = this._rpcService.getResultData("event");
            var _loc_3:* = this._rpcService.getResultData("month");
            var _loc_4:* = this._rpcService.getResultData("zodiac");
            this._currentEvent = new AlmanaxEvent();
            this.event.bossText = _loc_2.bosstext;
            this.event.ephemeris = _loc_2.ephemeris;
            this.event.festText = _loc_2.festtext;
            this.event.id = _loc_2.id;
            this.event.name = _loc_2.name;
            this.event.rubrikabrax = _loc_2.rubrikabrax;
            this.event.webImageUrl = _loc_2.imageurl;
            this._currentMonth = new AlmanaxMonth();
            this.month.id = _loc_3.id;
            this.month.monthNum = _loc_3.month;
            this.month.protectorDescription = _loc_3.protectordesc;
            this.month.protectorName = _loc_3.protectorname;
            this.month.webImageUrl = _loc_3.protectorimageurl;
            this._currentZodiac = new AlmanaxZodiac();
            this.zodiac.id = _loc_4.id;
            this.zodiac.name = _loc_4.name;
            this.zodiac.webImageUrl = _loc_4.imageurl;
            this.zodiac.description = _loc_4.description;
            StoreDataManager.getInstance().setData(this._ds, "currentEvent", this._currentEvent);
            StoreDataManager.getInstance().setData(this._ds, "currentMonth", this._currentMonth);
            StoreDataManager.getInstance().setData(this._ds, "currentZodiac", this._currentZodiac);
            StoreDataManager.getInstance().setData(this._ds, "cacheDate", new Date());
            return;
        }// end function

        private function onError(event:Event) : void
        {
            this._currentEvent = new AlmanaxEvent();
            this.event.bossText = "ui.almanax.default.boss";
            this.event.ephemeris = "ui.almanax.default.ephemeris";
            this.event.festText = "";
            this.event.name = "";
            this.event.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/jour.jpg");
            this._currentMonth = new AlmanaxMonth();
            this.month.protectorDescription = "ui.almanax.default.protector";
            this.month.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/protecteur.jpg");
            this._currentZodiac = new AlmanaxZodiac();
            this.zodiac.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/constellation.jpg");
            this.zodiac.description = "ui.almanax.default.zodiac";
            StoreDataManager.getInstance().setData(this._ds, "currentEvent", this._currentEvent);
            StoreDataManager.getInstance().setData(this._ds, "currentMonth", this._currentMonth);
            StoreDataManager.getInstance().setData(this._ds, "currentZodiac", this._currentZodiac);
            StoreDataManager.getInstance().setData(this._ds, "cacheDate", new Date());
            return;
        }// end function

        public static function getInstance() : AlmanaxManager
        {
            if (!_self)
            {
                _self = new AlmanaxManager;
            }
            return _self;
        }// end function

    }
}

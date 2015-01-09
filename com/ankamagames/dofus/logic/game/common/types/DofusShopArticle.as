package com.ankamagames.dofus.logic.game.common.types
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.types.Uri;
    import flash.utils.Timer;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;

    public class DofusShopArticle extends DofusShopObject implements IDataCenter 
    {

        private static const date_regexp:RegExp = new RegExp(/\-/g);

        private var _subtitle:String;
        private var _price:Number;
        private var _originalPrice:Number;
        private var _endDate:Date;
        private var _currency:String;
        private var _stock:int;
        private var _imgSmall:String;
        private var _imgNormal:String;
        private var _imgSwf:Uri;
        private var _references:Array;
        private var _promo:Array;
        private var _endTimer:Timer;
        private var _gids:Array;
        private var _isNew:Boolean;
        private var _hasExpired:Boolean;

        public function DofusShopArticle(data:Object)
        {
            super(data);
        }

        override public function init(data:Object):void
        {
            var dateStr:String;
            var expirationTime:Number;
            var remainingTime:Number;
            var ref:Object;
            var startDate:Date;
            var content:Object;
            var iw:ItemWrapper;
            super.init(data);
            this._subtitle = data.subtitle;
            this._price = data.price;
            this._originalPrice = data.original_price;
            this._isNew = false;
            var currentTime:Number = new Date().getTime();
            if (data.startdate)
            {
                dateStr = data.startdate;
                dateStr = dateStr.replace(date_regexp, "/");
                startDate = new Date(Date.parse(dateStr));
                expirationTime = startDate.getTime();
                remainingTime = (currentTime - expirationTime);
                this._isNew = (((remainingTime > 0)) && ((remainingTime < 0x337F9800)));
            };
            if (data.enddate)
            {
                dateStr = data.enddate;
                dateStr = dateStr.replace(date_regexp, "/");
                this._endDate = new Date(Date.parse(dateStr));
                expirationTime = this._endDate.getTime();
                remainingTime = (expirationTime - currentTime);
                if (remainingTime <= 0)
                {
                    this._hasExpired = true;
                }
                else
                {
                    if (remainingTime <= 43200000)
                    {
                        this._endTimer = new Timer(remainingTime, 1);
                        this._endTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onEndDate);
                        this._endTimer.start();
                    };
                };
            };
            this._currency = data.currency;
            this._stock = (((data.stock == null)) ? -1 : data.stock);
            this._references = data.references;
            this._gids = [];
            for each (ref in this._references)
            {
                if (((((ref) && ((typeof(ref) == "object")))) && (ref.hasOwnProperty("content"))))
                {
                    for each (content in ref.content)
                    {
                        if (((((content) && ((typeof(content) == "object")))) && (content.hasOwnProperty("id"))))
                        {
                            this._gids.push(parseInt(content.id));
                        };
                    };
                };
            };
            if (this._gids.length == 1)
            {
                iw = ItemWrapper.create(0, 0, this._gids[0], 1, null, false);
                this._imgSwf = iw.getIconUri(false);
            };
            if (data.image)
            {
                this._imgSmall = data.image["70_70"];
                this._imgNormal = data.image["200_200"];
            };
            this._promo = data.promo;
        }

        protected function onEndDate(event:TimerEvent):void
        {
            this._endTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onEndDate);
            DofusShopManager.getInstance().updateAfterExpiredArticle(id);
        }

        override public function free():void
        {
            if (this._endTimer)
            {
                this._endTimer.stop();
                this._endTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onEndDate);
                this._endTimer = null;
            };
            this._subtitle = null;
            this._price = 0;
            this._originalPrice = 0;
            this._endDate = null;
            this._currency = null;
            this._stock = 0;
            this._imgSmall = null;
            this._imgNormal = null;
            this._references = null;
            this._promo = null;
            this._gids = null;
            super.free();
        }

        public function get subtitle():String
        {
            return (this._subtitle);
        }

        public function get price():Number
        {
            return (this._price);
        }

        public function get originalPrice():Number
        {
            return (this._originalPrice);
        }

        public function get endDate():Date
        {
            return (this._endDate);
        }

        public function get currency():String
        {
            return (this._currency);
        }

        public function get stock():int
        {
            return (this._stock);
        }

        public function get imageSmall():String
        {
            return (this._imgSmall);
        }

        public function get imageSwf():Uri
        {
            return (this._imgSwf);
        }

        public function get imageNormal():String
        {
            return (this._imgNormal);
        }

        public function get references():Array
        {
            return (this._references);
        }

        public function get gids():Array
        {
            return (this._gids);
        }

        public function get promo():Array
        {
            return (this._promo);
        }

        public function get isNew():Boolean
        {
            return (this._isNew);
        }

        public function get hasExpired():Boolean
        {
            return (this._hasExpired);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.types


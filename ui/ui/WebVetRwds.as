package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.TimeApi;
    import d2data.ItemWrapper;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import d2components.Label;
    import d2components.Texture;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Grid;
    import d2data.VeteranReward;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    import d2enums.LocationEnum;

    public class WebVetRwds 
    {

        private static const DAYS_PER_YEAR:uint = 360;
        private static const SECONDS_PER_DAY:uint = 86400;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var timeApi:TimeApi;
        private var _subscriptionDurationElapsed:Number;
        private var _subscriptionEndDate:Number;
        private var _allRewards:Array;
        private var _remainingTime:uint;
        private var _lastTime:uint;
        private var _lastRwd:ItemWrapper;
        private var _nextRwd:ItemWrapper;
        private var _timer:Timer;
        private var _interactiveComponentsList:Dictionary;
        public var lbl_subscriptionDuration:Label;
        public var tx_lastRwd:Texture;
        public var tx_nextRwd:Texture;
        public var tx_lastRwdSlot:Texture;
        public var tx_nextRwdSlot:Texture;
        public var lbl_lastRwd:Label;
        public var lbl_remainingTime:Label;
        public var lbl_remainingSub:Label;
        public var lbl_moreInfo:Label;
        public var ctr_noEnoughSub:GraphicContainer;
        public var btn_addSub:ButtonContainer;
        public var lbl_enoughSub:Label;
        public var lbl_month1:Label;
        public var lbl_month3:Label;
        public var lbl_month6:Label;
        public var lbl_month9:Label;
        public var gd_rewards:Grid;

        public function WebVetRwds()
        {
            this._allRewards = new Array();
            this._interactiveComponentsList = new Dictionary(true);
            super();
        }

        public function main(oParam:Object=null):void
        {
            var rwd:VeteranReward;
            this.uiApi.addComponentHook(this.tx_lastRwdSlot, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_lastRwdSlot, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_lastRwd, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_lastRwd, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_nextRwdSlot, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_nextRwdSlot, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_nextRwd, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_nextRwd, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_moreInfo, ComponentHookList.ON_RELEASE);
            var allDataRewards:Object = this.dataApi.getAllVeteranRewards();
            var yearlyRwds:Array = new Array();
            var year:uint = 1;
            for each (rwd in allDataRewards)
            {
                this._allRewards.push(rwd);
            };
            this._allRewards.sortOn("requiredSubDays", Array.NUMERIC);
            yearlyRwds.push({
                "text":this.uiApi.getText("ui.veteran.year", year),
                "items":[]
            });
            for each (rwd in this._allRewards)
            {
                if (rwd.requiredSubDays < (year * DAYS_PER_YEAR))
                {
                    yearlyRwds[(year - 1)].items.push(rwd.item);
                }
                else
                {
                    year++;
                    yearlyRwds.push({
                        "text":this.uiApi.getText("ui.veteran.year", year),
                        "items":[rwd.item]
                    });
                };
            };
            this.gd_rewards.dataProvider = yearlyRwds;
            this.lbl_month1.text = this.uiApi.processText(this.uiApi.getText("ui.social.monthsSinceLastConnection", 1), "", true);
            this.lbl_month3.text = this.uiApi.processText(this.uiApi.getText("ui.social.monthsSinceLastConnection", 3), "", false);
            this.lbl_month6.text = this.uiApi.processText(this.uiApi.getText("ui.social.monthsSinceLastConnection", 6), "", false);
            this.lbl_month9.text = this.uiApi.processText(this.uiApi.getText("ui.social.monthsSinceLastConnection", 9), "", false);
            this.refreshSubscriberDuration();
        }

        public function unload():void
        {
            if (this._timer)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.onTimerTick);
            };
        }

        public function updateRwdLine(data:*, components:*, selected:Boolean):void
        {
            var i:int;
            while (i < 6)
            {
                if (!(this._interactiveComponentsList[components[("slot" + i)].name]))
                {
                    this.uiApi.addComponentHook(components[("slot" + i)], ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(components[("slot" + i)], ComponentHookList.ON_ROLL_OUT);
                };
                this._interactiveComponentsList[components[("slot" + i)].name] = ((data) ? data.items[i] : null);
                i++;
            };
            if (data)
            {
                components.lbl_year.text = data.text;
                i = 0;
                while (i < 6)
                {
                    if (data.items[i])
                    {
                        components[("slot" + i)].data = data.items[i];
                    }
                    else
                    {
                        components[("slot" + i)].data = null;
                    };
                    i++;
                };
            }
            else
            {
                components.lbl_year.text = "";
                i = 0;
                while (i < 6)
                {
                    components[("slot" + i)].data = null;
                    i++;
                };
            };
        }

        private function refreshSubscriberDuration():void
        {
            var rwd:VeteranReward;
            var days:int;
            var years:int;
            var months:int;
            var durationText:String;
            var remainingDays:uint;
            this._subscriptionDurationElapsed = this.sysApi.getPlayerManager().subscriptionDurationElapsed;
            this._subscriptionEndDate = this.sysApi.getPlayerManager().subscriptionEndDate;
            if (this._subscriptionDurationElapsed == 0)
            {
                this.lbl_subscriptionDuration.text = this.uiApi.getText("ui.common.none");
            }
            else
            {
                days = Math.floor((this._subscriptionDurationElapsed / SECONDS_PER_DAY));
                years = Math.floor((days / 360));
                months = Math.floor(((days - (years * 360)) / 30));
                days = ((days - (years * 360)) - (months * 30));
                durationText = "";
                if (years > 0)
                {
                    durationText = (durationText + this.uiApi.processText(this.uiApi.getText("ui.veteran.years", years), "m", (years <= 1)));
                };
                if (months > 0)
                {
                    if (durationText.length > 0)
                    {
                        durationText = (durationText + ", ");
                    };
                    durationText = (durationText + this.uiApi.processText(this.uiApi.getText("ui.social.monthsSinceLastConnection", months), "m", (months <= 1)));
                };
                if (days > 0)
                {
                    if (durationText.length > 0)
                    {
                        durationText = (durationText + ", ");
                    };
                    durationText = (durationText + this.uiApi.processText(this.uiApi.getText("ui.social.daysSinceLastConnection", days), "m", (days <= 1)));
                };
                this.lbl_subscriptionDuration.text = durationText;
            };
            var lastRwdGID:int;
            var nextRwdGID:int;
            for each (rwd in this._allRewards)
            {
                if ((rwd.requiredSubDays * SECONDS_PER_DAY) <= this._subscriptionDurationElapsed)
                {
                    lastRwdGID = rwd.itemGID;
                }
                else
                {
                    if (nextRwdGID == 0)
                    {
                        nextRwdGID = rwd.itemGID;
                        this._remainingTime = ((rwd.requiredSubDays * SECONDS_PER_DAY) - this._subscriptionDurationElapsed);
                    };
                };
            };
            if (lastRwdGID > 0)
            {
                this._lastRwd = this.dataApi.getItemWrapper(lastRwdGID);
                this.tx_lastRwd.uri = this._lastRwd.fullSizeIconUri;
                this.lbl_lastRwd.width = 280;
                this.lbl_lastRwd.text = this.uiApi.getText("ui.veteran.lastRewardInfo", this._lastRwd.name);
                this.tx_lastRwdSlot.visible = true;
                this.tx_lastRwd.visible = true;
            }
            else
            {
                this._lastRwd = null;
                this.lbl_lastRwd.width = 451;
                this.lbl_lastRwd.text = this.uiApi.getText("ui.veteran.noLastReward");
                this.tx_lastRwdSlot.visible = false;
                this.tx_lastRwd.visible = false;
            };
            this._nextRwd = this.dataApi.getItemWrapper(nextRwdGID);
            this.tx_nextRwd.uri = this._nextRwd.fullSizeIconUri;
            if (this._remainingTime <= SECONDS_PER_DAY)
            {
                this._lastTime = getTimer();
                this._timer = new Timer(1000);
                this._timer.addEventListener(TimerEvent.TIMER, this.onTimerTick);
                this._timer.start();
            }
            else
            {
                remainingDays = Math.ceil((this._remainingTime / SECONDS_PER_DAY));
                this.lbl_remainingTime.text = this.uiApi.getText("ui.veteran.nextRewardInfoDays", this._nextRwd.name, remainingDays);
            };
            var currentDate:Number = new Date().time;
            if (((!(this._subscriptionEndDate)) || (((this._subscriptionEndDate) && (((this._subscriptionEndDate - currentDate) < (this._remainingTime * 1000)))))))
            {
                this.ctr_noEnoughSub.visible = true;
                this.lbl_enoughSub.visible = false;
            }
            else
            {
                this.ctr_noEnoughSub.visible = false;
                this.lbl_enoughSub.visible = true;
            };
            if (this._subscriptionEndDate == 0)
            {
                if (this.sysApi.getPlayerManager().hasRights)
                {
                    this.lbl_remainingSub.text = this.uiApi.getText("ui.common.admin");
                }
                else
                {
                    this.lbl_remainingSub.text = this.uiApi.getText("ui.common.non_subscriber");
                };
            }
            else
            {
                if (this._subscriptionEndDate < 2051222400000)
                {
                    this.lbl_remainingSub.text = this.uiApi.getText("ui.connection.subscriberUntil", ((this.timeApi.getDate(this._subscriptionEndDate, true, true) + " ") + this.timeApi.getClock(this._subscriptionEndDate, true, true)));
                }
                else
                {
                    this.lbl_remainingSub.text = this.uiApi.getText("ui.common.infiniteSubscription");
                };
            };
        }

        private function formatLeadingZero(value:Number):String
        {
            return ((((value)<10) ? ("0" + value) : value.toString()));
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_addSub)
            {
                this.sysApi.goToUrl(this.uiApi.getText("ui.link.subscribe"));
            }
            else
            {
                if (target == this.lbl_moreInfo)
                {
                    this.sysApi.goToUrl(this.uiApi.getText("ui.link.vetRewards"));
                };
            };
        }

        public function onRollOver(target:Object):void
        {
            var data:*;
            var point:uint = LocationEnum.POINT_TOP;
            var relativePoint:uint = LocationEnum.POINT_BOTTOM;
            var tooltipMaker:String = "itemName";
            var makerParams:Object = {};
            var cacheName:String = "ItemTooltip";
            if ((((target == this.tx_lastRwdSlot)) || ((target == this.tx_lastRwd))))
            {
                data = this._lastRwd;
            }
            else
            {
                if ((((target == this.tx_nextRwdSlot)) || ((target == this.tx_nextRwd))))
                {
                    data = this._nextRwd;
                }
                else
                {
                    data = target.data;
                };
            };
            if (data)
            {
                this.uiApi.showTooltip(data, target, false, "standard", point, relativePoint, 4, tooltipMaker, null, makerParams, cacheName);
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
        }

        private function onTimerTick(pEvent:TimerEvent):void
        {
            var hours:int;
            var minutes:int;
            var seconds:int;
            var clock:String;
            var timePassed:Number = (getTimer() - this._lastTime);
            this._remainingTime = (this._remainingTime - 1);
            if (this._remainingTime <= 0)
            {
                this._timer.removeEventListener(TimerEvent.TIMER, this.onTimerTick);
                this._timer.stop();
                this.refreshSubscriberDuration();
            }
            else
            {
                hours = Math.floor((this._remainingTime / 3600));
                minutes = Math.floor(((this._remainingTime - (hours * 3600)) / 60));
                seconds = ((this._remainingTime - (hours * 3600)) - (minutes * 60));
                clock = ((((this.formatLeadingZero(hours) + ":") + this.formatLeadingZero(minutes)) + ":") + this.formatLeadingZero(seconds));
                this.lbl_remainingTime.text = this.uiApi.getText("ui.veteran.nextRewardInfoClock", this._nextRwd.name, clock);
            };
        }


    }
}//package ui


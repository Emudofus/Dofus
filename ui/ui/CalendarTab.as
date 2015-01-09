package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.SoundApi;
    import d2api.TimeApi;
    import d2api.InventoryApi;
    import d2api.DataApi;
    import d2api.QuestApi;
    import d2data.AlmanaxMonth;
    import d2data.AlmanaxZodiac;
    import d2data.AlmanaxEvent;
    import d2data.AlmanaxCalendar;
    import d2data.Npc;
    import d2components.Label;
    import d2components.TextArea;
    import d2components.EntityDisplayer;
    import d2components.ButtonContainer;
    import d2components.Texture;
    import d2components.GraphicContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2enums.ComponentHookList;
    import flash.geom.ColorTransform;
    import d2enums.BuildTypeEnum;
    import d2data.Item;
    import d2hooks.AddMapFlag;
    import d2actions.*;
    import d2hooks.*;

    public class CalendarTab 
    {

        private static const NUMBER_OF_DAYS:int = 365;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        public var soundApi:SoundApi;
        public var timeApi:TimeApi;
        public var inventoryApi:InventoryApi;
        public var dataApi:DataApi;
        public var questApi:QuestApi;
        private var _dateId:int;
        private var _monthInfo:AlmanaxMonth;
        private var _zodiacInfo:AlmanaxZodiac;
        private var _eventInfo:AlmanaxEvent;
        private var _calendar:AlmanaxCalendar;
        private var _meryde:Npc;
        private var _sheetsQuantity:int;
        public var lbl_month:Label;
        public var lbl_year:Label;
        public var lbl_nameday:Label;
        public var lbl_titlemeryde:Label;
        public var lbl_meryde:TextArea;
        public var lbl_titleBonus:Label;
        public var lbl_bonus:TextArea;
        public var lbl_dayObjective:Label;
        public var lbl_quest:TextArea;
        public var lbl_questProgress:Label;
        public var ed_meryde:EntityDisplayer;
        public var btn_site:ButtonContainer;
        public var btn_locTemple:ButtonContainer;
        public var btn_hideDailyNotif:ButtonContainer;
        public var tx_day:Texture;
        public var tx_astro:Texture;
        public var tx_monthGod:Texture;
        public var tx_nameDayIllu:Texture;
        public var tx_dolmanax:Texture;
        public var tx_progressBar:Texture;
        public var tx_progressBarBg:Texture;
        public var tx_bgMeryde:Texture;
        public var ctr_nameDayIllu:GraphicContainer;


        public function main(oParam:Object=null):void
        {
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.uiApi.addComponentHook(this.btn_locTemple, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_site, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_site, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_site, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_astro, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_astro, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_monthGod, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_monthGod, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ed_meryde, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ed_meryde, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_bgMeryde, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_bgMeryde, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_progressBar, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_progressBar, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_progressBarBg, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_progressBarBg, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_hideDailyNotif, ComponentHookList.ON_RELEASE);
            var colorT:ColorTransform = new ColorTransform(0.498, 0.975, 0.156);
            this.tx_progressBar.transform.colorTransform = colorT;
            if (this.sysApi.getBuildType() == BuildTypeEnum.BETA)
            {
                this.btn_site.disabled = true;
            };
            this._sheetsQuantity = this.inventoryApi.getItemQty(13345);
            this.btn_hideDailyNotif.selected = this.sysApi.getData("hideAlmanaxDailyNotif");
            this.updateCalendarInfos();
        }

        public function unload():void
        {
            this.uiApi.hideTooltip();
        }

        public function updateCalendarInfos():void
        {
            var infos:Object = Grimoire.getInstance().calendarInfos;
            this._calendar = infos.calendar;
            this._monthInfo = infos.month;
            this._zodiacInfo = infos.zodiac;
            this._eventInfo = infos.event;
            this._meryde = infos.meryde;
            this.displayCalendar();
        }

        private function displayCalendar():void
        {
            var qty:int;
            this.tx_day.gotoAndStop = ("" + this.timeApi.getDofusDay());
            this.lbl_month.text = this.timeApi.getDofusMonth();
            this.lbl_year.text = this.uiApi.getText("ui.common.year", this.timeApi.getDofusYear());
            if (this._zodiacInfo)
            {
                this.tx_astro.uri = this.uiApi.createUri(this._zodiacInfo.webImageUrl);
            };
            if (this._monthInfo)
            {
                this.tx_monthGod.uri = this.uiApi.createUri(this._monthInfo.webImageUrl);
            };
            if (this._eventInfo)
            {
                this.lbl_nameday.text = this._eventInfo.name;
                this.tx_nameDayIllu.uri = this.uiApi.createUri(this._eventInfo.webImageUrl);
                this.lbl_meryde.text = this.getText(this._eventInfo.ephemeris);
            };
            if (this._meryde)
            {
                this.lbl_titlemeryde.text = this.uiApi.getText("ui.almanax.dayMeryde", this._meryde.name);
                this.ed_meryde.look = this._meryde.look;
                this.lbl_dayObjective.text = this.uiApi.getText("ui.almanax.offeringTo", this._meryde.name);
            };
            if (this._calendar)
            {
                this.lbl_titleBonus.text = ((this.uiApi.getText("ui.almanax.dayBonus") + this.uiApi.getText("ui.common.colon")) + this._calendar.bonusName);
                this.lbl_bonus.text = this._calendar.bonusDescription;
            };
            var completedQuests:Object = this.questApi.getCompletedQuests();
            if (((completedQuests) && ((completedQuests.indexOf(954) == -1))))
            {
                this.lbl_quest.text = this.uiApi.getText("ui.almanax.dolmanaxQuestDesc");
                this.lbl_questProgress.text = this.uiApi.getText("ui.almanax.questProgress");
                qty = (((this._sheetsQuantity > NUMBER_OF_DAYS)) ? NUMBER_OF_DAYS : this._sheetsQuantity);
                this.tx_progressBar.scaleX = (qty / NUMBER_OF_DAYS);
            }
            else
            {
                this.lbl_quest.text = this.uiApi.getText("ui.almanax.dolmanaxQuestDone");
                this.lbl_questProgress.text = this.uiApi.getText("ui.almanax.questDone");
                this._sheetsQuantity = NUMBER_OF_DAYS;
                this.tx_progressBar.scaleX = 1;
            };
            var dolmanax:Item = this.dataApi.getItem(13344);
            if (dolmanax)
            {
                this.tx_dolmanax.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("item_path") + dolmanax.iconId) + ".swf"));
            };
        }

        private function getText(txt:String):String
        {
            if (txt.indexOf("ui.") == 0)
            {
                return (this.uiApi.getText(txt));
            };
            return (txt);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_locTemple:
                    this.sysApi.dispatchHook(AddMapFlag, "flag_teleportPoint", (this.uiApi.getText("ui.almanax.sanctuary") + " (-4,-24)"), 1, -4, -24, 15636787, true);
                    break;
                case this.btn_site:
                    this.sysApi.goToUrl(this.uiApi.getText("ui.almanax.link"));
                    break;
                case this.btn_hideDailyNotif:
                    this.sysApi.setData("hideAlmanaxDailyNotif", this.btn_hideDailyNotif.selected);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var ttData:*;
            switch (target)
            {
                case this.btn_site:
                    ttData = this.uiApi.getText("ui.almanax.goToWebsite");
                    break;
                case this.tx_monthGod:
                    if (this._monthInfo)
                    {
                        ttData = this.getText(this._monthInfo.protectorDescription);
                    };
                    break;
                case this.tx_astro:
                    if (this._zodiacInfo)
                    {
                        ttData = this.getText(this._zodiacInfo.description);
                    };
                    break;
                case this.ed_meryde:
                case this.tx_bgMeryde:
                    if (this._eventInfo)
                    {
                        ttData = this.getText(this._eventInfo.bossText);
                    };
                    break;
                case this.tx_progressBar:
                case this.tx_progressBarBg:
                    ttData = this.uiApi.getText("ui.almanax.calendarSheetsCollected", this._sheetsQuantity, NUMBER_OF_DAYS);
                    break;
            };
            if (ttData)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(ttData), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }


    }
}//package ui


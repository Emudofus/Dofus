package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.TooltipApi;
    import d2components.ButtonContainer;
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2components.Label;
    import flash.utils.Timer;
    import d2hooks.MailStatus;
    import d2hooks.LaggingNotification;
    import flash.events.TimerEvent;
    import d2hooks.OpenWebPortal;
    import com.ankamagames.dofusModuleLibrary.enum.WebLocationEnum;
    import d2actions.OpenMainMenu;
    import d2hooks.*;
    import d2actions.*;

    public class GameMenu 
    {

        private static const NEW_MAIL_POPUP_DURATION:int = (15 * 1000);//15000

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var tooltipApi:TooltipApi;
        public var btn_abo:ButtonContainer;
        public var btn_options:ButtonContainer;
        public var btn_menu:ButtonContainer;
        public var btn_mp:ButtonContainer;
        public var btn_newMail:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var ctr_newMail:GraphicContainer;
        public var tx_bg:Texture;
        public var tx_lagometer:Texture;
        public var lbl_newMail:Label;
        private var _mailUnread:uint;
        private var _mailTotal:uint;
        private var _newMailTimer:Timer;


        public function main(... args):void
        {
            this.sysApi.addHook(MailStatus, this.onMailStatus);
            this.sysApi.addHook(LaggingNotification, this.onLaggingNotification);
            this.uiApi.addComponentHook(this.btn_abo, "onRollOver");
            this.uiApi.addComponentHook(this.btn_abo, "onRollOut");
            this.uiApi.addComponentHook(this.btn_abo, "onRelease");
            this.uiApi.addComponentHook(this.btn_options, "onRollOver");
            this.uiApi.addComponentHook(this.btn_options, "onRollOut");
            this.uiApi.addComponentHook(this.btn_options, "onRelease");
            this.uiApi.addComponentHook(this.btn_menu, "onRollOver");
            this.uiApi.addComponentHook(this.btn_menu, "onRollOut");
            this.uiApi.addComponentHook(this.btn_menu, "onRelease");
            this.uiApi.addComponentHook(this.btn_mp, "onRollOver");
            this.uiApi.addComponentHook(this.btn_mp, "onRollOut");
            this.uiApi.addComponentHook(this.btn_mp, "onRelease");
            this.uiApi.addComponentHook(this.btn_newMail, "onRelease");
            this.uiApi.addComponentHook(this.btn_close, "onRelease");
            this.uiApi.addShortcutHook("optionMenu1", this.onShortcut);
            if ((((this.sysApi.getPlayerManager().subscriptionEndDate > 0)) || (((this.sysApi.getPlayerManager().hasRights) && (!((this.sysApi.getCurrentLanguage() == "ja")))))))
            {
                this.btn_abo.visible = false;
                this.tx_bg.x = (this.tx_bg.x + 21);
            };
            this.ctr_newMail.visible = false;
            this._newMailTimer = new Timer(NEW_MAIL_POPUP_DURATION, 1);
            this._newMailTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerUp);
            this.tx_lagometer.visible = false;
        }

        private function onLaggingNotification(isLagging:Boolean):void
        {
            this.tx_lagometer.visible = isLagging;
        }

        public function unload():void
        {
            this.hideNewMailBox();
        }

        private function showNewMailBox():void
        {
            this._newMailTimer.start();
            this.ctr_newMail.visible = true;
        }

        private function hideNewMailBox():void
        {
            this._newMailTimer.stop();
            this._newMailTimer.reset();
            this.ctr_newMail.visible = false;
        }

        private function onTimerUp(event:TimerEvent):void
        {
            this.hideNewMailBox();
        }

        public function onMailStatus(hasNewMail:Boolean, unread:uint, total:uint):void
        {
            if (this.sysApi.isGuest())
            {
                return;
            };
            if (!(this.btn_mp.visible))
            {
                this.btn_mp.visible = true;
                this.btn_abo.x = (this.btn_abo.x - 26);
                this.tx_bg.x = (this.tx_bg.x - 26);
                this.tx_bg.width = (this.tx_bg.width + 26);
            };
            this._mailUnread = unread;
            this._mailTotal = total;
            this.btn_mp.selected = (this._mailUnread > 0);
            if (hasNewMail)
            {
                this.showNewMailBox();
            };
        }

        public function onRelease(target:Object):void
        {
            this.sysApi.log(8, ((("release sur " + target) + " : ") + target.name));
            switch (target)
            {
                case this.btn_mp:
                    this.sysApi.dispatchHook(OpenWebPortal, WebLocationEnum.WEB_LOCATION_ANKABOX);
                    this.btn_mp.selected = false;
                    this._mailUnread = 0;
                    break;
                case this.btn_menu:
                    this.sysApi.sendAction(new OpenMainMenu());
                    break;
                case this.btn_abo:
                    this.sysApi.goToUrl(this.uiApi.getText("ui.link.subscribe"));
                    break;
                case this.btn_options:
                    this.modCommon.openOptionMenu(false, "performance");
                    break;
                case this.btn_newMail:
                    this.sysApi.dispatchHook(OpenWebPortal, WebLocationEnum.WEB_LOCATION_ANKABOX_LAST_UNREAD);
                    this.hideNewMailBox();
                    this.btn_mp.selected = false;
                    this._mailUnread = 0;
                    break;
                case this.btn_close:
                    this.hideNewMailBox();
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var data:Object;
            var point:uint = 7;
            var relPoint:uint = 1;
            var shortcutKey:String;
            switch (target)
            {
                case this.btn_abo:
                    tooltipText = this.uiApi.getText("ui.header.subscribe");
                    break;
                case this.btn_menu:
                    tooltipText = this.uiApi.getText("ui.banner.mainMenu");
                    break;
                case this.btn_options:
                    tooltipText = this.uiApi.getText("ui.common.optionsMenu");
                    break;
                case this.btn_mp:
                    tooltipText = this.uiApi.processText(this.uiApi.getText("ui.ankabox.unread", this._mailUnread), "m", (this._mailUnread > 0));
                    break;
            };
            data = this.uiApi.textTooltipInfo(tooltipText);
            this.uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "optionMenu1":
                    this.modCommon.openOptionMenu(false, "performance");
                    return (true);
            };
            return (false);
        }


    }
}//package ui


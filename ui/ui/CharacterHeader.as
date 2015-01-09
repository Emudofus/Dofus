package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.TimeApi;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.Texture;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.AuthenticationTicket;
    import d2hooks.ServersList;
    import d2enums.BuildTypeEnum;
    import d2data.Server;
    import d2hooks.*;
    import d2actions.*;

    public class CharacterHeader 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var timeApi:TimeApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var btn_subscribe:ButtonContainer;
        public var lbl_pseudo:Label;
        public var lbl_abo:Label;
        public var lbl_server:Label;
        public var tx_logo:Texture;
        public var tx_background:Texture;
        private var _subscriberMode:Boolean;


        public function main(... args):void
        {
            var lastWarning:Number;
            var now:Number;
            var subscriberMode:* = this.sysApi.getConfigKey("subscriberMode");
            if ((((subscriberMode === false)) || ((subscriberMode == "false"))))
            {
                this.lbl_abo.visible = false;
                this.btn_subscribe.visible = false;
            };
            this.btn_subscribe.soundId = SoundEnum.SPEC_BUTTON;
            this.sysApi.addHook(AuthenticationTicket, this.onAuthenticationTicket);
            this.sysApi.addHook(ServersList, this.onServersList);
            this.uiApi.addComponentHook(this.lbl_abo, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_abo, "onRollOut");
            var logoUrl:String = (this.sysApi.getConfigEntry("config.content.path") + "/gfx/illusUi/logo_dofus.swf|");
            switch (this.sysApi.getCurrentLanguage())
            {
                case "ja":
                    logoUrl = (logoUrl + "tx_logo_JP");
                    break;
                case "ru":
                    logoUrl = (logoUrl + "tx_logo_RU");
                    this.tx_background.uri = this.uiApi.createUri((this.uiApi.me().getConstant("assets") + "tx_background_russe"));
                    break;
                case "fr":
                default:
                    logoUrl = (logoUrl + "tx_logo_FR");
            };
            this.tx_logo.uri = this.uiApi.createUri(logoUrl);
            this.playerDisplay();
            if (((!((this.sysApi.getBuildType() == BuildTypeEnum.BETA))) && ((((((this.sysApi.getOs() == "Windows")) && ((this.sysApi.getOsVersion() == "2000")))) || ((((this.sysApi.getOs() == "Mac OS")) && ((this.sysApi.getCpu() == "PowerPC"))))))))
            {
                if (!(this.sysApi.getData("lastOsWarning")))
                {
                    this.sysApi.setData("lastOsWarning", 0);
                };
                lastWarning = this.sysApi.getData("lastOsWarning");
                now = new Date().getTime();
                if ((((lastWarning == 0)) || (((now - lastWarning) > 0x240C8400))))
                {
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.report.oldOs.popup"), [this.uiApi.getText("ui.common.ok")], [this.voidFunction], this.voidFunction);
                    this.sysApi.setData("lastOsWarning", now);
                };
            };
        }

        public function unload():void
        {
        }

        private function playerDisplay():void
        {
            if (this.sysApi.isGuest())
            {
                this.lbl_pseudo.text = (this.uiApi.getText("ui.header.dofusPseudo") + this.uiApi.getText("ui.common.colon"));
            }
            else
            {
                this.lbl_pseudo.text = ((this.uiApi.getText("ui.header.dofusPseudo") + this.uiApi.getText("ui.common.colon")) + this.sysApi.getPlayerManager().nickname);
            };
            if (this.sysApi.getPlayerManager().subscriptionEndDate == 0)
            {
                if (this.sysApi.getPlayerManager().hasRights)
                {
                    this.lbl_abo.text = this.uiApi.getText("ui.common.admin");
                }
                else
                {
                    if (this.sysApi.isGuest())
                    {
                        this.lbl_abo.text = this.uiApi.getText("ui.guest.guestMode");
                    }
                    else
                    {
                        this.lbl_abo.text = this.uiApi.getText("ui.common.non_subscriber");
                    };
                };
            }
            else
            {
                if (this.sysApi.getPlayerManager().subscriptionEndDate < 2051222400000)
                {
                    this.lbl_abo.text = this.uiApi.getText("ui.common.until", ((this.timeApi.getDate(this.sysApi.getPlayerManager().subscriptionEndDate, true, true) + " ") + this.timeApi.getClock(this.sysApi.getPlayerManager().subscriptionEndDate, true, true)));
                }
                else
                {
                    this.lbl_abo.text = this.uiApi.getText("ui.common.infiniteSubscription");
                };
            };
            this.lbl_server.text = (this.uiApi.getText("ui.header.server") + this.uiApi.getText("ui.common.colon"));
            var server:Server = this.sysApi.getCurrentServer();
            if (server)
            {
                this.lbl_server.text = (this.lbl_server.text + server.name);
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_subscribe:
                    this.sysApi.goToUrl(this.uiApi.getText("ui.link.subscribe"));
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            switch (target)
            {
                case this.lbl_abo:
                    if (this.sysApi.getPlayerManager().subscriptionEndDate > 0)
                    {
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.header.subscriptionEndDate")), target, false, "standard", 2, 8, 0, null, null, null, "TextInfo");
                    };
                    break;
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onAuthenticationTicket():void
        {
            this.playerDisplay();
        }

        public function onServersList(o:Object):void
        {
            this.playerDisplay();
        }

        public function validPoll(answers:Array):void
        {
            var answer:String;
            var sendindDone:Boolean;
            var answerString:String = (("ID:" + this.sysApi.getPlayerManager().accountId) + ",");
            if (answers.length)
            {
                answerString = (answerString + "A:");
            };
            for each (answer in answers)
            {
                answerString = (answerString + (answer + ","));
            };
            answerString = answerString.substr(0, (answerString.length - 1));
            if ((((this.sysApi.getOs() == "Windows")) && ((this.sysApi.getOsVersion() == "2000"))))
            {
                sendindDone = this.sysApi.sendStatisticReport("SondageWindows2000", answerString);
            }
            else
            {
                if ((((this.sysApi.getOs() == "Mac OS")) && ((this.sysApi.getCpu() == "PowerPC"))))
                {
                    this.sysApi.sendStatisticReport("SondageMacPPC", answerString);
                };
            };
        }

        public function voidFunction():void
        {
        }


    }
}//package ui


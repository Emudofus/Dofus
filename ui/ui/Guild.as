package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2api.SocialApi;
    import d2api.DataApi;
    import d2api.TimeApi;
    import d2data.GuildWrapper;
    import d2components.GraphicContainer;
    import d2components.Label;
    import d2components.Texture;
    import d2components.ButtonContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.GuildInformationsGeneral;
    import d2enums.ComponentHookList;
    import d2actions.GuildGetInformations;
    import d2enums.GuildInformationsTypeEnum;
    import d2data.EmblemSymbol;
    import flash.geom.ColorTransform;
    import d2hooks.*;
    import d2actions.*;

    public class Guild 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var utilApi:UtilApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var socialApi:SocialApi;
        public var dataApi:DataApi;
        public var timeApi:TimeApi;
        private var _nCurrentTab:int = -1;
        private var _guild:GuildWrapper;
        private var guildInformationsAsked:Boolean = false;
        private var _enabled:Boolean;
        private var _expLevelFloor:Number;
        private var _experience:Number;
        private var _expNextLevelFloor:Number;
        private var _level:uint;
        public var mainCtr:GraphicContainer;
        public var lbl_title:Label;
        public var lbl_guildLevel:Label;
        public var lbl_members:Label;
        public var lbl_birthday:Label;
        public var tx_progressBar:Texture;
        public var tx_progressBarBackground:Texture;
        public var tx_emblemBack:Texture;
        public var tx_emblemUp:Texture;
        public var tx_paddockWarning:Texture;
        public var tx_disabled:Texture;
        public var btn_members:ButtonContainer;
        public var btn_customization:ButtonContainer;
        public var btn_taxCollector:ButtonContainer;
        public var btn_paddock:ButtonContainer;
        public var btn_houses:ButtonContainer;


        public function main(... args):void
        {
            this.btn_members.soundId = SoundEnum.TAB;
            this.btn_customization.soundId = SoundEnum.TAB;
            this.btn_taxCollector.soundId = SoundEnum.TAB;
            this.btn_paddock.soundId = SoundEnum.TAB;
            this.btn_houses.soundId = SoundEnum.TAB;
            this.sysApi.addHook(GuildInformationsGeneral, this.onGuildInformationsGeneral);
            this._guild = this.socialApi.getGuild();
            this.lbl_title.text = ((this.uiApi.getText("ui.common.guild") + " - ") + this._guild.guildName);
            this.tx_emblemBack.dispatchMessages = true;
            this.tx_emblemUp.dispatchMessages = true;
            this.uiApi.addComponentHook(this.tx_emblemBack, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.tx_emblemUp, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.btn_members, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_customization, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_taxCollector, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_paddock, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_houses, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.tx_progressBarBackground, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_progressBarBackground, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_birthday, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_birthday, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_disabled, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_disabled, ComponentHookList.ON_ROLL_OUT);
            this.tx_emblemBack.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("picto_uri") + "back/") + this._guild.backEmblem.idEmblem) + ".swf"));
            this.tx_emblemUp.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("picto_uri") + "up/") + this._guild.upEmblem.idEmblem) + ".swf"));
            this.tx_progressBar.mouseEnabled = false;
            this.openSelectedTab(args[0][0]);
        }

        public function unload():void
        {
            this.uiApi.unloadUi("subGuildUi");
        }

        private function openSelectedTab(tab:uint):void
        {
            if (!(this.guildInformationsAsked))
            {
                this.guildInformationsAsked = true;
                this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_GENERAL));
            };
            if (this._nCurrentTab == tab)
            {
                return;
            };
            switch (tab)
            {
                case 2:
                    this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_GUILD_ONLY));
                    break;
                case 4:
                    this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_HOUSES));
                    break;
            };
            this.uiApi.unloadUi("subGuildUi");
            this.uiApi.loadUiInside(this.getUiNameByTab(tab), this.mainCtr, "subGuildUi", null);
            this.getButtonByTab(tab).selected = true;
        }

        private function getUiNameByTab(tab:uint):String
        {
            if (tab == 0)
            {
                return ("guildMembers");
            };
            if (tab == 1)
            {
                return ("guildPersonalization");
            };
            if (tab == 2)
            {
                return ("guildTaxCollector");
            };
            if (tab == 3)
            {
                return ("guildPaddock");
            };
            if (tab == 4)
            {
                return ("guildHouses");
            };
            return (null);
        }

        private function getButtonByTab(tab:uint):Object
        {
            if (tab == 0)
            {
                return (this.btn_members);
            };
            if (tab == 1)
            {
                return (this.btn_customization);
            };
            if (tab == 2)
            {
                return (this.btn_taxCollector);
            };
            if (tab == 3)
            {
                return (this.btn_paddock);
            };
            if (tab == 4)
            {
                return (this.btn_houses);
            };
            return (null);
        }

        public function onTextureReady(target:Object):void
        {
            var _local_2:EmblemSymbol;
            switch (target)
            {
                case this.tx_emblemBack:
                    this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"), this._guild.backEmblem.color, 1);
                    break;
                case this.tx_emblemUp:
                    _local_2 = this.dataApi.getEmblemSymbol(this._guild.upEmblem.idEmblem);
                    if (_local_2.colorizable)
                    {
                        this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"), this._guild.upEmblem.color, 0);
                    }
                    else
                    {
                        this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"), this._guild.upEmblem.color, 0, true);
                    };
                    break;
            };
        }

        private function onGuildInformationsGeneral(enabled:Boolean, expLevelFloor:Number, experience:Number, expNextLevelFloor:Number, level:uint, creationDate:uint, warning:Boolean, nbConnectedMembers:int, nbMembers:int):void
        {
            this._enabled = enabled;
            this._expLevelFloor = expLevelFloor;
            this._experience = experience;
            this._expNextLevelFloor = expNextLevelFloor;
            this._level = level;
            this.lbl_guildLevel.text = ((this.uiApi.getText("ui.common.level") + " ") + level.toString());
            var barWidth:int = (this.tx_progressBarBackground.width - 2);
            this.tx_progressBar.width = barWidth;
            this.tx_progressBar.width = int((((experience - expLevelFloor) / (expNextLevelFloor - expLevelFloor)) * barWidth));
            this.tx_progressBar.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -76, -10, 33, 0);
            this.lbl_birthday.text = this.timeApi.getDofusDate((creationDate * 1000));
            this.lbl_members.text = ((nbConnectedMembers + " / ") + nbMembers);
            if (warning)
            {
                this.tx_paddockWarning.visible = true;
            }
            else
            {
                this.tx_paddockWarning.visible = false;
            };
            if (enabled)
            {
                this.tx_disabled.visible = false;
            }
            else
            {
                this.tx_disabled.visible = true;
            };
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_members)
            {
                this.openSelectedTab(0);
            }
            else
            {
                if (target == this.btn_customization)
                {
                    this.openSelectedTab(1);
                }
                else
                {
                    if (target == this.btn_taxCollector)
                    {
                        this.openSelectedTab(2);
                    }
                    else
                    {
                        if (target == this.btn_paddock)
                        {
                            this.tx_paddockWarning.visible = false;
                            this.openSelectedTab(3);
                        }
                        else
                        {
                            if (target == this.btn_houses)
                            {
                                this.openSelectedTab(4);
                            };
                        };
                    };
                };
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.tx_progressBarBackground:
                    tooltipText = ((this.utilApi.kamasToString(this._experience, "") + " / ") + this.utilApi.kamasToString(this._expNextLevelFloor, ""));
                    break;
                case this.lbl_birthday:
                    tooltipText = ((this.timeApi.getDate((this._guild.creationDate * 1000)) + " ") + this.timeApi.getClock((this._guild.creationDate * 1000)));
                    break;
                case this.tx_disabled:
                    tooltipText = this.uiApi.getText("ui.guild.disabled");
                    break;
            };
            if (tooltipText)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }


    }
}//package ui


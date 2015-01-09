package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2api.DataApi;
    import d2api.SocialApi;
    import d2api.TimeApi;
    import d2api.ChatApi;
    import flash.utils.Dictionary;
    import d2components.Label;
    import d2components.Texture;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import d2hooks.OpenOneAlliance;
    import d2enums.ComponentHookList;
    import d2data.EmblemSymbol;
    import d2hooks.*;
    import d2actions.*;

    public class AllianceCard 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var utilApi:UtilApi;
        public var dataApi:DataApi;
        public var socialApi:SocialApi;
        public var timeApi:TimeApi;
        public var chatApi:ChatApi;
        private var _data:Object;
        private var _compsTxEmblem:Dictionary;
        private var _comps:Dictionary;
        private var _emblemsPath:String;
        public var lbl_name:Label;
        public var lbl_tag:Label;
        public var lbl_leader:Label;
        public var lbl_guilds:Label;
        public var lbl_areas:Label;
        public var lbl_members:Label;
        public var lbl_creationDate:Label;
        public var tx_emblemBack:Texture;
        public var tx_emblemUp:Texture;
        public var tx_disabled:Texture;
        public var gd_guilds:Grid;
        public var btn_close:ButtonContainer;

        public function AllianceCard()
        {
            this._compsTxEmblem = new Dictionary(true);
            this._comps = new Dictionary(true);
            super();
        }

        public function main(... args):void
        {
            this.sysApi.addHook(OpenOneAlliance, this.onOpenOneAlliance);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.tx_emblemBack.dispatchMessages = true;
            this.tx_emblemUp.dispatchMessages = true;
            this.uiApi.addComponentHook(this.tx_emblemBack, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.tx_emblemUp, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.tx_disabled, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_disabled, ComponentHookList.ON_ROLL_OUT);
            this._emblemsPath = this.uiApi.me().getConstant("emblems_uri");
            this._data = args[0].alliance;
            this.updateInformations();
        }

        public function unload():void
        {
        }

        public function updateGuildLine(data:*, components:*, selected:Boolean):void
        {
            var icon:EmblemSymbol;
            this._compsTxEmblem[components.tx_emblemBackGuild.name] = data;
            this._compsTxEmblem[components.tx_emblemUpGuild.name] = data;
            if (!(this._comps[components.tx_disabledGuild.name]))
            {
                this.uiApi.addComponentHook(components.tx_disabledGuild, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.tx_disabledGuild, ComponentHookList.ON_ROLL_OUT);
            };
            this._comps[components.tx_disabledGuild.name] = true;
            if (data != null)
            {
                components.lbl_guildName.text = this.chatApi.getGuildLink(data, data.guildName);
                components.lbl_guildLvl.text = data.guildLevel;
                components.tx_emblemBackGuild.uri = this.uiApi.createUri((((this._emblemsPath + "icons/back/") + data.backEmblem.idEmblem) + ".png"));
                components.tx_emblemUpGuild.uri = this.uiApi.createUri((((this._emblemsPath + "icons/up/") + data.upEmblem.idEmblem) + ".png"));
                this.utilApi.changeColor(components.tx_emblemBackGuild, data.backEmblem.color, 1);
                icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
                if (icon.colorizable)
                {
                    this.utilApi.changeColor(components.tx_emblemUpGuild, data.upEmblem.color, 0);
                }
                else
                {
                    this.utilApi.changeColor(components.tx_emblemUpGuild, data.upEmblem.color, 0, true);
                };
                if (data.enabled)
                {
                    components.tx_disabledGuild.visible = false;
                }
                else
                {
                    components.tx_disabledGuild.visible = true;
                };
            }
            else
            {
                components.lbl_guildName.text = "";
                components.lbl_guildLvl.text = "";
                components.tx_emblemBackGuild.uri = null;
                components.tx_emblemUpGuild.uri = null;
                components.tx_disabledGuild.visible = false;
            };
        }

        private function updateInformations():void
        {
            this.lbl_name.text = this._data.allianceName;
            this.lbl_tag.text = (("[" + this._data.allianceTag) + "]");
            this.lbl_leader.text = (((((("{player," + this._data.leaderCharacterName) + ",") + this._data.leaderCharacterId) + "::") + this._data.leaderCharacterName) + "}");
            this.lbl_guilds.text = ("" + this._data.nbGuilds);
            this.lbl_members.text = ("" + this.utilApi.formateIntToString(this._data.nbMembers));
            if (((this._data.prismIds) && (this._data.prismIds.length)))
            {
                this.lbl_areas.text = this.uiApi.getText("ui.prism.nbPrisms", this._data.prismIds.length);
            }
            else
            {
                this.lbl_areas.text = this.uiApi.getText("ui.prism.noPrism");
            };
            this.lbl_creationDate.text = this.timeApi.getDofusDate((this._data.creationDate * 1000));
            if (this._data.enabled)
            {
                this.tx_disabled.visible = false;
            }
            else
            {
                this.tx_disabled.visible = true;
            };
            this.tx_emblemBack.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("emblems_uri") + "backalliance/") + this._data.backEmblem.idEmblem) + ".swf"));
            this.tx_emblemUp.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("emblems_uri") + "up/") + this._data.upEmblem.idEmblem) + ".swf"));
            this.gd_guilds.dataProvider = this._data.guilds;
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var point:uint = 7;
            var relPoint:uint = 1;
            if (target == this.tx_disabled)
            {
                tooltipText = this.uiApi.getText("ui.alliance.disabled");
            }
            else
            {
                if (target.name.indexOf("tx_disabledGuild") != -1)
                {
                    tooltipText = this.uiApi.getText("ui.guild.disabled");
                };
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

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        public function onTextureReady(target:Object):void
        {
            var icon:EmblemSymbol;
            var data:Object = this._data;
            if (target.name.indexOf("Guild") != -1)
            {
                data = this._compsTxEmblem[target.name];
            };
            if (target.name.indexOf("tx_emblemBack") != -1)
            {
                this.utilApi.changeColor(target.getChildByName("back"), data.backEmblem.color, 1);
            }
            else
            {
                if (target.name.indexOf("tx_emblemUp") != -1)
                {
                    icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
                    if (icon.colorizable)
                    {
                        this.utilApi.changeColor(target.getChildByName("up"), data.upEmblem.color, 0);
                    }
                    else
                    {
                        this.utilApi.changeColor(target.getChildByName("up"), data.upEmblem.color, 0, true);
                    };
                };
            };
        }

        private function onOpenOneAlliance(alliance:Object):void
        {
            this._data = alliance;
            this.updateInformations();
        }


    }
}//package ui


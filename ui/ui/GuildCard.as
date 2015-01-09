package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2api.DataApi;
    import d2api.SocialApi;
    import d2api.TimeApi;
    import d2api.PlayedCharacterApi;
    import d2api.ChatApi;
    import d2data.GuildWrapper;
    import d2components.Label;
    import d2components.Texture;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import d2hooks.OpenOneGuild;
    import d2enums.ComponentHookList;
    import d2data.AllianceWrapper;
    import d2data.GuildFactSheetWrapper;
    import d2actions.AllianceInvitation;
    import d2data.EmblemSymbol;
    import d2hooks.*;
    import d2actions.*;

    public class GuildCard 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var utilApi:UtilApi;
        public var dataApi:DataApi;
        public var socialApi:SocialApi;
        public var timeApi:TimeApi;
        public var playerApi:PlayedCharacterApi;
        public var chatApi:ChatApi;
        private var _data:Object;
        private var _myGuild:GuildWrapper;
        public var lbl_name:Label;
        public var lbl_alliance:Label;
        public var lbl_level:Label;
        public var lbl_creationDate:Label;
        public var lbl_leader:Label;
        public var lbl_taxcollectors:Label;
        public var lbl_members:Label;
        public var tx_emblemBack:Texture;
        public var tx_emblemUp:Texture;
        public var tx_disabled:Texture;
        public var gd_members:Grid;
        public var btn_inviteInAlliance:ButtonContainer;
        public var btn_close:ButtonContainer;


        public function main(... args):void
        {
            this.sysApi.addHook(OpenOneGuild, this.onOpenOneGuild);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addComponentHook(this.btn_inviteInAlliance, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_inviteInAlliance, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_inviteInAlliance, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_disabled, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_disabled, ComponentHookList.ON_ROLL_OUT);
            this.tx_emblemBack.dispatchMessages = true;
            this.tx_emblemUp.dispatchMessages = true;
            this.uiApi.addComponentHook(this.tx_emblemBack, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.tx_emblemUp, ComponentHookList.ON_TEXTURE_READY);
            this._data = args[0].guild;
            this._myGuild = this.socialApi.getGuild();
            this.updateInformations();
        }

        public function unload():void
        {
        }

        public function updateMemberLine(data:*, components:*, selected:Boolean):void
        {
            if (data != null)
            {
                components.lbl_memberName.text = (((((("{player," + data.name) + ",") + data.id) + "::") + data.name) + "}");
                components.lbl_memberLvl.text = data.level;
            }
            else
            {
                components.lbl_memberName.text = "";
                components.lbl_memberLvl.text = "";
            };
        }

        private function updateInformations():void
        {
            var alliance:AllianceWrapper;
            var leaderGuild:GuildFactSheetWrapper;
            this.lbl_name.text = this._data.guildName;
            this.btn_inviteInAlliance.visible = false;
            if (this._data.allianceId)
            {
                this.lbl_alliance.text = ((this.uiApi.getText("ui.common.alliance") + this.uiApi.getText("ui.common.colon")) + this.chatApi.getAllianceLink(this._data, this._data.allianceName));
            }
            else
            {
                this.lbl_alliance.text = this.uiApi.getText("ui.alliance.noAllianceForThisGuild");
                if (this.socialApi.hasAlliance())
                {
                    alliance = this.socialApi.getAlliance();
                    leaderGuild = alliance.guilds[0];
                    if ((((this._myGuild.guildId == leaderGuild.guildId)) && (this.socialApi.hasGuildRight(this.playerApi.id(), "isBoss"))))
                    {
                        this.btn_inviteInAlliance.visible = true;
                    };
                };
            };
            this.lbl_level.text = this._data.guildLevel;
            this.lbl_creationDate.text = this.timeApi.getDofusDate((this._data.creationDate * 1000));
            this.lbl_leader.text = (((((("{player," + this._data.leaderName) + ",") + this._data.leaderId) + "::") + this._data.leaderName) + "}");
            this.lbl_members.text = this._data.nbMembers;
            this.lbl_taxcollectors.text = this.uiApi.processText(this.uiApi.getText("ui.guild.taxcollectorsCurrentlyCollecting", this._data.nbTaxCollectors), "n", (this._data.nbTaxCollectors < 2));
            if (this._data.enabled)
            {
                this.tx_disabled.visible = false;
            }
            else
            {
                this.tx_disabled.visible = true;
            };
            this.tx_emblemBack.uri = this._data.backEmblem.fullSizeIconUri;
            this.tx_emblemUp.uri = this._data.upEmblem.fullSizeIconUri;
            if (((this._data.members) && (this._data.members.length)))
            {
                this.gd_members.dataProvider = this._data.members;
            }
            else
            {
                this.gd_members.dataProvider = new Array();
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_inviteInAlliance:
                    this.sysApi.sendAction(new AllianceInvitation(this._data.leaderId));
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.btn_inviteInAlliance:
                    tooltipText = this.uiApi.getText("ui.alliance.inviteLeader", this._data.leaderName);
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
            if (target.name.indexOf("tx_emblemBack") != -1)
            {
                this.utilApi.changeColor(target.getChildByName("back"), this._data.backEmblem.color, 1);
            }
            else
            {
                if (target.name.indexOf("tx_emblemUp") != -1)
                {
                    icon = this.dataApi.getEmblemSymbol(this._data.upEmblem.idEmblem);
                    if (icon.colorizable)
                    {
                        this.utilApi.changeColor(target.getChildByName("up"), this._data.upEmblem.color, 0);
                    }
                    else
                    {
                        this.utilApi.changeColor(target.getChildByName("up"), this._data.upEmblem.color, 0, true);
                    };
                };
            };
        }

        private function onOpenOneGuild(guild:Object):void
        {
            this._data = guild;
            this.updateInformations();
        }


    }
}//package ui


package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.SocialApi;
    import d2api.DataApi;
    import d2api.SoundApi;
    import flash.utils.Dictionary;
    import d2components.GraphicContainer;
    import d2components.ComboBox;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import d2components.Label;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2actions.GuildChangeMemberParameters;
    import d2actions.*;
    import d2hooks.*;

    public class GuildMemberRights 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var socialApi:SocialApi;
        public var dataApi:DataApi;
        public var soundApi:SoundApi;
        private var _rightsList:Array;
        private var _memberInfo:Object;
        private var _playerId:uint;
        private var _percentXP:int;
        private var _playerRank:uint;
        private var _rankIndex:int;
        private var _currentRankId:uint;
        private var _partChangeRights:Boolean;
        private var _rigthBtnList:Dictionary;
        public var mainCtr:GraphicContainer;
        public var cbRank:ComboBox;
        public var gd_list:Grid;
        public var btnModify:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var btn_changeGuildXP:ButtonContainer;
        public var lbl_title:Label;
        public var lbl_rank:Label;
        public var lbl_guildXP:Label;

        public function GuildMemberRights()
        {
            this._rigthBtnList = new Dictionary(true);
            super();
        }

        public function main(params:Object):void
        {
            var rankList:Object;
            var cbProvider:Array;
            var rankListSize:int;
            var currentRank:Object;
            var i:int;
            var rankName:Object;
            var rankObject:Object;
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.btnModify.soundId = SoundEnum.OK_BUTTON;
            this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
            this._memberInfo = params.memberInfo;
            this._partChangeRights = params.rightsToChange;
            var drm:Boolean = params.displayRightsMember;
            var manageRanks:Boolean = params.allowToManageRank;
            this.uiApi.addComponentHook(this.btn_changeGuildXP, "onRelease");
            this.uiApi.addComponentHook(this.cbRank, "onSelectItem");
            this.uiApi.addComponentHook(this.btn_close, "onRelease");
            this.uiApi.addComponentHook(this.btnModify, "onRelease");
            var myId:int = this.playerApi.id();
            this._playerId = this._memberInfo.id;
            this._percentXP = this._memberInfo.experienceGivenPercent;
            this._playerRank = this._memberInfo.rank;
            this._currentRankId = this._playerRank;
            this.lbl_guildXP.text = (this._percentXP + " %");
            this.lbl_title.text = ((((this._memberInfo.name + " - <font size='14'>") + this.uiApi.getText("ui.common.short.level")) + this._memberInfo.level) + "</font>");
            if (!params.manageXPContribution)
            {
                if (!((params.manageMyXPContribution) && (params.selfPlayerItem)))
                {
                    this.btn_changeGuildXP.disabled = true;
                };
            };
            this._rightsList = new Array();
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsAllRights"),
                "rightString":"manageRights",
                "selected":this.socialApi.hasGuildRight(this._playerId, "manageRights"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "manageRights"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsBoost"),
                "rightString":"manageGuildBoosts",
                "selected":this.socialApi.hasGuildRight(this._playerId, "manageGuildBoosts"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "manageGuildBoosts"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsRights"),
                "rightString":"manageLightRights",
                "selected":this.socialApi.hasGuildRight(this._playerId, "manageLightRights"),
                "disabled":((!(drm)) || (this._partChangeRights))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsInvit"),
                "rightString":"inviteNewMembers",
                "selected":this.socialApi.hasGuildRight(this._playerId, "inviteNewMembers"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "inviteNewMembers"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsBann"),
                "rightString":"banMembers",
                "selected":this.socialApi.hasGuildRight(this._playerId, "banMembers"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "banMembers"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsPercentXP"),
                "rightString":"manageXPContribution",
                "selected":this.socialApi.hasGuildRight(this._playerId, "manageXPContribution"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "manageXPContribution"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightManageOwnXP"),
                "rightString":"manageMyXpContribution",
                "selected":this.socialApi.hasGuildRight(this._playerId, "manageMyXpContribution"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "manageMyXpContribution"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsRank"),
                "rightString":"manageRanks",
                "selected":this.socialApi.hasGuildRight(this._playerId, "manageRanks"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "manageRanks"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsPrioritizeMe"),
                "rightString":"prioritizeMeInDefense",
                "selected":this.socialApi.hasGuildRight(this._playerId, "prioritizeMeInDefense"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "prioritizeMeInDefense"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsHiretax"),
                "rightString":"hireTaxCollector",
                "selected":this.socialApi.hasGuildRight(this._playerId, "hireTaxCollector"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "hireTaxCollector"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsCollect"),
                "rightString":"collect",
                "selected":this.socialApi.hasGuildRight(this._playerId, "collect"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "collect"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsCollectMy"),
                "rightString":"collectMyTaxCollectors",
                "selected":this.socialApi.hasGuildRight(this._playerId, "collectMyTaxCollectors"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "collectMyTaxCollectors"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsMountParkUse"),
                "rightString":"useFarms",
                "selected":this.socialApi.hasGuildRight(this._playerId, "useFarms"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "useFarms"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsMountParkArrange"),
                "rightString":"organizeFarms",
                "selected":this.socialApi.hasGuildRight(this._playerId, "organizeFarms"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "organizeFarms"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsManageOtherMount"),
                "rightString":"takeOthersRidesInFarm",
                "selected":this.socialApi.hasGuildRight(this._playerId, "takeOthersRidesInFarm"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "takeOthersRidesInFarm"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsSetAlliancePrism"),
                "rightString":"setAlliancePrism",
                "selected":this.socialApi.hasGuildRight(this._playerId, "setAlliancePrism"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "setAlliancePrism"))))))
            });
            this._rightsList.push({
                "drm":drm,
                "name":this.uiApi.getText("ui.social.guildRightsTalkInAllianceChannel"),
                "rightString":"talkInAllianceChannel",
                "selected":this.socialApi.hasGuildRight(this._playerId, "talkInAllianceChannel"),
                "disabled":((!(drm)) || (((this._partChangeRights) && (!(this.socialApi.hasGuildRight(myId, "talkInAllianceChannel"))))))
            });
            this.gd_list.dataProvider = this._rightsList;
            if (manageRanks)
            {
                rankList = this.dataApi.getAllRankNames();
                cbProvider = new Array();
                rankListSize = rankList.length;
                i = 0;
                while (i < rankListSize)
                {
                    rankName = rankList[i];
                    rankObject = {
                        "order":rankName.order,
                        "label":rankName.name,
                        "rankId":rankName.id
                    };
                    if (((!((rankObject.rankId == 1))) || (params.iamBoss)))
                    {
                        cbProvider.push(rankObject);
                    };
                    if (rankName.id == this._playerRank)
                    {
                        currentRank = rankObject;
                    };
                    i++;
                };
                cbProvider.sortOn("order", Array.NUMERIC);
                this.cbRank.dataProvider = cbProvider;
                this.cbRank.value = currentRank;
                this._rankIndex = this.cbRank.selectedIndex;
                this.cbRank.visible = true;
                this.lbl_rank.visible = false;
            }
            else
            {
                this.cbRank.visible = false;
                this.lbl_rank.visible = true;
                this.lbl_rank.text = this.dataApi.getRankName(this._playerRank).name;
            };
        }

        public function unload():void
        {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
        }

        public function updateRightLine(data:*, componentsRef:*, selected:Boolean):void
        {
            var selectedChk:Boolean;
            if (!(this._rigthBtnList[componentsRef.lblcb_right.name]))
            {
                this.uiApi.addComponentHook(componentsRef.lblcb_right, "onRelease");
            };
            this._rigthBtnList[componentsRef.lblcb_right.name] = data;
            if (data)
            {
                componentsRef.btn_label_lblcb_right.text = data.name;
                componentsRef.lblcb_right.selected = data.selected;
                componentsRef.lblcb_right.visible = true;
                componentsRef.lblcb_right.disabled = data.disabled;
            }
            else
            {
                componentsRef.lblcb_right.visible = false;
            };
        }

        private function rightsToArray():Array
        {
            var right:Object;
            var rightsList:Array = new Array();
            for each (right in this._rightsList)
            {
                if (right.selected)
                {
                    rightsList.push(right.rightString);
                };
            };
            return (rightsList);
        }

        private function onConfirmNewBoss():void
        {
            this._playerRank = 1;
            this._rankIndex = this.cbRank.selectedIndex;
        }

        private function onCancelNewBoss():void
        {
            this.cbRank.selectedIndex = this._rankIndex;
        }

        private function onValidQty(qty:Number):void
        {
            this._percentXP = qty;
            this.lbl_guildXP.text = (qty + " %");
        }

        public function onRelease(target:Object):void
        {
            var right:Object;
            var vsv:int;
            if (target.name.indexOf("lblcb_right") != -1)
            {
                for each (right in this._rightsList)
                {
                    if (right.rightString == this._rigthBtnList[target.name].rightString)
                    {
                        right.selected = !(right.selected);
                        break;
                    };
                };
                vsv = this.gd_list.verticalScrollValue;
                this.gd_list.updateItems();
                this.gd_list.verticalScrollValue = vsv;
            }
            else
            {
                if (target == this.btnModify)
                {
                    this.sysApi.sendAction(new GuildChangeMemberParameters(this._playerId, this._playerRank, this._percentXP, this.rightsToArray()));
                    this.uiApi.unloadUi("guildMemberRights");
                }
                else
                {
                    if (target == this.btn_close)
                    {
                        this.uiApi.unloadUi("guildMemberRights");
                    }
                    else
                    {
                        if (target == this.btn_changeGuildXP)
                        {
                            this.modCommon.openQuantityPopup(0, 90, this._percentXP, this.onValidQty, null, true);
                        };
                    };
                };
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (target == this.cbRank)
            {
                if (((isNewSelection) && (!((selectMethod == 2)))))
                {
                    if ((((target.value.rankId == 1)) && (!((this._currentRankId == 1)))))
                    {
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.social.doUGiveRights", this._memberInfo.name), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmNewBoss, this.onCancelNewBoss], this.onConfirmNewBoss, this.onCancelNewBoss);
                    }
                    else
                    {
                        this._playerRank = target.value.rankId;
                        this._rankIndex = target.selectedIndex;
                    };
                };
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    this.sysApi.sendAction(new GuildChangeMemberParameters(this._playerId, this._playerRank, this._percentXP, this.rightsToArray()));
                    this.uiApi.unloadUi("guildMemberRights");
                    return (true);
                case "closeUi":
                    this.uiApi.unloadUi("guildMemberRights");
                    return (true);
            };
            return (false);
        }


    }
}//package ui


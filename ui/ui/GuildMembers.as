package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2api.SocialApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import flash.utils.Dictionary;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.Texture;
    import d2hooks.GuildInformationsMembers;
    import d2hooks.MemberWarningState;
    import d2hooks.GuildInformationsMemberUpdate;
    import d2actions.GuildGetInformations;
    import d2enums.GuildInformationsTypeEnum;
    import d2data.Smiley;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofusModuleLibrary.utils.PlayerGuildRights;
    import d2enums.PlayerStatusEnum;
    import d2actions.GuildKickRequest;
    import d2network.GuildMember;
    import d2actions.MemberWarningSet;
    import d2network.PlayerStatusExtended;
    import d2hooks.*;
    import d2actions.*;

    public class GuildMembers 
    {

        private static var _showOfflineMembers:Boolean = false;
        private static var _warnWhenMemberIsOnline:Boolean = false;
        public static var playerRights:uint;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var utilApi:UtilApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var socialApi:SocialApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        private var _membersList:Object;
        private var _iconsPath:String;
        private var _bDescendingSort:Boolean = false;
        private var _compsLblName:Dictionary;
        private var _compsBtnKick:Dictionary;
        private var _compsBtnRights:Dictionary;
        private var _compTxStatus:Dictionary;
        private var _memberIdWaitingForKick:int;
        public var gd_list:Grid;
        public var btn_showOfflineMembers:ButtonContainer;
        public var btn_warnWhenMemberIsOnline:ButtonContainer;
        public var lbl_membersLevel:Label;
        public var btn_tabBreed:ButtonContainer;
        public var btn_tabName:ButtonContainer;
        public var btn_tabRank:ButtonContainer;
        public var btn_tabLevel:ButtonContainer;
        public var btn_tabXP:ButtonContainer;
        public var btn_tabXPP:ButtonContainer;
        public var btn_tabAchievement:ButtonContainer;
        public var btn_tabState:ButtonContainer;
        public var tx_status:Texture;

        public function GuildMembers()
        {
            this._compsLblName = new Dictionary(true);
            this._compsBtnKick = new Dictionary(true);
            this._compsBtnRights = new Dictionary(true);
            this._compTxStatus = new Dictionary(true);
            super();
        }

        public function main(... params):void
        {
            this.sysApi.addHook(GuildInformationsMembers, this.onGuildMembersUpdated);
            this.sysApi.addHook(MemberWarningState, this.onMemberWarningState);
            this.sysApi.addHook(GuildInformationsMemberUpdate, this.onGuildInformationsMemberUpdate);
            this.uiApi.addComponentHook(this.btn_showOfflineMembers, "onRelease");
            this.uiApi.addComponentHook(this.btn_warnWhenMemberIsOnline, "onRelease");
            this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_MEMBERS));
            this._iconsPath = this.uiApi.me().getConstant("icons_uri");
            this.btn_showOfflineMembers.selected = _showOfflineMembers;
            this.btn_warnWhenMemberIsOnline.selected = this.socialApi.getWarnOnMemberConnec();
        }

        public function unload():void
        {
        }

        public function updateGuildMemberLine(data:*, components:*, selected:Boolean):void
        {
            var memberInfo:Object;
            var displayRightsMember:Boolean;
            var selfPlayerItem:Boolean;
            var sexString:String;
            var smiley:Smiley;
            if (!(this._compsBtnKick[components.btn_kick.name]))
            {
                this.uiApi.addComponentHook(components.btn_kick, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(components.btn_kick, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_kick, ComponentHookList.ON_ROLL_OUT);
            };
            this._compsBtnKick[components.btn_kick.name] = data;
            if (!(this._compsBtnRights[components.btn_rights.name]))
            {
                this.uiApi.addComponentHook(components.btn_rights, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(components.btn_rights, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_rights, ComponentHookList.ON_ROLL_OUT);
            };
            this._compsBtnRights[components.btn_rights.name] = data;
            if (!(this._compsLblName[components.lbl_playerName.name]))
            {
                this.uiApi.addComponentHook(components.lbl_playerName, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.lbl_playerName, ComponentHookList.ON_ROLL_OUT);
            };
            this._compsLblName[components.lbl_playerName.name] = data;
            if (!(this._compTxStatus[components.tx_status.name]))
            {
                this.uiApi.addComponentHook(components.tx_status, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.tx_status, ComponentHookList.ON_ROLL_OUT);
            };
            this._compTxStatus[components.tx_status.name] = data;
            if (data != null)
            {
                memberInfo = data.member;
                displayRightsMember = ((((((((((((data.displayRightsMember) || (PlayerGuildRights.isBoss(playerRights)))) || (PlayerGuildRights.manageGuildBoosts(playerRights)))) || (PlayerGuildRights.manageRanks(playerRights)))) || (PlayerGuildRights.manageRights(playerRights)))) || (PlayerGuildRights.manageLightRights(playerRights)))) || (PlayerGuildRights.manageXPContribution(playerRights)));
                selfPlayerItem = (this.playerApi.id() == memberInfo.id);
                components.lbl_rank.text = data.rankName;
                components.lbl_lvl.text = memberInfo.level;
                components.lbl_XPP.text = (memberInfo.experienceGivenPercent + "%");
                components.lbl_XP.text = this.utilApi.kamasToString(memberInfo.givenExperience, "");
                components.tx_mood.uri = null;
                components.tx_status.uri = null;
                if (memberInfo.sex)
                {
                    sexString = "1";
                }
                else
                {
                    sexString = "0";
                };
                components.tx_head.uri = this.uiApi.createUri(((((this.uiApi.me().getConstant("heads") + data.breed) + "") + data.sex) + ".png"));
                if (memberInfo.alignmentSide > 0)
                {
                    components.tx_alignment.uri = this.uiApi.createUri((this.uiApi.me().getConstant("alignment_uri") + memberInfo.alignmentSide));
                }
                else
                {
                    components.tx_alignment.uri = null;
                };
                if (data.achievementPoints == -1)
                {
                    components.lbl_achievement.text = "-";
                }
                else
                {
                    components.lbl_achievement.text = data.achievementPoints;
                };
                if (memberInfo.connected == 0)
                {
                    components.tx_state.uri = this.uiApi.createUri(this.uiApi.me().getConstant("offline_uri"));
                    components.lbl_playerName.text = memberInfo.name;
                }
                else
                {
                    if (memberInfo.connected == 1)
                    {
                        components.lbl_playerName.text = (((((("{player," + memberInfo.name) + ",") + memberInfo.id) + "::") + memberInfo.name) + "}");
                        components.tx_state.uri = null;
                        if (memberInfo.moodSmileyId != -1)
                        {
                            smiley = this.dataApi.getSmiley(memberInfo.moodSmileyId);
                            if (smiley)
                            {
                                components.tx_mood.uri = this.uiApi.createUri((this.uiApi.me().getConstant("smilies_uri") + smiley.gfxId));
                            };
                        };
                    }
                    else
                    {
                        if (memberInfo.connected != 2)
                        {
                            if (memberInfo.connected == 99)
                            {
                                components.lbl_playerName.text = memberInfo.name;
                                components.tx_state.uri = null;
                            }
                            else
                            {
                                components.lbl_playerName.text = memberInfo.name;
                                components.tx_state.uri = null;
                            };
                        };
                    };
                };
                if (memberInfo.connected != 0)
                {
                    if (memberInfo.status.statusId)
                    {
                        switch (memberInfo.status.statusId)
                        {
                            case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                                components.tx_status.uri = this.uiApi.createUri((this._iconsPath + "|available"));
                                break;
                            case PlayerStatusEnum.PLAYER_STATUS_AFK:
                            case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                                components.tx_status.uri = this.uiApi.createUri((this._iconsPath + "|away"));
                                break;
                            case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                                components.tx_status.uri = this.uiApi.createUri((this._iconsPath + "|private"));
                                break;
                            case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                                components.tx_status.uri = this.uiApi.createUri((this._iconsPath + "|solo"));
                                break;
                        };
                    }
                    else
                    {
                        components.tx_status.uri = null;
                    };
                };
                if (data.displayBanMember)
                {
                    components.btn_kick.visible = true;
                }
                else
                {
                    components.btn_kick.visible = selfPlayerItem;
                };
                if (displayRightsMember)
                {
                    components.btn_rights.visible = true;
                }
                else
                {
                    components.btn_rights.visible = selfPlayerItem;
                };
            }
            else
            {
                components.lbl_playerName.text = "";
                components.lbl_rank.text = "";
                components.lbl_lvl.text = "";
                components.lbl_XPP.text = "";
                components.lbl_XP.text = "";
                components.tx_alignment.uri = null;
                components.tx_head.uri = null;
                components.tx_state.uri = null;
                components.tx_mood.uri = null;
                components.btn_rights.visible = false;
                components.btn_kick.visible = false;
                components.tx_status.uri = null;
                components.lbl_achievement.text = "";
            };
        }

        private function popupDeletePlayer(data:Object):void
        {
            var text:String;
            if (((data.isBoss) && (!(data.isAlone))))
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.social.guildBossCantBeBann"), [this.uiApi.getText("ui.common.ok")]);
            }
            else
            {
                if (this.playerApi.id() == data.member.id)
                {
                    text = this.uiApi.getText("ui.social.doUDeleteYou");
                }
                else
                {
                    text = this.uiApi.getText("ui.social.doUDeleteMember", data.member.name);
                };
                this._memberIdWaitingForKick = data.member.id;
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), text, [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmDeletePlayer, this.onCancelDeletePlayer], this.onConfirmDeletePlayer, this.onCancelDeletePlayer);
            };
        }

        private function onConfirmDeletePlayer():void
        {
            this.sysApi.sendAction(new GuildKickRequest(this._memberIdWaitingForKick));
            this._memberIdWaitingForKick = 0;
        }

        private function onCancelDeletePlayer():void
        {
            this._memberIdWaitingForKick = 0;
        }

        private function displayMemberRights(data:Object):void
        {
            if (this.uiApi.getUi("guildMemberRights") != null)
            {
                this.uiApi.unloadUi("guildMemberRights");
            };
            var manageOtherPlayersRights:Boolean = ((((((PlayerGuildRights.isBoss(playerRights)) || (PlayerGuildRights.manageGuildBoosts(playerRights)))) || (PlayerGuildRights.manageRights(playerRights)))) || (PlayerGuildRights.manageLightRights(playerRights)));
            var lightManage:Boolean = ((((PlayerGuildRights.manageLightRights(playerRights)) && (!(PlayerGuildRights.isBoss(playerRights))))) && (!(PlayerGuildRights.manageRights(playerRights))));
            this.uiApi.loadUi("guildMemberRights", "guildMemberRights", {
                "memberInfo":data.member,
                "displayRightsMember":manageOtherPlayersRights,
                "allowToManageRank":data.manageRanks,
                "manageXPContribution":data.manageXPContribution,
                "manageMyXPContribution":data.manageMyXPContribution,
                "selfPlayerItem":(this.playerApi.id() == data.member.id),
                "iamBoss":PlayerGuildRights.isBoss(playerRights),
                "rightsToChange":lightManage
            });
        }

        private function onGuildMembersUpdated(members:Object):void
        {
            var member:GuildMember;
            this._membersList = members;
            var listDisplayed:Array = new Array();
            var totalMembers:int = members.length;
            var totalLevels:int;
            var connected:int;
            var manageXPContribution:Boolean = this.socialApi.getGuild().manageXPContribution;
            for each (member in this._membersList)
            {
                if (member.id == this.playerApi.id())
                {
                    playerRights = member.rights;
                };
                totalLevels = (totalLevels + member.level);
                if (((member.connected) || (_showOfflineMembers)))
                {
                    listDisplayed.push(this.createMemberObject(member, (totalMembers == 1)));
                    if (member.connected)
                    {
                        connected++;
                    };
                };
            };
            listDisplayed.sortOn("rankOrder", Array.NUMERIC);
            this.gd_list.dataProvider = listDisplayed;
            this.lbl_membersLevel.text = ((this.uiApi.getText("ui.social.guildAvgMembersLevel") + this.uiApi.getText("ui.common.colon")) + int((totalLevels / totalMembers)));
            this.uiApi.getUi("subSocialUi").uiClass.lbl_members.text = ((connected + " / ") + totalMembers);
        }

        public function onGuildInformationsMemberUpdate(memberInfo:Object):void
        {
            var member:GuildMember;
            var index:int;
            var i:int;
            for each (member in this._membersList)
            {
                if (member.id == memberInfo.id)
                {
                    member = (memberInfo as GuildMember);
                    index = 0;
                    i = 0;
                    while (i < this.gd_list.dataProvider.length)
                    {
                        if (this.gd_list.dataProvider[i].id == memberInfo.id)
                        {
                            index = i;
                        };
                        i++;
                    };
                    this.gd_list.updateItem(index);
                    return;
                };
            };
        }

        private function onMemberWarningState(enable:Boolean):void
        {
            if (this.btn_warnWhenMemberIsOnline.selected != enable)
            {
                this.btn_warnWhenMemberIsOnline.selected = enable;
            };
        }

        private function createMemberObject(member:Object, isAlone:Boolean):Object
        {
            var guild:Object = this.socialApi.getGuild();
            var memberObject:Object = new Object();
            memberObject.id = member.id;
            memberObject.member = member;
            memberObject.manageXPContribution = guild.manageXPContribution;
            memberObject.manageMyXPContribution = guild.manageMyXpContribution;
            memberObject.manageRanks = guild.manageRanks;
            memberObject.displayBanMember = guild.banMembers;
            memberObject.displayRightsMember = guild.manageRights;
            memberObject.displayLightRightsMember = guild.manageLightRights;
            memberObject.name = member.name;
            memberObject.breed = member.breed;
            var rank:Object = this.dataApi.getRankName(member.rank);
            memberObject.isBoss = (member.rank == 1);
            memberObject.rankName = rank.name;
            memberObject.rankOrder = rank.order;
            memberObject.level = member.level;
            memberObject.XP = member.givenExperience;
            memberObject.XPP = member.experienceGivenPercent;
            memberObject.state = member.connected;
            memberObject.sex = ((member.sex) ? 1 : 0);
            memberObject.isAlone = isAlone;
            memberObject.achievementPoints = member.achievementPoints;
            memberObject.status = member.status;
            return (memberObject);
        }

        public function onRelease(target:Object):void
        {
            var data:Object;
            var data2:Object;
            if (target == this.btn_showOfflineMembers)
            {
                _showOfflineMembers = this.btn_showOfflineMembers.selected;
                if (this._membersList != null)
                {
                    this.onGuildMembersUpdated(this._membersList);
                };
            }
            else
            {
                if (target == this.btn_warnWhenMemberIsOnline)
                {
                    this.sysApi.sendAction(new MemberWarningSet(this.btn_warnWhenMemberIsOnline.selected));
                }
                else
                {
                    if (target == this.btn_tabBreed)
                    {
                        if (this._bDescendingSort)
                        {
                            this.gd_list.sortOn("breed", Array.NUMERIC);
                        }
                        else
                        {
                            this.gd_list.sortOn("breed", (Array.NUMERIC | Array.DESCENDING));
                        };
                        this._bDescendingSort = !(this._bDescendingSort);
                    }
                    else
                    {
                        if (target == this.btn_tabName)
                        {
                            if (this._bDescendingSort)
                            {
                                this.gd_list.sortOn("name", Array.CASEINSENSITIVE);
                            }
                            else
                            {
                                this.gd_list.sortOn("name", (Array.CASEINSENSITIVE | Array.DESCENDING));
                            };
                            this._bDescendingSort = !(this._bDescendingSort);
                        }
                        else
                        {
                            if (target == this.btn_tabRank)
                            {
                                if (this._bDescendingSort)
                                {
                                    this.gd_list.sortOn("rankOrder", Array.NUMERIC);
                                }
                                else
                                {
                                    this.gd_list.sortOn("rankOrder", (Array.NUMERIC | Array.DESCENDING));
                                };
                                this._bDescendingSort = !(this._bDescendingSort);
                            }
                            else
                            {
                                if (target == this.btn_tabLevel)
                                {
                                    if (this._bDescendingSort)
                                    {
                                        this.gd_list.sortOn("level", Array.NUMERIC);
                                    }
                                    else
                                    {
                                        this.gd_list.sortOn("level", (Array.NUMERIC | Array.DESCENDING));
                                    };
                                    this._bDescendingSort = !(this._bDescendingSort);
                                }
                                else
                                {
                                    if (target == this.btn_tabXP)
                                    {
                                        if (this._bDescendingSort)
                                        {
                                            this.gd_list.sortOn("XP", Array.NUMERIC);
                                        }
                                        else
                                        {
                                            this.gd_list.sortOn("XP", (Array.NUMERIC | Array.DESCENDING));
                                        };
                                        this._bDescendingSort = !(this._bDescendingSort);
                                    }
                                    else
                                    {
                                        if (target == this.btn_tabXPP)
                                        {
                                            if (this._bDescendingSort)
                                            {
                                                this.gd_list.sortOn("XPP", Array.NUMERIC);
                                            }
                                            else
                                            {
                                                this.gd_list.sortOn("XPP", (Array.NUMERIC | Array.DESCENDING));
                                            };
                                            this._bDescendingSort = !(this._bDescendingSort);
                                        }
                                        else
                                        {
                                            if (target == this.btn_tabAchievement)
                                            {
                                                if (this._bDescendingSort)
                                                {
                                                    this.gd_list.sortOn("achievementPoints", Array.NUMERIC);
                                                }
                                                else
                                                {
                                                    this.gd_list.sortOn("achievementPoints", (Array.NUMERIC | Array.DESCENDING));
                                                };
                                                this._bDescendingSort = !(this._bDescendingSort);
                                            }
                                            else
                                            {
                                                if (target == this.btn_tabState)
                                                {
                                                    if (this._bDescendingSort)
                                                    {
                                                        this.gd_list.sortOn("state", Array.NUMERIC);
                                                    }
                                                    else
                                                    {
                                                        this.gd_list.sortOn("state", (Array.NUMERIC | Array.DESCENDING));
                                                    };
                                                    this._bDescendingSort = !(this._bDescendingSort);
                                                }
                                                else
                                                {
                                                    if (target.name.indexOf("btn_rights") != -1)
                                                    {
                                                        data = this._compsBtnRights[target.name];
                                                        this.displayMemberRights(data);
                                                    }
                                                    else
                                                    {
                                                        if (target.name.indexOf("btn_kick") != -1)
                                                        {
                                                            data2 = this._compsBtnKick[target.name];
                                                            this.popupDeletePlayer(data2);
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var data:Object;
            var memberInfo:Object;
            var months:int;
            var days:int;
            var hours:int;
            var argText:String;
            var sdata:Object;
            var memberStatusInfo:Object;
            var point:uint = 6;
            var relPoint:uint;
            if (target.name.indexOf("btn_rights") != -1)
            {
                tooltipText = this.uiApi.getText("ui.social.guildManageRights");
            }
            else
            {
                if (target.name.indexOf("btn_kick") != -1)
                {
                    tooltipText = this.uiApi.getText("ui.charsel.characterDelete");
                }
                else
                {
                    if (target.name.indexOf("lbl_playerName") != -1)
                    {
                        data = this._compsLblName[target.name];
                        if (!(data))
                        {
                            return;
                        };
                        memberInfo = data.member;
                        if (((memberInfo) && ((memberInfo.connected == 0))))
                        {
                            months = Math.floor((memberInfo.hoursSinceLastConnection / 720));
                            days = ((memberInfo.hoursSinceLastConnection - (months * 720)) / 24);
                            hours = ((memberInfo.hoursSinceLastConnection - (days * 24)) - (months * 720));
                            if (months > 0)
                            {
                                if (days > 0)
                                {
                                    argText = this.uiApi.processText(this.uiApi.getText("ui.social.monthsAndDaysSinceLastConnection", months, days), "m", (days <= 1));
                                }
                                else
                                {
                                    argText = this.uiApi.processText(this.uiApi.getText("ui.social.monthsSinceLastConnection", months), "m", (months <= 1));
                                };
                            }
                            else
                            {
                                if (days > 0)
                                {
                                    argText = this.uiApi.processText(this.uiApi.getText("ui.social.daysSinceLastConnection", days), "m", (days <= 1));
                                }
                                else
                                {
                                    argText = this.uiApi.getText("ui.social.lessThanADay");
                                };
                            };
                            tooltipText = this.uiApi.getText("ui.social.lastConnection", argText);
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("tx_status") != -1)
                        {
                            sdata = this._compTxStatus[target.name];
                            if (!(sdata))
                            {
                                return;
                            };
                            memberStatusInfo = sdata.member;
                            if (((memberStatusInfo) && (!((memberStatusInfo.connected == 0)))))
                            {
                                switch (memberStatusInfo.status.statusId)
                                {
                                    case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                                        tooltipText = this.uiApi.getText("ui.chat.status.availiable");
                                        break;
                                    case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                                        tooltipText = this.uiApi.getText("ui.chat.status.idle");
                                        break;
                                    case PlayerStatusEnum.PLAYER_STATUS_AFK:
                                        tooltipText = this.uiApi.getText("ui.chat.status.away");
                                        if ((((memberStatusInfo.status is PlayerStatusExtended)) && (!((PlayerStatusExtended(memberStatusInfo.status).message == "")))))
                                        {
                                            tooltipText = (tooltipText + (this.uiApi.getText("ui.common.colon") + PlayerStatusExtended(memberStatusInfo.status).message));
                                        };
                                        break;
                                    case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                                        tooltipText = this.uiApi.getText("ui.chat.status.private");
                                        break;
                                    case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                                        tooltipText = this.uiApi.getText("ui.chat.status.solo");
                                        break;
                                };
                            };
                        };
                    };
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


    }
}//package ui


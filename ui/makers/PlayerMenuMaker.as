package makers
{
    import d2hooks.ChatFocus;
    import d2actions.NumericWhoIsRequest;
    import d2hooks.OpenWebPortal;
    import com.ankamagames.dofusModuleLibrary.enum.WebLocationEnum;
    import d2actions.PlayerFightRequest;
    import d2actions.PartyInvitation;
    import d2actions.ExchangePlayerRequest;
    import d2actions.GuildInvitationByName;
    import d2actions.GuildInvitation;
    import d2actions.AddEnemy;
    import d2actions.AddFriend;
    import d2actions.AddIgnored;
    import d2actions.RemoveIgnored;
    import d2actions.HouseKick;
    import d2actions.ExchangePlayerMultiCraftRequest;
    import d2enums.ExchangeTypeEnum;
    import d2actions.BasicWhoIsRequest;
    import d2actions.GuildFactsRequest;
    import d2actions.AllianceFactsRequest;
    import d2actions.ExchangeRequestOnShopStock;
    import d2actions.GameRolePlayFreeSoulRequest;
    import d2actions.ExchangeShowVendorTax;
    import d2actions.PivotCharacter;
    import d2actions.StartZoom;
    import d2hooks.OpenReport;
    import d2actions.ChatTextOutput;
    import d2hooks.ReadyToFight;
    import d2actions.GameContextKick;
    import d2actions.JoinFriend;
    import d2actions.JoinSpouse;
    import d2actions.PartyAbdicateThrone;
    import d2actions.PartyKickRequest;
    import d2actions.PartyLeaveRequest;
    import d2actions.PartyFollowMember;
    import d2actions.PartyAllFollowMember;
    import d2actions.PartyStopFollowingMember;
    import d2actions.PartyAllStopFollowingMember;
    import d2actions.PartyCancelInvitation;
    import d2network.GameRolePlayHumanoidInformations;
    import d2network.GameFightCharacterInformations;
    import d2network.HumanInformations;
    import d2network.HumanOptionGuild;
    import d2network.HumanOptionAlliance;
    import d2network.GameRolePlayCharacterInformations;
    import d2network.GameRolePlayMutantInformations;
    import d2data.PartyMemberWrapper;
    import d2data.OptionalFeature;
    import d2data.SubArea;
    import d2enums.PvpArenaTypeEnum;
    import d2enums.BuildTypeEnum;
    import d2data.PrismSubAreaWrapper;
    import d2data.MapPosition;
    import d2data.AllianceWrapper;
    import d2enums.PrismStateEnum;
    import d2enums.AggressableStatusEnum;
    import d2hooks.*;
    import d2actions.*;

    public class PlayerMenuMaker 
    {

        public static var disabled:Boolean = false;

        protected const SUPERAREA_INCARNAM:uint = 3;

        protected var _playerName:String = null;
        protected var _cellId:int = -1;
        protected var _partyId:int = 0;
        protected var _ava:Boolean;


        protected function onWisperMessage(playerName:String):void
        {
            Api.system.dispatchHook(ChatFocus, playerName);
        }

        protected function onAnkaboxMessage(playerName:String, pPlayerId:uint):void
        {
            var accountId:int = Api.system.getAccountId(playerName);
            if (!(accountId))
            {
                Api.system.sendAction(new NumericWhoIsRequest(pPlayerId));
            };
            Api.system.dispatchHook(OpenWebPortal, WebLocationEnum.WEB_LOCATION_ANKABOX_SEND_MESSAGE, false, [accountId, playerName]);
        }

        protected function onFightChallenge(targetId:uint):void
        {
            Api.system.sendAction(new PlayerFightRequest(targetId, false, true, true, this._cellId));
        }

        protected function onAttack(targetId:int):void
        {
            Api.system.sendAction(new PlayerFightRequest(targetId, this._ava, false, false, this._cellId));
        }

        protected function onInviteMenuClicked(playerName:String):void
        {
            Api.system.sendAction(new PartyInvitation(playerName, 0, false));
        }

        protected function onArenaInvite(playerName:String):void
        {
            Api.system.sendAction(new PartyInvitation(playerName, 0, true));
        }

        protected function onExchangeMenuClicked(playerID:uint):void
        {
            Api.system.sendAction(new ExchangePlayerRequest(1, playerID));
        }

        protected function onGuildInvite(playerID:*):void
        {
            if ((playerID is String))
            {
                Api.system.sendAction(new GuildInvitationByName((playerID as String)));
            }
            else
            {
                Api.system.sendAction(new GuildInvitation((playerID as uint)));
            };
        }

        protected function onAddEnemy(playerName:String):void
        {
            this._playerName = playerName;
            Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"), Api.ui.getText("ui.social.confirmAddEnemy", playerName), [Api.ui.getText("ui.common.yes"), Api.ui.getText("ui.common.no")], [this.onAcceptAddEnemy], this.onAcceptAddEnemy);
        }

        protected function onAcceptAddEnemy():void
        {
            Api.system.sendAction(new AddEnemy(this._playerName));
        }

        protected function onAddFriend(playerName:String):void
        {
            this._playerName = playerName;
            Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"), Api.ui.getText("ui.social.confirmAddFriend", playerName), [Api.ui.getText("ui.common.yes"), Api.ui.getText("ui.common.no")], [this.onAcceptAddFriend], this.onAcceptAddFriend);
        }

        protected function onAcceptAddFriend():void
        {
            Api.system.sendAction(new AddFriend(this._playerName));
        }

        protected function onIgnorePlayer(playerName:String):void
        {
            Api.system.sendAction(new AddIgnored(playerName));
        }

        protected function onUnignorePlayer(playerAccountId:int):void
        {
            Api.system.sendAction(new RemoveIgnored(playerAccountId));
        }

        protected function onHouseKickOff(playerID:uint):void
        {
            Api.system.sendAction(new HouseKick(playerID));
        }

        protected function onMultiCraftCustomerAskClicked(pCrafterId:uint, pSkillId:uint):void
        {
            Api.system.sendAction(new ExchangePlayerMultiCraftRequest(ExchangeTypeEnum.MULTICRAFT_CUSTOMER, pCrafterId, pSkillId));
        }

        protected function onMultiCraftCrafterAskClicked(pCustomerId:uint, pSkillId:uint):void
        {
            Api.system.sendAction(new ExchangePlayerMultiCraftRequest(ExchangeTypeEnum.MULTICRAFT_CRAFTER, pCustomerId, pSkillId));
        }

        protected function onInformations(playerName:String, shouldIOpenCharacterPage:Boolean=false, playerId:int=0):void
        {
            var uid:Number;
            var uri:String;
            if (!(shouldIOpenCharacterPage))
            {
                Api.system.sendAction(new BasicWhoIsRequest(playerName, true));
            }
            else
            {
                uid = ((playerId * 100000) + Api.system.getCurrentServer().id);
                uri = Api.ui.getText("ui.link.characterPage", (Api.system.getCurrentServer().name as String).toLowerCase(), playerName.toLowerCase(), uid);
                Api.system.goToUrl(uri);
            };
        }

        protected function onGuildInformations(guildId:uint):void
        {
            Api.system.sendAction(new GuildFactsRequest(guildId));
        }

        protected function onAllianceInformations(allianceId:uint):void
        {
            Api.system.sendAction(new AllianceFactsRequest(allianceId));
        }

        protected function onManageShoppingModMenuClicked():void
        {
            Api.system.sendAction(new ExchangeRequestOnShopStock());
        }

        protected function onWantFreeSoul():void
        {
            Api.system.sendAction(new GameRolePlayFreeSoulRequest());
        }

        protected function onShoppingModMenuClicked():void
        {
            Api.system.sendAction(new ExchangeShowVendorTax());
        }

        protected function onPivotCharacter():void
        {
            Api.system.sendAction(new PivotCharacter());
        }

        protected function onZoom(playerID:uint):void
        {
            Api.system.sendAction(new StartZoom(playerID, 2));
        }

        protected function onReportClicked(playerID:uint, playerName:String, context:Object=null):void
        {
            Api.system.dispatchHook(OpenReport, playerID, playerName, context);
        }

        protected function onSlapMenuClicked():void
        {
            Api.system.sendAction(new ChatTextOutput(Api.ui.getText("ui.dialog.slapSentence"), 0, null, null));
        }

        protected function onReady():void
        {
            Api.system.dispatchHook(ReadyToFight);
        }

        protected function onKick(targetId:uint):void
        {
            Api.system.sendAction(new GameContextKick(targetId));
        }

        protected function onJoinFriend(targetName:String):void
        {
            Api.system.sendAction(new JoinFriend(targetName));
        }

        protected function onJoinSpouse():void
        {
            Api.system.sendAction(new JoinSpouse());
        }

        protected function promoteLeader(pPartyId:int, pPlayerId:uint):void
        {
            Api.system.sendAction(new PartyAbdicateThrone(pPartyId, pPlayerId));
        }

        protected function kickPlayer(pPartyId:int, pPlayerId:uint):void
        {
            Api.system.sendAction(new PartyKickRequest(pPartyId, pPlayerId));
        }

        protected function leaveParty(pPartyId:int):void
        {
            Api.system.sendAction(new PartyLeaveRequest(pPartyId));
        }

        protected function followThisMember(pPartyId:int, pPlayerId:uint):void
        {
            Api.system.sendAction(new PartyFollowMember(pPartyId, pPlayerId));
        }

        protected function followAllThisMember(pPartyId:int, pPlayerId:uint):void
        {
            Api.system.sendAction(new PartyAllFollowMember(pPartyId, pPlayerId));
        }

        protected function stopFollowingThisMember(pPartyId:int, pPlayerId:uint):void
        {
            Api.system.sendAction(new PartyStopFollowingMember(pPartyId, pPlayerId));
        }

        protected function stopAllFollowingThisMember(pPartyId:int, pPlayerId:uint):void
        {
            Api.system.sendAction(new PartyAllStopFollowingMember(pPartyId, pPlayerId));
        }

        protected function cancelPartyInvitation(pPartyId:int, pGuestId:uint):void
        {
            Api.system.sendAction(new PartyCancelInvitation(pPartyId, pGuestId));
        }

        protected function addPartyMenu(pPlayerId:uint, bIsGuest:Boolean, hostId:int=0, arena:Boolean=false):Array
        {
            var leaderId:int;
            var partyId:int;
            var followingPlayerId:int;
            var menu:Array = new Array();
            if (!(arena))
            {
                menu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.common.party")));
            }
            else
            {
                menu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.common.koliseum")));
            };
            var playerId:uint = Api.player.id();
            if (arena)
            {
                partyId = Api.party.getArenaPartyId();
                leaderId = Api.party.getPartyLeaderId(partyId);
            }
            else
            {
                partyId = Api.party.getPartyId();
                leaderId = Api.party.getPartyLeaderId(partyId);
            };
            var allMemberFollowPlayerId:uint = Api.party.getAllMemberFollowPlayerId(this._partyId);
            if (pPlayerId == playerId)
            {
                if (!(arena))
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.leaveParty"), this.leaveParty, [partyId]));
                }
                else
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.arenaQuit"), this.leaveParty, [partyId]));
                };
                if ((((leaderId == playerId)) && (!(arena))))
                {
                    if (allMemberFollowPlayerId == playerId)
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.stopAllFollowingMe"), this.stopAllFollowingThisMember, [partyId, pPlayerId]));
                    }
                    else
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.followMeAll"), this.followAllThisMember, [partyId, pPlayerId]));
                    };
                };
            }
            else
            {
                if (bIsGuest)
                {
                    if ((((playerId == leaderId)) || ((playerId == hostId))))
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.cancelInvitation"), this.cancelPartyInvitation, [partyId, pPlayerId]));
                    };
                }
                else
                {
                    if (!(arena))
                    {
                        followingPlayerId = Api.player.getFollowingPlayerId();
                        if (followingPlayerId == pPlayerId)
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.stopFollowing"), this.stopFollowingThisMember, [partyId, pPlayerId]));
                        }
                        else
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.follow"), this.followThisMember, [partyId, pPlayerId]));
                        };
                    };
                    if (leaderId == playerId)
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.kickPlayer"), this.kickPlayer, [partyId, pPlayerId]));
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.promotePartyLeader"), this.promoteLeader, [partyId, pPlayerId]));
                        if (!(arena))
                        {
                            if (allMemberFollowPlayerId == pPlayerId)
                            {
                                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.stopAllFollowingHim"), this.stopAllFollowingThisMember, [partyId, pPlayerId]));
                            }
                            else
                            {
                                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.followHimAll"), this.followAllThisMember, [partyId, pPlayerId]));
                            };
                        };
                    };
                };
            };
            if (menu.length > 1)
            {
                return (menu);
            };
            return (new Array());
        }

        public function createMenu(data:*, param:Object):Array
        {
            var infos:GameRolePlayHumanoidInformations;
            var entity:Object;
            var guildInfo:Object;
            var allianceInfo:Object;
            var alignInfo:Object;
            var cantBeChallenged:Boolean;
            var cantExchange:Boolean;
            var option:*;
            var fightInfos:GameFightCharacterInformations;
            if ((data is GameRolePlayHumanoidInformations))
            {
                infos = (data as GameRolePlayHumanoidInformations);
                entity = param[0];
                if (((((entity.hasOwnProperty("position")) && (entity.position))) && (entity.position.hasOwnProperty("cellId"))))
                {
                    this._cellId = entity.position.cellId;
                };
                guildInfo = null;
                allianceInfo = null;
                alignInfo = null;
                cantBeChallenged = false;
                cantExchange = false;
                if ((infos.humanoidInfo is HumanInformations))
                {
                    for each (option in (infos.humanoidInfo as HumanInformations).options)
                    {
                        if ((option is HumanOptionGuild))
                        {
                            guildInfo = option.guildInformations;
                        };
                        if ((option is HumanOptionAlliance))
                        {
                            allianceInfo = option;
                        };
                    };
                    cantBeChallenged = infos.humanoidInfo.restrictions.cantChallenge;
                    cantExchange = infos.humanoidInfo.restrictions.cantExchange;
                };
                if ((infos is GameRolePlayCharacterInformations))
                {
                    alignInfo = (infos as GameRolePlayCharacterInformations).alignmentInfos;
                };
                return (this.createMenu2(infos.name, entity.id, this.getIsMutant(infos), alignInfo, guildInfo, allianceInfo, param[0], infos.accountId, cantBeChallenged, cantExchange));
            };
            if ((data is GameFightCharacterInformations))
            {
                fightInfos = (data as GameFightCharacterInformations);
                return (this.createMenu2(fightInfos.name, fightInfos.contextualId, false));
            };
            return (this.createMenu2(data, 0, false));
        }

        public function getIsMutant(infos:GameRolePlayHumanoidInformations):Boolean
        {
            return ((infos is GameRolePlayMutantInformations));
        }

        public function createMenu2(pPlayerName:String, pPlayerId:uint, isMutant:Boolean, pPlayerAlignement:Object=null, pPlayerGuild:Object=null, pPlayerAlliance:Object=null, pContext:Object=null, pPlayerAccountId:uint=0, cantBeChallenged:Boolean=false, cantExchange:Boolean=false):Array
        {
            var partyHostId:int;
            var arenaPartyHostId:int;
            var partyMember:PartyMemberWrapper;
            var isInMap:Boolean;
            var informationsMenu:Array;
            var feature:OptionalFeature;
            var entityTemp:Object;
            var entityInfos:Object;
            var canJoin:Boolean;
            var currSubArea:SubArea;
            var superArea:Object;
            var zoomAvailable:Boolean;
            var playerSkills:Object;
            var inviteTo:String;
            var skill:Object;
            var otherSkills:Object;
            var askTo:String;
            var menu:Array = new Array();
            var dead:Boolean = !(Api.player.isAlive());
            var playerIsInParty:Boolean;
            var playerIsGuestInParty:Boolean;
            var playerIsInArenaParty:Boolean;
            var playerIsGuestInArenaParty:Boolean;
            var playerInfos:Object = Api.player.getPlayedCharacterInfo();
            if (playerInfos.name == pPlayerName)
            {
                pPlayerId = playerInfos.id;
            };
            for each (partyMember in Api.party.getPartyMembers(0))
            {
                if (partyMember.id == pPlayerId)
                {
                    playerIsInParty = true;
                    playerIsGuestInParty = !(partyMember.isMember);
                    if (playerIsGuestInParty)
                    {
                        partyHostId = partyMember.hostId;
                    };
                };
            };
            for each (partyMember in Api.party.getPartyMembers(1))
            {
                if (partyMember.id == pPlayerId)
                {
                    playerIsInArenaParty = true;
                    playerIsGuestInArenaParty = !(partyMember.isMember);
                    if (playerIsGuestInArenaParty)
                    {
                        arenaPartyHostId = partyMember.hostId;
                    };
                };
            };
            if (((!((pPlayerId == playerInfos.id))) && (!((pPlayerName == playerInfos.name)))))
            {
                isInMap = false;
                if (pPlayerName != null)
                {
                    if (((!(Api.player.isInFight())) && (!(Api.player.isInPreFight()))))
                    {
                        entityTemp = Api.roleplay.getEntityByName(pPlayerName);
                        isInMap = !((entityTemp == null));
                        if (entityTemp)
                        {
                            entityInfos = Api.roleplay.getEntityInfos(entityTemp);
                            if (entityInfos)
                            {
                                pPlayerId = entityInfos.contextualId;
                            };
                        };
                    };
                }
                else
                {
                    if (pPlayerId)
                    {
                        isInMap = Api.roleplay.getPlayerIsInCurrentMap(pPlayerId);
                    };
                };
                menu.push(ContextMenu.static_createContextMenuTitleObject(pPlayerName));
                if (((((Api.player.isInPreFight()) && (Api.fight.isFightLeader()))) && (!((Api.fight.getFighterInformations(pPlayerId) == Api.fight.getFighterInformations(Api.player.id()))))))
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.fight.kick"), this.onKick, [pPlayerId]), ((disabled) || (dead)));
                    menu.push(ContextMenu.static_createContextMenuSeparatorObject());
                };
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.wisperMessage"), this.onWisperMessage, [pPlayerName], disabled));
                if (Api.system.getIsAnkaBoxEnabled())
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.ankaboxMessage"), this.onAnkaboxMessage, [pPlayerName, pPlayerId], disabled));
                };
                if (!(Api.player.isInFight()))
                {
                    if (isInMap)
                    {
                        if (((((!(Api.player.restrictions().cantChallenge)) && (!(cantBeChallenged)))) && (!(dead))))
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.challenge"), this.onFightChallenge, [pPlayerId], ((disabled) || (dead))));
                        };
                        if (((pPlayerAlignement) && (!(dead))))
                        {
                            switch (this.allowAgression(pPlayerAlignement, pPlayerAlliance, isMutant, pPlayerId))
                            {
                                case -1:
                                    break;
                                case 0:
                                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.pvp.assault"), null, null, true));
                                    break;
                                case 1:
                                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.pvp.assault"), this.onAttack, [pPlayerId], ((disabled) || (dead))));
                                    break;
                            };
                        };
                    };
                    if (((isInMap) && (Api.player.isInHisHouse())))
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.kickOff"), this.onHouseKickOff, [pPlayerId], ((disabled) || (dead))));
                    };
                    canJoin = false;
                    currSubArea = Api.map.getCurrentSubArea();
                    if (((((currSubArea) && (currSubArea.area))) && (currSubArea.area.superArea)))
                    {
                        superArea = currSubArea.area.superArea;
                        if (currSubArea.area.superArea.id == this.SUPERAREA_INCARNAM)
                        {
                            canJoin = true;
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.join"), this.onJoinFriend, [pPlayerName], ((disabled) || (dead))));
                        };
                    };
                    if (((((((!(canJoin)) && (Api.social.hasSpouse()))) && (Api.social.getSpouse()))) && ((Api.social.getSpouse().id == pPlayerId))))
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.join"), this.onJoinSpouse, null, ((disabled) || (dead))));
                    };
                    if (isInMap)
                    {
                        zoomAvailable = false;
                        if (pPlayerId)
                        {
                            zoomAvailable = true;
                        };
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.zoom"), this.onZoom, [pPlayerId], ((disabled) || (!(zoomAvailable)))));
                    };
                };
                informationsMenu = new Array();
                informationsMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.details"), this.onInformations, [pPlayerName, false], disabled));
                informationsMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.characterPage"), this.onInformations, [pPlayerName, true, pPlayerId], disabled));
                if (pPlayerGuild)
                {
                    informationsMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.guild.guildInformations"), this.onGuildInformations, [pPlayerGuild.guildId], disabled));
                    if (pPlayerAlliance)
                    {
                        informationsMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.alliance.allianceInformations"), this.onAllianceInformations, [pPlayerAlliance.allianceInformations.allianceId], disabled));
                    };
                };
                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.informations"), null, null, false, informationsMenu));
                menu.push(ContextMenu.static_createContextMenuSeparatorObject());
                if (!(Api.player.isInFight()))
                {
                    if (((((isInMap) && (!(Api.player.restrictions().cantExchange)))) && (!(cantExchange))))
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.exchangeProp"), this.onExchangeMenuClicked, [pPlayerId], ((disabled) || (dead))));
                    };
                };
                if (((!(playerIsInParty)) && ((Api.party.getPartyMembers(0).length < 8))))
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.addToParty"), this.onInviteMenuClicked, [pPlayerName], disabled));
                };
                feature = Api.data.getOptionalFeatureByKeyword("pvp.arena");
                if (feature)
                {
                    if (((((!(playerIsInArenaParty)) && ((Api.party.getPartyMembers(1).length < PvpArenaTypeEnum.ARENA_TYPE_3VS3)))) && (Api.config.isOptionalFeatureActive(feature.id))))
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.addToArena"), this.onArenaInvite, [pPlayerName], disabled));
                    };
                };
                if (((Api.social.hasGuild()) && (Api.social.hasGuildRight(playerInfos.id, "inviteNewMembers"))))
                {
                    if (!(pPlayerGuild))
                    {
                        if (pPlayerId == 0)
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.inviteInGuild"), this.onGuildInvite, [pPlayerName], disabled));
                        }
                        else
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.inviteInGuild"), this.onGuildInvite, [pPlayerId], disabled));
                        };
                    };
                };
                if (((!(Api.player.isInFight())) && (isInMap)))
                {
                    playerSkills = Api.jobs.getUsableSkillsInMap(playerInfos.id);
                    inviteTo = Api.ui.getText("ui.common.inviteTo");
                    for each (skill in playerSkills)
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(((inviteTo + " ") + skill.name), this.onMultiCraftCrafterAskClicked, [pPlayerId, skill.id], ((disabled) || (dead))));
                    };
                    otherSkills = Api.jobs.getUsableSkillsInMap(pPlayerId);
                    askTo = Api.ui.getText("ui.common.askTo");
                    for each (skill in otherSkills)
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(((askTo + " ") + skill.name), this.onMultiCraftCustomerAskClicked, [pPlayerId, skill.id], ((disabled) || (dead))));
                    };
                };
                menu.push(ContextMenu.static_createContextMenuSeparatorObject());
                if (((!(Api.social.isFriend(pPlayerName))) && (!(Api.social.isEnemy(pPlayerName)))))
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.addToFriends"), this.onAddFriend, [pPlayerName], disabled));
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.addToEnemy"), this.onAddEnemy, [pPlayerName], disabled));
                };
                if (Api.social.isIgnored(pPlayerName, pPlayerAccountId))
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.blackListRemove"), this.onUnignorePlayer, [pPlayerAccountId], disabled));
                }
                else
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.blackListTemporarly"), this.onIgnorePlayer, [pPlayerName], disabled));
                };
                if ((((Api.system.getBuildType() == BuildTypeEnum.DEBUG)) || ((Api.system.getBuildType() == BuildTypeEnum.INTERNAL))))
                {
                    if (((pContext) && (((((((((((!(pContext.hasOwnProperty("chan"))) || ((pContext.chan == 0)))) || ((pContext.chan == 3)))) || ((pContext.chan == 5)))) || ((pContext.chan == 6)))) || ((pContext.chan == 9))))))
                    {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.report"), this.onReportClicked, [pPlayerId, pPlayerName, pContext], disabled));
                    };
                };
            }
            else
            {
                menu.push(ContextMenu.static_createContextMenuTitleObject(pPlayerName));
                switch (Api.player.state())
                {
                    case 1:
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.freeSoul"), this.onWantFreeSoul, null, disabled));
                        break;
                    case 0:
                    case 2:
                        if (Api.player.isInPreFight())
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.banner.ready"), this.onReady, null, ((disabled) || (Api.fight.isWaitingBeforeFight()))));
                        }
                        else
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.dialog.slapHimself"), this.onSlapMenuClicked, null, disabled));
                        };
                        if (!(Api.player.isInFight()))
                        {
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.humanVendor.organizeShop"), this.onManageShoppingModMenuClicked, null, ((disabled) || ((Api.player.state() == 2)))));
                            if (!(Api.player.restrictions().cantBeMerchant))
                            {
                                menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.humanVendor.switchToMerchantMode"), this.onShoppingModMenuClicked, null, ((disabled) || ((Api.player.state() == 2)))));
                            };
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.orientCharacter"), this.onPivotCharacter, null, ((disabled) || (Api.roleplay.isUsingInteractive()))));
                            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.zoom"), this.onZoom, [pPlayerId], disabled));
                        };
                        break;
                };
            };
            if (Api.player.isInParty())
            {
                if (playerIsInParty)
                {
                    menu = menu.concat(this.addPartyMenu(pPlayerId, playerIsGuestInParty, partyHostId, false));
                };
                if (playerIsInArenaParty)
                {
                    menu = menu.concat(this.addPartyMenu(pPlayerId, playerIsGuestInArenaParty, arenaPartyHostId, true));
                };
            };
            return (menu);
        }

        private function allowAgression(pTargetAlignment:Object, pTargetAlliance:Object, targetIsMutant:Boolean, pId:uint):int
        {
            var worldPoint:Object = Api.player.currentMap();
            var subArea:SubArea = Api.player.currentSubArea();
            var currentPrism:PrismSubAreaWrapper = Api.social.getPrismSubAreaById(subArea.id);
            var playerAlignment:Object = Api.player.characteristics().alignmentInfos;
            var mapPos:MapPosition = Api.map.getMapPositionById(worldPoint.mapId);
            if (((mapPos) && (!(mapPos.allowAggression))))
            {
                return (-1);
            };
            if (Api.player.isMutant())
            {
                if (!(Api.player.restrictions().cantAttack))
                {
                    if (targetIsMutant)
                    {
                        return (0);
                    };
                    return (1);
                };
                return (0);
            };
            if (targetIsMutant)
            {
                return (1);
            };
            var serverType:int = Api.system.getPlayerManager().serverGameType;
            var sh:Boolean = !((serverType == 0));
            var myAlliance:AllianceWrapper = Api.social.getAlliance();
            var subAreaWithPrism:Boolean = ((currentPrism) && (!((currentPrism.mapId == -1))));
            var alignmentFightWithPrism:Boolean;
            if (subAreaWithPrism)
            {
                if (((!(sh)) || ((serverType == 4))))
                {
                    if (currentPrism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
                    {
                        if (myAlliance)
                        {
                            if (!(this.isAggressableAvA(playerAlignment.aggressable)))
                            {
                                return (-1);
                            };
                            if (pTargetAlliance == null)
                            {
                                return (-1);
                            };
                        };
                    }
                    else
                    {
                        alignmentFightWithPrism = true;
                    };
                }
                else
                {
                    if (myAlliance)
                    {
                        if (currentPrism.alliance.allianceId != myAlliance.allianceId)
                        {
                            if (!(this.isAggressableAvA(playerAlignment.aggressable)))
                            {
                                return (-1);
                            };
                        }
                        else
                        {
                            if (((!(this.isAggressableAvA(playerAlignment.aggressable))) && (!((playerAlignment.aggressable == AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE)))))
                            {
                                return (-1);
                            };
                        };
                    };
                };
                if (((!(alignmentFightWithPrism)) && (!(myAlliance))))
                {
                    return (-1);
                };
                if (((((!(alignmentFightWithPrism)) && (pTargetAlliance))) && (((sh) || ((currentPrism.state == PrismStateEnum.PRISM_STATE_VULNERABLE))))))
                {
                    if (pTargetAlliance.aggressable == AggressableStatusEnum.AvA_DISQUALIFIED)
                    {
                        return (0);
                    };
                    if (!(this.isAggressableAvA(pTargetAlliance.aggressable)))
                    {
                        return (-1);
                    };
                    if (myAlliance.allianceId == pTargetAlliance.allianceInformations.allianceId)
                    {
                        return (-1);
                    };
                };
                this._ava = true;
            };
            if (((!(sh)) || ((serverType == 4))))
            {
                if (((!(subAreaWithPrism)) || (alignmentFightWithPrism)))
                {
                    if ((((playerAlignment == null)) || ((pTargetAlignment == null))))
                    {
                        return (-1);
                    };
                    if (playerAlignment.aggressable != AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE)
                    {
                        return (-1);
                    };
                    if ((((pTargetAlignment.alignmentSide <= 0)) || ((pTargetAlignment.alignmentGrade == 0))))
                    {
                        return (-1);
                    };
                    if (((!((playerAlignment.alignmentSide == 3))) && ((playerAlignment.alignmentSide == pTargetAlignment.alignmentSide))))
                    {
                        return (-1);
                    };
                    if (playerAlignment.alignmentSide == 0)
                    {
                        return (-1);
                    };
                    this._ava = false;
                };
            }
            else
            {
                if (!(subAreaWithPrism))
                {
                    if (((myAlliance) && (pTargetAlliance)))
                    {
                        if ((((((myAlliance.allianceId == pTargetAlliance.allianceInformations.allianceId)) || (!(this.isAggressableAvA(playerAlignment.aggressable))))) || (!(this.isAggressableAvA(pTargetAlliance.aggressable)))))
                        {
                            return (-1);
                        };
                    }
                    else
                    {
                        if (((!(myAlliance)) || (!(this.isAggressableAvA(playerAlignment.aggressable)))))
                        {
                            return (-1);
                        };
                    };
                    this._ava = true;
                };
            };
            if (((sh) && ((Api.player.getPlayedCharacterInfo().level < 50))))
            {
                return (0);
            };
            var gap:int = ((this._ava) ? 100 : 50);
            var lvl:int = Api.player.getPlayedCharacterInfo().level;
            if ((lvl + gap) < (pTargetAlignment.characterPower - pId))
            {
                return (-1);
            };
            return (1);
        }

        private function isAggressableAvA(pAggressableStatus:uint):Boolean
        {
            return (!(((!((pAggressableStatus == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE))) && (!((pAggressableStatus == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE))))));
        }


    }
}//package makers


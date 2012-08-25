package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.people.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.actions.party.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.messages.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.party.*;
    import com.ankamagames.dofus.network.messages.game.interactive.meeting.*;
    import com.ankamagames.dofus.network.types.game.character.alignment.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.pattern.*;
    import flash.events.*;
    import flash.utils.*;

    public class PartyManagementFrame extends Object implements Frame
    {
        private var _playerNameInvited:String;
        private var _partyMembers:Vector.<PartyMemberWrapper>;
        private var _arenaPartyMembers:Vector.<PartyMemberWrapper>;
        private var _arenaReadyPartyMemberIds:Array;
        private var _arenaAlliesIds:Array;
        private var _timerRegen:Timer;
        private var _dicRegen:Dictionary;
        private var _dicRegenArena:Dictionary;
        private var _currentInvitations:Dictionary;
        private var _teleportBuddiesDialogFrame:TeleportBuddiesDialogFrame;
        private var _partyLoyalty:Boolean = false;
        private var _isArenaRegistered:Boolean = false;
        private var _arenaCurrentStatus:int = 3;
        private var _partyId:int;
        private var _arenaPartyId:int;
        private var _arenaLeader:PartyMemberWrapper;
        private var _arenaRanks:Array;
        private var _todaysFights:int;
        private var _todaysWonFights:int;
        private var _playerDungeons:Vector.<uint>;
        private var _playerSubscribedDungeons:Vector.<uint>;
        private var _dungeonFighters:Vector.<DungeonPartyFinderPlayer>;
        private var _lastFightType:int = -1;
        public var allMemberFollowPlayerId:uint = 0;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PartyManagementFrame));

        public function PartyManagementFrame()
        {
            this._partyMembers = new Vector.<PartyMemberWrapper>;
            this._arenaPartyMembers = new Vector.<PartyMemberWrapper>;
            this._arenaReadyPartyMemberIds = new Array();
            this._arenaAlliesIds = new Array();
            this._playerDungeons = new Vector.<uint>;
            this._playerSubscribedDungeons = new Vector.<uint>;
            this._dungeonFighters = new Vector.<DungeonPartyFinderPlayer>;
            this._dicRegen = new Dictionary();
            this._dicRegenArena = new Dictionary();
            this._currentInvitations = new Dictionary();
            this._timerRegen = new Timer(1000);
            this._timerRegen.addEventListener(TimerEvent.TIMER, this.onTimerTick);
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get partyMembers() : Vector.<PartyMemberWrapper>
        {
            return this._partyMembers;
        }// end function

        public function get arenaPartyMembers() : Vector.<PartyMemberWrapper>
        {
            return this._arenaPartyMembers;
        }// end function

        public function get subscribedDungeons() : Vector.<uint>
        {
            return this._playerSubscribedDungeons;
        }// end function

        public function get partyLoyalty() : Boolean
        {
            return this._partyLoyalty;
        }// end function

        public function get isArenaRegistered() : Boolean
        {
            return this._isArenaRegistered;
        }// end function

        public function get arenaCurrentStatus() : int
        {
            return this._arenaCurrentStatus;
        }// end function

        public function get arenaLeader() : PartyMemberWrapper
        {
            return this._arenaLeader;
        }// end function

        public function get arenaPartyId() : int
        {
            return this._arenaPartyId;
        }// end function

        public function get partyId() : int
        {
            return this._partyId;
        }// end function

        public function get arenaReadyPartyMemberIds() : Array
        {
            return this._arenaReadyPartyMemberIds;
        }// end function

        public function get arenaAlliesIds() : Array
        {
            return this._arenaAlliesIds;
        }// end function

        public function get arenaRanks() : Array
        {
            return this._arenaRanks;
        }// end function

        public function get todaysArenaFights() : int
        {
            return this._todaysFights;
        }// end function

        public function get todaysWonArenaFights() : int
        {
            return this._todaysWonFights;
        }// end function

        private function get roleplayContextFrame() : RoleplayContextFrame
        {
            return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
        }// end function

        private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame
        {
            return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
        }// end function

        public function set lastFightType(param1:int) : void
        {
            this._lastFightType = param1;
            return;
        }// end function

        public function pushed() : Boolean
        {
            this._arenaRanks = new Array();
            this._teleportBuddiesDialogFrame = new TeleportBuddiesDialogFrame();
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var pia:PartyInvitationAction;
            var pidmsg:PartyInvitationDungeonMessage;
            var pidmsgNid:uint;
            var pimsg:PartyInvitationMessage;
            var textInvitationKey:String;
            var pimsgNid:uint;
            var pcjenmsg:PartyCannotJoinErrorMessage;
            var reasonText:String;
            var pngmsg:PartyNewGuestMessage;
            var canBeHostMember:PartyMemberWrapper;
            var newGuest:PartyMemberWrapper;
            var pidra:PartyInvitationDetailsRequestAction;
            var pidrmsg:PartyInvitationDetailsRequestMessage;
            var piddmsg:PartyInvitationDungeonDetailsMessage;
            var pidemsg:PartyInvitationDetailsMessage;
            var paia:PartyAcceptInvitationAction;
            var paimsg:PartyAcceptInvitationMessage;
            var pumsg:PartyUpdateMessage;
            var member:PartyMemberWrapper;
            var newMember:PartyMemberWrapper;
            var existingMember:Boolean;
            var pjmsg:PartyJoinMessage;
            var memberJoin:PartyMemberInformations;
            var partyMember:PartyMemberWrapper;
            var guest:PartyGuestInformations;
            var partyGuest:PartyMemberWrapper;
            var canBeHostMember2:PartyMemberWrapper;
            var arena:Boolean;
            var pria:PartyRefuseInvitationAction;
            var primsg:PartyRefuseInvitationMessage;
            var prinmsg:PartyRefuseInvitationNotificationMessage;
            var guestRefusingIndex:int;
            var prinGuestName:String;
            var iMember:int;
            var pdmsg:PartyDeletedMessage;
            var pcia:PartyCancelInvitationAction;
            var pcimsg:PartyCancelInvitationMessage;
            var pcinmsg:PartyCancelInvitationNotificationMessage;
            var guestRefusingIndex2:int;
            var pcinGuestName:String;
            var pcinCancelerName:String;
            var iMember2:int;
            var picfgmsg:PartyInvitationCancelledForGuestMessage;
            var prmsg:PartyRestrictedMessage;
            var pka:PartyKickRequestAction;
            var pkickrimsg:PartyKickRequestMessage;
            var pkbmsg:PartyKickedByMessage;
            var plmsg:PartyLeaveMessage;
            var pmrmsg:PartyMemberRemoveMessage;
            var memberToRemoveIndex:int;
            var iMember3:int;
            var plra:PartyLeaveRequestAction;
            var plrmsg:PartyLeaveRequestMessage;
            var plulmsg:PartyLeaderUpdateMessage;
            var partyMem:PartyMemberWrapper;
            var pulmsg:PartyUpdateLightMessage;
            var partyMemb:PartyMemberWrapper;
            var lptmanager:LifePointTickManager;
            var pata:PartyAbdicateThroneAction;
            var patmsg:PartyAbdicateThroneMessage;
            var pplra:PartyPledgeLoyaltyRequestAction;
            var pplrmsg:PartyPledgeLoyaltyRequestMessage;
            var plsmsg:PartyLoyaltyStatusMessage;
            var pfma:PartyFollowMemberAction;
            var pfmrmsg:PartyFollowMemberRequestMessage;
            var psfma:PartyStopFollowingMemberAction;
            var psfrmsg:PartyStopFollowRequestMessage;
            var pafma:PartyAllFollowMemberAction;
            var pftmrmsg:PartyFollowThisMemberRequestMessage;
            var pasfma:PartyAllStopFollowingMemberAction;
            var pftmrmsg2:PartyFollowThisMemberRequestMessage;
            var psma:PartyShowMenuAction;
            var modContextMenu:Object;
            var menu:Object;
            var plmmsg:PartyLocateMembersMessage;
            var tbmsg:TeleportBuddiesMessage;
            var commonModTp:Object;
            var tbrmsg:TeleportBuddiesRequestedMessage;
            var hostName:String;
            var poorBuddiesNames:String;
            var dungeonPropName:String;
            var prinText:String;
            var ttbomsg:TeleportToBuddyOfferMessage;
            var buddyName:String;
            var dungeonName:String;
            var ttbomsgNid:uint;
            var ttbcmsg:TeleportToBuddyCloseMessage;
            var ttbaa:TeleportToBuddyAnswerAction;
            var ttbamsg:TeleportToBuddyAnswerMessage;
            var dpfada:DungeonPartyFinderAvailableDungeonsAction;
            var dpfadrmsg:DungeonPartyFinderAvailableDungeonsRequestMessage;
            var dpfadmsg:DungeonPartyFinderAvailableDungeonsMessage;
            var dpfla:DungeonPartyFinderListenAction;
            var dpflrmsg:DungeonPartyFinderListenRequestMessage;
            var dpflemsg:DungeonPartyFinderListenErrorMessage;
            var dpfrcmsg:DungeonPartyFinderRoomContentMessage;
            var dpfrcumsg:DungeonPartyFinderRoomContentUpdateMessage;
            var tempDjFighters:Vector.<DungeonPartyFinderPlayer>;
            var dpfra:DungeonPartyFinderRegisterAction;
            var dungeons:Vector.<uint>;
            var dpfrrmsg:DungeonPartyFinderRegisterRequestMessage;
            var dpfrsmsg:DungeonPartyFinderRegisterSuccessMessage;
            var resultText:String;
            var dpfremsg:DungeonPartyFinderRegisterErrorMessage;
            var errortext:String;
            var ara:ArenaRegisterAction;
            var grparmsg:GameRolePlayArenaRegisterMessage;
            var aua:ArenaUnregisterAction;
            var grpaumsg:GameRolePlayArenaUnregisterMessage;
            var grparsmsg:GameRolePlayArenaRegistrationStatusMessage;
            var grpafpmsg:GameRolePlayArenaFightPropositionMessage;
            var grpafpmsgNid:uint;
            var afaa:ArenaFightAnswerAction;
            var grpafamsg:GameRolePlayArenaFightAnswerMessage;
            var grpafsmsg:GameRolePlayArenaFighterStatusMessage;
            var grpaupimsg:GameRolePlayArenaUpdatePlayerInfosMessage;
            var gfjmsg:GameFightJoinMessage;
            var femsg:FightEndingMessage;
            var piarmsg:PartyInvitationArenaRequestMessage;
            var pirmsg:PartyInvitationRequestMessage;
            var pidgrmsg:PartyInvitationDungeonRequestMessage;
            var prinText2:String;
            var pcinText:String;
            var picfgInviterName:String;
            var picfgText:String;
            var buddyPropMember:PartyMemberWrapper;
            var buddyMember:PartyMemberWrapper;
            var fighterDungeon:DungeonPartyFinderPlayer;
            var iFD:int;
            var currentfighterDungeon:DungeonPartyFinderPlayer;
            var removedfighterId:int;
            var addedfighterDungeon:DungeonPartyFinderPlayer;
            var dungeonId:uint;
            var paramDonjons:String;
            var djId:int;
            var allyId:int;
            var commonMod:Object;
            var msg:* = param1;
            switch(true)
            {
                case msg is PartyInvitationAction:
                {
                    pia = msg as PartyInvitationAction;
                    this._playerNameInvited = pia.name;
                    if (pia.inArena)
                    {
                        piarmsg = new PartyInvitationArenaRequestMessage();
                        piarmsg.initPartyInvitationArenaRequestMessage(pia.name);
                        ConnectionsHandler.getConnection().send(piarmsg);
                    }
                    else if (pia.dungeon == 0)
                    {
                        pirmsg = new PartyInvitationRequestMessage();
                        pirmsg.initPartyInvitationRequestMessage(pia.name);
                        ConnectionsHandler.getConnection().send(pirmsg);
                    }
                    else
                    {
                        pidgrmsg = new PartyInvitationDungeonRequestMessage();
                        pidgrmsg.initPartyInvitationDungeonRequestMessage(pia.name, pia.dungeon);
                        ConnectionsHandler.getConnection().send(pidgrmsg);
                    }
                    return true;
                }
                case msg is PartyInvitationDungeonMessage:
                {
                    pidmsg = msg as PartyInvitationDungeonMessage;
                    this._currentInvitations[pidmsg.partyId] = {fromName:pidmsg.fromName};
                    pidmsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.invitation"), I18n.getUiText("ui.party.playerInvitationToDungeon", [pidmsg.fromName, Dungeon.getDungeonById(pidmsg.dungeonId).name]), NotificationTypeEnum.INVITATION, "partyInvit_" + pidmsg.partyId);
                    NotificationManager.getInstance().addButtonToNotification(pidmsgNid, I18n.getUiText("ui.common.details"), "PartyInvitationDetailsRequest", [pidmsg.partyId], false, 130);
                    NotificationManager.getInstance().addButtonToNotification(pidmsgNid, I18n.getUiText("ui.common.accept"), "PartyAcceptInvitation", [pidmsg.partyId], true, 130);
                    NotificationManager.getInstance().addCallbackToNotification(pidmsgNid, "PartyRefuseInvitation", [pidmsg.partyId]);
                    NotificationManager.getInstance().sendNotification(pidmsgNid);
                    return true;
                }
                case msg is PartyInvitationMessage:
                {
                    pimsg = msg as PartyInvitationMessage;
                    this._currentInvitations[pimsg.partyId] = {fromName:pimsg.fromName};
                    if (pimsg.partyType == PartyTypeEnum.PARTY_TYPE_ARENA)
                    {
                        textInvitationKey;
                    }
                    else
                    {
                        textInvitationKey;
                    }
                    pimsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.invitation"), I18n.getUiText(textInvitationKey, [pimsg.fromName]), NotificationTypeEnum.INVITATION, "partyInvit_" + pimsg.partyId);
                    NotificationManager.getInstance().addButtonToNotification(pimsgNid, I18n.getUiText("ui.common.details"), "PartyInvitationDetailsRequest", [pimsg.partyId]);
                    NotificationManager.getInstance().addButtonToNotification(pimsgNid, I18n.getUiText("ui.common.accept"), "PartyAcceptInvitation", [pimsg.partyId], true);
                    NotificationManager.getInstance().addCallbackToNotification(pimsgNid, "PartyRefuseInvitation", [pimsg.partyId]);
                    NotificationManager.getInstance().sendNotification(pimsgNid);
                    return true;
                }
                case msg is PartyCannotJoinErrorMessage:
                {
                    pcjenmsg = msg as PartyCannotJoinErrorMessage;
                    reasonText;
                    switch(pcjenmsg.reason)
                    {
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PARTY_FULL:
                        {
                            reasonText = I18n.getUiText("ui.party.partyFull");
                            break;
                        }
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PARTY_NOT_FOUND:
                        {
                            reasonText = I18n.getUiText("ui.party.cantFindParty");
                            break;
                        }
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_BUSY:
                        {
                            reasonText = I18n.getUiText("ui.party.cantInvitPlayerBusy");
                            break;
                        }
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_NOT_FOUND:
                        {
                            reasonText = I18n.getUiText("ui.common.playerNotFound", [this._playerNameInvited]);
                            break;
                        }
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_UNMET_CRITERION:
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_LOYAL:
                        {
                            break;
                        }
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_TOO_SOLLICITED:
                        {
                            reasonText = I18n.getUiText("ui.party.playerTooSollicited");
                            break;
                        }
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_UNMODIFIABLE:
                        {
                            reasonText = I18n.getUiText("ui.party.partyUnmodifiable");
                            break;
                        }
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_ALREADY_INVITED:
                        {
                            reasonText = I18n.getUiText("ui.party.playerAlreayBeingInvited");
                            break;
                        }
                        case PartyJoinErrorEnum.PARTY_JOIN_ERROR_UNKNOWN:
                        {
                        }
                        default:
                        {
                            reasonText = I18n.getUiText("ui.party.cantInvit");
                            break;
                            break;
                        }
                    }
                    if (reasonText != "")
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.PartyCannotJoinError, reasonText);
                    }
                    return true;
                }
                case msg is PartyNewGuestMessage:
                {
                    pngmsg = msg as PartyNewGuestMessage;
                    newGuest = new PartyMemberWrapper(pngmsg.guest.guestId, pngmsg.guest.name, false, false, 0, pngmsg.guest.guestLook);
                    newGuest.hostId = pngmsg.guest.hostId;
                    if (pngmsg.partyId == this._arenaPartyId)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._arenaPartyMembers;
                        while (_loc_4 in _loc_3)
                        {
                            
                            canBeHostMember = _loc_4[_loc_3];
                            if (canBeHostMember.id == pngmsg.guest.hostId)
                            {
                                newGuest.hostName = canBeHostMember.name;
                            }
                        }
                        this._arenaPartyMembers.push(newGuest);
                    }
                    else if (pngmsg.partyId == this._partyId)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._partyMembers;
                        while (_loc_4 in _loc_3)
                        {
                            
                            canBeHostMember = _loc_4[_loc_3];
                            if (canBeHostMember.id == pngmsg.guest.hostId)
                            {
                                newGuest.hostName = canBeHostMember.name;
                            }
                        }
                        this._partyMembers.push(newGuest);
                    }
                    if (pngmsg.partyId != this._arenaPartyId && pngmsg.partyId != this._partyId)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdateDetails, pngmsg.partyId, newGuest, false);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdate, pngmsg.partyId, newGuest.id);
                    }
                    return true;
                }
                case msg is PartyInvitationDetailsRequestAction:
                {
                    pidra = msg as PartyInvitationDetailsRequestAction;
                    pidrmsg = new PartyInvitationDetailsRequestMessage();
                    pidrmsg.initPartyInvitationDetailsRequestMessage(pidra.partyId);
                    ConnectionsHandler.getConnection().send(pidrmsg);
                    NotificationManager.getInstance().hideNotification("partyInvit_" + pidra.partyId);
                    return true;
                }
                case msg is PartyInvitationDungeonDetailsMessage:
                {
                    piddmsg = msg as PartyInvitationDungeonDetailsMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.PartyInvitation, piddmsg.partyId, piddmsg.fromName, piddmsg.leaderId, piddmsg.partyType, piddmsg.members, piddmsg.dungeonId, piddmsg.playersDungeonReady);
                    return true;
                }
                case msg is PartyInvitationDetailsMessage:
                {
                    pidemsg = msg as PartyInvitationDetailsMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.PartyInvitation, pidemsg.partyId, pidemsg.fromName, pidemsg.leaderId, pidemsg.partyType, pidemsg.members, 0, null);
                    return true;
                }
                case msg is PartyAcceptInvitationAction:
                {
                    paia = msg as PartyAcceptInvitationAction;
                    NotificationManager.getInstance().closeNotification("partyInvit_" + paia.partyId);
                    paimsg = new PartyAcceptInvitationMessage();
                    paimsg.initPartyAcceptInvitationMessage(paia.partyId);
                    ConnectionsHandler.getConnection().send(paimsg);
                    delete this._currentInvitations[paimsg.partyId];
                    return true;
                }
                case msg is PartyNewMemberMessage:
                case msg is PartyUpdateMessage:
                {
                    pumsg = msg as PartyUpdateMessage;
                    existingMember;
                    if (pumsg.partyId == this._arenaPartyId)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._arenaPartyMembers;
                        while (_loc_4 in _loc_3)
                        {
                            
                            member = _loc_4[_loc_3];
                            if (member.id == pumsg.memberInformations.id)
                            {
                                member.name = pumsg.memberInformations.name;
                                member.isMember = true;
                                member.level = pumsg.memberInformations.level;
                                member.entityLook = pumsg.memberInformations.entityLook;
                                member.lifePoints = pumsg.memberInformations.lifePoints;
                                member.maxLifePoints = pumsg.memberInformations.maxLifePoints;
                                member.maxInitiative = pumsg.memberInformations.initiative;
                                member.rank = (pumsg.memberInformations as PartyMemberArenaInformations).rank;
                                member.prospecting = 0;
                                member.pvpEnabled = pumsg.memberInformations.pvpEnabled;
                                member.alignmentSide = pumsg.memberInformations.alignmentSide;
                                member.regenRate = pumsg.memberInformations.regenRate;
                                existingMember;
                            }
                        }
                        if (!existingMember)
                        {
                            newMember = new PartyMemberWrapper(pumsg.memberInformations.id, pumsg.memberInformations.name, true, false, pumsg.memberInformations.level, pumsg.memberInformations.entityLook, pumsg.memberInformations.lifePoints, pumsg.memberInformations.maxLifePoints, pumsg.memberInformations.initiative, 0, pumsg.memberInformations.pvpEnabled, pumsg.memberInformations.alignmentSide, pumsg.memberInformations.regenRate, (pumsg.memberInformations as PartyMemberArenaInformations).rank);
                            this._arenaPartyMembers.push(newMember);
                        }
                    }
                    else if (pumsg.partyId == this._partyId)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._partyMembers;
                        while (_loc_4 in _loc_3)
                        {
                            
                            member = _loc_4[_loc_3];
                            if (member.id == pumsg.memberInformations.id)
                            {
                                member.name = pumsg.memberInformations.name;
                                member.isMember = true;
                                member.level = pumsg.memberInformations.level;
                                member.entityLook = pumsg.memberInformations.entityLook;
                                member.lifePoints = pumsg.memberInformations.lifePoints;
                                member.maxLifePoints = pumsg.memberInformations.maxLifePoints;
                                member.maxInitiative = pumsg.memberInformations.initiative;
                                member.prospecting = pumsg.memberInformations.prospecting;
                                member.pvpEnabled = pumsg.memberInformations.pvpEnabled;
                                member.alignmentSide = pumsg.memberInformations.alignmentSide;
                                member.regenRate = pumsg.memberInformations.regenRate;
                                existingMember;
                            }
                        }
                        if (!existingMember)
                        {
                            newMember = new PartyMemberWrapper(pumsg.memberInformations.id, pumsg.memberInformations.name, true, false, pumsg.memberInformations.level, pumsg.memberInformations.entityLook, pumsg.memberInformations.lifePoints, pumsg.memberInformations.maxLifePoints, pumsg.memberInformations.initiative, pumsg.memberInformations.prospecting, pumsg.memberInformations.pvpEnabled, pumsg.memberInformations.alignmentSide, pumsg.memberInformations.regenRate);
                            this._partyMembers.push(newMember);
                        }
                    }
                    if (pumsg.partyId != this._arenaPartyId && pumsg.partyId != this._partyId)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdateDetails, pumsg.partyId, pumsg.memberInformations, true);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdate, pumsg.partyId, pumsg.memberInformations.id);
                    }
                    return true;
                }
                case msg is PartyJoinMessage:
                {
                    pjmsg = msg as PartyJoinMessage;
                    if (pjmsg.partyType == PartyTypeEnum.PARTY_TYPE_ARENA)
                    {
                        this._arenaPartyMembers = new Vector.<PartyMemberWrapper>;
                        this._arenaPartyId = pjmsg.partyId;
                        var _loc_3:int = 0;
                        var _loc_4:* = pjmsg.members;
                        while (_loc_4 in _loc_3)
                        {
                            
                            memberJoin = _loc_4[_loc_3];
                            partyMember = new PartyMemberWrapper(memberJoin.id, memberJoin.name, true, false, memberJoin.level, memberJoin.entityLook, memberJoin.lifePoints, memberJoin.maxLifePoints, memberJoin.initiative, memberJoin.prospecting, memberJoin.pvpEnabled, memberJoin.alignmentSide, memberJoin.regenRate, (memberJoin as PartyMemberArenaInformations).rank);
                            if (memberJoin.id == pjmsg.partyLeaderId)
                            {
                                partyMember.isLeader = true;
                                this._arenaLeader = partyMember;
                            }
                            this._arenaPartyMembers.push(partyMember);
                        }
                        var _loc_3:int = 0;
                        var _loc_4:* = pjmsg.guests;
                        while (_loc_4 in _loc_3)
                        {
                            
                            guest = _loc_4[_loc_3];
                            partyGuest = new PartyMemberWrapper(guest.guestId, guest.name, false, false, 0, guest.guestLook);
                            partyGuest.hostId = guest.hostId;
                            var _loc_5:int = 0;
                            var _loc_6:* = this._arenaPartyMembers;
                            while (_loc_6 in _loc_5)
                            {
                                
                                canBeHostMember2 = _loc_6[_loc_5];
                                if (canBeHostMember2.id == guest.hostId)
                                {
                                    partyGuest.hostName = canBeHostMember2.name;
                                }
                            }
                            this._arenaPartyMembers.push(partyGuest);
                        }
                    }
                    else
                    {
                        this._partyMembers = new Vector.<PartyMemberWrapper>;
                        this._partyId = pjmsg.partyId;
                        var _loc_3:int = 0;
                        var _loc_4:* = pjmsg.members;
                        while (_loc_4 in _loc_3)
                        {
                            
                            memberJoin = _loc_4[_loc_3];
                            partyMember = new PartyMemberWrapper(memberJoin.id, memberJoin.name, true, false, memberJoin.level, memberJoin.entityLook, memberJoin.lifePoints, memberJoin.maxLifePoints, memberJoin.initiative, memberJoin.prospecting, memberJoin.pvpEnabled, memberJoin.alignmentSide, memberJoin.regenRate);
                            if (memberJoin.id == pjmsg.partyLeaderId)
                            {
                                partyMember.isLeader = true;
                            }
                            this._partyMembers.push(partyMember);
                        }
                        var _loc_3:int = 0;
                        var _loc_4:* = pjmsg.guests;
                        while (_loc_4 in _loc_3)
                        {
                            
                            guest = _loc_4[_loc_3];
                            partyGuest = new PartyMemberWrapper(guest.guestId, guest.name, false, false, 0, guest.guestLook);
                            partyGuest.hostId = guest.hostId;
                            var _loc_5:int = 0;
                            var _loc_6:* = this._partyMembers;
                            while (_loc_6 in _loc_5)
                            {
                                
                                canBeHostMember2 = _loc_6[_loc_5];
                                if (canBeHostMember2.id == guest.hostId)
                                {
                                    partyGuest.hostName = canBeHostMember2.name;
                                }
                            }
                            this._partyMembers.push(partyGuest);
                        }
                    }
                    this._timerRegen.start();
                    arena = pjmsg.partyType == PartyTypeEnum.PARTY_TYPE_ARENA;
                    KernelEventsManager.getInstance().processCallback(HookList.PartyJoin, pjmsg.partyId, arena ? (this._arenaPartyMembers) : (this._partyMembers), pjmsg.restricted, arena);
                    PlayedCharacterManager.getInstance().isInParty = true;
                    if (pjmsg.partyLeaderId == PlayedCharacterManager.getInstance().infos.id)
                    {
                        PlayedCharacterManager.getInstance().isPartyLeader = true;
                    }
                    return true;
                }
                case msg is PartyRefuseInvitationAction:
                {
                    pria = msg as PartyRefuseInvitationAction;
                    primsg = new PartyRefuseInvitationMessage();
                    primsg.initPartyRefuseInvitationMessage(pria.partyId);
                    ConnectionsHandler.getConnection().send(primsg);
                    NotificationManager.getInstance().closeNotification("partyInvit_" + pria.partyId);
                    delete this._currentInvitations[pria.partyId];
                    return true;
                }
                case msg is PartyRefuseInvitationNotificationMessage:
                {
                    prinmsg = msg as PartyRefuseInvitationNotificationMessage;
                    guestRefusingIndex;
                    if (prinmsg.partyId == this._arenaPartyId)
                    {
                        iMember;
                        while (iMember < this._arenaPartyMembers.length)
                        {
                            
                            if (prinmsg.guestId == this._arenaPartyMembers[iMember].id)
                            {
                                guestRefusingIndex = iMember;
                                prinGuestName = this._arenaPartyMembers[iMember].name;
                            }
                            iMember = (iMember + 1);
                        }
                        if (guestRefusingIndex != 0)
                        {
                            this._arenaPartyMembers.splice(guestRefusingIndex, 1);
                        }
                    }
                    else if (prinmsg.partyId == this._partyId)
                    {
                        iMember;
                        while (iMember < this._partyMembers.length)
                        {
                            
                            if (prinmsg.guestId == this._partyMembers[iMember].id)
                            {
                                guestRefusingIndex = iMember;
                                prinGuestName = this._partyMembers[iMember].name;
                            }
                            iMember = (iMember + 1);
                        }
                        if (guestRefusingIndex != 0)
                        {
                            this._partyMembers.splice(guestRefusingIndex, 1);
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.PartyMemberRemove, prinmsg.partyId, prinmsg.guestId);
                    if (guestRefusingIndex != 0)
                    {
                        prinText2 = I18n.getUiText("ui.party.invitationRefused", [prinGuestName]);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, prinText2, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case msg is PartyDeletedMessage:
                {
                    pdmsg = msg as PartyDeletedMessage;
                    this.deleteParty(pdmsg.partyId);
                    return true;
                }
                case msg is PartyCancelInvitationAction:
                {
                    pcia = msg as PartyCancelInvitationAction;
                    pcimsg = new PartyCancelInvitationMessage();
                    pcimsg.initPartyCancelInvitationMessage(pcia.partyId, pcia.guestId);
                    ConnectionsHandler.getConnection().send(pcimsg);
                    return true;
                }
                case msg is PartyCancelInvitationNotificationMessage:
                {
                    pcinmsg = msg as PartyCancelInvitationNotificationMessage;
                    guestRefusingIndex2;
                    if (pcinmsg.partyId == this._arenaPartyId)
                    {
                        iMember2;
                        while (iMember2 < this._arenaPartyMembers.length)
                        {
                            
                            if (pcinmsg.guestId == this._arenaPartyMembers[iMember2].id)
                            {
                                guestRefusingIndex2 = iMember2;
                                pcinGuestName = this._arenaPartyMembers[iMember2].name;
                            }
                            if (pcinmsg.cancelerId == this._arenaPartyMembers[iMember2].id)
                            {
                                pcinCancelerName = this._arenaPartyMembers[iMember2].name;
                            }
                            iMember2 = (iMember2 + 1);
                        }
                        if (guestRefusingIndex2 != 0)
                        {
                            this._arenaPartyMembers.splice(guestRefusingIndex2, 1);
                        }
                    }
                    else if (pcinmsg.partyId == this._partyId)
                    {
                        iMember2;
                        while (iMember2 < this._partyMembers.length)
                        {
                            
                            if (pcinmsg.guestId == this._partyMembers[iMember2].id)
                            {
                                guestRefusingIndex2 = iMember2;
                                pcinGuestName = this._partyMembers[iMember2].name;
                            }
                            if (pcinmsg.cancelerId == this._partyMembers[iMember2].id)
                            {
                                pcinCancelerName = this._partyMembers[iMember2].name;
                            }
                            iMember2 = (iMember2 + 1);
                        }
                        if (guestRefusingIndex2 != 0)
                        {
                            this._partyMembers.splice(guestRefusingIndex2, 1);
                        }
                    }
                    if (guestRefusingIndex2 != 0)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.PartyMemberRemove, pcinmsg.partyId, pcinmsg.guestId);
                        pcinText = I18n.getUiText("ui.party.invitationCancelled", [pcinCancelerName, pcinGuestName]);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, pcinText, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case msg is PartyInvitationCancelledForGuestMessage:
                {
                    picfgmsg = msg as PartyInvitationCancelledForGuestMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.PartyCancelledInvitation, picfgmsg.partyId);
                    NotificationManager.getInstance().closeNotification("partyInvit_" + picfgmsg.partyId);
                    if (this._currentInvitations[picfgmsg.partyId])
                    {
                        picfgInviterName = this._currentInvitations[picfgmsg.partyId].fromName;
                        picfgText = I18n.getUiText("ui.party.invitationCancelledForGuest", [picfgInviterName]);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, picfgText, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        delete this._currentInvitations[picfgmsg.partyId];
                    }
                    return true;
                }
                case msg is PartyRestrictedMessage:
                {
                    prmsg = msg as PartyRestrictedMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.OptionLockParty, prmsg.restricted);
                    return true;
                }
                case msg is PartyKickRequestAction:
                {
                    pka = msg as PartyKickRequestAction;
                    pkickrimsg = new PartyKickRequestMessage();
                    pkickrimsg.initPartyKickRequestMessage(pka.partyId, pka.playerId);
                    ConnectionsHandler.getConnection().send(pkickrimsg);
                    return true;
                }
                case msg is PartyKickedByMessage:
                {
                    pkbmsg = msg as PartyKickedByMessage;
                    this.deleteParty(pkbmsg.partyId);
                    return true;
                }
                case msg is PartyLeaveMessage:
                {
                    plmsg = msg as PartyLeaveMessage;
                    this.deleteParty(plmsg.partyId);
                    return true;
                }
                case msg is PartyMemberRemoveMessage:
                {
                    pmrmsg = msg as PartyMemberRemoveMessage;
                    memberToRemoveIndex;
                    if (pmrmsg.partyId == this._arenaPartyId)
                    {
                        iMember3;
                        while (iMember3 < this._arenaPartyMembers.length)
                        {
                            
                            if (pmrmsg.leavingPlayerId == this._arenaPartyMembers[iMember3].id)
                            {
                                memberToRemoveIndex = iMember3;
                            }
                            iMember3 = (iMember3 + 1);
                        }
                        this._arenaPartyMembers.splice(memberToRemoveIndex, 1);
                    }
                    else if (pmrmsg.partyId == this._partyId)
                    {
                        iMember3;
                        while (iMember3 < this._partyMembers.length)
                        {
                            
                            if (pmrmsg.leavingPlayerId == this._partyMembers[iMember3].id)
                            {
                                memberToRemoveIndex = iMember3;
                            }
                            iMember3 = (iMember3 + 1);
                        }
                        this._partyMembers.splice(memberToRemoveIndex, 1);
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.PartyMemberRemove, pmrmsg.partyId, pmrmsg.leavingPlayerId);
                    return true;
                }
                case msg is PartyLeaveRequestAction:
                {
                    plra = msg as PartyLeaveRequestAction;
                    plrmsg = new PartyLeaveRequestMessage();
                    plrmsg.initPartyLeaveRequestMessage(plra.partyId);
                    ConnectionsHandler.getConnection().send(plrmsg);
                    return true;
                }
                case msg is PartyLeaderUpdateMessage:
                {
                    plulmsg = msg as PartyLeaderUpdateMessage;
                    if (plulmsg.partyId == this._arenaPartyId)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._arenaPartyMembers;
                        while (_loc_4 in _loc_3)
                        {
                            
                            partyMem = _loc_4[_loc_3];
                            if (partyMem.id == plulmsg.partyLeaderId)
                            {
                                partyMem.isLeader = true;
                                this._arenaLeader = partyMem;
                                continue;
                            }
                            partyMem.isLeader = false;
                        }
                        KernelEventsManager.getInstance().processCallback(HookList.PartyUpdate, plulmsg.partyId, this._arenaPartyMembers);
                    }
                    else if (plulmsg.partyId == this._partyId)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._partyMembers;
                        while (_loc_4 in _loc_3)
                        {
                            
                            partyMem = _loc_4[_loc_3];
                            if (partyMem.id == plulmsg.partyLeaderId)
                            {
                                partyMem.isLeader = true;
                                continue;
                            }
                            partyMem.isLeader = false;
                        }
                        KernelEventsManager.getInstance().processCallback(HookList.PartyUpdate, plulmsg.partyId, this._partyMembers);
                    }
                    if (plulmsg.partyLeaderId == PlayedCharacterManager.getInstance().infos.id)
                    {
                        PlayedCharacterManager.getInstance().isPartyLeader = true;
                    }
                    else
                    {
                        PlayedCharacterManager.getInstance().isPartyLeader = false;
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.PartyLeaderUpdate, plulmsg.partyId, plulmsg.partyLeaderId);
                    return true;
                }
                case msg is PartyUpdateLightMessage:
                {
                    pulmsg = msg as PartyUpdateLightMessage;
                    if (pulmsg.partyId == this._arenaPartyId)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._arenaPartyMembers;
                        while (_loc_4 in _loc_3)
                        {
                            
                            partyMemb = _loc_4[_loc_3];
                            if (partyMemb.id == pulmsg.id)
                            {
                                partyMemb.lifePoints = pulmsg.lifePoints;
                                partyMemb.maxLifePoints = pulmsg.maxLifePoints;
                                partyMemb.prospecting = pulmsg.prospecting;
                                partyMemb.regenRate = pulmsg.regenRate;
                            }
                            if (this._dicRegenArena[partyMemb.id] == null)
                            {
                                lptmanager = new LifePointTickManager();
                            }
                            else
                            {
                                lptmanager = this._dicRegenArena[partyMemb.id];
                            }
                            lptmanager.originalLifePoint = partyMemb.lifePoints;
                            lptmanager.regenRate = partyMemb.regenRate;
                            lptmanager.tickNumber = 1;
                            this._dicRegenArena[partyMemb.id] = lptmanager;
                        }
                    }
                    else if (pulmsg.partyId == this._partyId)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._partyMembers;
                        while (_loc_4 in _loc_3)
                        {
                            
                            partyMemb = _loc_4[_loc_3];
                            if (partyMemb.id == pulmsg.id)
                            {
                                partyMemb.lifePoints = pulmsg.lifePoints;
                                partyMemb.maxLifePoints = pulmsg.maxLifePoints;
                                partyMemb.prospecting = pulmsg.prospecting;
                                partyMemb.regenRate = pulmsg.regenRate;
                            }
                            if (this._dicRegen[partyMemb.id] == null)
                            {
                                lptmanager = new LifePointTickManager();
                            }
                            else
                            {
                                lptmanager = this._dicRegen[partyMemb.id];
                            }
                            lptmanager.originalLifePoint = partyMemb.lifePoints;
                            lptmanager.regenRate = partyMemb.regenRate;
                            lptmanager.tickNumber = 1;
                            this._dicRegen[partyMemb.id] = lptmanager;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdate, pulmsg.partyId, pulmsg.id);
                    return true;
                }
                case msg is PartyAbdicateThroneAction:
                {
                    pata = msg as PartyAbdicateThroneAction;
                    patmsg = new PartyAbdicateThroneMessage();
                    patmsg.initPartyAbdicateThroneMessage(pata.partyId, pata.playerId);
                    ConnectionsHandler.getConnection().send(patmsg);
                    return true;
                }
                case msg is PartyPledgeLoyaltyRequestAction:
                {
                    pplra = msg as PartyPledgeLoyaltyRequestAction;
                    pplrmsg = new PartyPledgeLoyaltyRequestMessage();
                    pplrmsg.initPartyPledgeLoyaltyRequestMessage(pplra.partyId, pplra.loyal);
                    ConnectionsHandler.getConnection().send(pplrmsg);
                    return true;
                }
                case msg is PartyLoyaltyStatusMessage:
                {
                    plsmsg = msg as PartyLoyaltyStatusMessage;
                    this._partyLoyalty = plsmsg.loyal;
                    KernelEventsManager.getInstance().processCallback(HookList.PartyLoyaltyStatus, plsmsg.partyId, plsmsg.loyal);
                    return true;
                }
                case msg is PartyFollowMemberAction:
                {
                    pfma = msg as PartyFollowMemberAction;
                    pfmrmsg = new PartyFollowMemberRequestMessage();
                    pfmrmsg.initPartyFollowMemberRequestMessage(pfma.partyId, pfma.playerId);
                    ConnectionsHandler.getConnection().send(pfmrmsg);
                    return true;
                }
                case msg is PartyStopFollowingMemberAction:
                {
                    psfma = msg as PartyStopFollowingMemberAction;
                    psfrmsg = new PartyStopFollowRequestMessage();
                    psfrmsg.initPartyStopFollowRequestMessage(psfma.partyId);
                    ConnectionsHandler.getConnection().send(psfrmsg);
                    return true;
                }
                case msg is PartyAllFollowMemberAction:
                {
                    pafma = msg as PartyAllFollowMemberAction;
                    pftmrmsg = new PartyFollowThisMemberRequestMessage();
                    pftmrmsg.initPartyFollowThisMemberRequestMessage(pafma.partyId, pafma.playerId, true);
                    this.allMemberFollowPlayerId = pafma.playerId;
                    ConnectionsHandler.getConnection().send(pftmrmsg);
                    return true;
                }
                case msg is PartyAllStopFollowingMemberAction:
                {
                    pasfma = msg as PartyAllStopFollowingMemberAction;
                    pftmrmsg2 = new PartyFollowThisMemberRequestMessage();
                    pftmrmsg2.initPartyFollowThisMemberRequestMessage(pasfma.partyId, pasfma.playerId, false);
                    this.allMemberFollowPlayerId = 0;
                    ConnectionsHandler.getConnection().send(pftmrmsg2);
                    return true;
                }
                case msg is PartyShowMenuAction:
                {
                    psma = msg as PartyShowMenuAction;
                    modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                    menu = this.createPartyPlayerContextMenu(psma.playerId, psma.partyId);
                    modContextMenu.createContextMenu(menu);
                    return true;
                }
                case msg is PartyLocateMembersMessage:
                {
                    plmmsg = msg as PartyLocateMembersMessage;
                    return true;
                }
                case msg is TeleportBuddiesMessage:
                {
                    tbmsg = msg as TeleportBuddiesMessage;
                    Kernel.getWorker().addFrame(this._teleportBuddiesDialogFrame);
                    commonModTp = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                    commonModTp.openPopup(I18n.getUiText("ui.common.confirm"), I18n.getUiText("ui.party.teleportMembersProposition"), [I18n.getUiText("ui.common.yes"), I18n.getUiText("ui.common.no")], [this.teleportWantedFunction, this.teleportUnwantedFunction], this.teleportWantedFunction, this.teleportUnwantedFunction);
                    return true;
                }
                case msg is TeleportBuddiesRequestedMessage:
                {
                    tbrmsg = msg as TeleportBuddiesRequestedMessage;
                    poorBuddiesNames;
                    var _loc_3:int = 0;
                    var _loc_4:* = this._partyMembers;
                    while (_loc_4 in _loc_3)
                    {
                        
                        buddyPropMember = _loc_4[_loc_3];
                        if (buddyPropMember.id == tbrmsg.inviterId)
                        {
                            hostName = buddyPropMember.name;
                            continue;
                        }
                        if (tbrmsg.invalidBuddiesIds.indexOf(buddyPropMember.id) != -1)
                        {
                            poorBuddiesNames = poorBuddiesNames + (buddyPropMember.name + ", ");
                        }
                    }
                    dungeonPropName = Dungeon.getDungeonById(tbrmsg.dungeonId).name;
                    prinText = I18n.getUiText("ui.party.teleportWish", [hostName, dungeonPropName]);
                    if (poorBuddiesNames != "")
                    {
                        poorBuddiesNames = poorBuddiesNames.substring(0, poorBuddiesNames.length - 2);
                        prinText = prinText + (" " + PatternDecoder.combine(I18n.getUiText("ui.party.teleportCriterionFallenAngels", [poorBuddiesNames]), "n", poorBuddiesNames.split(", ").length == 1));
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, prinText, ChatActivableChannelsEnum.CHANNEL_PARTY, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case msg is TeleportToBuddyOfferMessage:
                {
                    ttbomsg = msg as TeleportToBuddyOfferMessage;
                    var _loc_3:int = 0;
                    var _loc_4:* = this._partyMembers;
                    while (_loc_4 in _loc_3)
                    {
                        
                        buddyMember = _loc_4[_loc_3];
                        if (buddyMember.id == ttbomsg.buddyId)
                        {
                            buddyName = buddyMember.name;
                        }
                    }
                    dungeonName = Dungeon.getDungeonById(ttbomsg.dungeonId).name;
                    ttbomsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.invitation"), I18n.getUiText("ui.party.teleportProposition", [buddyName, dungeonName]), NotificationTypeEnum.PRIORITY_INVITATION, "teleportProposition");
                    NotificationManager.getInstance().addTimerToNotification(ttbomsgNid, ttbomsg.timeLeft);
                    NotificationManager.getInstance().addButtonToNotification(ttbomsgNid, I18n.getUiText("ui.common.refuse"), "TeleportToBuddyAnswer", [ttbomsg.dungeonId, ttbomsg.buddyId, false], false, 130);
                    NotificationManager.getInstance().addButtonToNotification(ttbomsgNid, I18n.getUiText("ui.common.accept"), "TeleportToBuddyAnswer", [ttbomsg.dungeonId, ttbomsg.buddyId, true], false, 130);
                    NotificationManager.getInstance().addCallbackToNotification(ttbomsgNid, "TeleportToBuddyAnswer", [ttbomsg.dungeonId, ttbomsg.buddyId, false]);
                    NotificationManager.getInstance().sendNotification(ttbomsgNid);
                    return true;
                }
                case msg is TeleportToBuddyCloseMessage:
                {
                    ttbcmsg = msg as TeleportToBuddyCloseMessage;
                    NotificationManager.getInstance().closeNotification("teleportProposition");
                    return true;
                }
                case msg is TeleportToBuddyAnswerAction:
                {
                    ttbaa = msg as TeleportToBuddyAnswerAction;
                    ttbamsg = new TeleportToBuddyAnswerMessage();
                    ttbamsg.initTeleportToBuddyAnswerMessage(ttbaa.dungeonId, ttbaa.buddyId, ttbaa.accept);
                    ConnectionsHandler.getConnection().send(ttbamsg);
                    return true;
                }
                case msg is DungeonPartyFinderAvailableDungeonsAction:
                {
                    dpfada = msg as DungeonPartyFinderAvailableDungeonsAction;
                    dpfadrmsg = new DungeonPartyFinderAvailableDungeonsRequestMessage();
                    dpfadrmsg.initDungeonPartyFinderAvailableDungeonsRequestMessage();
                    ConnectionsHandler.getConnection().send(dpfadrmsg);
                    return true;
                }
                case msg is DungeonPartyFinderAvailableDungeonsMessage:
                {
                    dpfadmsg = msg as DungeonPartyFinderAvailableDungeonsMessage;
                    if (dpfadmsg.dungeonIds != this._playerDungeons)
                    {
                        this._playerDungeons = dpfadmsg.dungeonIds;
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.DungeonPartyFinderAvailableDungeons, this._playerDungeons);
                    return true;
                }
                case msg is DungeonPartyFinderListenAction:
                {
                    dpfla = msg as DungeonPartyFinderListenAction;
                    dpflrmsg = new DungeonPartyFinderListenRequestMessage();
                    dpflrmsg.initDungeonPartyFinderListenRequestMessage(dpfla.dungeonId);
                    ConnectionsHandler.getConnection().send(dpflrmsg);
                    return true;
                }
                case msg is DungeonPartyFinderListenErrorMessage:
                {
                    dpflemsg = msg as DungeonPartyFinderListenErrorMessage;
                    return true;
                }
                case msg is DungeonPartyFinderRoomContentMessage:
                {
                    dpfrcmsg = msg as DungeonPartyFinderRoomContentMessage;
                    this._dungeonFighters = new Vector.<DungeonPartyFinderPlayer>;
                    var _loc_3:int = 0;
                    var _loc_4:* = dpfrcmsg.players;
                    while (_loc_4 in _loc_3)
                    {
                        
                        fighterDungeon = _loc_4[_loc_3];
                        this._dungeonFighters.push(fighterDungeon);
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.DungeonPartyFinderRoomContent, this._dungeonFighters);
                    return true;
                }
                case msg is DungeonPartyFinderRoomContentUpdateMessage:
                {
                    dpfrcumsg = msg as DungeonPartyFinderRoomContentUpdateMessage;
                    tempDjFighters = this._dungeonFighters.concat();
                    iFD = (tempDjFighters.length - 1);
                    while (iFD >= 0)
                    {
                        
                        currentfighterDungeon = tempDjFighters[iFD];
                        var _loc_3:int = 0;
                        var _loc_4:* = dpfrcumsg.removedPlayersIds;
                        while (_loc_4 in _loc_3)
                        {
                            
                            removedfighterId = _loc_4[_loc_3];
                            if (currentfighterDungeon.playerId == removedfighterId)
                            {
                                this._dungeonFighters.splice(iFD, 1);
                            }
                        }
                        iFD = (iFD - 1);
                    }
                    var _loc_3:int = 0;
                    var _loc_4:* = dpfrcumsg.addedPlayers;
                    while (_loc_4 in _loc_3)
                    {
                        
                        addedfighterDungeon = _loc_4[_loc_3];
                        this._dungeonFighters.push(addedfighterDungeon);
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.DungeonPartyFinderRoomContent, this._dungeonFighters);
                    return true;
                }
                case msg is DungeonPartyFinderRegisterAction:
                {
                    dpfra = msg as DungeonPartyFinderRegisterAction;
                    dungeons = new Vector.<uint>;
                    var _loc_3:int = 0;
                    var _loc_4:* = dpfra.dungeons;
                    while (_loc_4 in _loc_3)
                    {
                        
                        dungeonId = _loc_4[_loc_3];
                        dungeons.push(dungeonId);
                    }
                    dpfrrmsg = new DungeonPartyFinderRegisterRequestMessage();
                    dpfrrmsg.initDungeonPartyFinderRegisterRequestMessage(dungeons);
                    ConnectionsHandler.getConnection().send(dpfrrmsg);
                    return true;
                }
                case msg is DungeonPartyFinderRegisterSuccessMessage:
                {
                    dpfrsmsg = msg as DungeonPartyFinderRegisterSuccessMessage;
                    if (dpfrsmsg.dungeonIds.length > 0)
                    {
                        paramDonjons;
                        var _loc_3:int = 0;
                        var _loc_4:* = dpfrsmsg.dungeonIds;
                        while (_loc_4 in _loc_3)
                        {
                            
                            djId = _loc_4[_loc_3];
                            paramDonjons = paramDonjons + (Dungeon.getDungeonById(djId).name + ", ");
                        }
                        paramDonjons = paramDonjons.substring(0, paramDonjons.length - 2);
                        resultText = I18n.getUiText("ui.teamSearch.registerSuccess", [paramDonjons]);
                    }
                    else
                    {
                        resultText = I18n.getUiText("ui.teamSearch.registerQuit");
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, resultText, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    this._playerSubscribedDungeons = dpfrsmsg.dungeonIds;
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.DungeonPartyFinderRegister, dpfrsmsg.dungeonIds.length > 0);
                    return true;
                }
                case msg is DungeonPartyFinderRegisterErrorMessage:
                {
                    dpfremsg = msg as DungeonPartyFinderRegisterErrorMessage;
                    errortext = I18n.getUiText("ui.teamSearch.registerError");
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, errortext, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case msg is ArenaRegisterAction:
                {
                    ara = msg as ArenaRegisterAction;
                    grparmsg = new GameRolePlayArenaRegisterMessage();
                    grparmsg.initGameRolePlayArenaRegisterMessage(ara.fightTypeId);
                    ConnectionsHandler.getConnection().send(grparmsg);
                    return true;
                }
                case msg is ArenaUnregisterAction:
                {
                    aua = msg as ArenaUnregisterAction;
                    grpaumsg = new GameRolePlayArenaUnregisterMessage();
                    grpaumsg.initGameRolePlayArenaUnregisterMessage();
                    ConnectionsHandler.getConnection().send(grpaumsg);
                    return true;
                }
                case msg is GameRolePlayArenaRegistrationStatusMessage:
                {
                    grparsmsg = msg as GameRolePlayArenaRegistrationStatusMessage;
                    _log.debug("GameRolePlayArenaRegistrationStatusMessage " + grparsmsg.registered + " : " + grparsmsg.step);
                    if (grparsmsg.registered)
                    {
                        this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_REGISTRED;
                        this._isArenaRegistered = true;
                    }
                    else
                    {
                        this._arenaCurrentStatus = grparsmsg.step;
                        this._isArenaRegistered = false;
                    }
                    this._arenaReadyPartyMemberIds = new Array();
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaRegistrationStatusUpdate, this._isArenaRegistered, this._arenaCurrentStatus);
                    return true;
                }
                case msg is GameRolePlayArenaFightPropositionMessage:
                {
                    grpafpmsg = msg as GameRolePlayArenaFightPropositionMessage;
                    this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_WAITING_FIGHT;
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaFightProposition, grpafpmsg.alliesId);
                    this._arenaAlliesIds = new Array();
                    var _loc_3:int = 0;
                    var _loc_4:* = grpafpmsg.alliesId;
                    while (_loc_4 in _loc_3)
                    {
                        
                        allyId = _loc_4[_loc_3];
                        this._arenaAlliesIds.push(allyId);
                    }
                    grpafpmsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.koliseum"), I18n.getUiText("ui.party.fightFound"), NotificationTypeEnum.PRIORITY_INVITATION, "fightProposition_" + grpafpmsg.fightId);
                    NotificationManager.getInstance().addTimerToNotification(grpafpmsgNid, grpafpmsg.duration);
                    NotificationManager.getInstance().addButtonToNotification(grpafpmsgNid, I18n.getUiText("ui.common.refuse"), "ArenaFightAnswer", [grpafpmsg.fightId, false], true, 130);
                    NotificationManager.getInstance().addButtonToNotification(grpafpmsgNid, I18n.getUiText("ui.common.accept"), "ArenaFightAnswer", [grpafpmsg.fightId, true], true, 130);
                    NotificationManager.getInstance().addCallbackToNotification(grpafpmsgNid, "ArenaFightAnswer", [grpafpmsg.fightId, false]);
                    NotificationManager.getInstance().sendNotification(grpafpmsgNid);
                    return true;
                }
                case msg is ArenaFightAnswerAction:
                {
                    afaa = msg as ArenaFightAnswerAction;
                    grpafamsg = new GameRolePlayArenaFightAnswerMessage();
                    grpafamsg.initGameRolePlayArenaFightAnswerMessage(afaa.fightId, afaa.accept);
                    ConnectionsHandler.getConnection().send(grpafamsg);
                    return true;
                }
                case msg is GameRolePlayArenaFighterStatusMessage:
                {
                    grpafsmsg = msg as GameRolePlayArenaFighterStatusMessage;
                    if (!grpafsmsg.accepted)
                    {
                        if (grpafsmsg.playerId == PlayedCharacterManager.getInstance().id)
                        {
                            this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_UNREGISTER;
                            this._isArenaRegistered = false;
                        }
                        else
                        {
                            this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_REGISTRED;
                            NotificationManager.getInstance().closeNotification("fightProposition_" + grpafsmsg.fightId);
                        }
                        this._arenaReadyPartyMemberIds = new Array();
                        this._arenaAlliesIds = new Array();
                        KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaRegistrationStatusUpdate, this._isArenaRegistered, this._arenaCurrentStatus);
                    }
                    else
                    {
                        this._arenaReadyPartyMemberIds.push(grpafsmsg.playerId);
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaFighterStatusUpdate, grpafsmsg.playerId, grpafsmsg.accepted);
                    return true;
                }
                case msg is GameRolePlayArenaUpdatePlayerInfosMessage:
                {
                    grpaupimsg = msg as GameRolePlayArenaUpdatePlayerInfosMessage;
                    this._arenaRanks[0] = grpaupimsg.rank;
                    this._arenaRanks[1] = grpaupimsg.bestDailyRank;
                    this._arenaRanks[2] = grpaupimsg.bestRank;
                    this._todaysFights = grpaupimsg.arenaFightcount;
                    this._todaysWonFights = grpaupimsg.victoryCount;
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaUpdateRank, this._arenaRanks, this._todaysFights, this._todaysWonFights);
                    return true;
                }
                case msg is GameFightJoinMessage:
                {
                    gfjmsg = msg as GameFightJoinMessage;
                    if (gfjmsg.fightType == FightTypeEnum.FIGHT_TYPE_PVP_ARENA)
                    {
                        this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_STARTING_FIGHT;
                        this._isArenaRegistered = false;
                        KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaRegistrationStatusUpdate, this._isArenaRegistered, this._arenaCurrentStatus);
                    }
                    return false;
                }
                case msg is FightEndingMessage:
                {
                    femsg = msg as FightEndingMessage;
                    if (this._lastFightType == FightTypeEnum.FIGHT_TYPE_PVP_ARENA)
                    {
                        this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_UNREGISTER;
                        this._isArenaRegistered = false;
                        this._arenaReadyPartyMemberIds = new Array();
                        KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaRegistrationStatusUpdate, this._isArenaRegistered, this._arenaCurrentStatus);
                        if (this._arenaLeader && PlayedCharacterManager.getInstance().id == this._arenaLeader.id)
                        {
                            commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                            commonMod.openPopup(I18n.getUiText("ui.common.confirm"), I18n.getUiText("ui.party.arenaPopupReinscription"), [I18n.getUiText("ui.common.yes"), I18n.getUiText("ui.common.no")], [this.reinscriptionWantedFunction, null], this.reinscriptionWantedFunction, function () : void
            {
                return;
            }// end function
            );
                        }
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            this._timerRegen.stop();
            this._timerRegen.removeEventListener(TimerEvent.TIMER, this.onTimerTick);
            this._timerRegen = null;
            return true;
        }// end function

        public function reinscriptionWantedFunction() : void
        {
            var _loc_1:* = new ArenaRegisterAction();
            _loc_1.fightTypeId = PvpArenaTypeEnum.ARENA_TYPE_3VS3;
            this.process(_loc_1);
            return;
        }// end function

        public function getGroupMemberById(param1:int) : PartyMemberWrapper
        {
            var _loc_2:PartyMemberWrapper = null;
            for each (_loc_2 in this._partyMembers)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function deleteParty(param1:int) : void
        {
            var _loc_2:Boolean = false;
            if (param1 == this._arenaPartyId)
            {
                _loc_2 = true;
                this._arenaPartyMembers = new Vector.<PartyMemberWrapper>;
                this._arenaPartyId = 0;
                this._arenaLeader = null;
            }
            else if (param1 == this._partyId)
            {
                this._partyMembers = new Vector.<PartyMemberWrapper>;
                this._partyId = 0;
            }
            if (this._arenaPartyId == 0 && this._partyId == 0)
            {
                this._timerRegen.stop();
                PlayedCharacterManager.getInstance().isInParty = false;
                PlayedCharacterManager.getInstance().isPartyLeader = false;
            }
            KernelEventsManager.getInstance().processCallback(HookList.PartyLeave, param1, _loc_2);
            return;
        }// end function

        private function createPartyPlayerContextMenu(param1:uint, param2:int) : Object
        {
            var _loc_6:ActorAlignmentInformations = null;
            var _loc_7:PartyMemberWrapper = null;
            var _loc_8:int = 0;
            var _loc_3:String = "";
            var _loc_4:* = new SocialApi();
            var _loc_5:Boolean = false;
            if (param2 == this._arenaPartyId)
            {
                for each (_loc_7 in this._arenaPartyMembers)
                {
                    
                    if (_loc_7.id == param1)
                    {
                        _loc_3 = _loc_7.name;
                    }
                }
            }
            else if (param2 == this._partyId)
            {
                for each (_loc_7 in this._partyMembers)
                {
                    
                    if (_loc_7.id == param1)
                    {
                        _loc_3 = _loc_7.name;
                    }
                }
            }
            if (_loc_3 == "")
            {
                return null;
            }
            if (this.roleplayEntitiesFrame)
            {
                for each (_loc_8 in this.roleplayEntitiesFrame.playersId)
                {
                    
                    if (_loc_8 == param1)
                    {
                        _loc_5 = true;
                        if (this.roleplayEntitiesFrame.getEntityInfos(_loc_8) is GameRolePlayCharacterInformations)
                        {
                            _loc_6 = (this.roleplayEntitiesFrame.getEntityInfos(_loc_8) as GameRolePlayCharacterInformations).alignmentInfos;
                            continue;
                        }
                        return null;
                    }
                }
            }
            return MenusFactory.create({id:param1, name:_loc_3, onSameMap:_loc_5, alignmentInfos:_loc_6}, "partyMember", param2);
        }// end function

        private function onTimerTick(event:TimerEvent) : void
        {
            var _loc_2:PartyMemberWrapper = null;
            var _loc_3:LifePointTickManager = null;
            var _loc_4:uint = 0;
            var _loc_5:uint = 0;
            var _loc_6:LifePointTickManager = null;
            var _loc_7:LifePointTickManager = null;
            var _loc_8:uint = 0;
            var _loc_9:uint = 0;
            var _loc_10:LifePointTickManager = null;
            for each (_loc_2 in this._partyMembers)
            {
                
                if (_loc_2.lifePoints < _loc_2.maxLifePoints && _loc_2.regenRate > 0)
                {
                    if (this._dicRegen[_loc_2.id] == null)
                    {
                        _loc_6 = new LifePointTickManager();
                        _loc_6.originalLifePoint = _loc_2.lifePoints;
                        _loc_6.regenRate = _loc_2.regenRate;
                        _loc_6.tickNumber = 1;
                        this._dicRegen[_loc_2.id] = _loc_6;
                    }
                    _loc_3 = this._dicRegen[_loc_2.id] as LifePointTickManager;
                    _loc_4 = Math.floor(_loc_3.tickNumber * (10 / _loc_3.regenRate));
                    _loc_5 = _loc_3.originalLifePoint + _loc_4;
                    if (_loc_5 >= _loc_2.maxLifePoints)
                    {
                        _loc_5 = _loc_2.maxLifePoints;
                    }
                    _loc_2.lifePoints = _loc_5;
                    var _loc_13:* = _loc_3;
                    var _loc_14:* = _loc_3.tickNumber + 1;
                    _loc_13.tickNumber = _loc_14;
                    KernelEventsManager.getInstance().processCallback(HookList.PartyMemberLifeUpdate, this._partyId, _loc_2.id, _loc_2.lifePoints, _loc_2.initiative);
                }
            }
            for each (_loc_2 in this._arenaPartyMembers)
            {
                
                if (_loc_2.lifePoints < _loc_2.maxLifePoints && _loc_2.regenRate > 0)
                {
                    if (this._dicRegenArena[_loc_2.id] == null)
                    {
                        _loc_10 = new LifePointTickManager();
                        _loc_10.originalLifePoint = _loc_2.lifePoints;
                        _loc_10.regenRate = _loc_2.regenRate;
                        _loc_10.tickNumber = 1;
                        this._dicRegenArena[_loc_2.id] = _loc_10;
                    }
                    _loc_7 = this._dicRegenArena[_loc_2.id] as LifePointTickManager;
                    _loc_8 = Math.floor(_loc_7.tickNumber * (10 / _loc_7.regenRate));
                    _loc_9 = _loc_7.originalLifePoint + _loc_8;
                    if (_loc_9 >= _loc_2.maxLifePoints)
                    {
                        _loc_9 = _loc_2.maxLifePoints;
                    }
                    _loc_2.lifePoints = _loc_9;
                    var _loc_13:* = _loc_7;
                    var _loc_14:* = _loc_7.tickNumber + 1;
                    _loc_13.tickNumber = _loc_14;
                    KernelEventsManager.getInstance().processCallback(HookList.PartyMemberLifeUpdate, this._arenaPartyId, _loc_2.id, _loc_2.lifePoints, _loc_2.initiative);
                }
            }
            return;
        }// end function

        public function teleportWantedFunction() : void
        {
            var _loc_1:* = new TeleportBuddiesAnswerAction();
            _loc_1.accept = true;
            this._teleportBuddiesDialogFrame.process(_loc_1);
            return;
        }// end function

        public function teleportUnwantedFunction() : void
        {
            var _loc_1:* = new TeleportBuddiesAnswerAction();
            _loc_1.accept = false;
            this._teleportBuddiesDialogFrame.process(_loc_1);
            return;
        }// end function

    }
}

class LifePointTickManager extends Object
{
    public var originalLifePoint:uint;
    public var regenRate:uint;
    public var tickNumber:uint;

    function LifePointTickManager()
    {
        return;
    }// end function

}


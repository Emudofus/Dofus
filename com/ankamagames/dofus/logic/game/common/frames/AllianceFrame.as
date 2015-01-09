package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.conquest.AllianceOnTheHillWrapper;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
    import com.ankamagames.dofus.internalDatacenter.conquest.PrismFightersWrapper;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.SetEnableAVARequestAction;
    import com.ankamagames.dofus.network.messages.game.pvp.SetEnableAVARequestMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.KohUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationStartedMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationResultMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceMembershipMessage;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitedMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationStateRecruterMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationStateRecrutedMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceJoinedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceKickRequestAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceKickRequestMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceGuildLeavingMessage;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceFactsRequestAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsRequestMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsMessage;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsErrorMessage;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceChangeGuildRightsAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceChangeGuildRightsMessage;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInsiderInfoRequestAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceInsiderInfoRequestMessage;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceInsiderInfoMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismsListUpdateMessage;
    import com.ankamagames.dofus.logic.game.common.actions.prism.PrismSettingsRequestAction;
    import com.ankamagames.dofus.network.messages.game.prism.PrismSettingsRequestMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismSettingsErrorMessage;
    import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightJoinLeaveRequestAction;
    import com.ankamagames.dofus.network.messages.game.prism.PrismFightJoinLeaveRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightSwapRequestAction;
    import com.ankamagames.dofus.network.messages.game.prism.PrismFightSwapRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.prism.PrismInfoJoinLeaveRequestAction;
    import com.ankamagames.dofus.network.messages.game.prism.PrismInfoJoinLeaveRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.prism.PrismsListRegisterAction;
    import com.ankamagames.dofus.logic.game.common.actions.prism.PrismAttackRequestAction;
    import com.ankamagames.dofus.network.messages.game.prism.PrismAttackRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.prism.PrismUseRequestAction;
    import com.ankamagames.dofus.network.messages.game.prism.PrismUseRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.prism.PrismModuleExchangeRequestAction;
    import com.ankamagames.dofus.network.messages.game.prism.PrismModuleExchangeRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.prism.PrismSetSabotagedRequestAction;
    import com.ankamagames.dofus.network.messages.game.prism.PrismSetSabotagedRequestMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismSetSabotagedRefusedMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismFightDefenderAddMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismFightDefenderLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismFightAttackerAddMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismFightAttackerRemoveMessage;
    import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
    import com.ankamagames.dofus.network.types.game.prism.AllianceInsiderPrismInformation;
    import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
    import com.ankamagames.dofus.network.messages.game.prism.PrismsListMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismFightAddedMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismFightRemovedMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismsInfoValidMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.AlliancePrismDialogQuestionMessage;
    import com.ankamagames.dofus.network.messages.game.pvp.UpdateSelfAgressableStatusMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInAllianceInformations;
    import com.ankamagames.dofus.network.types.game.social.GuildInsiderFactSheetInformations;
    import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
    import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
    import com.ankamagames.dofus.network.messages.game.prism.PrismsListRegisterMessage;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.enums.PrismStateEnum;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.PrismHookList;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.misc.lists.AlignmentHookList;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.misc.lists.SocialHookList;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationStartedMessage;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.network.enums.SocialGroupCreationResultEnum;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.network.enums.SocialGroupInvitationStateEnum;
    import com.ankamagames.dofus.types.enums.EntityIconEnum;
    import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceLeftMessage;
    import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
    import com.ankamagames.dofus.network.enums.PrismListenEnum;
    import com.ankamagames.dofus.network.enums.PrismSetSabotagedRefusedReasonEnum;
    import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
    import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.logic.common.managers.NotificationManager;
    import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
    import com.ankamagames.jerakine.messages.Message;
    import __AS3__.vec.*;

    public class AllianceFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceFrame));
        private static const SIDE_MINE:int = 0;
        private static const SIDE_DEFENDERS:int = 1;
        private static const SIDE_ATTACKERS:int = 2;
        private static var _instance:AllianceFrame;

        private var _allianceDialogFrame:AllianceDialogFrame;
        private var _hasAlliance:Boolean = false;
        private var _alliance:AllianceWrapper;
        private var _allAlliances:Dictionary;
        private var _alliancesOnTheHill:Vector.<AllianceOnTheHillWrapper>;
        private var _fightId:uint = 0;
        private var _prismState:int = 0;
        private var _infoJoinLeave:Boolean;
        private var _autoLeaveHelpers:Boolean;
        private var _currentPrismsListenMode:uint;
        private var _prismsListeners:Dictionary;

        public function AllianceFrame()
        {
            this._allAlliances = new Dictionary(true);
            super();
        }

        public static function getInstance():AllianceFrame
        {
            return (_instance);
        }


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get hasAlliance():Boolean
        {
            return (this._hasAlliance);
        }

        public function get alliance():AllianceWrapper
        {
            return (this._alliance);
        }

        public function getAllianceById(id:uint):AllianceWrapper
        {
            var aw:AllianceWrapper = this._allAlliances[id];
            if (!(aw))
            {
                aw = AllianceWrapper.getAllianceById(id);
            };
            return (aw);
        }

        public function getPrismSubAreaById(id:uint):PrismSubAreaWrapper
        {
            return (PrismSubAreaWrapper.prismList[id]);
        }

        public function get alliancesOnTheHill():Vector.<AllianceOnTheHillWrapper>
        {
            return (this._alliancesOnTheHill);
        }

        public function _pickup_fighter(vec:Array, defenderId:uint):PrismFightersWrapper
        {
            var defender:PrismFightersWrapper;
            var idx:uint;
            var found:Boolean;
            for each (defender in vec)
            {
                if (defender.playerCharactersInformations.id == defenderId)
                {
                    found = true;
                    break;
                };
                idx++;
            };
            return (vec.splice(idx, 1)[0]);
        }

        public function pushed():Boolean
        {
            PrismSubAreaWrapper.reset();
            _instance = this;
            this._infoJoinLeave = false;
            this._allianceDialogFrame = new AllianceDialogFrame();
            this._prismsListeners = new Dictionary();
            return (true);
        }

        public function pulled():Boolean
        {
            _instance = null;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:CurrentMapMessage;
            var _local_3:SubArea;
            var _local_4:SubArea;
            var _local_5:SetEnableAVARequestAction;
            var _local_6:SetEnableAVARequestMessage;
            var _local_7:KohUpdateMessage;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:AllianceOnTheHillWrapper;
            var _local_12:int;
            var _local_13:AllianceModificationStartedMessage;
            var _local_14:AllianceCreationResultMessage;
            var _local_15:String;
            var _local_16:AllianceMembershipMessage;
            var _local_17:AllianceInvitationAction;
            var _local_18:AllianceInvitationMessage;
            var _local_19:AllianceInvitedMessage;
            var _local_20:AllianceInvitationStateRecruterMessage;
            var _local_21:AllianceInvitationStateRecrutedMessage;
            var _local_22:AllianceJoinedMessage;
            var _local_23:String;
            var _local_24:AllianceKickRequestAction;
            var _local_25:AllianceKickRequestMessage;
            var _local_26:AllianceGuildLeavingMessage;
            var _local_27:RoleplayEntitiesFrame;
            var _local_28:AllianceFactsRequestAction;
            var _local_29:AllianceFactsRequestMessage;
            var _local_30:AllianceFactsMessage;
            var _local_31:AllianceWrapper;
            var _local_32:Vector.<GuildFactSheetWrapper>;
            var _local_33:GuildFactSheetWrapper;
            var _local_34:int;
            var _local_35:SocialFrame;
            var _local_36:AllianceFactsErrorMessage;
            var _local_37:AllianceChangeGuildRightsAction;
            var _local_38:AllianceChangeGuildRightsMessage;
            var _local_39:AllianceInsiderInfoRequestAction;
            var _local_40:AllianceInsiderInfoRequestMessage;
            var _local_41:AllianceInsiderInfoMessage;
            var _local_42:Vector.<GuildFactSheetWrapper>;
            var _local_43:GuildFactSheetWrapper;
            var _local_44:Boolean;
            var _local_45:Vector.<uint>;
            var _local_46:int;
            var _local_47:SocialFrame;
            var _local_48:PrismsListUpdateMessage;
            var _local_49:PrismSettingsRequestAction;
            var _local_50:PrismSettingsRequestMessage;
            var _local_51:PrismSettingsErrorMessage;
            var _local_52:String;
            var _local_53:PrismFightJoinLeaveRequestAction;
            var _local_54:PrismFightJoinLeaveRequestMessage;
            var _local_55:PrismFightSwapRequestAction;
            var _local_56:PrismFightSwapRequestMessage;
            var _local_57:PrismInfoJoinLeaveRequestAction;
            var _local_58:PrismInfoJoinLeaveRequestMessage;
            var _local_59:PrismsListRegisterAction;
            var _local_60:Boolean;
            var _local_61:int;
            var _local_62:int;
            var _local_63:PrismAttackRequestAction;
            var _local_64:PrismAttackRequestMessage;
            var _local_65:PrismUseRequestAction;
            var _local_66:PrismUseRequestMessage;
            var _local_67:PrismModuleExchangeRequestAction;
            var _local_68:PrismModuleExchangeRequestMessage;
            var _local_69:PrismSetSabotagedRequestAction;
            var _local_70:PrismSetSabotagedRequestMessage;
            var _local_71:PrismSetSabotagedRefusedMessage;
            var _local_72:String;
            var _local_73:PrismFightDefenderAddMessage;
            var _local_74:PrismFightDefenderLeaveMessage;
            var _local_75:PrismFightAttackerAddMessage;
            var _local_76:PrismFightAttackerRemoveMessage;
            var _local_77:PrismsListUpdateMessage;
            var _local_78:Array;
            var _local_79:PrismSubAreaWrapper;
            var _local_80:AllianceWrapper;
            var _local_81:PrismGeolocalizedInformation;
            var _local_82:AllianceInsiderPrismInformation;
            var _local_83:AlliancePrismInformation;
            var _local_84:PrismsListMessage;
            var _local_85:Vector.<PrismSubAreaWrapper>;
            var _local_86:PrismFightAddedMessage;
            var _local_87:PrismFightRemovedMessage;
            var _local_88:PrismsInfoValidMessage;
            var _local_89:AlliancePrismDialogQuestionMessage;
            var prism:PrismSubAreaWrapper;
            var oldPrism:PrismSubAreaWrapper;
            var i:int;
            var pid:int;
            var usasmsg:UpdateSelfAgressableStatusMessage;
            var giai:GuildInAllianceInformations;
            var gifsi:GuildInsiderFactSheetInformations;
            var insPrism:PrismSubareaEmptyInfo;
            var p:SocialEntityInFightWrapper;
            var defender:Object;
            var _local_100:Object;
            var plrmsg:PrismsListRegisterMessage;
            var text2:String;
            var prismUpdated:PrismSubareaEmptyInfo;
            var worldX:int;
            var worldY:int;
            var prismN:String;
            var sentenceToDispatch:String;
            var nid:uint;
            var indPrism:uint;
            var pw:PrismSubAreaWrapper;
            switch (true)
            {
                case (msg is CurrentMapMessage):
                    _local_2 = (msg as CurrentMapMessage);
                    if (((!(PlayedCharacterManager.getInstance())) || (!(PlayedCharacterManager.getInstance().currentMap))))
                    {
                        break;
                    };
                    _local_3 = SubArea.getSubAreaByMapId(PlayedCharacterManager.getInstance().currentMap.mapId);
                    _local_4 = SubArea.getSubAreaByMapId(_local_2.mapId);
                    if (((PlayedCharacterManager.getInstance().currentSubArea) && (!((_local_4.id == _local_3.id)))))
                    {
                        if (((!(PrismSubAreaWrapper.prismList[_local_3.id])) && (PrismSubAreaWrapper.prismList[_local_4.id])))
                        {
                            prism = PrismSubAreaWrapper.prismList[_local_4.id];
                            if (prism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
                            {
                                KernelEventsManager.getInstance().processCallback(PrismHookList.KohState, prism);
                            };
                        };
                        if (((PrismSubAreaWrapper.prismList[_local_3.id]) && (!(PrismSubAreaWrapper.prismList[_local_4.id]))))
                        {
                            oldPrism = PrismSubAreaWrapper.prismList[_local_3.id];
                            if (oldPrism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
                            {
                                KernelEventsManager.getInstance().processCallback(PrismHookList.KohState, null);
                            };
                        };
                    };
                    return (false);
                case (msg is SetEnableAVARequestAction):
                    _local_5 = (msg as SetEnableAVARequestAction);
                    _local_6 = new SetEnableAVARequestMessage();
                    _local_6.initSetEnableAVARequestMessage(_local_5.enable);
                    ConnectionsHandler.getConnection().send(_local_6);
                    return (true);
                case (msg is KohUpdateMessage):
                    _local_7 = (msg as KohUpdateMessage);
                    this._alliancesOnTheHill = new Vector.<AllianceOnTheHillWrapper>();
                    _local_8 = _local_7.alliances.length;
                    _local_10 = PlayedCharacterManager.getInstance().currentSubArea.id;
                    _local_12 = 0;
                    if (this.alliance)
                    {
                        _local_12 = this.alliance.allianceId;
                    };
                    i = 0;
                    while (i < _local_8)
                    {
                        if (_local_7.alliances[i].allianceId == _local_12)
                        {
                            _local_9 = SIDE_MINE;
                        }
                        else
                        {
                            if (_local_7.alliances[i].allianceId == _local_10)
                            {
                                _local_9 = SIDE_DEFENDERS;
                            }
                            else
                            {
                                _local_9 = SIDE_ATTACKERS;
                            };
                        };
                        _local_11 = AllianceOnTheHillWrapper.create(_local_7.alliances[i].allianceId, _local_7.alliances[i].allianceTag, _local_7.alliances[i].allianceName, _local_7.alliances[i].allianceEmblem, _local_7.allianceNbMembers[i], _local_7.allianceRoundWeigth[i], _local_7.allianceMatchScore[i], _local_9);
                        this._alliancesOnTheHill.push(_local_11);
                        i++;
                    };
                    KernelEventsManager.getInstance().processCallback(AlignmentHookList.KohUpdate, this._alliancesOnTheHill, _local_7.allianceMapWinner, _local_7.allianceMapWinnerScore, _local_7.allianceMapMyAllianceScore, _local_7.nextTickTime);
                    return (true);
                case (msg is AllianceCreationStartedMessage):
                    Kernel.getWorker().addFrame(this._allianceDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationStarted, false, false);
                    return (true);
                case (msg is AllianceModificationStartedMessage):
                    _local_13 = (msg as AllianceModificationStartedMessage);
                    Kernel.getWorker().addFrame(this._allianceDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationStarted, _local_13.canChangeName, _local_13.canChangeEmblem);
                    return (true);
                case (msg is AllianceCreationResultMessage):
                    _local_14 = (msg as AllianceCreationResultMessage);
                    switch (_local_14.result)
                    {
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_ALREADY_IN_GROUP:
                            _local_15 = I18n.getUiText("ui.alliance.alreadyInAlliance");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_CANCEL:
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                            _local_15 = I18n.getUiText("ui.guild.AlreadyUseEmblem");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_LEAVE:
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:
                            _local_15 = I18n.getUiText("ui.alliance.alreadyUseName");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:
                            _local_15 = I18n.getUiText("ui.alliance.invalidName");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_TAG_ALREADY_EXISTS:
                            _local_15 = I18n.getUiText("ui.alliance.alreadyUseTag");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_TAG_INVALID:
                            _local_15 = I18n.getUiText("ui.alliance.invalidTag");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:
                            _local_15 = I18n.getUiText("ui.guild.requirementUnmet");
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_OK:
                            Kernel.getWorker().removeFrame(this._allianceDialogFrame);
                            this._hasAlliance = true;
                            break;
                        case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_UNKNOWN:
                            _local_15 = I18n.getUiText("ui.common.unknownFail");
                            break;
                    };
                    if (_local_15)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_15, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationResult, _local_14.result);
                    return (true);
                case (msg is AllianceMembershipMessage):
                    _local_16 = (msg as AllianceMembershipMessage);
                    if (this._alliance != null)
                    {
                        this._alliance.update(_local_16.allianceInfo.allianceId, _local_16.allianceInfo.allianceTag, _local_16.allianceInfo.allianceName, _local_16.allianceInfo.allianceEmblem);
                    }
                    else
                    {
                        this._alliance = AllianceWrapper.create(_local_16.allianceInfo.allianceId, _local_16.allianceInfo.allianceTag, _local_16.allianceInfo.allianceName, _local_16.allianceInfo.allianceEmblem);
                    };
                    this._hasAlliance = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated, true);
                    return (true);
                case (msg is AllianceInvitationAction):
                    _local_17 = (msg as AllianceInvitationAction);
                    _local_18 = new AllianceInvitationMessage();
                    _local_18.initAllianceInvitationMessage(_local_17.targetId);
                    ConnectionsHandler.getConnection().send(_local_18);
                    return (true);
                case (msg is AllianceInvitedMessage):
                    _local_19 = (msg as AllianceInvitedMessage);
                    Kernel.getWorker().addFrame(this._allianceDialogFrame);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvited, _local_19.allianceInfo.allianceName, _local_19.recruterId, _local_19.recruterName);
                    return (true);
                case (msg is AllianceInvitationStateRecruterMessage):
                    _local_20 = (msg as AllianceInvitationStateRecruterMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvitationStateRecruter, _local_20.invitationState, _local_20.recrutedName);
                    if ((((_local_20.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED)) || ((_local_20.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK))))
                    {
                        Kernel.getWorker().removeFrame(this._allianceDialogFrame);
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(this._allianceDialogFrame);
                    };
                    return (true);
                case (msg is AllianceInvitationStateRecrutedMessage):
                    _local_21 = (msg as AllianceInvitationStateRecrutedMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvitationStateRecruted, _local_21.invitationState);
                    if ((((_local_21.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED)) || ((_local_21.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK))))
                    {
                        Kernel.getWorker().removeFrame(this._allianceDialogFrame);
                    };
                    return (true);
                case (msg is AllianceJoinedMessage):
                    _local_22 = (msg as AllianceJoinedMessage);
                    this._hasAlliance = true;
                    this._alliance = AllianceWrapper.create(_local_22.allianceInfo.allianceId, _local_22.allianceInfo.allianceTag, _local_22.allianceInfo.allianceName, _local_22.allianceInfo.allianceEmblem);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated, true);
                    _local_23 = I18n.getUiText("ui.alliance.joinAllianceMessage", [_local_22.allianceInfo.allianceName]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_23, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is AllianceKickRequestAction):
                    _local_24 = (msg as AllianceKickRequestAction);
                    _local_25 = new AllianceKickRequestMessage();
                    _local_25.initAllianceKickRequestMessage(_local_24.guildId);
                    ConnectionsHandler.getConnection().send(_local_25);
                    return (true);
                case (msg is AllianceGuildLeavingMessage):
                    _local_26 = (msg as AllianceGuildLeavingMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceGuildLeaving, _local_26.kicked, _local_26.guildId);
                    return (true);
                case (msg is AllianceLeftMessage):
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceLeft);
                    this._hasAlliance = false;
                    this._alliance = null;
                    _local_27 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    if (_local_27)
                    {
                        for each (pid in _local_27.playersId)
                        {
                            _local_27.removeIconsCategory(pid, EntityIconEnum.AVA_CATEGORY);
                        };
                        usasmsg = new UpdateSelfAgressableStatusMessage();
                        usasmsg.initUpdateSelfAgressableStatusMessage(AggressableStatusEnum.NON_AGGRESSABLE);
                        _local_27.process(usasmsg);
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated, false);
                    return (true);
                case (msg is AllianceFactsRequestAction):
                    _local_28 = (msg as AllianceFactsRequestAction);
                    _local_29 = new AllianceFactsRequestMessage();
                    _local_29.initAllianceFactsRequestMessage(_local_28.allianceId);
                    ConnectionsHandler.getConnection().send(_local_29);
                    return (true);
                case (msg is AllianceFactsMessage):
                    _local_30 = (msg as AllianceFactsMessage);
                    _local_31 = this._allAlliances[_local_30.infos.allianceId];
                    _local_32 = new Vector.<GuildFactSheetWrapper>();
                    _local_34 = 0;
                    _local_35 = SocialFrame.getInstance();
                    for each (giai in _local_30.guilds)
                    {
                        _local_33 = _local_35.getGuildById(giai.guildId);
                        if (_local_33)
                        {
                            _local_33.update(giai.guildId, giai.guildName, giai.guildEmblem, _local_33.leaderId, _local_33.leaderName, giai.guildLevel, giai.nbMembers, _local_33.creationDate, _local_33.members, _local_33.nbConnectedMembers, _local_33.nbTaxCollectors, _local_33.lastActivity, giai.enabled, _local_30.infos.allianceId, _local_30.infos.allianceName, _local_30.infos.allianceTag, _local_44);
                        }
                        else
                        {
                            _local_33 = GuildFactSheetWrapper.create(giai.guildId, giai.guildName, giai.guildEmblem, 0, "", giai.guildLevel, giai.nbMembers, 0, null, 0, 0, 0, giai.enabled, _local_30.infos.allianceId, _local_30.infos.allianceName, _local_30.infos.allianceTag, _local_44);
                        };
                        _local_34 = (_local_34 + giai.nbMembers);
                        _local_35.updateGuildById(giai.guildId, _local_33);
                        _local_32.push(_local_33);
                    };
                    if (_local_31)
                    {
                        _local_31.update(_local_30.infos.allianceId, _local_30.infos.allianceTag, _local_30.infos.allianceName, _local_30.infos.allianceEmblem, _local_30.infos.creationDate, _local_32.length, _local_34, _local_32, _local_30.controlledSubareaIds, _local_30.leaderCharacterId, _local_30.leaderCharacterName);
                    }
                    else
                    {
                        _local_31 = AllianceWrapper.create(_local_30.infos.allianceId, _local_30.infos.allianceTag, _local_30.infos.allianceName, _local_30.infos.allianceEmblem, _local_30.infos.creationDate, _local_32.length, _local_34, _local_32, _local_30.controlledSubareaIds, _local_30.leaderCharacterId, _local_30.leaderCharacterName);
                        this._allAlliances[_local_30.infos.allianceId] = _local_31;
                    };
                    KernelEventsManager.getInstance().processCallback(SocialHookList.OpenOneAlliance, _local_31);
                    return (true);
                case (msg is AllianceFactsErrorMessage):
                    _local_36 = (msg as AllianceFactsErrorMessage);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.alliance.doesntExistAnymore"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is AllianceChangeGuildRightsAction):
                    _local_37 = (msg as AllianceChangeGuildRightsAction);
                    _local_38 = new AllianceChangeGuildRightsMessage();
                    _local_38.initAllianceChangeGuildRightsMessage(_local_37.guildId, _local_37.rights);
                    ConnectionsHandler.getConnection().send(_local_38);
                    return (true);
                case (msg is AllianceInsiderInfoRequestAction):
                    _local_39 = (msg as AllianceInsiderInfoRequestAction);
                    _local_40 = new AllianceInsiderInfoRequestMessage();
                    _local_40.initAllianceInsiderInfoRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_40);
                    return (true);
                case (msg is AllianceInsiderInfoMessage):
                    _local_41 = (msg as AllianceInsiderInfoMessage);
                    _local_42 = new Vector.<GuildFactSheetWrapper>();
                    _local_44 = true;
                    _local_45 = new Vector.<uint>();
                    _local_46 = 0;
                    _local_47 = SocialFrame.getInstance();
                    for each (gifsi in _local_41.guilds)
                    {
                        _local_43 = _local_47.getGuildById(gifsi.guildId);
                        if (_local_43)
                        {
                            _local_43.update(gifsi.guildId, gifsi.guildName, gifsi.guildEmblem, gifsi.leaderId, gifsi.leaderName, gifsi.guildLevel, gifsi.nbMembers, _local_43.creationDate, _local_43.members, gifsi.nbConnectedMembers, gifsi.nbTaxCollectors, gifsi.lastActivity, gifsi.enabled, _local_41.allianceInfos.allianceId, _local_41.allianceInfos.allianceName, _local_41.allianceInfos.allianceTag, _local_44);
                        }
                        else
                        {
                            _local_43 = GuildFactSheetWrapper.create(gifsi.guildId, gifsi.guildName, gifsi.guildEmblem, gifsi.leaderId, gifsi.leaderName, gifsi.guildLevel, gifsi.nbMembers, 0, null, gifsi.nbConnectedMembers, gifsi.nbTaxCollectors, gifsi.lastActivity, gifsi.enabled, _local_41.allianceInfos.allianceId, _local_41.allianceInfos.allianceName, _local_41.allianceInfos.allianceTag, _local_44);
                        };
                        _local_46 = (_local_46 + gifsi.nbMembers);
                        _local_47.updateGuildById(gifsi.guildId, _local_43);
                        _local_42.push(_local_43);
                        _local_44 = false;
                    };
                    for each (insPrism in _local_41.prisms)
                    {
                        if ((((insPrism is PrismGeolocalizedInformation)) && (((insPrism as PrismGeolocalizedInformation).prism is AllianceInsiderPrismInformation))))
                        {
                            _local_45.push(insPrism.subAreaId);
                        };
                    };
                    _local_48 = new PrismsListUpdateMessage();
                    _local_48.initPrismsListUpdateMessage(_local_41.prisms);
                    this.process(_local_48);
                    if (this._alliance)
                    {
                        this._alliance.update(_local_41.allianceInfos.allianceId, _local_41.allianceInfos.allianceTag, _local_41.allianceInfos.allianceName, _local_41.allianceInfos.allianceEmblem, _local_41.allianceInfos.creationDate, _local_41.guilds.length, _local_46, _local_42, _local_45);
                    }
                    else
                    {
                        this._alliance = AllianceWrapper.create(_local_41.allianceInfos.allianceId, _local_41.allianceInfos.allianceTag, _local_41.allianceInfos.allianceName, _local_41.allianceInfos.allianceEmblem, _local_41.allianceInfos.creationDate, _local_41.guilds.length, _local_46, _local_42, _local_45);
                    };
                    this._allAlliances[_local_41.allianceInfos.allianceId] = this._alliance;
                    this._hasAlliance = true;
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceUpdateInformations);
                    return (true);
                case (msg is PrismSettingsRequestAction):
                    _local_49 = (msg as PrismSettingsRequestAction);
                    _local_50 = new PrismSettingsRequestMessage();
                    _local_50.initPrismSettingsRequestMessage(_local_49.subAreaId, _local_49.startDefenseTime);
                    ConnectionsHandler.getConnection().send(_local_50);
                    return (true);
                case (msg is PrismSettingsErrorMessage):
                    _local_51 = (msg as PrismSettingsErrorMessage);
                    _local_52 = I18n.getUiText("ui.error.cantModifiedPrismVulnerabiltyHour");
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_52, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is PrismFightJoinLeaveRequestAction):
                    _local_53 = (msg as PrismFightJoinLeaveRequestAction);
                    _local_54 = new PrismFightJoinLeaveRequestMessage();
                    this._autoLeaveHelpers = false;
                    if ((((_local_53.subAreaId == 0)) && (!(_local_53.join))))
                    {
                        for each (p in TaxCollectorsManager.getInstance().prismsFighters)
                        {
                            for each (defender in p.allyCharactersInformations)
                            {
                                if (defender.playerCharactersInformations.id == PlayedCharacterManager.getInstance().id)
                                {
                                    this._autoLeaveHelpers = true;
                                    _local_54.initPrismFightJoinLeaveRequestMessage(p.uniqueId, _local_53.join);
                                    ConnectionsHandler.getConnection().send(_local_54);
                                    return (true);
                                };
                            };
                        };
                    }
                    else
                    {
                        _local_54.initPrismFightJoinLeaveRequestMessage(_local_53.subAreaId, _local_53.join);
                        ConnectionsHandler.getConnection().send(_local_54);
                    };
                    return (true);
                case (msg is PrismFightSwapRequestAction):
                    _local_55 = (msg as PrismFightSwapRequestAction);
                    _local_56 = new PrismFightSwapRequestMessage();
                    _local_56.initPrismFightSwapRequestMessage(_local_55.subAreaId, _local_55.targetId);
                    ConnectionsHandler.getConnection().send(_local_56);
                    return (true);
                case (msg is PrismInfoJoinLeaveRequestAction):
                    _local_57 = (msg as PrismInfoJoinLeaveRequestAction);
                    _local_58 = new PrismInfoJoinLeaveRequestMessage();
                    _local_58.initPrismInfoJoinLeaveRequestMessage(_local_57.join);
                    this._infoJoinLeave = _local_57.join;
                    ConnectionsHandler.getConnection().send(_local_58);
                    return (true);
                case (msg is PrismsListRegisterAction):
                    _local_59 = (msg as PrismsListRegisterAction);
                    _local_60 = false;
                    _local_61 = 0;
                    if (this._prismsListeners[_local_59.uiName])
                    {
                        _local_61 = this._prismsListeners[_local_59.uiName];
                    };
                    _local_62 = _local_59.listen;
                    if (_local_62 != PrismListenEnum.PRISM_LISTEN_NONE)
                    {
                        if (_local_61 == PrismListenEnum.PRISM_LISTEN_NONE)
                        {
                            this._prismsListeners[_local_59.uiName] = _local_62;
                        };
                        if (this._currentPrismsListenMode == PrismListenEnum.PRISM_LISTEN_MINE)
                        {
                            _local_60 = false;
                        }
                        else
                        {
                            _local_60 = true;
                        };
                    }
                    else
                    {
                        if (_local_61 > PrismListenEnum.PRISM_LISTEN_NONE)
                        {
                            this._prismsListeners[_local_59.uiName] = PrismListenEnum.PRISM_LISTEN_NONE;
                        };
                        for each (_local_100 in this._prismsListeners)
                        {
                            if (_local_100 == PrismListenEnum.PRISM_LISTEN_MINE)
                            {
                                _local_62 = PrismListenEnum.PRISM_LISTEN_MINE;
                                break;
                            };
                            if (_local_100 == PrismListenEnum.PRISM_LISTEN_ALL)
                            {
                                _local_62 = PrismListenEnum.PRISM_LISTEN_ALL;
                            };
                        };
                        _local_60 = true;
                    };
                    if (_local_60)
                    {
                        plrmsg = new PrismsListRegisterMessage();
                        plrmsg.initPrismsListRegisterMessage(_local_62);
                        ConnectionsHandler.getConnection().send(plrmsg);
                        this._currentPrismsListenMode = _local_62;
                    };
                    return (true);
                case (msg is PrismAttackRequestAction):
                    _local_63 = (msg as PrismAttackRequestAction);
                    _local_64 = new PrismAttackRequestMessage();
                    _local_64.initPrismAttackRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_64);
                    return (true);
                case (msg is PrismUseRequestAction):
                    _local_65 = (msg as PrismUseRequestAction);
                    _local_66 = new PrismUseRequestMessage();
                    _local_66.initPrismUseRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_66);
                    return (true);
                case (msg is PrismModuleExchangeRequestAction):
                    _local_67 = (msg as PrismModuleExchangeRequestAction);
                    _local_68 = new PrismModuleExchangeRequestMessage();
                    _local_68.initPrismModuleExchangeRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_68);
                    return (true);
                case (msg is PrismSetSabotagedRequestAction):
                    _local_69 = (msg as PrismSetSabotagedRequestAction);
                    _local_70 = new PrismSetSabotagedRequestMessage();
                    _local_70.initPrismSetSabotagedRequestMessage(_local_69.subAreaId);
                    ConnectionsHandler.getConnection().send(_local_70);
                    return (true);
                case (msg is PrismSetSabotagedRefusedMessage):
                    _local_71 = (msg as PrismSetSabotagedRefusedMessage);
                    switch (_local_71.reason)
                    {
                        case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_REFUSED:
                            _local_72 = I18n.getUiText("ui.prism.sabotageRefused");
                            break;
                        case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_INSUFFICIENT_RIGHTS:
                            _local_72 = I18n.getUiText("ui.social.taxCollectorNoRights");
                            break;
                        case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_MEMBER_ACCOUNT_NEEDED:
                            _local_72 = I18n.getUiText("ui.payzone.limit");
                            break;
                        case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_RESTRICTED_ACCOUNT:
                            _local_72 = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                            break;
                        case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_WRONG_STATE:
                            _local_72 = I18n.getUiText("ui.prism.sabotageRefusedWrongState");
                            break;
                        case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_WRONG_ALLIANCE:
                        case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_NO_PRISM:
                            _log.debug(("ERROR : Prism sabotage failed for reason " + _local_71.reason));
                            break;
                    };
                    if (_local_72)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_72, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is PrismFightDefenderAddMessage):
                    _local_73 = (msg as PrismFightDefenderAddMessage);
                    TaxCollectorsManager.getInstance().addFighter(1, _local_73.subAreaId, _local_73.defender, true);
                    return (true);
                case (msg is PrismFightDefenderLeaveMessage):
                    _local_74 = (msg as PrismFightDefenderLeaveMessage);
                    if (((this._autoLeaveHelpers) && ((_local_74.fighterToRemoveId == PlayedCharacterManager.getInstance().id))))
                    {
                        text2 = I18n.getUiText("ui.prism.AutoDisjoin");
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, text2, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    TaxCollectorsManager.getInstance().removeFighter(1, _local_74.subAreaId, _local_74.fighterToRemoveId, true);
                    return (true);
                case (msg is PrismFightAttackerAddMessage):
                    _local_75 = (msg as PrismFightAttackerAddMessage);
                    TaxCollectorsManager.getInstance().addFighter(1, _local_75.subAreaId, _local_75.attacker, false);
                    return (true);
                case (msg is PrismFightAttackerRemoveMessage):
                    _local_76 = (msg as PrismFightAttackerRemoveMessage);
                    TaxCollectorsManager.getInstance().removeFighter(1, _local_76.subAreaId, _local_76.fighterToRemoveId, false);
                    return (true);
                case (msg is PrismsListUpdateMessage):
                    _local_77 = (msg as PrismsListUpdateMessage);
                    _local_78 = new Array();
                    for each (prismUpdated in _local_77.prisms)
                    {
                        if ((((prismUpdated is PrismGeolocalizedInformation)) && (((prismUpdated as PrismGeolocalizedInformation).prism is AllianceInsiderPrismInformation))))
                        {
                            _local_81 = (prismUpdated as PrismGeolocalizedInformation);
                            _local_82 = (_local_81.prism as AllianceInsiderPrismInformation);
                            _local_79 = PrismSubAreaWrapper.prismList[prismUpdated.subAreaId];
                            worldX = _local_81.worldX;
                            worldY = _local_81.worldY;
                            prismN = (((SubArea.getSubAreaById(_local_81.subAreaId).name + " (") + SubArea.getSubAreaById(_local_81.subAreaId).area.name) + ")");
                            if ((((((_local_82.state == PrismStateEnum.PRISM_STATE_SABOTAGED)) && (_local_79))) && (!((_local_79.state == PrismStateEnum.PRISM_STATE_SABOTAGED)))))
                            {
                                sentenceToDispatch = I18n.getUiText("ui.prism.sabotaged", [prismN, ((worldX + ",") + worldY)]);
                                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, sentenceToDispatch, ChatActivableChannelsEnum.CHANNEL_ALLIANCE, TimeManager.getInstance().getTimestamp());
                            }
                            else
                            {
                                if ((((((_local_82.state == PrismStateEnum.PRISM_STATE_ATTACKED)) && (_local_79))) && (!((_local_79.state == PrismStateEnum.PRISM_STATE_ATTACKED)))))
                                {
                                    sentenceToDispatch = I18n.getUiText("ui.prism.attacked", [prismN, ((worldX + ",") + worldY)]);
                                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, (((("{openSocial,2,2,1," + _local_81.subAreaId) + "::") + sentenceToDispatch) + "}"), ChatActivableChannelsEnum.CHANNEL_ALLIANCE, TimeManager.getInstance().getTimestamp());
                                    if (((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.PRISM_ATTACK))))
                                    {
                                        KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.PRISM_ATTACK, [prismN, ((_local_81.worldX + ",") + _local_81.worldY)]);
                                    };
                                    if (OptionManager.getOptionManager("dofus")["warnOnGuildItemAgression"])
                                    {
                                        nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.prism.attackedNotificationTitle"), I18n.getUiText("ui.prism.attackedNotification", [SubArea.getSubAreaById(_local_81.subAreaId).name, ((_local_81.worldX + ",") + _local_81.worldY)]), NotificationTypeEnum.INVITATION, "PrismAttacked");
                                        NotificationManager.getInstance().addButtonToNotification(nid, I18n.getUiText("ui.common.join"), "OpenSocial", [2, 2, [1, _local_81.subAreaId]], false, 200, 0, "hook");
                                        NotificationManager.getInstance().sendNotification(nid);
                                    };
                                };
                            };
                        };
                        _local_78.push(prismUpdated.subAreaId);
                        PrismSubAreaWrapper.getFromNetwork(prismUpdated, this._alliance);
                    };
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsListUpdate, _local_78);
                    return (true);
                case (msg is PrismsListMessage):
                    _local_84 = (msg as PrismsListMessage);
                    _local_85 = new Vector.<PrismSubAreaWrapper>();
                    indPrism = 0;
                    while (indPrism < _local_84.prisms.length)
                    {
                        pw = PrismSubAreaWrapper.getFromNetwork(_local_84.prisms[indPrism], this._alliance);
                        if (pw.alliance)
                        {
                            _local_85.push(pw);
                        };
                        indPrism++;
                    };
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsList, PrismSubAreaWrapper.prismList);
                    return (true);
                case (msg is PrismFightAddedMessage):
                    _local_86 = (msg as PrismFightAddedMessage);
                    TaxCollectorsManager.getInstance().addPrism(_local_86.fight);
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInFightAdded, _local_86.fight.subAreaId);
                    return (true);
                case (msg is PrismFightRemovedMessage):
                    _local_87 = (msg as PrismFightRemovedMessage);
                    delete TaxCollectorsManager.getInstance().prismsFighters[_local_87.subAreaId];
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInFightRemoved, _local_87.subAreaId);
                    return (true);
                case (msg is PrismsInfoValidMessage):
                    _local_88 = (msg as PrismsInfoValidMessage);
                    TaxCollectorsManager.getInstance().setPrismsInFight(_local_88.fights);
                    KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsInFightList);
                    return (true);
                case (msg is AlliancePrismDialogQuestionMessage):
                    _local_89 = (msg as AlliancePrismDialogQuestionMessage);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.AlliancePrismDialogQuestion);
                    return (true);
            };
            return (false);
        }

        public function pushRoleplay():void
        {
        }

        public function pullRoleplay():void
        {
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames


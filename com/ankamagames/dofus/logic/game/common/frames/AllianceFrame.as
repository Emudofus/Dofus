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
   import com.ankamagames.jerakine.messages.Message;
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
   import com.ankamagames.dofus.network.messages.game.prism.PrismsListRegisterMessage;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismAttackRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismAttackRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismUseRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismUseRequestMessage;
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
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.misc.lists.AlignmentHookList;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.network.enums.SocialGroupCreationResultEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.enums.SocialGroupInvitationStateEnum;
   import com.ankamagames.dofus.types.enums.EntityIconEnum;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
   import com.ankamagames.dofus.network.enums.PrismSetSabotagedRefusedReasonEnum;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationStartedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceLeftMessage;
   
   public class AllianceFrame extends Object implements Frame
   {
      
      public function AllianceFrame() {
         this._allAlliances = new Dictionary(true);
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceFrame));
      
      private static const SIDE_MINE:int = 0;
      
      private static const SIDE_DEFENDERS:int = 1;
      
      private static const SIDE_ATTACKERS:int = 2;
      
      private static var _instance:AllianceFrame;
      
      public static function getInstance() : AllianceFrame {
         return _instance;
      }
      
      private var _allianceDialogFrame:AllianceDialogFrame;
      
      private var _hasAlliance:Boolean = false;
      
      private var _alliance:AllianceWrapper;
      
      private var _allAlliances:Dictionary;
      
      private var _alliancesOnTheHill:Vector.<AllianceOnTheHillWrapper>;
      
      private var _fightId:uint = 0;
      
      private var _prismState:int = 0;
      
      private var _infoJoinLeave:Boolean;
      
      private var _autoLeaveHelpers:Boolean;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get hasAlliance() : Boolean {
         return this._hasAlliance;
      }
      
      public function get alliance() : AllianceWrapper {
         return this._alliance;
      }
      
      public function getAllianceById(param1:uint) : AllianceWrapper {
         var _loc2_:AllianceWrapper = this._allAlliances[param1];
         if(!_loc2_)
         {
            _loc2_ = AllianceWrapper.getAllianceById(param1);
         }
         return _loc2_;
      }
      
      public function getPrismSubAreaById(param1:uint) : PrismSubAreaWrapper {
         return PrismSubAreaWrapper.prismList[param1];
      }
      
      public function get alliancesOnTheHill() : Vector.<AllianceOnTheHillWrapper> {
         return this._alliancesOnTheHill;
      }
      
      public function _pickup_fighter(param1:Array, param2:uint) : PrismFightersWrapper {
         var _loc5_:PrismFightersWrapper = null;
         var _loc3_:uint = 0;
         var _loc4_:* = false;
         for each (_loc5_ in param1)
         {
            if(_loc5_.playerCharactersInformations.id == param2)
            {
               _loc4_ = true;
               break;
            }
            _loc3_++;
         }
         return param1.splice(_loc3_,1)[0];
      }
      
      public function pushed() : Boolean {
         PrismSubAreaWrapper.reset();
         _instance = this;
         this._infoJoinLeave = false;
         this._allianceDialogFrame = new AllianceDialogFrame();
         return true;
      }
      
      public function pulled() : Boolean {
         _instance = null;
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:CurrentMapMessage = null;
         var _loc3_:SubArea = null;
         var _loc4_:SubArea = null;
         var _loc5_:SetEnableAVARequestAction = null;
         var _loc6_:SetEnableAVARequestMessage = null;
         var _loc7_:KohUpdateMessage = null;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:AllianceOnTheHillWrapper = null;
         var _loc12_:* = 0;
         var _loc13_:AllianceModificationStartedMessage = null;
         var _loc14_:AllianceCreationResultMessage = null;
         var _loc15_:String = null;
         var _loc16_:AllianceMembershipMessage = null;
         var _loc17_:AllianceInvitationAction = null;
         var _loc18_:AllianceInvitationMessage = null;
         var _loc19_:AllianceInvitedMessage = null;
         var _loc20_:AllianceInvitationStateRecruterMessage = null;
         var _loc21_:AllianceInvitationStateRecrutedMessage = null;
         var _loc22_:AllianceJoinedMessage = null;
         var _loc23_:String = null;
         var _loc24_:AllianceKickRequestAction = null;
         var _loc25_:AllianceKickRequestMessage = null;
         var _loc26_:AllianceGuildLeavingMessage = null;
         var _loc27_:RoleplayEntitiesFrame = null;
         var _loc28_:AllianceFactsRequestAction = null;
         var _loc29_:AllianceFactsRequestMessage = null;
         var _loc30_:AllianceFactsMessage = null;
         var _loc31_:AllianceWrapper = null;
         var _loc32_:Vector.<GuildFactSheetWrapper> = null;
         var _loc33_:GuildFactSheetWrapper = null;
         var _loc34_:* = 0;
         var _loc35_:SocialFrame = null;
         var _loc36_:AllianceFactsErrorMessage = null;
         var _loc37_:AllianceChangeGuildRightsAction = null;
         var _loc38_:AllianceChangeGuildRightsMessage = null;
         var _loc39_:AllianceInsiderInfoRequestAction = null;
         var _loc40_:AllianceInsiderInfoRequestMessage = null;
         var _loc41_:AllianceInsiderInfoMessage = null;
         var _loc42_:Vector.<GuildFactSheetWrapper> = null;
         var _loc43_:GuildFactSheetWrapper = null;
         var _loc44_:* = false;
         var _loc45_:Vector.<uint> = null;
         var _loc46_:* = 0;
         var _loc47_:SocialFrame = null;
         var _loc48_:PrismsListUpdateMessage = null;
         var _loc49_:PrismSettingsRequestAction = null;
         var _loc50_:PrismSettingsRequestMessage = null;
         var _loc51_:PrismSettingsErrorMessage = null;
         var _loc52_:String = null;
         var _loc53_:PrismFightJoinLeaveRequestAction = null;
         var _loc54_:PrismFightJoinLeaveRequestMessage = null;
         var _loc55_:PrismFightSwapRequestAction = null;
         var _loc56_:PrismFightSwapRequestMessage = null;
         var _loc57_:PrismInfoJoinLeaveRequestAction = null;
         var _loc58_:PrismInfoJoinLeaveRequestMessage = null;
         var _loc59_:PrismsListRegisterAction = null;
         var _loc60_:PrismsListRegisterMessage = null;
         var _loc61_:PrismAttackRequestAction = null;
         var _loc62_:PrismAttackRequestMessage = null;
         var _loc63_:PrismUseRequestAction = null;
         var _loc64_:PrismUseRequestMessage = null;
         var _loc65_:PrismSetSabotagedRequestAction = null;
         var _loc66_:PrismSetSabotagedRequestMessage = null;
         var _loc67_:PrismSetSabotagedRefusedMessage = null;
         var _loc68_:String = null;
         var _loc69_:PrismFightDefenderAddMessage = null;
         var _loc70_:PrismFightDefenderLeaveMessage = null;
         var _loc71_:PrismFightAttackerAddMessage = null;
         var _loc72_:PrismFightAttackerRemoveMessage = null;
         var _loc73_:PrismsListUpdateMessage = null;
         var _loc74_:Array = null;
         var _loc75_:PrismSubAreaWrapper = null;
         var _loc76_:AllianceWrapper = null;
         var _loc77_:PrismGeolocalizedInformation = null;
         var _loc78_:AllianceInsiderPrismInformation = null;
         var _loc79_:AlliancePrismInformation = null;
         var _loc80_:PrismsListMessage = null;
         var _loc81_:Vector.<PrismSubAreaWrapper> = null;
         var _loc82_:PrismFightAddedMessage = null;
         var _loc83_:PrismFightRemovedMessage = null;
         var _loc84_:PrismsInfoValidMessage = null;
         var _loc85_:AlliancePrismDialogQuestionMessage = null;
         var _loc86_:PrismSubAreaWrapper = null;
         var _loc87_:PrismSubAreaWrapper = null;
         var _loc88_:* = 0;
         var _loc89_:* = 0;
         var _loc90_:UpdateSelfAgressableStatusMessage = null;
         var _loc91_:GuildInAllianceInformations = null;
         var _loc92_:GuildInsiderFactSheetInformations = null;
         var _loc93_:PrismSubareaEmptyInfo = null;
         var _loc94_:SocialEntityInFightWrapper = null;
         var _loc95_:Object = null;
         var _loc96_:String = null;
         var _loc97_:PrismSubareaEmptyInfo = null;
         var _loc98_:* = 0;
         var _loc99_:* = 0;
         var _loc100_:String = null;
         var _loc101_:String = null;
         var _loc102_:uint = 0;
         var _loc103_:uint = 0;
         var _loc104_:PrismSubAreaWrapper = null;
         switch(true)
         {
            case param1 is CurrentMapMessage:
               _loc2_ = param1 as CurrentMapMessage;
               if(!PlayedCharacterManager.getInstance() || !PlayedCharacterManager.getInstance().currentMap)
               {
                  break;
               }
               _loc3_ = SubArea.getSubAreaByMapId(PlayedCharacterManager.getInstance().currentMap.mapId);
               _loc4_ = SubArea.getSubAreaByMapId(_loc2_.mapId);
               if((PlayedCharacterManager.getInstance().currentSubArea) && !(_loc4_.id == _loc3_.id))
               {
                  if(!PrismSubAreaWrapper.prismList[_loc3_.id] && (PrismSubAreaWrapper.prismList[_loc4_.id]))
                  {
                     _loc86_ = PrismSubAreaWrapper.prismList[_loc4_.id];
                     if(_loc86_.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
                     {
                        KernelEventsManager.getInstance().processCallback(PrismHookList.KohState,_loc86_);
                     }
                  }
                  if((PrismSubAreaWrapper.prismList[_loc3_.id]) && !PrismSubAreaWrapper.prismList[_loc4_.id])
                  {
                     _loc87_ = PrismSubAreaWrapper.prismList[_loc3_.id];
                     if(_loc87_.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
                     {
                        KernelEventsManager.getInstance().processCallback(PrismHookList.KohState,null);
                     }
                  }
               }
               return false;
            case param1 is SetEnableAVARequestAction:
               _loc5_ = param1 as SetEnableAVARequestAction;
               _loc6_ = new SetEnableAVARequestMessage();
               _loc6_.initSetEnableAVARequestMessage(_loc5_.enable);
               ConnectionsHandler.getConnection().send(_loc6_);
               return true;
            case param1 is KohUpdateMessage:
               _loc7_ = param1 as KohUpdateMessage;
               this._alliancesOnTheHill = new Vector.<AllianceOnTheHillWrapper>();
               _loc8_ = _loc7_.alliances.length;
               _loc10_ = PlayedCharacterManager.getInstance().currentSubArea.id;
               _loc12_ = 0;
               if(this.alliance)
               {
                  _loc12_ = this.alliance.allianceId;
               }
               _loc88_ = 0;
               while(_loc88_ < _loc8_)
               {
                  if(_loc7_.alliances[_loc88_].allianceId == _loc12_)
                  {
                     _loc9_ = SIDE_MINE;
                  }
                  else
                  {
                     if(_loc7_.alliances[_loc88_].allianceId == _loc10_)
                     {
                        _loc9_ = SIDE_DEFENDERS;
                     }
                     else
                     {
                        _loc9_ = SIDE_ATTACKERS;
                     }
                  }
                  _loc11_ = AllianceOnTheHillWrapper.create(_loc7_.alliances[_loc88_].allianceId,_loc7_.alliances[_loc88_].allianceTag,_loc7_.alliances[_loc88_].allianceName,_loc7_.alliances[_loc88_].allianceEmblem,_loc7_.allianceNbMembers[_loc88_],_loc7_.allianceRoundWeigth[_loc88_],_loc7_.allianceMatchScore[_loc88_],_loc9_);
                  this._alliancesOnTheHill.push(_loc11_);
                  _loc88_++;
               }
               KernelEventsManager.getInstance().processCallback(AlignmentHookList.KohUpdate,this._alliancesOnTheHill,_loc7_.allianceMapWinner,_loc7_.allianceMapWinnerScore,_loc7_.allianceMapMyAllianceScore);
               return true;
            case param1 is AllianceCreationStartedMessage:
               Kernel.getWorker().addFrame(this._allianceDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationStarted,false,false);
               return true;
            case param1 is AllianceModificationStartedMessage:
               _loc13_ = param1 as AllianceModificationStartedMessage;
               Kernel.getWorker().addFrame(this._allianceDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationStarted,_loc13_.canChangeName,_loc13_.canChangeEmblem);
               return true;
            case param1 is AllianceCreationResultMessage:
               _loc14_ = param1 as AllianceCreationResultMessage;
               switch(_loc14_.result)
               {
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_ALREADY_IN_GROUP:
                     _loc15_ = I18n.getUiText("ui.alliance.alreadyInAlliance");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_CANCEL:
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                     _loc15_ = I18n.getUiText("ui.guild.AlreadyUseEmblem");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_LEAVE:
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:
                     _loc15_ = I18n.getUiText("ui.alliance.alreadyUseName");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:
                     _loc15_ = I18n.getUiText("ui.alliance.invalidName");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_TAG_ALREADY_EXISTS:
                     _loc15_ = I18n.getUiText("ui.alliance.alreadyUseTag");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_TAG_INVALID:
                     _loc15_ = I18n.getUiText("ui.alliance.invalidTag");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:
                     _loc15_ = I18n.getUiText("ui.guild.requirementUnmet");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_OK:
                     Kernel.getWorker().removeFrame(this._allianceDialogFrame);
                     this._hasAlliance = true;
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_UNKNOWN:
                     _loc15_ = I18n.getUiText("ui.common.unknownFail");
                     break;
               }
               if(_loc15_)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc15_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationResult,_loc14_.result);
               return true;
            case param1 is AllianceMembershipMessage:
               _loc16_ = param1 as AllianceMembershipMessage;
               if(this._alliance != null)
               {
                  this._alliance.update(_loc16_.allianceInfo.allianceId,_loc16_.allianceInfo.allianceTag,_loc16_.allianceInfo.allianceName,_loc16_.allianceInfo.allianceEmblem);
               }
               else
               {
                  this._alliance = AllianceWrapper.create(_loc16_.allianceInfo.allianceId,_loc16_.allianceInfo.allianceTag,_loc16_.allianceInfo.allianceName,_loc16_.allianceInfo.allianceEmblem);
               }
               this._hasAlliance = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated,true);
               return true;
            case param1 is AllianceInvitationAction:
               _loc17_ = param1 as AllianceInvitationAction;
               _loc18_ = new AllianceInvitationMessage();
               _loc18_.initAllianceInvitationMessage(_loc17_.targetId);
               ConnectionsHandler.getConnection().send(_loc18_);
               return true;
            case param1 is AllianceInvitedMessage:
               _loc19_ = param1 as AllianceInvitedMessage;
               Kernel.getWorker().addFrame(this._allianceDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvited,_loc19_.allianceInfo.allianceName,_loc19_.recruterId,_loc19_.recruterName);
               return true;
            case param1 is AllianceInvitationStateRecruterMessage:
               _loc20_ = param1 as AllianceInvitationStateRecruterMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvitationStateRecruter,_loc20_.invitationState,_loc20_.recrutedName);
               if(_loc20_.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || _loc20_.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._allianceDialogFrame);
               }
               else
               {
                  Kernel.getWorker().addFrame(this._allianceDialogFrame);
               }
               return true;
            case param1 is AllianceInvitationStateRecrutedMessage:
               _loc21_ = param1 as AllianceInvitationStateRecrutedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvitationStateRecruted,_loc21_.invitationState);
               if(_loc21_.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || _loc21_.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._allianceDialogFrame);
               }
               return true;
            case param1 is AllianceJoinedMessage:
               _loc22_ = param1 as AllianceJoinedMessage;
               this._hasAlliance = true;
               this._alliance = AllianceWrapper.create(_loc22_.allianceInfo.allianceId,_loc22_.allianceInfo.allianceTag,_loc22_.allianceInfo.allianceName,_loc22_.allianceInfo.allianceEmblem);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated,true);
               _loc23_ = I18n.getUiText("ui.alliance.joinAllianceMessage",[_loc22_.allianceInfo.allianceName]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc23_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is AllianceKickRequestAction:
               _loc24_ = param1 as AllianceKickRequestAction;
               _loc25_ = new AllianceKickRequestMessage();
               _loc25_.initAllianceKickRequestMessage(_loc24_.guildId);
               ConnectionsHandler.getConnection().send(_loc25_);
               return true;
            case param1 is AllianceGuildLeavingMessage:
               _loc26_ = param1 as AllianceGuildLeavingMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceGuildLeaving,_loc26_.kicked,_loc26_.guildId);
               return true;
            case param1 is AllianceLeftMessage:
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceLeft);
               this._hasAlliance = false;
               this._alliance = null;
               _loc27_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if(_loc27_)
               {
                  for each (_loc89_ in _loc27_.playersId)
                  {
                     _loc27_.removeIconsCategory(_loc89_,EntityIconEnum.AVA_CATEGORY);
                  }
                  _loc90_ = new UpdateSelfAgressableStatusMessage();
                  _loc90_.initUpdateSelfAgressableStatusMessage(AggressableStatusEnum.NON_AGGRESSABLE);
                  _loc27_.process(_loc90_);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated,false);
               return true;
            case param1 is AllianceFactsRequestAction:
               _loc28_ = param1 as AllianceFactsRequestAction;
               _loc29_ = new AllianceFactsRequestMessage();
               _loc29_.initAllianceFactsRequestMessage(_loc28_.allianceId);
               ConnectionsHandler.getConnection().send(_loc29_);
               return true;
            case param1 is AllianceFactsMessage:
               _loc30_ = param1 as AllianceFactsMessage;
               _loc31_ = this._allAlliances[_loc30_.infos.allianceId];
               _loc32_ = new Vector.<GuildFactSheetWrapper>();
               _loc34_ = 0;
               _loc35_ = SocialFrame.getInstance();
               for each (_loc91_ in _loc30_.guilds)
               {
                  _loc33_ = _loc35_.getGuildById(_loc91_.guildId);
                  if(_loc33_)
                  {
                     _loc33_.update(_loc91_.guildId,_loc91_.guildName,_loc91_.guildEmblem,_loc33_.leaderId,_loc33_.leaderName,_loc91_.guildLevel,_loc91_.nbMembers,_loc33_.creationDate,_loc33_.members,_loc33_.nbConnectedMembers,_loc33_.nbTaxCollectors,_loc33_.lastActivity,_loc91_.enabled,_loc30_.infos.allianceId,_loc30_.infos.allianceName,_loc44_);
                  }
                  else
                  {
                     _loc33_ = GuildFactSheetWrapper.create(_loc91_.guildId,_loc91_.guildName,_loc91_.guildEmblem,0,"",_loc91_.guildLevel,_loc91_.nbMembers,0,null,0,0,0,_loc91_.enabled,_loc30_.infos.allianceId,_loc30_.infos.allianceName,_loc44_);
                  }
                  _loc34_ = _loc34_ + _loc91_.nbMembers;
                  _loc35_.updateGuildById(_loc91_.guildId,_loc33_);
                  _loc32_.push(_loc33_);
               }
               if(_loc31_)
               {
                  _loc31_.update(_loc30_.infos.allianceId,_loc30_.infos.allianceTag,_loc30_.infos.allianceName,_loc30_.infos.allianceEmblem,_loc30_.infos.creationDate,_loc32_.length,_loc34_,_loc32_,_loc30_.controlledSubareaIds);
               }
               else
               {
                  _loc31_ = AllianceWrapper.create(_loc30_.infos.allianceId,_loc30_.infos.allianceTag,_loc30_.infos.allianceName,_loc30_.infos.allianceEmblem,_loc30_.infos.creationDate,_loc32_.length,_loc34_,_loc32_,_loc30_.controlledSubareaIds);
                  this._allAlliances[_loc30_.infos.allianceId] = _loc31_;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.OpenOneAlliance,_loc31_);
               return true;
            case param1 is AllianceFactsErrorMessage:
               _loc36_ = param1 as AllianceFactsErrorMessage;
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.alliance.doesntExistAnymore"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is AllianceChangeGuildRightsAction:
               _loc37_ = param1 as AllianceChangeGuildRightsAction;
               _loc38_ = new AllianceChangeGuildRightsMessage();
               _loc38_.initAllianceChangeGuildRightsMessage(_loc37_.guildId,_loc37_.rights);
               ConnectionsHandler.getConnection().send(_loc38_);
               return true;
            case param1 is AllianceInsiderInfoRequestAction:
               _loc39_ = param1 as AllianceInsiderInfoRequestAction;
               _loc40_ = new AllianceInsiderInfoRequestMessage();
               _loc40_.initAllianceInsiderInfoRequestMessage();
               ConnectionsHandler.getConnection().send(_loc40_);
               return true;
            case param1 is AllianceInsiderInfoMessage:
               _loc41_ = param1 as AllianceInsiderInfoMessage;
               _loc42_ = new Vector.<GuildFactSheetWrapper>();
               _loc44_ = true;
               _loc45_ = new Vector.<uint>();
               _loc46_ = 0;
               _loc47_ = SocialFrame.getInstance();
               for each (_loc92_ in _loc41_.guilds)
               {
                  _loc43_ = _loc47_.getGuildById(_loc92_.guildId);
                  if(_loc43_)
                  {
                     _loc43_.update(_loc92_.guildId,_loc92_.guildName,_loc92_.guildEmblem,_loc92_.leaderId,_loc92_.leaderName,_loc92_.guildLevel,_loc92_.nbMembers,_loc43_.creationDate,_loc43_.members,_loc92_.nbConnectedMembers,_loc92_.nbTaxCollectors,_loc92_.lastActivity,_loc92_.enabled,_loc41_.allianceInfos.allianceId,_loc41_.allianceInfos.allianceName,_loc44_);
                  }
                  else
                  {
                     _loc43_ = GuildFactSheetWrapper.create(_loc92_.guildId,_loc92_.guildName,_loc92_.guildEmblem,_loc92_.leaderId,_loc92_.leaderName,_loc92_.guildLevel,_loc92_.nbMembers,0,null,_loc92_.nbConnectedMembers,_loc92_.nbTaxCollectors,_loc92_.lastActivity,_loc92_.enabled,_loc41_.allianceInfos.allianceId,_loc41_.allianceInfos.allianceName,_loc44_);
                  }
                  _loc46_ = _loc46_ + _loc92_.nbMembers;
                  _loc47_.updateGuildById(_loc92_.guildId,_loc43_);
                  _loc42_.push(_loc43_);
                  _loc44_ = false;
               }
               for each (_loc93_ in _loc41_.prisms)
               {
                  if(_loc93_ is PrismGeolocalizedInformation && (_loc93_ as PrismGeolocalizedInformation).prism is AllianceInsiderPrismInformation)
                  {
                     _loc45_.push(_loc93_.subAreaId);
                  }
               }
               _loc48_ = new PrismsListUpdateMessage();
               _loc48_.initPrismsListUpdateMessage(_loc41_.prisms);
               this.process(_loc48_);
               if(this._alliance)
               {
                  this._alliance.update(_loc41_.allianceInfos.allianceId,_loc41_.allianceInfos.allianceTag,_loc41_.allianceInfos.allianceName,_loc41_.allianceInfos.allianceEmblem,_loc41_.allianceInfos.creationDate,_loc41_.guilds.length,_loc46_,_loc42_,_loc45_);
               }
               else
               {
                  this._alliance = AllianceWrapper.create(_loc41_.allianceInfos.allianceId,_loc41_.allianceInfos.allianceTag,_loc41_.allianceInfos.allianceName,_loc41_.allianceInfos.allianceEmblem,_loc41_.allianceInfos.creationDate,_loc41_.guilds.length,_loc46_,_loc42_,_loc45_);
               }
               this._allAlliances[_loc41_.allianceInfos.allianceId] = this._alliance;
               this._hasAlliance = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceUpdateInformations);
               return true;
            case param1 is PrismSettingsRequestAction:
               _loc49_ = param1 as PrismSettingsRequestAction;
               _loc50_ = new PrismSettingsRequestMessage();
               _loc50_.initPrismSettingsRequestMessage(_loc49_.subAreaId,_loc49_.startDefenseTime);
               ConnectionsHandler.getConnection().send(_loc50_);
               return true;
            case param1 is PrismSettingsErrorMessage:
               _loc51_ = param1 as PrismSettingsErrorMessage;
               _loc52_ = I18n.getUiText("ui.error.cantModifiedPrismVulnerabiltyHour");
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc52_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is PrismFightJoinLeaveRequestAction:
               _loc53_ = param1 as PrismFightJoinLeaveRequestAction;
               _loc54_ = new PrismFightJoinLeaveRequestMessage();
               this._autoLeaveHelpers = false;
               if(_loc53_.subAreaId == 0 && !_loc53_.join)
               {
                  for each (_loc94_ in TaxCollectorsManager.getInstance().prismsFighters)
                  {
                     for each (_loc95_ in _loc94_.allyCharactersInformations)
                     {
                        if(_loc95_.playerCharactersInformations.id == PlayedCharacterManager.getInstance().id)
                        {
                           this._autoLeaveHelpers = true;
                           _loc54_.initPrismFightJoinLeaveRequestMessage(_loc94_.uniqueId,_loc53_.join);
                           ConnectionsHandler.getConnection().send(_loc54_);
                           return true;
                        }
                     }
                  }
               }
               else
               {
                  _loc54_.initPrismFightJoinLeaveRequestMessage(_loc53_.subAreaId,_loc53_.join);
                  ConnectionsHandler.getConnection().send(_loc54_);
               }
               return true;
            case param1 is PrismFightSwapRequestAction:
               _loc55_ = param1 as PrismFightSwapRequestAction;
               _loc56_ = new PrismFightSwapRequestMessage();
               _loc56_.initPrismFightSwapRequestMessage(_loc55_.subAreaId,_loc55_.targetId);
               ConnectionsHandler.getConnection().send(_loc56_);
               return true;
            case param1 is PrismInfoJoinLeaveRequestAction:
               _loc57_ = param1 as PrismInfoJoinLeaveRequestAction;
               _loc58_ = new PrismInfoJoinLeaveRequestMessage();
               _loc58_.initPrismInfoJoinLeaveRequestMessage(_loc57_.join);
               this._infoJoinLeave = _loc57_.join;
               ConnectionsHandler.getConnection().send(_loc58_);
               return true;
            case param1 is PrismsListRegisterAction:
               _loc59_ = param1 as PrismsListRegisterAction;
               _loc60_ = new PrismsListRegisterMessage();
               _loc60_.initPrismsListRegisterMessage(_loc59_.listen);
               ConnectionsHandler.getConnection().send(_loc60_);
               return true;
            case param1 is PrismAttackRequestAction:
               _loc61_ = param1 as PrismAttackRequestAction;
               _loc62_ = new PrismAttackRequestMessage();
               _loc62_.initPrismAttackRequestMessage();
               ConnectionsHandler.getConnection().send(_loc62_);
               return true;
            case param1 is PrismUseRequestAction:
               _loc63_ = param1 as PrismUseRequestAction;
               _loc64_ = new PrismUseRequestMessage();
               _loc64_.initPrismUseRequestMessage();
               ConnectionsHandler.getConnection().send(_loc64_);
               return true;
            case param1 is PrismSetSabotagedRequestAction:
               _loc65_ = param1 as PrismSetSabotagedRequestAction;
               _loc66_ = new PrismSetSabotagedRequestMessage();
               _loc66_.initPrismSetSabotagedRequestMessage(_loc65_.subAreaId);
               ConnectionsHandler.getConnection().send(_loc66_);
               return true;
            case param1 is PrismSetSabotagedRefusedMessage:
               _loc67_ = param1 as PrismSetSabotagedRefusedMessage;
               switch(_loc67_.reason)
               {
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_REFUSED:
                     _loc68_ = I18n.getUiText("ui.prism.sabotageRefused");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_INSUFFICIENT_RIGHTS:
                     _loc68_ = I18n.getUiText("ui.social.taxCollectorNoRights");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_MEMBER_ACCOUNT_NEEDED:
                     _loc68_ = I18n.getUiText("ui.payzone.limit");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_RESTRICTED_ACCOUNT:
                     _loc68_ = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_WRONG_STATE:
                     _loc68_ = I18n.getUiText("ui.prism.sabotageRefusedWrongState");
                     break;
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_WRONG_ALLIANCE:
                  case PrismSetSabotagedRefusedReasonEnum.SABOTAGE_NO_PRISM:
                     _log.debug("ERROR : Prism sabotage failed for reason " + _loc67_.reason);
                     break;
               }
               if(_loc68_)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc68_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case param1 is PrismFightDefenderAddMessage:
               _loc69_ = param1 as PrismFightDefenderAddMessage;
               TaxCollectorsManager.getInstance().addFighter(1,_loc69_.subAreaId,_loc69_.defender,true);
               return true;
            case param1 is PrismFightDefenderLeaveMessage:
               _loc70_ = param1 as PrismFightDefenderLeaveMessage;
               if((this._autoLeaveHelpers) && _loc70_.fighterToRemoveId == PlayedCharacterManager.getInstance().id)
               {
                  _loc96_ = I18n.getUiText("ui.prism.AutoDisjoin");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc96_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               TaxCollectorsManager.getInstance().removeFighter(1,_loc70_.subAreaId,_loc70_.fighterToRemoveId,true);
               return true;
            case param1 is PrismFightAttackerAddMessage:
               _loc71_ = param1 as PrismFightAttackerAddMessage;
               TaxCollectorsManager.getInstance().addFighter(1,_loc71_.subAreaId,_loc71_.attacker,false);
               return true;
            case param1 is PrismFightAttackerRemoveMessage:
               _loc72_ = param1 as PrismFightAttackerRemoveMessage;
               TaxCollectorsManager.getInstance().removeFighter(1,_loc72_.subAreaId,_loc72_.fighterToRemoveId,false);
               return true;
            case param1 is PrismsListUpdateMessage:
               _loc73_ = param1 as PrismsListUpdateMessage;
               _loc74_ = new Array();
               for each (_loc97_ in _loc73_.prisms)
               {
                  if(_loc97_ is PrismGeolocalizedInformation && (_loc97_ as PrismGeolocalizedInformation).prism is AllianceInsiderPrismInformation)
                  {
                     _loc77_ = _loc97_ as PrismGeolocalizedInformation;
                     _loc78_ = _loc77_.prism as AllianceInsiderPrismInformation;
                     _loc75_ = PrismSubAreaWrapper.prismList[_loc97_.subAreaId];
                     _loc98_ = _loc77_.worldX;
                     _loc99_ = _loc77_.worldY;
                     _loc100_ = SubArea.getSubAreaById(_loc77_.subAreaId).name + " (" + SubArea.getSubAreaById(_loc77_.subAreaId).area.name + ")";
                     if((_loc78_.state == PrismStateEnum.PRISM_STATE_SABOTAGED) && (_loc75_) && !(_loc75_.state == PrismStateEnum.PRISM_STATE_SABOTAGED))
                     {
                        _loc101_ = I18n.getUiText("ui.prism.sabotaged",[_loc100_,_loc98_ + "," + _loc99_]);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc101_,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
                     }
                     else
                     {
                        if((_loc78_.state == PrismStateEnum.PRISM_STATE_ATTACKED) && (_loc75_) && !(_loc75_.state == PrismStateEnum.PRISM_STATE_ATTACKED))
                        {
                           _loc101_ = I18n.getUiText("ui.prism.attacked",[_loc100_,_loc98_ + "," + _loc99_]);
                           KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"{openSocial,2,2,1," + _loc77_.subAreaId + "::" + _loc101_ + "}",ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
                           if((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.PRISM_ATTACK)))
                           {
                              KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.PRISM_ATTACK,[_loc100_,_loc77_.worldX + "," + _loc77_.worldY]);
                           }
                           if(OptionManager.getOptionManager("dofus")["warnOnGuildItemAgression"])
                           {
                              _loc102_ = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.prism.attackedNotificationTitle"),I18n.getUiText("ui.prism.attackedNotification",[SubArea.getSubAreaById(_loc77_.subAreaId).name,_loc77_.worldX + "," + _loc77_.worldY]),NotificationTypeEnum.INVITATION,"PrismAttacked");
                              NotificationManager.getInstance().addButtonToNotification(_loc102_,I18n.getUiText("ui.common.join"),"OpenSocial",[2,2,[1,_loc77_.subAreaId]],false,200,0,"hook");
                              NotificationManager.getInstance().sendNotification(_loc102_);
                           }
                        }
                     }
                  }
                  _loc74_.push(_loc97_.subAreaId);
                  PrismSubAreaWrapper.getFromNetwork(_loc97_,this._alliance);
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsListUpdate,_loc74_);
               return true;
            case param1 is PrismsListMessage:
               _loc80_ = param1 as PrismsListMessage;
               _loc81_ = new Vector.<PrismSubAreaWrapper>();
               _loc103_ = 0;
               while(_loc103_ < _loc80_.prisms.length)
               {
                  _loc104_ = PrismSubAreaWrapper.getFromNetwork(_loc80_.prisms[_loc103_],this._alliance);
                  if(_loc104_.alliance)
                  {
                     _loc81_.push(_loc104_);
                  }
                  _loc103_++;
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsList,PrismSubAreaWrapper.prismList);
               return true;
            case param1 is PrismFightAddedMessage:
               _loc82_ = param1 as PrismFightAddedMessage;
               TaxCollectorsManager.getInstance().addPrism(_loc82_.fight);
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInFightAdded,_loc82_.fight.subAreaId);
               return true;
            case param1 is PrismFightRemovedMessage:
               _loc83_ = param1 as PrismFightRemovedMessage;
               delete TaxCollectorsManager.getInstance().prismsFighters[[_loc83_.subAreaId]];
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInFightRemoved,_loc83_.subAreaId);
               return true;
            case param1 is PrismsInfoValidMessage:
               _loc84_ = param1 as PrismsInfoValidMessage;
               TaxCollectorsManager.getInstance().setPrismsInFight(_loc84_.fights);
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsInFightList);
               return true;
            case param1 is AlliancePrismDialogQuestionMessage:
               _loc85_ = param1 as AlliancePrismDialogQuestionMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AlliancePrismDialogQuestion);
               return true;
         }
         return false;
      }
      
      public function pushRoleplay() : void {
      }
      
      public function pullRoleplay() : void {
      }
   }
}

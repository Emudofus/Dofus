package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.logic.common.actions.OpenPopupAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.BasicSwitchModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatCommandAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatLoadedAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ClearChatAction;
   import com.ankamagames.dofus.logic.common.actions.AuthorizedCommandAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
   import com.ankamagames.dofus.logic.connection.actions.NicknameChoiceRequestAction;
   import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
   import com.ankamagames.dofus.logic.connection.actions.AcquaintanceSearchAction;
   import com.ankamagames.dofus.logic.game.approach.actions.SubscribersGiftListRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.NewsLoginRequestAction;
   import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
   import com.ankamagames.dofus.logic.common.actions.DirectSelectionCharacterAction;
   import com.ankamagames.dofus.logic.common.actions.ChangeServerAction;
   import com.ankamagames.dofus.logic.common.actions.QuitGameAction;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.logic.common.actions.AgreementAgreedAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterCreationAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeletionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterNameSuggestionRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterReplayRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeselectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterRecolorSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterRenameSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterRelookSelectionAction;
   import com.ankamagames.dofus.logic.game.common.actions.GameContextQuitAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenCurrentFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMainMenuAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMountAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMapAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.CloseBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenServerSelectionAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSmileysAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenTeamSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenArenaAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenStatsAction;
   import com.ankamagames.dofus.logic.game.common.actions.IncreaseSpellLevelAction;
   import com.ankamagames.dofus.logic.game.common.actions.BasicWhoIsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.NumericWhoIsRequestAction;
   import com.ankamagames.dofus.logic.common.actions.AddBehaviorToStackAction;
   import com.ankamagames.dofus.logic.common.actions.RemoveBehaviorToStackAction;
   import com.ankamagames.dofus.logic.common.actions.EmptyStackAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ChallengeTargetsListRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightReadyAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellCastAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightTurnFinishAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityClickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementPositionRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.BannerEmptySlotClickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleHelpWantedAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockFightAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockPartyAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleWitnessForbiddenAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TogglePointCellAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameContextKickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.DisableAfkAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.TeleportRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PresetSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectDropAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.SpellSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.StatsUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DeleteObjectAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetDeleteAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetSaveAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetSaveCustomAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetUseAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetItemUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcDialogReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.InteractiveElementActivationAction;
   import com.ankamagames.dofus.logic.game.common.actions.PivotCharacterAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationDetailsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyCancelInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAcceptInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyRefuseInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAbdicateThroneAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyPledgeLoyaltyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyFollowMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAllFollowMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyStopFollowingMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAllStopFollowingMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyShowMenuAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.MapRunningFightDetailsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.StopToListenRunningFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.JoinFightRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.JoinAsSpectatorRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.GameFightSpectatePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildShareAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildRightsViewAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildRightsChangeAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseSellAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseSellFromInsideAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseKickAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseKickIndoorMerchantAction;
   import com.ankamagames.dofus.logic.game.common.actions.LockableChangeCodeAction;
   import com.ankamagames.dofus.logic.game.common.actions.LockableUseCodeAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseLockFromInsideAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.GameRolePlayFreeSoulRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestInfosRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestStartRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementDetailedListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementDetailsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementRewardRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestObjectiveValidationAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntDigRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.PortalUseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntGiveUpRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeReturnRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeQuitRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.SetEnablePVPRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.SetEnableAVARequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismSettingsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightJoinLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightSwapRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismInfoJoinLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismsListRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismAttackRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismUseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismSetSabotagedRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseOnCellAction;
   import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationUpdateFlagAction;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationResetAction;
   import com.ankamagames.dofus.logic.game.common.actions.StartZoomAction;
   import com.ankamagames.dofus.logic.game.common.actions.PlaySoundAction;
   import com.ankamagames.dofus.logic.game.approach.actions.GetPartsListAction;
   import com.ankamagames.dofus.logic.game.approach.actions.DownloadPartAction;
   import com.ankamagames.dofus.logic.game.approach.actions.GetPartInfoAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarAddRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarRemoveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarSwapRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterTokenRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterInventoryRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterTransferRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterPlayingStatusAction;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitlesAndOrnamentsListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitleSelectRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.OrnamentSelectRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowMonstersInfoAction;
   import com.ankamagames.dofus.logic.game.common.actions.ContactLookRequestByIdAction;
   import com.ankamagames.dofus.modules.utils.actions.ModuleListRequestAction;
   import com.ankamagames.dofus.modules.utils.actions.ModuleInstallRequestAction;
   import com.ankamagames.dofus.modules.utils.actions.ModuleDeleteRequestAction;
   import com.ankamagames.dofus.modules.utils.actions.InstalledModuleListRequestAction;
   import com.ankamagames.dofus.modules.utils.actions.InstalledModuleInfoRequestAction;
   import com.ankamagames.dofus.modules.utils.actions.ModuleInstallConfirmAction;
   import com.ankamagames.dofus.modules.utils.actions.ModuleInstallCancelAction;
   
   public class ApiActionList extends Object
   {
      
      public function ApiActionList() {
         super();
      }
      
      public static const OpenPopup:DofusApiAction;
      
      public static const BasicSwitchMode:DofusApiAction;
      
      public static const ChatCommand:DofusApiAction;
      
      public static const ChatLoaded:DofusApiAction;
      
      public static const ClearChat:DofusApiAction;
      
      public static const AuthorizedCommand:DofusApiAction;
      
      public static const LoginValidation:DofusApiAction;
      
      public static const LoginValidationWithTicket:DofusApiAction;
      
      public static const NicknameChoiceRequest:DofusApiAction;
      
      public static const ServerSelection:DofusApiAction;
      
      public static const AcquaintanceSearch:DofusApiAction;
      
      public static const SubscribersGiftListRequest:DofusApiAction;
      
      public static const NewsLoginRequest:DofusApiAction;
      
      public static const ChangeCharacter:DofusApiAction;
      
      public static const DirectSelectionCharacter:DofusApiAction;
      
      public static const ChangeServer:DofusApiAction;
      
      public static const QuitGame:DofusApiAction;
      
      public static const ResetGame:DofusApiAction;
      
      public static const AgreementAgreed:DofusApiAction;
      
      public static const CharacterCreation:DofusApiAction;
      
      public static const CharacterDeletion:DofusApiAction;
      
      public static const CharacterNameSuggestionRequest:DofusApiAction;
      
      public static const CharacterReplayRequest:DofusApiAction;
      
      public static const CharacterDeselection:DofusApiAction;
      
      public static const CharacterSelection:DofusApiAction;
      
      public static const CharacterRecolorSelection:DofusApiAction;
      
      public static const CharacterRenameSelection:DofusApiAction;
      
      public static const CharacterRelookSelection:DofusApiAction;
      
      public static const GameContextQuit:DofusApiAction;
      
      public static const OpenCurrentFight:DofusApiAction;
      
      public static const OpenMainMenu:DofusApiAction;
      
      public static const OpenMount:DofusApiAction;
      
      public static const OpenInventory:DofusApiAction;
      
      public static const CloseInventory:DofusApiAction;
      
      public static const OpenMap:DofusApiAction;
      
      public static const OpenBook:DofusApiAction;
      
      public static const CloseBook:DofusApiAction;
      
      public static const OpenServerSelection:DofusApiAction;
      
      public static const OpenSmileys:DofusApiAction;
      
      public static const OpenTeamSearch:DofusApiAction;
      
      public static const OpenArena:DofusApiAction;
      
      public static const OpenStats:DofusApiAction;
      
      public static const IncreaseSpellLevel:DofusApiAction;
      
      public static const BasicWhoIsRequest:DofusApiAction;
      
      public static const NumericWhoIsRequest:DofusApiAction;
      
      public static const AddBehaviorToStack:DofusApiAction;
      
      public static const RemoveBehaviorToStack:DofusApiAction;
      
      public static const EmptyStack:DofusApiAction;
      
      public static const ChallengeTargetsListRequest:DofusApiAction;
      
      public static const GameFightReady:DofusApiAction;
      
      public static const GameFightSpellCast:DofusApiAction;
      
      public static const GameFightTurnFinish:DofusApiAction;
      
      public static const TimelineEntityClick:DofusApiAction;
      
      public static const GameFightPlacementPositionRequest:DofusApiAction;
      
      public static const BannerEmptySlotClick:DofusApiAction;
      
      public static const TimelineEntityOver:DofusApiAction;
      
      public static const TimelineEntityOut:DofusApiAction;
      
      public static const ToggleDematerialization:DofusApiAction;
      
      public static const ToggleHelpWanted:DofusApiAction;
      
      public static const ToggleLockFight:DofusApiAction;
      
      public static const ToggleLockParty:DofusApiAction;
      
      public static const ToggleWitnessForbidden:DofusApiAction;
      
      public static const TogglePointCell:DofusApiAction;
      
      public static const GameContextKick:DofusApiAction;
      
      public static const DisableAfk:DofusApiAction;
      
      public static const ShowTacticMode:DofusApiAction;
      
      public static const LeaveDialogRequest:DofusApiAction;
      
      public static const TeleportRequest:DofusApiAction;
      
      public static const ObjectSetPosition:DofusApiAction;
      
      public static const PresetSetPosition:DofusApiAction;
      
      public static const ObjectDrop:DofusApiAction;
      
      public static const SpellSetPosition:DofusApiAction;
      
      public static const StatsUpgradeRequest:DofusApiAction;
      
      public static const DeleteObject:DofusApiAction;
      
      public static const ObjectUse:DofusApiAction;
      
      public static const InventoryPresetDelete:DofusApiAction;
      
      public static const InventoryPresetSave:DofusApiAction;
      
      public static const InventoryPresetSaveCustom:DofusApiAction;
      
      public static const InventoryPresetUse:DofusApiAction;
      
      public static const InventoryPresetItemUpdateRequest:DofusApiAction;
      
      public static const SwitchCreatureMode:DofusApiAction;
      
      public static const NpcDialogReply:DofusApiAction;
      
      public static const InteractiveElementActivation:DofusApiAction;
      
      public static const PivotCharacter:DofusApiAction;
      
      public static const ShowAllNames:DofusApiAction;
      
      public static const PartyInvitation:DofusApiAction;
      
      public static const PartyInvitationDetailsRequest:DofusApiAction;
      
      public static const PartyCancelInvitation:DofusApiAction;
      
      public static const PartyAcceptInvitation:DofusApiAction;
      
      public static const PartyRefuseInvitation:DofusApiAction;
      
      public static const PartyLeaveRequest:DofusApiAction;
      
      public static const PartyKickRequest:DofusApiAction;
      
      public static const PartyAbdicateThrone:DofusApiAction;
      
      public static const PartyPledgeLoyaltyRequest:DofusApiAction;
      
      public static const PartyFollowMember:DofusApiAction;
      
      public static const PartyAllFollowMember:DofusApiAction;
      
      public static const PartyStopFollowingMember:DofusApiAction;
      
      public static const PartyAllStopFollowingMember:DofusApiAction;
      
      public static const PartyShowMenu:DofusApiAction;
      
      public static const MapRunningFightDetailsRequest:DofusApiAction;
      
      public static const StopToListenRunningFight:DofusApiAction;
      
      public static const JoinFightRequest:DofusApiAction;
      
      public static const JoinAsSpectatorRequest:DofusApiAction;
      
      public static const GameFightSpectatePlayerRequest:DofusApiAction;
      
      public static const HouseGuildShare:DofusApiAction;
      
      public static const HouseGuildRightsView:DofusApiAction;
      
      public static const HouseGuildRightsChange:DofusApiAction;
      
      public static const HouseBuy:DofusApiAction;
      
      public static const LeaveDialog:DofusApiAction;
      
      public static const HouseSell:DofusApiAction;
      
      public static const HouseSellFromInside:DofusApiAction;
      
      public static const HouseKick:DofusApiAction;
      
      public static const HouseKickIndoorMerchant:DofusApiAction;
      
      public static const LockableChangeCode:DofusApiAction;
      
      public static const LockableUseCode:DofusApiAction;
      
      public static const HouseLockFromInside:DofusApiAction;
      
      public static const GameRolePlayFreeSoulRequest:DofusApiAction;
      
      public static const QuestInfosRequest:DofusApiAction;
      
      public static const QuestListRequest:DofusApiAction;
      
      public static const QuestStartRequest:DofusApiAction;
      
      public static const AchievementDetailedListRequest:DofusApiAction;
      
      public static const AchievementDetailsRequest:DofusApiAction;
      
      public static const AchievementRewardRequest:DofusApiAction;
      
      public static const QuestObjectiveValidation:DofusApiAction;
      
      public static const TreasureHuntRequest:DofusApiAction;
      
      public static const TreasureHuntDigRequest:DofusApiAction;
      
      public static const PortalUseRequest:DofusApiAction;
      
      public static const TreasureHuntGiveUpRequest:DofusApiAction;
      
      public static const GuidedModeReturnRequest:DofusApiAction;
      
      public static const GuidedModeQuitRequest:DofusApiAction;
      
      public static const SetEnablePVPRequest:DofusApiAction;
      
      public static const SetEnableAVARequest:DofusApiAction;
      
      public static const PrismSettingsRequest:DofusApiAction;
      
      public static const PrismFightJoinLeaveRequest:DofusApiAction;
      
      public static const PrismFightSwapRequest:DofusApiAction;
      
      public static const PrismInfoJoinLeaveRequest:DofusApiAction;
      
      public static const PrismsListRegister:DofusApiAction;
      
      public static const PrismAttackRequest:DofusApiAction;
      
      public static const PrismUseRequest:DofusApiAction;
      
      public static const PrismSetSabotagedRequest:DofusApiAction;
      
      public static const ObjectUseOnCell:DofusApiAction;
      
      public static const GiftAssignRequest:DofusApiAction;
      
      public static const NotificationUpdateFlag:DofusApiAction;
      
      public static const NotificationReset:DofusApiAction;
      
      public static const StartZoom:DofusApiAction;
      
      public static const PlaySound:DofusApiAction;
      
      public static const GetPartsList:DofusApiAction;
      
      public static const DownloadPart:DofusApiAction;
      
      public static const GetPartInfo:DofusApiAction;
      
      public static const ShortcutBarAddRequest:DofusApiAction;
      
      public static const ShortcutBarRemoveRequest:DofusApiAction;
      
      public static const ShortcutBarSwapRequest:DofusApiAction;
      
      public static const KrosmasterTokenRequest:DofusApiAction;
      
      public static const KrosmasterInventoryRequest:DofusApiAction;
      
      public static const KrosmasterTransferRequest:DofusApiAction;
      
      public static const KrosmasterPlayingStatus:DofusApiAction;
      
      public static const TitlesAndOrnamentsListRequest:DofusApiAction;
      
      public static const TitleSelectRequest:DofusApiAction;
      
      public static const OrnamentSelectRequest:DofusApiAction;
      
      public static const ShowMonstersInfo:DofusApiAction;
      
      public static const ContactLookRequestById:DofusApiAction;
      
      public static const ModuleListRequest:DofusApiAction;
      
      public static const ModuleInstallRequest:DofusApiAction;
      
      public static const ModuleDeleteRequest:DofusApiAction;
      
      public static const InstalledModuleListRequest:DofusApiAction;
      
      public static const InstalledModuleInfoRequest:DofusApiAction;
      
      public static const ModuleInstallConfirm:DofusApiAction;
      
      public static const ModuleInstallCancel:DofusApiAction;
   }
}

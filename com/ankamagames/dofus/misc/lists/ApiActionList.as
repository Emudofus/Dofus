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
      
      public static const OpenPopup:DofusApiAction = new DofusApiAction("OpenPopup",OpenPopupAction);
      
      public static const BasicSwitchMode:DofusApiAction = new DofusApiAction("BasicSwitchMode",BasicSwitchModeAction);
      
      public static const ChatCommand:DofusApiAction = new DofusApiAction("ChatCommand",ChatCommandAction);
      
      public static const ChatLoaded:DofusApiAction = new DofusApiAction("ChatLoaded",ChatLoadedAction);
      
      public static const ClearChat:DofusApiAction = new DofusApiAction("ClearChat",ClearChatAction);
      
      public static const AuthorizedCommand:DofusApiAction = new DofusApiAction("AuthorizedCommand",AuthorizedCommandAction);
      
      public static const LoginValidation:DofusApiAction = new DofusApiAction("LoginValidation",LoginValidationAction);
      
      public static const LoginValidationWithTicket:DofusApiAction = new DofusApiAction("LoginValidationWithTicket",LoginValidationWithTicketAction);
      
      public static const NicknameChoiceRequest:DofusApiAction = new DofusApiAction("NicknameChoiceRequest",NicknameChoiceRequestAction);
      
      public static const ServerSelection:DofusApiAction = new DofusApiAction("ServerSelection",ServerSelectionAction);
      
      public static const AcquaintanceSearch:DofusApiAction = new DofusApiAction("AcquaintanceSearch",AcquaintanceSearchAction);
      
      public static const SubscribersGiftListRequest:DofusApiAction = new DofusApiAction("SubscribersGiftListRequest",SubscribersGiftListRequestAction);
      
      public static const NewsLoginRequest:DofusApiAction = new DofusApiAction("NewsLoginRequest",NewsLoginRequestAction);
      
      public static const ChangeCharacter:DofusApiAction = new DofusApiAction("ChangeCharacter",ChangeCharacterAction);
      
      public static const DirectSelectionCharacter:DofusApiAction = new DofusApiAction("DirectSelectionCharacter",DirectSelectionCharacterAction);
      
      public static const ChangeServer:DofusApiAction = new DofusApiAction("ChangeServer",ChangeServerAction);
      
      public static const QuitGame:DofusApiAction = new DofusApiAction("QuitGame",QuitGameAction);
      
      public static const ResetGame:DofusApiAction = new DofusApiAction("ResetGame",ResetGameAction);
      
      public static const AgreementAgreed:DofusApiAction = new DofusApiAction("AgreementAgreed",AgreementAgreedAction);
      
      public static const CharacterCreation:DofusApiAction = new DofusApiAction("CharacterCreation",CharacterCreationAction);
      
      public static const CharacterDeletion:DofusApiAction = new DofusApiAction("CharacterDeletion",CharacterDeletionAction);
      
      public static const CharacterNameSuggestionRequest:DofusApiAction = new DofusApiAction("CharacterNameSuggestionRequest",CharacterNameSuggestionRequestAction);
      
      public static const CharacterReplayRequest:DofusApiAction = new DofusApiAction("CharacterReplayRequest",CharacterReplayRequestAction);
      
      public static const CharacterDeselection:DofusApiAction = new DofusApiAction("CharacterDeselection",CharacterDeselectionAction);
      
      public static const CharacterSelection:DofusApiAction = new DofusApiAction("CharacterSelection",CharacterSelectionAction);
      
      public static const CharacterRecolorSelection:DofusApiAction = new DofusApiAction("CharacterRecolorSelection",CharacterRecolorSelectionAction);
      
      public static const CharacterRenameSelection:DofusApiAction = new DofusApiAction("CharacterRenameSelection",CharacterRenameSelectionAction);
      
      public static const CharacterRelookSelection:DofusApiAction = new DofusApiAction("CharacterRelookSelection",CharacterRelookSelectionAction);
      
      public static const GameContextQuit:DofusApiAction = new DofusApiAction("GameContextQuit",GameContextQuitAction);
      
      public static const OpenCurrentFight:DofusApiAction = new DofusApiAction("OpenCurrentFight",OpenCurrentFightAction);
      
      public static const OpenMainMenu:DofusApiAction = new DofusApiAction("OpenMainMenu",OpenMainMenuAction);
      
      public static const OpenMount:DofusApiAction = new DofusApiAction("OpenMount",OpenMountAction);
      
      public static const OpenInventory:DofusApiAction = new DofusApiAction("OpenInventory",OpenInventoryAction);
      
      public static const CloseInventory:DofusApiAction = new DofusApiAction("CloseInventory",CloseInventoryAction);
      
      public static const OpenMap:DofusApiAction = new DofusApiAction("OpenMap",OpenMapAction);
      
      public static const OpenBook:DofusApiAction = new DofusApiAction("OpenBook",OpenBookAction);
      
      public static const CloseBook:DofusApiAction = new DofusApiAction("CloseBook",CloseBookAction);
      
      public static const OpenServerSelection:DofusApiAction = new DofusApiAction("OpenServerSelection",OpenServerSelectionAction);
      
      public static const OpenSmileys:DofusApiAction = new DofusApiAction("OpenSmileys",OpenSmileysAction);
      
      public static const OpenTeamSearch:DofusApiAction = new DofusApiAction("OpenTeamSearch",OpenTeamSearchAction);
      
      public static const OpenArena:DofusApiAction = new DofusApiAction("OpenArena",OpenArenaAction);
      
      public static const OpenStats:DofusApiAction = new DofusApiAction("OpenStats",OpenStatsAction);
      
      public static const IncreaseSpellLevel:DofusApiAction = new DofusApiAction("IncreaseSpellLevel",IncreaseSpellLevelAction);
      
      public static const BasicWhoIsRequest:DofusApiAction = new DofusApiAction("BasicWhoIsRequest",BasicWhoIsRequestAction);
      
      public static const NumericWhoIsRequest:DofusApiAction = new DofusApiAction("NumericWhoIsRequest",NumericWhoIsRequestAction);
      
      public static const AddBehaviorToStack:DofusApiAction = new DofusApiAction("AddBehaviorToStack",AddBehaviorToStackAction);
      
      public static const RemoveBehaviorToStack:DofusApiAction = new DofusApiAction("RemoveBehaviorToStack",RemoveBehaviorToStackAction);
      
      public static const EmptyStack:DofusApiAction = new DofusApiAction("EmptyStack",EmptyStackAction);
      
      public static const ChallengeTargetsListRequest:DofusApiAction = new DofusApiAction("ChallengeTargetsListRequest",ChallengeTargetsListRequestAction);
      
      public static const GameFightReady:DofusApiAction = new DofusApiAction("GameFightReady",GameFightReadyAction);
      
      public static const GameFightSpellCast:DofusApiAction = new DofusApiAction("GameFightSpellCast",GameFightSpellCastAction);
      
      public static const GameFightTurnFinish:DofusApiAction = new DofusApiAction("GameFightTurnFinish",GameFightTurnFinishAction);
      
      public static const TimelineEntityClick:DofusApiAction = new DofusApiAction("TimelineEntityClick",TimelineEntityClickAction);
      
      public static const GameFightPlacementPositionRequest:DofusApiAction = new DofusApiAction("GameFightPlacementPositionRequest",GameFightPlacementPositionRequestAction);
      
      public static const BannerEmptySlotClick:DofusApiAction = new DofusApiAction("BannerEmptySlotClick",BannerEmptySlotClickAction);
      
      public static const TimelineEntityOver:DofusApiAction = new DofusApiAction("TimelineEntityOver",TimelineEntityOverAction);
      
      public static const TimelineEntityOut:DofusApiAction = new DofusApiAction("TimelineEntityOut",TimelineEntityOutAction);
      
      public static const ToggleDematerialization:DofusApiAction = new DofusApiAction("ToggleDematerialization",ToggleDematerializationAction);
      
      public static const ToggleHelpWanted:DofusApiAction = new DofusApiAction("ToggleHelpWanted",ToggleHelpWantedAction);
      
      public static const ToggleLockFight:DofusApiAction = new DofusApiAction("ToggleLockFight",ToggleLockFightAction);
      
      public static const ToggleLockParty:DofusApiAction = new DofusApiAction("ToggleLockParty",ToggleLockPartyAction);
      
      public static const ToggleWitnessForbidden:DofusApiAction = new DofusApiAction("ToggleWitnessForbidden",ToggleWitnessForbiddenAction);
      
      public static const TogglePointCell:DofusApiAction = new DofusApiAction("TogglePointCell",TogglePointCellAction);
      
      public static const GameContextKick:DofusApiAction = new DofusApiAction("GameContextKick",GameContextKickAction);
      
      public static const DisableAfk:DofusApiAction = new DofusApiAction("DisableAfk",DisableAfkAction);
      
      public static const ShowTacticMode:DofusApiAction = new DofusApiAction("ShowTacticMode",ShowTacticModeAction);
      
      public static const LeaveDialogRequest:DofusApiAction = new DofusApiAction("LeaveDialogRequest",LeaveDialogRequestAction);
      
      public static const TeleportRequest:DofusApiAction = new DofusApiAction("TeleportRequest",TeleportRequestAction);
      
      public static const ObjectSetPosition:DofusApiAction = new DofusApiAction("ObjectSetPosition",ObjectSetPositionAction);
      
      public static const PresetSetPosition:DofusApiAction = new DofusApiAction("PresetSetPosition",PresetSetPositionAction);
      
      public static const ObjectDrop:DofusApiAction = new DofusApiAction("ObjectDrop",ObjectDropAction);
      
      public static const SpellSetPosition:DofusApiAction = new DofusApiAction("SpellSetPosition",SpellSetPositionAction);
      
      public static const StatsUpgradeRequest:DofusApiAction = new DofusApiAction("StatsUpgradeRequest",StatsUpgradeRequestAction);
      
      public static const DeleteObject:DofusApiAction = new DofusApiAction("DeleteObject",DeleteObjectAction);
      
      public static const ObjectUse:DofusApiAction = new DofusApiAction("ObjectUse",ObjectUseAction);
      
      public static const InventoryPresetDelete:DofusApiAction = new DofusApiAction("InventoryPresetDelete",InventoryPresetDeleteAction);
      
      public static const InventoryPresetSave:DofusApiAction = new DofusApiAction("InventoryPresetSave",InventoryPresetSaveAction);
      
      public static const InventoryPresetSaveCustom:DofusApiAction = new DofusApiAction("InventoryPresetSaveCustom",InventoryPresetSaveCustomAction);
      
      public static const InventoryPresetUse:DofusApiAction = new DofusApiAction("InventoryPresetUse",InventoryPresetUseAction);
      
      public static const InventoryPresetItemUpdateRequest:DofusApiAction = new DofusApiAction("InventoryPresetItemUpdateRequest",InventoryPresetItemUpdateRequestAction);
      
      public static const SwitchCreatureMode:DofusApiAction = new DofusApiAction("SwitchCreatureMode",SwitchCreatureModeAction);
      
      public static const NpcDialogReply:DofusApiAction = new DofusApiAction("NpcDialogReply",NpcDialogReplyAction);
      
      public static const InteractiveElementActivation:DofusApiAction = new DofusApiAction("InteractiveElementActivation",InteractiveElementActivationAction);
      
      public static const PivotCharacter:DofusApiAction = new DofusApiAction("PivotCharacter",PivotCharacterAction);
      
      public static const ShowAllNames:DofusApiAction = new DofusApiAction("ShowAllNames",ShowAllNamesAction);
      
      public static const PartyInvitation:DofusApiAction = new DofusApiAction("PartyInvitation",PartyInvitationAction);
      
      public static const PartyInvitationDetailsRequest:DofusApiAction = new DofusApiAction("PartyInvitationDetailsRequest",PartyInvitationDetailsRequestAction);
      
      public static const PartyCancelInvitation:DofusApiAction = new DofusApiAction("PartyCancelInvitation",PartyCancelInvitationAction);
      
      public static const PartyAcceptInvitation:DofusApiAction = new DofusApiAction("PartyAcceptInvitation",PartyAcceptInvitationAction);
      
      public static const PartyRefuseInvitation:DofusApiAction = new DofusApiAction("PartyRefuseInvitation",PartyRefuseInvitationAction);
      
      public static const PartyLeaveRequest:DofusApiAction = new DofusApiAction("PartyLeaveRequest",PartyLeaveRequestAction);
      
      public static const PartyKickRequest:DofusApiAction = new DofusApiAction("PartyKickRequest",PartyKickRequestAction);
      
      public static const PartyAbdicateThrone:DofusApiAction = new DofusApiAction("PartyAbdicateThrone",PartyAbdicateThroneAction);
      
      public static const PartyPledgeLoyaltyRequest:DofusApiAction = new DofusApiAction("PartyPledgeLoyaltyRequest",PartyPledgeLoyaltyRequestAction);
      
      public static const PartyFollowMember:DofusApiAction = new DofusApiAction("PartyFollowMember",PartyFollowMemberAction);
      
      public static const PartyAllFollowMember:DofusApiAction = new DofusApiAction("PartyAllFollowMember",PartyAllFollowMemberAction);
      
      public static const PartyStopFollowingMember:DofusApiAction = new DofusApiAction("PartyStopFollowingMember",PartyStopFollowingMemberAction);
      
      public static const PartyAllStopFollowingMember:DofusApiAction = new DofusApiAction("PartyAllStopFollowingMember",PartyAllStopFollowingMemberAction);
      
      public static const PartyShowMenu:DofusApiAction = new DofusApiAction("PartyShowMenu",PartyShowMenuAction);
      
      public static const MapRunningFightDetailsRequest:DofusApiAction = new DofusApiAction("MapRunningFightDetailsRequest",MapRunningFightDetailsRequestAction);
      
      public static const StopToListenRunningFight:DofusApiAction = new DofusApiAction("StopToListenRunningFight",StopToListenRunningFightAction);
      
      public static const JoinFightRequest:DofusApiAction = new DofusApiAction("JoinFightRequest",JoinFightRequestAction);
      
      public static const JoinAsSpectatorRequest:DofusApiAction = new DofusApiAction("JoinAsSpectatorRequest",JoinAsSpectatorRequestAction);
      
      public static const GameFightSpectatePlayerRequest:DofusApiAction = new DofusApiAction("GameFightSpectatePlayerRequest",GameFightSpectatePlayerRequestAction);
      
      public static const HouseGuildShare:DofusApiAction = new DofusApiAction("HouseGuildShare",HouseGuildShareAction);
      
      public static const HouseGuildRightsView:DofusApiAction = new DofusApiAction("HouseGuildRightsView",HouseGuildRightsViewAction);
      
      public static const HouseGuildRightsChange:DofusApiAction = new DofusApiAction("HouseGuildRightsChange",HouseGuildRightsChangeAction);
      
      public static const HouseBuy:DofusApiAction = new DofusApiAction("HouseBuy",HouseBuyAction);
      
      public static const LeaveDialog:DofusApiAction = new DofusApiAction("LeaveDialog",LeaveDialogAction);
      
      public static const HouseSell:DofusApiAction = new DofusApiAction("HouseSell",HouseSellAction);
      
      public static const HouseSellFromInside:DofusApiAction = new DofusApiAction("HouseSellFromInside",HouseSellFromInsideAction);
      
      public static const HouseKick:DofusApiAction = new DofusApiAction("HouseKick",HouseKickAction);
      
      public static const HouseKickIndoorMerchant:DofusApiAction = new DofusApiAction("HouseKickIndoorMerchant",HouseKickIndoorMerchantAction);
      
      public static const LockableChangeCode:DofusApiAction = new DofusApiAction("LockableChangeCode",LockableChangeCodeAction);
      
      public static const LockableUseCode:DofusApiAction = new DofusApiAction("LockableUseCode",LockableUseCodeAction);
      
      public static const HouseLockFromInside:DofusApiAction = new DofusApiAction("HouseLockFromInside",HouseLockFromInsideAction);
      
      public static const GameRolePlayFreeSoulRequest:DofusApiAction = new DofusApiAction("GameRolePlayFreeSoulRequest",GameRolePlayFreeSoulRequestAction);
      
      public static const QuestInfosRequest:DofusApiAction = new DofusApiAction("QuestInfosRequest",QuestInfosRequestAction);
      
      public static const QuestListRequest:DofusApiAction = new DofusApiAction("QuestListRequest",QuestListRequestAction);
      
      public static const QuestStartRequest:DofusApiAction = new DofusApiAction("QuestStartRequest",QuestStartRequestAction);
      
      public static const AchievementDetailedListRequest:DofusApiAction = new DofusApiAction("AchievementDetailedListRequest",AchievementDetailedListRequestAction);
      
      public static const AchievementDetailsRequest:DofusApiAction = new DofusApiAction("AchievementDetailsRequest",AchievementDetailsRequestAction);
      
      public static const AchievementRewardRequest:DofusApiAction = new DofusApiAction("AchievementRewardRequest",AchievementRewardRequestAction);
      
      public static const QuestObjectiveValidation:DofusApiAction = new DofusApiAction("QuestObjectiveValidation",QuestObjectiveValidationAction);
      
      public static const TreasureHuntRequest:DofusApiAction = new DofusApiAction("TreasureHuntRequest",TreasureHuntRequestAction);
      
      public static const TreasureHuntDigRequest:DofusApiAction = new DofusApiAction("TreasureHuntDigRequest",TreasureHuntDigRequestAction);
      
      public static const PortalUseRequest:DofusApiAction = new DofusApiAction("PortalUseRequest",PortalUseRequestAction);
      
      public static const TreasureHuntGiveUpRequest:DofusApiAction = new DofusApiAction("TreasureHuntGiveUpRequest",TreasureHuntGiveUpRequestAction);
      
      public static const GuidedModeReturnRequest:DofusApiAction = new DofusApiAction("GuidedModeReturnRequest",GuidedModeReturnRequestAction);
      
      public static const GuidedModeQuitRequest:DofusApiAction = new DofusApiAction("GuidedModeQuitRequest",GuidedModeQuitRequestAction);
      
      public static const SetEnablePVPRequest:DofusApiAction = new DofusApiAction("SetEnablePVPRequest",SetEnablePVPRequestAction);
      
      public static const SetEnableAVARequest:DofusApiAction = new DofusApiAction("SetEnableAVARequest",SetEnableAVARequestAction);
      
      public static const PrismSettingsRequest:DofusApiAction = new DofusApiAction("PrismSettingsRequest",PrismSettingsRequestAction);
      
      public static const PrismFightJoinLeaveRequest:DofusApiAction = new DofusApiAction("PrismFightJoinLeaveRequest",PrismFightJoinLeaveRequestAction);
      
      public static const PrismFightSwapRequest:DofusApiAction = new DofusApiAction("PrismFightSwapRequest",PrismFightSwapRequestAction);
      
      public static const PrismInfoJoinLeaveRequest:DofusApiAction = new DofusApiAction("PrismInfoJoinLeaveRequest",PrismInfoJoinLeaveRequestAction);
      
      public static const PrismsListRegister:DofusApiAction = new DofusApiAction("PrismsListRegister",PrismsListRegisterAction);
      
      public static const PrismAttackRequest:DofusApiAction = new DofusApiAction("PrismAttackRequest",PrismAttackRequestAction);
      
      public static const PrismUseRequest:DofusApiAction = new DofusApiAction("PrismUseRequest",PrismUseRequestAction);
      
      public static const PrismSetSabotagedRequest:DofusApiAction = new DofusApiAction("PrismSetSabotagedRequest",PrismSetSabotagedRequestAction);
      
      public static const ObjectUseOnCell:DofusApiAction = new DofusApiAction("ObjectUseOnCell",ObjectUseOnCellAction);
      
      public static const GiftAssignRequest:DofusApiAction = new DofusApiAction("GiftAssignRequest",GiftAssignRequestAction);
      
      public static const NotificationUpdateFlag:DofusApiAction = new DofusApiAction("NotificationUpdateFlag",NotificationUpdateFlagAction);
      
      public static const NotificationReset:DofusApiAction = new DofusApiAction("NotificationReset",NotificationResetAction);
      
      public static const StartZoom:DofusApiAction = new DofusApiAction("StartZoom",StartZoomAction);
      
      public static const PlaySound:DofusApiAction = new DofusApiAction("PlaySound",PlaySoundAction);
      
      public static const GetPartsList:DofusApiAction = new DofusApiAction("GetPartsList",GetPartsListAction);
      
      public static const DownloadPart:DofusApiAction = new DofusApiAction("DownloadPart",DownloadPartAction);
      
      public static const GetPartInfo:DofusApiAction = new DofusApiAction("GetPartInfo",GetPartInfoAction);
      
      public static const ShortcutBarAddRequest:DofusApiAction = new DofusApiAction("ShortcutBarAddRequest",ShortcutBarAddRequestAction);
      
      public static const ShortcutBarRemoveRequest:DofusApiAction = new DofusApiAction("ShortcutBarRemoveRequest",ShortcutBarRemoveRequestAction);
      
      public static const ShortcutBarSwapRequest:DofusApiAction = new DofusApiAction("ShortcutBarSwapRequest",ShortcutBarSwapRequestAction);
      
      public static const KrosmasterTokenRequest:DofusApiAction = new DofusApiAction("KrosmasterTokenRequest",KrosmasterTokenRequestAction);
      
      public static const KrosmasterInventoryRequest:DofusApiAction = new DofusApiAction("KrosmasterInventoryRequest",KrosmasterInventoryRequestAction);
      
      public static const KrosmasterTransferRequest:DofusApiAction = new DofusApiAction("KrosmasterTransferRequest",KrosmasterTransferRequestAction);
      
      public static const KrosmasterPlayingStatus:DofusApiAction = new DofusApiAction("KrosmasterPlayingStatus",KrosmasterPlayingStatusAction);
      
      public static const TitlesAndOrnamentsListRequest:DofusApiAction = new DofusApiAction("TitlesAndOrnamentsListRequest",TitlesAndOrnamentsListRequestAction);
      
      public static const TitleSelectRequest:DofusApiAction = new DofusApiAction("TitleSelectRequest",TitleSelectRequestAction);
      
      public static const OrnamentSelectRequest:DofusApiAction = new DofusApiAction("OrnamentSelectRequest",OrnamentSelectRequestAction);
      
      public static const ShowMonstersInfo:DofusApiAction = new DofusApiAction("ShowMonstersInfo",ShowMonstersInfoAction);
      
      public static const ContactLookRequestById:DofusApiAction = new DofusApiAction("ContactLookRequestById",ContactLookRequestByIdAction);
      
      public static const ModuleListRequest:DofusApiAction = new DofusApiAction("ModuleListRequest",ModuleListRequestAction);
      
      public static const ModuleInstallRequest:DofusApiAction = new DofusApiAction("ModuleInstallRequest",ModuleInstallRequestAction);
      
      public static const ModuleDeleteRequest:DofusApiAction = new DofusApiAction("ModuleDeleteRequest",ModuleDeleteRequestAction);
      
      public static const InstalledModuleListRequest:DofusApiAction = new DofusApiAction("InstalledModuleListRequest",InstalledModuleListRequestAction);
      
      public static const InstalledModuleInfoRequest:DofusApiAction = new DofusApiAction("InstalledModuleInfoRequest",InstalledModuleInfoRequestAction);
      
      public static const ModuleInstallConfirm:DofusApiAction = new DofusApiAction("ModuleInstallConfirm",ModuleInstallConfirmAction);
      
      public static const ModuleInstallCancel:DofusApiAction = new DofusApiAction("ModuleInstallCancel",ModuleInstallCancelAction);
   }
}

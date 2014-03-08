package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class HookList extends Object
   {
      
      public function HookList() {
         super();
      }
      
      public static const LangFileLoaded:Hook = new Hook("LangFileLoaded",true);
      
      public static const ConfigStart:Hook = new Hook("ConfigStart",true);
      
      public static const AuthentificationStart:Hook = new Hook("AuthentificationStart",true);
      
      public static const AgreementsRequired:Hook = new Hook("AgreementsRequired",true);
      
      public static const IdentificationSuccess:Hook = new Hook("IdentificationSuccess",true);
      
      public static const IdentificationFailed:Hook = new Hook("IdentificationFailed",true);
      
      public static const IdentificationFailedWithDuration:Hook = new Hook("IdentificationFailedWithDuration",true);
      
      public static const IdentificationFailedForBadVersion:Hook = new Hook("IdentificationFailedForBadVersion",true);
      
      public static const LoginQueueStart:Hook = new Hook("LoginQueueStart",true);
      
      public static const LoginQueueStatus:Hook = new Hook("LoginQueueStatus",true);
      
      public static const QueueStatus:Hook = new Hook("QueueStatus",true);
      
      public static const SubscribersList:Hook = new Hook("SubscribersList",true);
      
      public static const NewsLogin:Hook = new Hook("NewsLogin",true);
      
      public static const ServerConnectionFailed:Hook = new Hook("ServerConnectionFailed",true);
      
      public static const SelectedServerRefused:Hook = new Hook("SelectedServerRefused",true);
      
      public static const SelectedServerFailed:Hook = new Hook("SelectedServerFailed",true);
      
      public static const AcquaintanceServerList:Hook = new Hook("AcquaintanceServerList",true);
      
      public static const AcquaintanceSearchError:Hook = new Hook("AcquaintanceSearchError",true);
      
      public static const AuthenticationTicket:Hook = new Hook("AuthenticationTicket",true);
      
      public static const LegalAgreementsLoaded:Hook = new Hook("LegalAgreementsLoaded",true);
      
      public static const ConsoleOutput:Hook = new Hook("ConsoleOutput",true);
      
      public static const ConsoleClear:Hook = new Hook("ConsoleClear",true);
      
      public static const ShowSmilies:Hook = new Hook("ShowSmilies",true);
      
      public static const ToggleConsole:Hook = new Hook("ToggleConsole",true);
      
      public static const ConsoleAddCmd:Hook = new Hook("ConsoleAddCmd",true);
      
      public static const AuthenticationTicketAccepted:Hook = new Hook("AuthenticationTicketAccepted",true);
      
      public static const AuthenticationTicketRefused:Hook = new Hook("AuthenticationTicketRefused",true);
      
      public static const ServersList:Hook = new Hook("ServersList",true);
      
      public static const ServerSelectionStart:Hook = new Hook("ServerSelectionStart",true);
      
      public static const CharacterSelectionStart:Hook = new Hook("CharacterSelectionStart",true);
      
      public static const CharacterCreationStart:Hook = new Hook("CharacterCreationStart",true);
      
      public static const CharactersListUpdated:Hook = new Hook("CharactersListUpdated",true);
      
      public static const TutorielAvailable:Hook = new Hook("TutorielAvailable",true);
      
      public static const BreedsAvailable:Hook = new Hook("BreedsAvailable",true);
      
      public static const CharacterStatsList:Hook = new Hook("CharacterStatsList",false);
      
      public static const CharacterLevelUp:Hook = new Hook("CharacterLevelUp",false);
      
      public static const CharacterNameSuggestioned:Hook = new Hook("CharacterNameSuggestioned",true);
      
      public static const CharacterDeletionError:Hook = new Hook("CharacterDeletionError",true);
      
      public static const CharacterCreationResult:Hook = new Hook("CharacterCreationResult",true);
      
      public static const CharacterImpossibleSelection:Hook = new Hook("CharacterImpossibleSelection",true);
      
      public static const ConnectionTimerStart:Hook = new Hook("ConnectionTimerStart",true);
      
      public static const NicknameRegistration:Hook = new Hook("NicknameRegistration",true);
      
      public static const NicknameRefused:Hook = new Hook("NicknameRefused",true);
      
      public static const NicknameAccepted:Hook = new Hook("NicknameAccepted",true);
      
      public static const GameStart:Hook = new Hook("GameStart",false);
      
      public static const SpellList:Hook = new Hook("SpellList",false);
      
      public static const SmileysStart:Hook = new Hook("SmileysStart",false);
      
      public static const UnexpectedSocketClosure:Hook = new Hook("UnexpectedSocketClosure",true);
      
      public static const AlreadyConnected:Hook = new Hook("AlreadyConnected",true);
      
      public static const CurrentMap:Hook = new Hook("CurrentMap",false);
      
      public static const EntityMouseOver:Hook = new Hook("EntityMouseOver",false);
      
      public static const EntityMouseOut:Hook = new Hook("EntityMouseOut",false);
      
      public static const OpenMap:Hook = new Hook("OpenMap",false);
      
      public static const MapDisplay:Hook = new Hook("MapDisplay",false);
      
      public static const OpenBook:Hook = new Hook("OpenBook",false);
      
      public static const OpenGrimoireSpellTab:Hook = new Hook("OpenGrimoireSpellTab",false);
      
      public static const OpenSpellInterface:Hook = new Hook("OpenSpellInterface",false);
      
      public static const OpenWebPortal:Hook = new Hook("OpenWebPortal",false);
      
      public static const OpenKrosmaster:Hook = new Hook("OpenKrosmaster",false);
      
      public static const OpenRecipe:Hook = new Hook("OpenRecipe",false);
      
      public static const OpenSet:Hook = new Hook("OpenSet",false);
      
      public static const OpenFeed:Hook = new Hook("OpenFeed",false);
      
      public static const OpenMountFeed:Hook = new Hook("OpenMountFeed",false);
      
      public static const HouseInformations:Hook = new Hook("HouseInformations",false);
      
      public static const HouseProperties:Hook = new Hook("HouseProperties",false);
      
      public static const HouseEntered:Hook = new Hook("HouseEntered",false);
      
      public static const HouseExit:Hook = new Hook("HouseExit",false);
      
      public static const HouseGuildNone:Hook = new Hook("HouseGuildNone",false);
      
      public static const HouseGuildRights:Hook = new Hook("HouseGuildRights",false);
      
      public static const PurchasableDialog:Hook = new Hook("PurchasableDialog",false);
      
      public static const HouseBuyResult:Hook = new Hook("HouseBuyResult",false);
      
      public static const HouseSold:Hook = new Hook("HouseSold",false);
      
      public static const LockableShowCode:Hook = new Hook("LockableShowCode",false);
      
      public static const LockableCodeResult:Hook = new Hook("LockableCodeResult",false);
      
      public static const LockableStateUpdateHouseDoor:Hook = new Hook("LockableStateUpdateHouseDoor",false);
      
      public static const Cinematic:Hook = new Hook("Cinematic",false);
      
      public static const ClosePopup:Hook = new Hook("ClosePopup",false);
      
      public static const FightEvent:Hook = new Hook("FightEvent",false);
      
      public static const FightText:Hook = new Hook("FightText",false);
      
      public static const GameFightStarting:Hook = new Hook("GameFightStarting",false);
      
      public static const GameFightJoin:Hook = new Hook("GameFightJoin",false);
      
      public static const GameFightTurnChangeInformations:Hook = new Hook("GameFightTurnChangeInformations",false);
      
      public static const GameFightTurnEnd:Hook = new Hook("GameFightTurnEnd",false);
      
      public static const FightersListUpdated:Hook = new Hook("FightersListUpdated",false);
      
      public static const GameFightTurnStart:Hook = new Hook("GameFightTurnStart",false);
      
      public static const GameFightTurnStartPlaying:Hook = new Hook("GameFightTurnStartPlaying",false);
      
      public static const GameFightStart:Hook = new Hook("GameFightStart",false);
      
      public static const GameFightEnd:Hook = new Hook("GameFightEnd",false);
      
      public static const GameFightLeave:Hook = new Hook("GameFightLeave",false);
      
      public static const GameActionFightPointsVariation:Hook = new Hook("GameActionFightPointsVariation",false);
      
      public static const GameActionFightPointsUse:Hook = new Hook("GameActionFightPointsUse",false);
      
      public static const GameActionFightLifePointsVariation:Hook = new Hook("GameActionFightLifePointsVariation",false);
      
      public static const GameActionFightDying:Hook = new Hook("GameActionFightDying",false);
      
      public static const GameActionFightDeathEnd:Hook = new Hook("GameActionFightDeathEnd",false);
      
      public static const CancelCastSpell:Hook = new Hook("CancelCastSpell",false);
      
      public static const CastSpellMode:Hook = new Hook("CastSpellMode",false);
      
      public static const ShowCell:Hook = new Hook("ShowCell",false);
      
      public static const OptionLockFight:Hook = new Hook("OptionLockFight",false);
      
      public static const OptionLockParty:Hook = new Hook("OptionLockParty",false);
      
      public static const OptionHelpWanted:Hook = new Hook("OptionHelpWanted",false);
      
      public static const OptionWitnessForbidden:Hook = new Hook("OptionWitnessForbidden",false);
      
      public static const ShowTacticMode:Hook = new Hook("ShowTacticMode",false);
      
      public static const MapsLoadingComplete:Hook = new Hook("MapsLoadingComplete",false);
      
      public static const MapFightCount:Hook = new Hook("MapFightCount",false);
      
      public static const ZaapList:Hook = new Hook("ZaapList",false);
      
      public static const LeaveDialog:Hook = new Hook("LeaveDialog",false);
      
      public static const GameRolePlayShowChallenge:Hook = new Hook("GameRolePlayShowChallenge",false);
      
      public static const MapComplementaryInformationsData:Hook = new Hook("MapComplementaryInformationsData",false);
      
      public static const StatsUpgradeResult:Hook = new Hook("StatsUpgradeResult",false);
      
      public static const OpenStats:Hook = new Hook("OpenStats",false);
      
      public static const OpenInventory:Hook = new Hook("OpenInventory",false);
      
      public static const OpenMount:Hook = new Hook("OpenMount",false);
      
      public static const OpenMainMenu:Hook = new Hook("OpenMainMenu",false);
      
      public static const CloseInventory:Hook = new Hook("CloseInventory",false);
      
      public static const SpellUpgradeSuccess:Hook = new Hook("SpellUpgradeSuccess",false);
      
      public static const SpellForgotten:Hook = new Hook("SpellForgotten",false);
      
      public static const SpellUpgradeFail:Hook = new Hook("SpellUpgradeFail",false);
      
      public static const PartyLoyaltyStatus:Hook = new Hook("PartyLoyaltyStatus",false);
      
      public static const PlayerAggression:Hook = new Hook("PlayerAggression",false);
      
      public static const JobsListUpdated:Hook = new Hook("JobsListUpdated",false);
      
      public static const NpcDialogCreation:Hook = new Hook("NpcDialogCreation",false);
      
      public static const PonyDialogCreation:Hook = new Hook("PonyDialogCreation",false);
      
      public static const PrismDialogCreation:Hook = new Hook("PrismDialogCreation",false);
      
      public static const NpcDialogCreationFailure:Hook = new Hook("NpcDialogCreationFailure",false);
      
      public static const NpcDialogQuestion:Hook = new Hook("NpcDialogQuestion",false);
      
      public static const SpellMovement:Hook = new Hook("SpellMovement",false);
      
      public static const SpellInventoryUpdate:Hook = new Hook("SpellInventoryUpdate",false);
      
      public static const PartyInvitation:Hook = new Hook("PartyInvitation",false);
      
      public static const PartyJoin:Hook = new Hook("PartyJoin",false);
      
      public static const PartyCannotJoinError:Hook = new Hook("PartyCannotJoinError",false);
      
      public static const PartyCancelledInvitation:Hook = new Hook("PartyCancelledInvitation",false);
      
      public static const PartyLeaderUpdate:Hook = new Hook("PartyLeaderUpdate",false);
      
      public static const PartyLeave:Hook = new Hook("PartyLeave",false);
      
      public static const PartyLocateMembers:Hook = new Hook("PartyLocateMembers",false);
      
      public static const PartyMemberRemove:Hook = new Hook("PartyMemberRemove",false);
      
      public static const PartyRefuseInvitationNotification:Hook = new Hook("PartyRefuseInvitationNotification",false);
      
      public static const PartyUpdate:Hook = new Hook("PartyUpdate",false);
      
      public static const PartyMemberLifeUpdate:Hook = new Hook("PartyMemberLifeUpdate",false);
      
      public static const PartyMemberUpdate:Hook = new Hook("PartyMemberUpdate",false);
      
      public static const PartyCompanionMemberUpdate:Hook = new Hook("PartyCompanionMemberUpdate",false);
      
      public static const PartyMemberUpdateDetails:Hook = new Hook("PartyMemberUpdateDetails",false);
      
      public static const PartyMemberFollowUpdate:Hook = new Hook("PartyMemberFollowUpdate",false);
      
      public static const LifePointsRegenBegin:Hook = new Hook("LifePointsRegenBegin",false);
      
      public static const PlayedCharacterLookChange:Hook = new Hook("PlayedCharacterLookChange",false);
      
      public static const MapRunningFightList:Hook = new Hook("MapRunningFightList",false);
      
      public static const MapRunningFightDetails:Hook = new Hook("MapRunningFightDetails",false);
      
      public static const GameRolePlayRemoveFight:Hook = new Hook("GameRolePlayRemoveFight",false);
      
      public static const GameFightOptionStateUpdate:Hook = new Hook("GameFightOptionStateUpdate",false);
      
      public static const ConfigPropertyChange:Hook = new Hook("ConfigPropertyChange",false);
      
      public static const OpenChatOptions:Hook = new Hook("OpenChatOptions",false);
      
      public static const UpdateChatOptions:Hook = new Hook("UpdateChatOptions",false);
      
      public static const GameRolePlayPlayerLifeStatus:Hook = new Hook("GameRolePlayPlayerLifeStatus",false);
      
      public static const DoubleClickItemInventory:Hook = new Hook("DoubleClickItemInventory",false);
      
      public static const NonSubscriberPopup:Hook = new Hook("NonSubscriberPopup",false);
      
      public static const InformationPopup:Hook = new Hook("InformationPopup",false);
      
      public static const SubscriptionZone:Hook = new Hook("SubscriptionZone",false);
      
      public static const GiftList:Hook = new Hook("GiftList",false);
      
      public static const GiftAssigned:Hook = new Hook("GiftAssigned",false);
      
      public static const DocumentReadingBeginMessage:Hook = new Hook("DocumentReadingBeginMessage",false);
      
      public static const AddMapFlag:Hook = new Hook("AddMapFlag",false);
      
      public static const RemoveMapFlag:Hook = new Hook("RemoveMapFlag",false);
      
      public static const ContextChanged:Hook = new Hook("ContextChanged",false);
      
      public static const LevelUiClosed:Hook = new Hook("LevelUiClosed",false);
      
      public static const NotificationReset:Hook = new Hook("NotificationReset",false);
      
      public static const OrderFightersSwitched:Hook = new Hook("OrderFightersSwitched",false);
      
      public static const HideDeadFighters:Hook = new Hook("HideDeadFighters",false);
      
      public static const HideSummonedFighters:Hook = new Hook("HideSummonedFighters",false);
      
      public static const StartZoom:Hook = new Hook("StartZoom",false);
      
      public static const ConnexionLost:Hook = new Hook("ConnexionLost",false);
      
      public static const WorldRightClick:Hook = new Hook("WorldRightClick",false);
      
      public static const WorldMouseWheel:Hook = new Hook("WorldMouseWheel",false);
      
      public static const UpdateStepChange:Hook = new Hook("UpdateStepChange",false);
      
      public static const UpdateProgress:Hook = new Hook("UpdateProgress",false);
      
      public static const UpdateFinished:Hook = new Hook("UpdateFinished",false);
      
      public static const UpdateError:Hook = new Hook("UpdateError",false);
      
      public static const PartsList:Hook = new Hook("PartsList",false);
      
      public static const PartInfo:Hook = new Hook("PartInfo",false);
      
      public static const PartDownloadInfo:Hook = new Hook("PartDownloadInfo",false);
      
      public static const DownloadSpeed:Hook = new Hook("DownloadSpeed",false);
      
      public static const PackRestrictedSubArea:Hook = new Hook("PackRestrictedSubArea",false);
      
      public static const DownloadError:Hook = new Hook("DownloadError",false);
      
      public static const QualitySelectionRequired:Hook = new Hook("QualitySelectionRequired",false);
      
      public static const SetDofusQuality:Hook = new Hook("SetDofusQuality",false);
      
      public static const AllDownloadTerminated:Hook = new Hook("AllDownloadTerminated",false);
      
      public static const CloseNotification:Hook = new Hook("CloseNotification",false);
      
      public static const HideNotification:Hook = new Hook("HideNotification",false);
      
      public static const SecureModeChange:Hook = new Hook("SecureModeChange",true);
      
      public static const InactivityNotification:Hook = new Hook("InactivityNotification",false);
      
      public static const LaggingNotification:Hook = new Hook("LaggingNotification",false);
      
      public static const PhoenixUpdate:Hook = new Hook("PhoenixUpdate",true);
      
      public static const ExternalNotification:Hook = new Hook("ExternalNotification",false);
      
      public static const CalendarDate:Hook = new Hook("CalendarDate",false);
      
      public static const OpenStatusMenu:Hook = new Hook("OpenStatusMenu",false);
      
      public static const KrosmasterAuthTokenError:Hook = new Hook("KrosmasterAuthTokenError",false);
      
      public static const KrosmasterAuthToken:Hook = new Hook("KrosmasterAuthToken",false);
      
      public static const KrosmasterInventoryError:Hook = new Hook("KrosmasterInventoryError",false);
      
      public static const KrosmasterInventory:Hook = new Hook("KrosmasterInventory",false);
      
      public static const KrosmasterTransfer:Hook = new Hook("KrosmasterTransfer",false);
      
      public static const ShowPlayersNames:Hook = new Hook("ShowPlayersNames",false);
      
      public static const ShowMonstersInfo:Hook = new Hook("ShowMonstersInfo",false);
      
      public static const OpenCartographyPopup:Hook = new Hook("OpenCartographyPopup",false);
      
      public static const ContactLook:Hook = new Hook("ContactLook",false);
      
      private var _import_CustomUiHookList:CustomUiHookList = null;
   }
}

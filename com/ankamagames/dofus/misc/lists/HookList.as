package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class HookList extends Object
   {
      
      public function HookList() {
         super();
      }
      
      public static const LangFileLoaded:Hook;
      
      public static const ConfigStart:Hook;
      
      public static const AuthentificationStart:Hook;
      
      public static const AgreementsRequired:Hook;
      
      public static const IdentificationSuccess:Hook;
      
      public static const IdentificationFailed:Hook;
      
      public static const IdentificationFailedWithDuration:Hook;
      
      public static const IdentificationFailedForBadVersion:Hook;
      
      public static const LoginQueueStart:Hook;
      
      public static const LoginQueueStatus:Hook;
      
      public static const QueueStatus:Hook;
      
      public static const SubscribersList:Hook;
      
      public static const NewsLogin:Hook;
      
      public static const ServerConnectionFailed:Hook;
      
      public static const SelectedServerRefused:Hook;
      
      public static const SelectedServerFailed:Hook;
      
      public static const AcquaintanceServerList:Hook;
      
      public static const AcquaintanceSearchError:Hook;
      
      public static const AuthenticationTicket:Hook;
      
      public static const LegalAgreementsLoaded:Hook;
      
      public static const ConsoleOutput:Hook;
      
      public static const ConsoleClear:Hook;
      
      public static const ShowSmilies:Hook;
      
      public static const ToggleConsole:Hook;
      
      public static const ConsoleAddCmd:Hook;
      
      public static const AuthenticationTicketAccepted:Hook;
      
      public static const AuthenticationTicketRefused:Hook;
      
      public static const ServersList:Hook;
      
      public static const ServerSelectionStart:Hook;
      
      public static const CharacterSelectionStart:Hook;
      
      public static const CharacterCreationStart:Hook;
      
      public static const CharactersListUpdated:Hook;
      
      public static const TutorielAvailable:Hook;
      
      public static const BreedsAvailable:Hook;
      
      public static const CharacterStatsList:Hook;
      
      public static const CharacterLevelUp:Hook;
      
      public static const CharacterNameSuggestioned:Hook;
      
      public static const CharacterDeletionError:Hook;
      
      public static const CharacterCreationResult:Hook;
      
      public static const CharacterImpossibleSelection:Hook;
      
      public static const ConnectionTimerStart:Hook;
      
      public static const NicknameRegistration:Hook;
      
      public static const NicknameRefused:Hook;
      
      public static const NicknameAccepted:Hook;
      
      public static const GameStart:Hook;
      
      public static const SpellList:Hook;
      
      public static const SmileysStart:Hook;
      
      public static const UnexpectedSocketClosure:Hook;
      
      public static const AlreadyConnected:Hook;
      
      public static const CurrentMap:Hook;
      
      public static const EntityMouseOver:Hook;
      
      public static const EntityMouseOut:Hook;
      
      public static const OpenMap:Hook;
      
      public static const MapDisplay:Hook;
      
      public static const OpenBook:Hook;
      
      public static const OpenGrimoireSpellTab:Hook;
      
      public static const OpenSpellInterface:Hook;
      
      public static const OpenWebPortal:Hook;
      
      public static const OpenKrosmaster:Hook;
      
      public static const OpenRecipe:Hook;
      
      public static const OpenSet:Hook;
      
      public static const OpenFeed:Hook;
      
      public static const OpenMountFeed:Hook;
      
      public static const HouseInformations:Hook;
      
      public static const HouseProperties:Hook;
      
      public static const HouseEntered:Hook;
      
      public static const HouseExit:Hook;
      
      public static const HouseGuildNone:Hook;
      
      public static const HouseGuildRights:Hook;
      
      public static const PurchasableDialog:Hook;
      
      public static const HouseBuyResult:Hook;
      
      public static const HouseSold:Hook;
      
      public static const LockableShowCode:Hook;
      
      public static const LockableCodeResult:Hook;
      
      public static const LockableStateUpdateHouseDoor:Hook;
      
      public static const Cinematic:Hook;
      
      public static const ClosePopup:Hook;
      
      public static const FightEvent:Hook;
      
      public static const FightText:Hook;
      
      public static const GameFightStarting:Hook;
      
      public static const GameFightJoin:Hook;
      
      public static const GameFightTurnChangeInformations:Hook;
      
      public static const GameFightTurnEnd:Hook;
      
      public static const FightersListUpdated:Hook;
      
      public static const GameFightTurnStart:Hook;
      
      public static const GameFightTurnStartPlaying:Hook;
      
      public static const GameFightStart:Hook;
      
      public static const GameFightEnd:Hook;
      
      public static const GameFightLeave:Hook;
      
      public static const GameActionFightPointsVariation:Hook;
      
      public static const GameActionFightPointsUse:Hook;
      
      public static const GameActionFightLifePointsVariation:Hook;
      
      public static const GameActionFightDying:Hook;
      
      public static const GameActionFightDeathEnd:Hook;
      
      public static const CancelCastSpell:Hook;
      
      public static const CastSpellMode:Hook;
      
      public static const ShowCell:Hook;
      
      public static const OptionLockFight:Hook;
      
      public static const OptionLockParty:Hook;
      
      public static const OptionHelpWanted:Hook;
      
      public static const OptionWitnessForbidden:Hook;
      
      public static const ShowTacticMode:Hook;
      
      public static const MapsLoadingComplete:Hook;
      
      public static const MapFightCount:Hook;
      
      public static const ZaapList:Hook;
      
      public static const LeaveDialog:Hook;
      
      public static const GameRolePlayShowChallenge:Hook;
      
      public static const MapComplementaryInformationsData:Hook;
      
      public static const StatsUpgradeResult:Hook;
      
      public static const OpenStats:Hook;
      
      public static const OpenInventory:Hook;
      
      public static const OpenMount:Hook;
      
      public static const OpenMainMenu:Hook;
      
      public static const CloseInventory:Hook;
      
      public static const SpellUpgradeSuccess:Hook;
      
      public static const SpellForgotten:Hook;
      
      public static const SpellUpgradeFail:Hook;
      
      public static const PartyLoyaltyStatus:Hook;
      
      public static const PlayerAggression:Hook;
      
      public static const JobsListUpdated:Hook;
      
      public static const SpellMovement:Hook;
      
      public static const SpellInventoryUpdate:Hook;
      
      public static const PartyInvitation:Hook;
      
      public static const PartyJoin:Hook;
      
      public static const PartyCannotJoinError:Hook;
      
      public static const PartyCancelledInvitation:Hook;
      
      public static const PartyLeaderUpdate:Hook;
      
      public static const PartyLeave:Hook;
      
      public static const PartyLocateMembers:Hook;
      
      public static const PartyMemberRemove:Hook;
      
      public static const PartyRefuseInvitationNotification:Hook;
      
      public static const PartyUpdate:Hook;
      
      public static const PartyMemberLifeUpdate:Hook;
      
      public static const PartyMemberUpdate:Hook;
      
      public static const PartyCompanionMemberUpdate:Hook;
      
      public static const PartyMemberUpdateDetails:Hook;
      
      public static const PartyMemberFollowUpdate:Hook;
      
      public static const LifePointsRegenBegin:Hook;
      
      public static const PlayedCharacterLookChange:Hook;
      
      public static const MapRunningFightList:Hook;
      
      public static const MapRunningFightDetails:Hook;
      
      public static const GameRolePlayRemoveFight:Hook;
      
      public static const GameFightOptionStateUpdate:Hook;
      
      public static const ConfigPropertyChange:Hook;
      
      public static const OpenChatOptions:Hook;
      
      public static const UpdateChatOptions:Hook;
      
      public static const GameRolePlayPlayerLifeStatus:Hook;
      
      public static const DoubleClickItemInventory:Hook;
      
      public static const NonSubscriberPopup:Hook;
      
      public static const InformationPopup:Hook;
      
      public static const SubscriptionZone:Hook;
      
      public static const GiftList:Hook;
      
      public static const GiftAssigned:Hook;
      
      public static const DocumentReadingBeginMessage:Hook;
      
      public static const AddMapFlag:Hook;
      
      public static const RemoveMapFlag:Hook;
      
      public static const ContextChanged:Hook;
      
      public static const LevelUiClosed:Hook;
      
      public static const NotificationReset:Hook;
      
      public static const OrderFightersSwitched:Hook;
      
      public static const HideDeadFighters:Hook;
      
      public static const HideSummonedFighters:Hook;
      
      public static const StartZoom:Hook;
      
      public static const ConnexionLost:Hook;
      
      public static const WorldRightClick:Hook;
      
      public static const WorldMouseWheel:Hook;
      
      public static const UpdateStepChange:Hook;
      
      public static const UpdateProgress:Hook;
      
      public static const UpdateFinished:Hook;
      
      public static const UpdateError:Hook;
      
      public static const PartsList:Hook;
      
      public static const PartInfo:Hook;
      
      public static const PartDownloadInfo:Hook;
      
      public static const DownloadSpeed:Hook;
      
      public static const PackRestrictedSubArea:Hook;
      
      public static const DownloadError:Hook;
      
      public static const QualitySelectionRequired:Hook;
      
      public static const SetDofusQuality:Hook;
      
      public static const AllDownloadTerminated:Hook;
      
      public static const CloseNotification:Hook;
      
      public static const HideNotification:Hook;
      
      public static const SecureModeChange:Hook;
      
      public static const InactivityNotification:Hook;
      
      public static const LaggingNotification:Hook;
      
      public static const PhoenixUpdate:Hook;
      
      public static const ExternalNotification:Hook;
      
      public static const CalendarDate:Hook;
      
      public static const OpenStatusMenu:Hook;
      
      public static const KrosmasterAuthTokenError:Hook;
      
      public static const KrosmasterAuthToken:Hook;
      
      public static const KrosmasterInventoryError:Hook;
      
      public static const KrosmasterInventory:Hook;
      
      public static const KrosmasterTransfer:Hook;
      
      public static const ShowPlayersNames:Hook;
      
      public static const ShowMonstersInfo:Hook;
      
      public static const OpenCartographyPopup:Hook;
      
      public static const ContactLook:Hook;
      
      public static const ModuleList:Hook;
      
      public static const ModuleInstallationError:Hook;
      
      public static const ModuleInstallationProgress:Hook;
      
      public static const InstalledModuleList:Hook;
      
      public static const ApisHooksActionsList:Hook;
      
      private var _import_CustomUiHookList:CustomUiHookList = null;
   }
}

package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ExchangeManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.HumanVendorManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SpectatorManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.BidHouseManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.frames.CraftFrame;
   import com.ankamagames.dofus.logic.game.common.frames.CommonExchangeManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SpellForgetDialogFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.PaddockWrapper;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import flash.utils.ByteArray;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.common.frames.StackManagementFrame;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcGenericActionRequestAction;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcGenericActionRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRequestOnTaxCollectorAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestOnTaxCollectorMessage;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.GameRolePlayTaxCollectorFightRequestAction;
   import com.ankamagames.dofus.network.messages.game.guild.tax.GameRolePlayTaxCollectorFightRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.InteractiveElementActivationAction;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DisplayContextualMenuAction;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcDialogCreationMessage;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.PortalUseRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.PortalUseRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.PortalDialogQuestionMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShowVendorTaxMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReplyTaxVendorMessage;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeOnHumanVendorRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestOnShopStockMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOnHumanVendorRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkHumanVendorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockStartedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartAsVendorMessage;
   import com.ankamagames.jerakine.network.messages.ExpectedSocketClosureMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedMountStockMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcShopMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectFoundWhileRecoltingMessage;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.communication.CraftSmileyItem;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayPlayerFightRequestMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightFriendlyAnswerAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayPlayerFightFriendlyAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayPlayerFightFriendlyAnsweredMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayFightRequestCanceledMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayPlayerFightFriendlyRequestedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.death.GameRolePlayFreeSoulRequestMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayAggressionMessage;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShopStockMouvmentAddAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMovePricedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShopStockMouvmentRemoveAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveMessage;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeBuyAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBuyMessage;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeSellAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeSellMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBuyOkMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeSellOkMessage;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangePlayerRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangePlayerRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangePlayerMultiCraftRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangePlayerMultiCraftRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.JobAllowMultiCraftRequestSetAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobAllowMultiCraftRequestSetMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobAllowMultiCraftRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.SpellForgetUIMessage;
   import com.ankamagames.dofus.network.messages.game.guild.ChallengeFightJoinRefusedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.SpellForgottenMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftInformationObjectMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.delay.GameRolePlayDelayedActionMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.document.DocumentReadingBeginMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockSellBuyDialogMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.visual.GameRolePlaySpellAnimMessage;
   import com.ankamagames.dofus.logic.game.roleplay.types.RoleplaySpellCastProvider;
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.BasicSwitchModeAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.ErrorMapNotFoundMessage;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobMultiCraftAvailableSkillsMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicSetAwayModeRequestMessage;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.hurlant.util.Hex;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManager;
   import com.ankamagames.atouin.messages.MapsLoadingCompleteMessage;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.atouin.messages.MapLoadingFailedMessage;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.data.DefaultMap;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.MouseEvent;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidBuyerMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidSellerMessage;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestedTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOkMultiCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkCraftWithInformationMessage;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.network.enums.ExchangeErrorEnum;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.network.enums.FighterRefusedReasonEnum;
   import com.ankamagames.dofus.network.enums.CraftResultEnum;
   import com.ankamagames.dofus.network.enums.DelayedActionTypeEnum;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockPropertiesMessage;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.script.ScriptExec;
   import com.ankamagames.dofus.scripts.DofusEmbedScript;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.PivotCharacterAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcGenericActionFailureMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShowVendorTaxAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeRequestOnShopStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeStartAsVendorRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.GameRolePlayFreeSoulRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.LeaveBidHouseAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.LeaveShopStockAction;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.ZaapListMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.TeleportDestinationsListMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.LeaveExchangeMountAction;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import flash.geom.Point;
   import com.ankamagames.jerakine.utils.display.AngleToOrientation;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationRequestMessage;
   
   public class RoleplayContextFrame extends Object implements Frame
   {
      
      public function RoleplayContextFrame() {
         super();
      }
      
      protected static const _log:Logger;
      
      private static const ASTRUB_SUBAREA_IDS:Array;
      
      private static var currentStatus:int = -1;
      
      private var _priority:int = 0;
      
      private var _entitiesFrame:RoleplayEntitiesFrame;
      
      private var _worldFrame:RoleplayWorldFrame;
      
      private var _interactivesFrame:RoleplayInteractivesFrame;
      
      private var _npcDialogFrame:NpcDialogFrame;
      
      private var _documentFrame:DocumentFrame;
      
      private var _zaapFrame:ZaapFrame;
      
      private var _paddockFrame:PaddockFrame;
      
      private var _emoticonFrame:EmoticonFrame;
      
      private var _exchangeManagementFrame:ExchangeManagementFrame;
      
      private var _humanVendorManagementFrame:HumanVendorManagementFrame;
      
      private var _spectatorManagementFrame:SpectatorManagementFrame;
      
      private var _bidHouseManagementFrame:BidHouseManagementFrame;
      
      private var _estateFrame:EstateFrame;
      
      private var _allianceFrame:AllianceFrame;
      
      private var _craftFrame:CraftFrame;
      
      private var _commonExchangeFrame:CommonExchangeManagementFrame;
      
      private var _movementFrame:RoleplayMovementFrame;
      
      private var _spellForgetDialogFrame:SpellForgetDialogFrame;
      
      private var _delayedActionFrame:DelayedActionFrame;
      
      private var _currentWaitingFightId:uint;
      
      private var _crafterId:uint;
      
      private var _customerID:uint;
      
      private var _playersMultiCraftSkill:Array;
      
      private var _currentPaddock:PaddockWrapper;
      
      private var _playerEntity:AnimatedCharacter;
      
      private var _interactionIsLimited:Boolean = false;
      
      public function get crafterId() : uint {
         return this._crafterId;
      }
      
      public function get customerID() : uint {
         return this._customerID;
      }
      
      public function get priority() : int {
         return this._priority;
      }
      
      public function set priority(p:int) : void {
         this._priority = p;
      }
      
      public function get entitiesFrame() : RoleplayEntitiesFrame {
         return this._entitiesFrame;
      }
      
      private function get socialFrame() : SocialFrame {
         return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
      }
      
      public function get hasWorldInteraction() : Boolean {
         return !this._interactionIsLimited;
      }
      
      public function get commonExchangeFrame() : CommonExchangeManagementFrame {
         return this._commonExchangeFrame;
      }
      
      public function get hasGuildedPaddock() : Boolean {
         return (this._currentPaddock) && (this._currentPaddock.guildIdentity);
      }
      
      public function get currentPaddock() : PaddockWrapper {
         return this._currentPaddock;
      }
      
      public function pushed() : Boolean {
         this._entitiesFrame = new RoleplayEntitiesFrame();
         this._delayedActionFrame = new DelayedActionFrame();
         this._movementFrame = new RoleplayMovementFrame();
         this._worldFrame = new RoleplayWorldFrame();
         this._interactivesFrame = new RoleplayInteractivesFrame();
         Kernel.getWorker().addFrame(this._delayedActionFrame);
         this._npcDialogFrame = new NpcDialogFrame();
         this._documentFrame = new DocumentFrame();
         this._zaapFrame = new ZaapFrame();
         this._paddockFrame = new PaddockFrame();
         this._exchangeManagementFrame = new ExchangeManagementFrame();
         this._spectatorManagementFrame = new SpectatorManagementFrame();
         this._bidHouseManagementFrame = new BidHouseManagementFrame();
         this._estateFrame = new EstateFrame();
         this._craftFrame = new CraftFrame();
         this._humanVendorManagementFrame = new HumanVendorManagementFrame();
         this._spellForgetDialogFrame = new SpellForgetDialogFrame();
         Kernel.getWorker().addFrame(this._spectatorManagementFrame);
         if(!Kernel.getWorker().contains(EstateFrame))
         {
            Kernel.getWorker().addFrame(this._estateFrame);
         }
         this._allianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         this._allianceFrame.pushRoleplay();
         if(!Kernel.getWorker().contains(EmoticonFrame))
         {
            this._emoticonFrame = new EmoticonFrame();
            Kernel.getWorker().addFrame(this._emoticonFrame);
         }
         else
         {
            this._emoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
         }
         this._playersMultiCraftSkill = new Array();
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var mcmsg:CurrentMapMessage = null;
         var newSubArea:SubArea = null;
         var wp:WorldPointWrapper = null;
         var decryptionKey:ByteArray = null;
         var commonMod:Object = null;
         var map:MapPosition = null;
         var cwiamsg:ChangeWorldInteractionAction = null;
         var bidHouseSwitch:* = false;
         var stackFrame:StackManagementFrame = null;
         var ngara:NpcGenericActionRequestAction = null;
         var playerEntity:IEntity = null;
         var ngarmsg:NpcGenericActionRequestMessage = null;
         var erotca:ExchangeRequestOnTaxCollectorAction = null;
         var erotcmsg:ExchangeRequestOnTaxCollectorMessage = null;
         var playerEntity4:IEntity = null;
         var grptcfra:GameRolePlayTaxCollectorFightRequestAction = null;
         var grptcfrmsg:GameRolePlayTaxCollectorFightRequestMessage = null;
         var ieaa:InteractiveElementActivationAction = null;
         var ieamsg:InteractiveElementActivationMessage = null;
         var dcma:DisplayContextualMenuAction = null;
         var entityInfo:GameContextActorInformations = null;
         var roleplayInteractivesFrame:RoleplayInteractivesFrame = null;
         var ndcmsg:NpcDialogCreationMessage = null;
         var entityNpcLike:Object = null;
         var pura:PortalUseRequestAction = null;
         var purmsg:PortalUseRequestMessage = null;
         var pdqmsg:PortalDialogQuestionMessage = null;
         var date:Date = null;
         var esvtmsg:ExchangeShowVendorTaxMessage = null;
         var ertvmsg:ExchangeReplyTaxVendorMessage = null;
         var erossa:ExchangeOnHumanVendorRequestAction = null;
         var ospmsg:ExchangeRequestOnShopStockMessage = null;
         var eohvra:ExchangeOnHumanVendorRequestAction = null;
         var playerEntity3:IEntity = null;
         var eohvrmsg:ExchangeOnHumanVendorRequestMessage = null;
         var esohvmsg:ExchangeStartOkHumanVendorMessage = null;
         var esostmsg:ExchangeShopStockStartedMessage = null;
         var entity:IEntity = null;
         var esavmsg:ExchangeStartAsVendorMessage = null;
         var escmsg:ExpectedSocketClosureMessage = null;
         var esmsmsg:ExchangeStartedMountStockMessage = null;
         var esonmsg:ExchangeStartOkNpcShopMessage = null;
         var esmsg:ExchangeStartedMessage = null;
         var commonExchangeFrame:CommonExchangeManagementFrame = null;
         var ofwrm:ObjectFoundWhileRecoltingMessage = null;
         var itemFound:Item = null;
         var playerId:uint = 0;
         var craftSmileyItem:CraftSmileyItem = null;
         var quantity:uint = 0;
         var itemName:String = null;
         var ressourceName:String = null;
         var message:String = null;
         var pfra:PlayerFightRequestAction = null;
         var gppfrm:GameRolePlayPlayerFightRequestMessage = null;
         var playerEntity2:IEntity = null;
         var pffaa:PlayerFightFriendlyAnswerAction = null;
         var grppffam2:GameRolePlayPlayerFightFriendlyAnswerMessage = null;
         var grppffam:GameRolePlayPlayerFightFriendlyAnsweredMessage = null;
         var grpfrcm:GameRolePlayFightRequestCanceledMessage = null;
         var grppffrm:GameRolePlayPlayerFightFriendlyRequestedMessage = null;
         var grpfsrmmsg:GameRolePlayFreeSoulRequestMessage = null;
         var ldrbidHousemsg:LeaveDialogRequestMessage = null;
         var ermsg:ExchangeErrorMessage = null;
         var errorMessage:String = null;
         var channelId:uint = 0;
         var grpamsg:GameRolePlayAggressionMessage = null;
         var ldrmsg:LeaveDialogRequestMessage = null;
         var essmaa:ExchangeShopStockMouvmentAddAction = null;
         var eompmsg:ExchangeObjectMovePricedMessage = null;
         var essmra:ExchangeShopStockMouvmentRemoveAction = null;
         var eommsg:ExchangeObjectMoveMessage = null;
         var eba:ExchangeBuyAction = null;
         var ebmsg:ExchangeBuyMessage = null;
         var esa:ExchangeSellAction = null;
         var eslmsg:ExchangeSellMessage = null;
         var ebomsg:ExchangeBuyOkMessage = null;
         var esomsg:ExchangeSellOkMessage = null;
         var epra:ExchangePlayerRequestAction = null;
         var eprmsg:ExchangePlayerRequestMessage = null;
         var epmcra:ExchangePlayerMultiCraftRequestAction = null;
         var epmcrmsg:ExchangePlayerMultiCraftRequestMessage = null;
         var jamcrsa:JobAllowMultiCraftRequestSetAction = null;
         var jamcrsmsg:JobAllowMultiCraftRequestSetMessage = null;
         var jamcrmsg:JobAllowMultiCraftRequestMessage = null;
         var messId:uint = 0;
         var sfuimsg:SpellForgetUIMessage = null;
         var cfjrmsg:ChallengeFightJoinRefusedMessage = null;
         var sfmsg:SpellForgottenMessage = null;
         var ecrmsg:ExchangeCraftResultMessage = null;
         var messageId:uint = 0;
         var eciomsg:ExchangeCraftInformationObjectMessage = null;
         var csi:CraftSmileyItem = null;
         var grda:GameRolePlayDelayedActionMessage = null;
         var drbm:DocumentReadingBeginMessage = null;
         var psbdmsg:PaddockSellBuyDialogMessage = null;
         var ldrmsg2:LeaveDialogRequestMessage = null;
         var grpsamsg:GameRolePlaySpellAnimMessage = null;
         var spellLuncher:RoleplaySpellCastProvider = null;
         var scriptRunner:SpellFxRunner = null;
         var bsma:BasicSwitchModeAction = null;
         var decryptionKeyString:String = null;
         var commonMod2:Object = null;
         var emnfmsg:ErrorMapNotFoundMessage = null;
         var currentMapX:* = 0;
         var currentMapY:* = 0;
         var currentWorldId:* = 0;
         var virtualMap:Map = null;
         var menuResult:* = false;
         var npcEntity:GameRolePlayNpcInformations = null;
         var ponyEntity:GameRolePlayTaxCollectorInformations = null;
         var prismEntity:GameRolePlayPrismInformations = null;
         var allianceName:String = null;
         var portalEntity:GameRolePlayPortalInformations = null;
         var area:Area = null;
         var areaName:String = null;
         var absoluteBounds:IRectangle = null;
         var infos:GameRolePlayCharacterInformations = null;
         var targetPlayerLevel:* = 0;
         var fightType:* = 0;
         var rcf:RoleplayContextFrame = null;
         var playerInfo:GameRolePlayActorInformations = null;
         var name:String = null;
         var gcai:GameContextActorInformations = null;
         var jmcasm:JobMultiCraftAvailableSkillsMessage = null;
         var mcefp:MultiCraftEnableForPlayer = null;
         var alreadyIn:* = false;
         var mcefplayer:MultiCraftEnableForPlayer = null;
         var compt:uint = 0;
         var index:* = 0;
         var item:Item = null;
         var iconId:uint = 0;
         var absBounds:IRectangle = null;
         var csiD:CraftSmileyItem = null;
         var iconIdD:uint = 0;
         var absBoundsD:IRectangle = null;
         var bsamrmsg:BasicSetAwayModeRequestMessage = null;
         switch(true)
         {
            case msg is CurrentMapMessage:
               mcmsg = msg as CurrentMapMessage;
               newSubArea = SubArea.getSubAreaByMapId(mcmsg.mapId);
               PlayedCharacterManager.getInstance().currentSubArea = newSubArea;
               Kernel.getWorker().pause(null,[SystemMessageDisplayMessage]);
               ConnectionsHandler.pause();
               if(TacticModeManager.getInstance().tacticModeActivated)
               {
                  TacticModeManager.getInstance().hide();
               }
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               Atouin.getInstance().initPreDisplay(wp);
               if((this._entitiesFrame) && (Kernel.getWorker().contains(RoleplayEntitiesFrame)))
               {
                  Kernel.getWorker().removeFrame(this._entitiesFrame);
               }
               if((this._worldFrame) && (Kernel.getWorker().contains(RoleplayWorldFrame)))
               {
                  Kernel.getWorker().removeFrame(this._worldFrame);
               }
               if((this._interactivesFrame) && (Kernel.getWorker().contains(RoleplayInteractivesFrame)))
               {
                  Kernel.getWorker().removeFrame(this._interactivesFrame);
               }
               if((this._movementFrame) && (Kernel.getWorker().contains(RoleplayMovementFrame)))
               {
                  Kernel.getWorker().removeFrame(this._movementFrame);
               }
               if(PlayedCharacterManager.getInstance().isInHouse)
               {
                  wp = new WorldPointWrapper(mcmsg.mapId,true,PlayedCharacterManager.getInstance().currentMap.outdoorX,PlayedCharacterManager.getInstance().currentMap.outdoorY);
               }
               else
               {
                  wp = new WorldPointWrapper(mcmsg.mapId);
               }
               PlayedCharacterManager.getInstance().currentMap = wp;
               Atouin.getInstance().clearEntities();
               if((mcmsg.mapKey) && (mcmsg.mapKey.length))
               {
                  decryptionKeyString = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                  if(!decryptionKeyString)
                  {
                     decryptionKeyString = mcmsg.mapKey;
                  }
                  decryptionKey = Hex.toArray(Hex.fromString(decryptionKeyString));
               }
               Atouin.getInstance().display(wp,decryptionKey);
               TooltipManager.hideAll();
               commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
               commonMod.closeAllMenu();
               this._currentPaddock = null;
               map = MapPosition.getMapPositionById(mcmsg.mapId);
               if((map) && (!(ASTRUB_SUBAREA_IDS.indexOf(map.subAreaId) == -1)))
               {
                  PartManager.getInstance().checkAndDownload("all");
               }
               KernelEventsManager.getInstance().processCallback(HookList.CurrentMap,mcmsg.mapId);
               return true;
            case msg is MapsLoadingCompleteMessage:
               if(!Kernel.getWorker().contains(RoleplayEntitiesFrame))
               {
                  Kernel.getWorker().addFrame(this._entitiesFrame);
               }
               TooltipManager.hideAll();
               KernelEventsManager.getInstance().processCallback(HookList.MapsLoadingComplete,MapsLoadingCompleteMessage(msg).mapPoint);
               if(!Kernel.getWorker().contains(RoleplayWorldFrame))
               {
                  Kernel.getWorker().addFrame(this._worldFrame);
               }
               if(!Kernel.getWorker().contains(RoleplayInteractivesFrame))
               {
                  Kernel.getWorker().addFrame(this._interactivesFrame);
               }
               if(!Kernel.getWorker().contains(RoleplayMovementFrame))
               {
                  Kernel.getWorker().addFrame(this._movementFrame);
               }
               SoundManager.getInstance().manager.setSubArea(MapsLoadingCompleteMessage(msg).mapData);
               Atouin.getInstance().updateCursor();
               Kernel.getWorker().resume();
               Kernel.getWorker().clearUnstoppableMsgClassList();
               ConnectionsHandler.resume();
               return true;
            case msg is MapLoadingFailedMessage:
               switch(MapLoadingFailedMessage(msg).errorReason)
               {
                  case MapLoadingFailedMessage.NO_FILE:
                     commonMod2 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                     commonMod2.openPopup(I18n.getUiText("ui.popup.information"),I18n.getUiText("ui.popup.noMapdataFile"),[I18n.getUiText("ui.common.ok")]);
                     emnfmsg = new ErrorMapNotFoundMessage();
                     emnfmsg.initErrorMapNotFoundMessage(MapLoadingFailedMessage(msg).id);
                     ConnectionsHandler.getConnection().send(emnfmsg);
                     MapDisplayManager.getInstance().fromMap(new DefaultMap(MapLoadingFailedMessage(msg).id));
                     return true;
                  default:
                     return false;
               }
            case msg is MapLoadedMessage:
               if(MapDisplayManager.getInstance().isDefaultMap)
               {
                  currentMapX = PlayedCharacterManager.getInstance().currentMap.x;
                  currentMapY = PlayedCharacterManager.getInstance().currentMap.y;
                  currentWorldId = PlayedCharacterManager.getInstance().currentMap.worldId;
                  virtualMap = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
                  virtualMap.rightNeighbourId = WorldPoint.fromCoords(currentWorldId,currentMapX + 1,currentMapY).mapId;
                  virtualMap.leftNeighbourId = WorldPoint.fromCoords(currentWorldId,currentMapX - 1,currentMapY).mapId;
                  virtualMap.bottomNeighbourId = WorldPoint.fromCoords(currentWorldId,currentMapX,currentMapY + 1).mapId;
                  virtualMap.topNeighbourId = WorldPoint.fromCoords(currentWorldId,currentMapX,currentMapY - 1).mapId;
               }
               return true;
            case msg is ChangeWorldInteractionAction:
               cwiamsg = msg as ChangeWorldInteractionAction;
               bidHouseSwitch = false;
               if((Kernel.getWorker().contains(BidHouseManagementFrame)) && (this._bidHouseManagementFrame.switching))
               {
                  bidHouseSwitch = true;
               }
               this._interactionIsLimited = !cwiamsg.enabled;
               switch(cwiamsg.total)
               {
                  case true:
                     if(cwiamsg.enabled)
                     {
                        if((!Kernel.getWorker().contains(RoleplayWorldFrame)) && (!bidHouseSwitch) && (SystemApi.wordInteractionEnable))
                        {
                           _log.info("Enabling interaction with the roleplay world.");
                           Kernel.getWorker().addFrame(this._worldFrame);
                        }
                        this._worldFrame.cellClickEnabled = true;
                        this._worldFrame.allowOnlyCharacterInteraction = false;
                        this._worldFrame.pivotingCharacter = false;
                     }
                     else if(Kernel.getWorker().contains(RoleplayWorldFrame))
                     {
                        _log.info("Disabling interaction with the roleplay world.");
                        Kernel.getWorker().removeFrame(this._worldFrame);
                     }
                     
                     break;
                  case false:
                     if(cwiamsg.enabled)
                     {
                        if((!Kernel.getWorker().contains(RoleplayWorldFrame)) && (!bidHouseSwitch))
                        {
                           _log.info("Enabling total interaction with the roleplay world.");
                           Kernel.getWorker().addFrame(this._worldFrame);
                           this._worldFrame.cellClickEnabled = true;
                           this._worldFrame.allowOnlyCharacterInteraction = false;
                           this._worldFrame.pivotingCharacter = false;
                        }
                        if(!Kernel.getWorker().contains(RoleplayInteractivesFrame))
                        {
                           Kernel.getWorker().addFrame(this._interactivesFrame);
                        }
                     }
                     else if(Kernel.getWorker().contains(RoleplayWorldFrame))
                     {
                        _log.info("Disabling partial interactions with the roleplay world.");
                        this._worldFrame.allowOnlyCharacterInteraction = true;
                     }
                     
                     break;
               }
               stackFrame = Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame;
               if(!((!this._interactionIsLimited) && (!SystemApi.wordInteractionEnable)))
               {
                  stackFrame.paused = this._interactionIsLimited;
               }
               if((!stackFrame.paused) && (stackFrame.waitingMessage))
               {
                  this._worldFrame.process(stackFrame.waitingMessage);
                  stackFrame.waitingMessage = null;
               }
               return true;
            case msg is NpcGenericActionRequestAction:
               ngara = msg as NpcGenericActionRequestAction;
               playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               ngarmsg = new NpcGenericActionRequestMessage();
               ngarmsg.initNpcGenericActionRequestMessage(ngara.npcId,ngara.actionId,PlayedCharacterManager.getInstance().currentMap.mapId);
               if((playerEntity as IMovable).isMoving)
               {
                  (playerEntity as IMovable).stop();
                  this._movementFrame.setFollowingMessage(ngarmsg);
               }
               else
               {
                  ConnectionsHandler.getConnection().send(ngarmsg);
               }
               return true;
            case msg is ExchangeRequestOnTaxCollectorAction:
               erotca = msg as ExchangeRequestOnTaxCollectorAction;
               erotcmsg = new ExchangeRequestOnTaxCollectorMessage();
               erotcmsg.initExchangeRequestOnTaxCollectorMessage(erotca.taxCollectorId);
               playerEntity4 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if((playerEntity4 as IMovable).isMoving)
               {
                  this._movementFrame.setFollowingMessage(erotcmsg);
                  (playerEntity4 as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(erotcmsg);
               }
               return true;
            case msg is GameRolePlayTaxCollectorFightRequestAction:
               grptcfra = msg as GameRolePlayTaxCollectorFightRequestAction;
               grptcfrmsg = new GameRolePlayTaxCollectorFightRequestMessage();
               grptcfrmsg.initGameRolePlayTaxCollectorFightRequestMessage(grptcfra.taxCollectorId);
               ConnectionsHandler.getConnection().send(grptcfrmsg);
               return true;
            case msg is InteractiveElementActivationAction:
               ieaa = msg as InteractiveElementActivationAction;
               ieamsg = new InteractiveElementActivationMessage(ieaa.interactiveElement,ieaa.position,ieaa.skillInstanceId);
               Kernel.getWorker().process(ieamsg);
               return true;
            case msg is DisplayContextualMenuAction:
               dcma = msg as DisplayContextualMenuAction;
               entityInfo = this.entitiesFrame.getEntityInfos(dcma.playerId);
               if(entityInfo)
               {
                  menuResult = RoleplayManager.getInstance().displayCharacterContextualMenu(entityInfo);
               }
               return false;
            case msg is PivotCharacterAction:
               roleplayInteractivesFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               if((roleplayInteractivesFrame) && (!roleplayInteractivesFrame.usingInteractive))
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                  this._worldFrame.pivotingCharacter = true;
                  this._playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
                  StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onListenOrientation);
                  StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onClickOrientation);
               }
               return true;
            case msg is NpcGenericActionFailureMessage:
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.NpcDialogCreationFailure);
               return true;
            case msg is NpcDialogCreationMessage:
               ndcmsg = msg as NpcDialogCreationMessage;
               entityNpcLike = this._entitiesFrame.getEntityInfos(ndcmsg.npcId);
               if(!Kernel.getWorker().contains(NpcDialogFrame))
               {
                  Kernel.getWorker().addFrame(this._npcDialogFrame);
               }
               Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
               TooltipManager.hideAll();
               if(entityNpcLike is GameRolePlayNpcInformations)
               {
                  npcEntity = entityNpcLike as GameRolePlayNpcInformations;
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.NpcDialogCreation,ndcmsg.mapId,npcEntity.npcId,EntityLookAdapter.fromNetwork(npcEntity.look));
               }
               else if(entityNpcLike is GameRolePlayTaxCollectorInformations)
               {
                  ponyEntity = entityNpcLike as GameRolePlayTaxCollectorInformations;
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PonyDialogCreation,ndcmsg.mapId,ponyEntity.identification.firstNameId,ponyEntity.identification.lastNameId,EntityLookAdapter.fromNetwork(ponyEntity.look));
               }
               else if(entityNpcLike is GameRolePlayPrismInformations)
               {
                  prismEntity = entityNpcLike as GameRolePlayPrismInformations;
                  if(prismEntity.prism is AlliancePrismInformation)
                  {
                     allianceName = (prismEntity.prism as AlliancePrismInformation).alliance.allianceName;
                     if(allianceName == "#NONAME#")
                     {
                        allianceName = I18n.getUiText("ui.guild.noName");
                     }
                  }
                  else if(AllianceFrame.getInstance().hasAlliance)
                  {
                     allianceName = AllianceFrame.getInstance().alliance.allianceName;
                  }
                  
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PrismDialogCreation,ndcmsg.mapId,allianceName,EntityLookAdapter.fromNetwork(prismEntity.look));
               }
               else if(entityNpcLike is GameRolePlayPortalInformations)
               {
                  portalEntity = entityNpcLike as GameRolePlayPortalInformations;
                  area = Area.getAreaById(portalEntity.portal.areaId);
                  if(!area)
                  {
                     return true;
                  }
                  areaName = area.name;
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PortalDialogCreation,ndcmsg.mapId,areaName,EntityLookAdapter.fromNetwork(portalEntity.look));
               }
               
               
               
               return true;
            case msg is PortalUseRequestAction:
               pura = msg as PortalUseRequestAction;
               purmsg = new PortalUseRequestMessage();
               purmsg.initPortalUseRequestMessage(pura.portalId);
               ConnectionsHandler.getConnection().send(purmsg);
               return true;
            case msg is PortalDialogQuestionMessage:
               pdqmsg = msg as PortalDialogQuestionMessage;
               date = new Date();
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.PortalDialogQuestion,pdqmsg.availableUseLeft,pdqmsg.closeDate * 1000 - date.time);
               return true;
            case msg is GameContextDestroyMessage:
               TooltipManager.hide();
               Kernel.getWorker().removeFrame(this);
               return true;
            case msg is ExchangeStartedBidBuyerMessage:
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
               }
               this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_BUY);
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
               }
               this._bidHouseManagementFrame.processExchangeStartedBidBuyerMessage(msg as ExchangeStartedBidBuyerMessage);
               return true;
            case msg is ExchangeStartedBidSellerMessage:
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
               }
               this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_SELL);
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
               }
               this._bidHouseManagementFrame.processExchangeStartedBidSellerMessage(msg as ExchangeStartedBidSellerMessage);
               return true;
            case msg is ExchangeShowVendorTaxAction:
               esvtmsg = new ExchangeShowVendorTaxMessage();
               esvtmsg.initExchangeShowVendorTaxMessage();
               ConnectionsHandler.getConnection().send(esvtmsg);
               return true;
            case msg is ExchangeReplyTaxVendorMessage:
               ertvmsg = msg as ExchangeReplyTaxVendorMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeReplyTaxVendor,ertvmsg.totalTaxValue);
               return true;
            case msg is ExchangeRequestOnShopStockAction:
               erossa = msg as ExchangeOnHumanVendorRequestAction;
               ospmsg = new ExchangeRequestOnShopStockMessage();
               ospmsg.initExchangeRequestOnShopStockMessage();
               ConnectionsHandler.getConnection().send(ospmsg);
               return true;
            case msg is ExchangeOnHumanVendorRequestAction:
               eohvra = msg as ExchangeOnHumanVendorRequestAction;
               playerEntity3 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               eohvrmsg = new ExchangeOnHumanVendorRequestMessage();
               eohvrmsg.initExchangeOnHumanVendorRequestMessage(eohvra.humanVendorId,eohvra.humanVendorCell);
               if((playerEntity3 as IMovable).isMoving)
               {
                  this._movementFrame.setFollowingMessage(eohvrmsg);
                  (playerEntity3 as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(eohvrmsg);
               }
               return true;
            case msg is ExchangeStartOkHumanVendorMessage:
               esohvmsg = msg as ExchangeStartOkHumanVendorMessage;
               if(!Kernel.getWorker().contains(HumanVendorManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._humanVendorManagementFrame);
               }
               this._humanVendorManagementFrame.process(msg);
               return true;
            case msg is ExchangeShopStockStartedMessage:
               esostmsg = msg as ExchangeShopStockStartedMessage;
               if(!Kernel.getWorker().contains(HumanVendorManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._humanVendorManagementFrame);
               }
               this._humanVendorManagementFrame.process(msg);
               return true;
            case msg is ExchangeStartAsVendorRequestAction:
               entity = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id);
               if((entity) && (!DataMapProvider.getInstance().pointCanStop(entity.position.x,entity.position.y)))
               {
                  return true;
               }
               ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR);
               esavmsg = new ExchangeStartAsVendorMessage();
               esavmsg.initExchangeStartAsVendorMessage();
               ConnectionsHandler.getConnection().send(esavmsg);
               return true;
            case msg is ExpectedSocketClosureMessage:
               escmsg = msg as ExpectedSocketClosureMessage;
               if(escmsg.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR)
               {
                  Kernel.getWorker().process(new ResetGameAction());
                  return true;
               }
               return false;
            case msg is ExchangeStartedMountStockMessage:
               esmsmsg = ExchangeStartedMountStockMessage(msg);
               this.addCommonExchangeFrame(ExchangeTypeEnum.MOUNT);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               PlayedCharacterManager.getInstance().isInExchange = true;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeBankStarted,ExchangeTypeEnum.MOUNT,esmsmsg.objectsInfos,0);
               this._exchangeManagementFrame.initMountStock(esmsmsg.objectsInfos);
               return true;
            case msg is ExchangeRequestedTradeMessage:
               this.addCommonExchangeFrame(ExchangeTypeEnum.PLAYER_TRADE);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                  this._exchangeManagementFrame.processExchangeRequestedTradeMessage(msg as ExchangeRequestedTradeMessage);
               }
               return true;
            case msg is ExchangeStartOkNpcTradeMessage:
               this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_TRADE);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                  this._exchangeManagementFrame.processExchangeStartOkNpcTradeMessage(msg as ExchangeStartOkNpcTradeMessage);
               }
               return true;
            case msg is ExchangeStartOkNpcShopMessage:
               esonmsg = msg as ExchangeStartOkNpcShopMessage;
               this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_SHOP);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               this._exchangeManagementFrame.process(msg);
               return true;
            case msg is ExchangeStartedMessage:
               esmsg = msg as ExchangeStartedMessage;
               commonExchangeFrame = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(commonExchangeFrame)
               {
                  commonExchangeFrame.resetEchangeSequence();
               }
               switch(esmsg.exchangeType)
               {
                  case ExchangeTypeEnum.CRAFT:
                  case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                  case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                     this.addCraftFrame();
                     break;
                  case ExchangeTypeEnum.BIDHOUSE_BUY:
                  case ExchangeTypeEnum.BIDHOUSE_SELL:
                  case ExchangeTypeEnum.PLAYER_TRADE:
               }
               this.addCommonExchangeFrame(esmsg.exchangeType);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               this._exchangeManagementFrame.process(msg);
               return true;
            case msg is ExchangeOkMultiCraftMessage:
               this.addCraftFrame();
               this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
               this._craftFrame.processExchangeOkMultiCraftMessage(msg as ExchangeOkMultiCraftMessage);
               return true;
            case msg is ExchangeStartOkCraftWithInformationMessage:
               this.addCraftFrame();
               this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
               this._craftFrame.processExchangeStartOkCraftWithInformationMessage(msg as ExchangeStartOkCraftWithInformationMessage);
               return true;
            case msg is ObjectFoundWhileRecoltingMessage:
               ofwrm = msg as ObjectFoundWhileRecoltingMessage;
               itemFound = Item.getItemById(ofwrm.genericId);
               playerId = PlayedCharacterManager.getInstance().id;
               craftSmileyItem = new CraftSmileyItem(playerId,itemFound.iconId,2);
               if(DofusEntities.getEntity(playerId) as IDisplayable)
               {
                  absoluteBounds = (DofusEntities.getEntity(playerId) as IDisplayable).absoluteBounds;
                  TooltipManager.show(craftSmileyItem,absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"craftSmiley" + playerId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null);
               }
               quantity = ofwrm.quantity;
               itemName = ofwrm.genericId?Item.getItemById(ofwrm.genericId).name:I18n.getUiText("ui.common.kamas");
               ressourceName = Item.getItemById(ofwrm.ressourceGenericId).name;
               message = I18n.getUiText("ui.common.itemFound",[quantity,itemName,ressourceName]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,message,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is PlayerFightRequestAction:
               pfra = PlayerFightRequestAction(msg);
               if((!pfra.launch) && (!pfra.friendly))
               {
                  infos = this.entitiesFrame.getEntityInfos(pfra.targetedPlayerId) as GameRolePlayCharacterInformations;
                  if(infos)
                  {
                     if(pfra.ava)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer,pfra.targetedPlayerId,true,infos.name,fightType,pfra.cellId);
                        return true;
                     }
                     if(infos.alignmentInfos.alignmentSide == 0)
                     {
                        rcf = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                        playerInfo = rcf.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations;
                        if(!(playerInfo is GameRolePlayMutantInformations))
                        {
                           KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer,pfra.targetedPlayerId,false,infos.name,2,pfra.cellId);
                           return true;
                        }
                     }
                     targetPlayerLevel = infos.alignmentInfos.characterPower - pfra.targetedPlayerId;
                     fightType = PlayedCharacterManager.getInstance().levelDiff(targetPlayerLevel);
                     if(fightType)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer,pfra.targetedPlayerId,false,infos.name,fightType,pfra.cellId);
                        return true;
                     }
                  }
               }
               gppfrm = new GameRolePlayPlayerFightRequestMessage();
               gppfrm.initGameRolePlayPlayerFightRequestMessage(pfra.targetedPlayerId,pfra.cellId,pfra.friendly);
               playerEntity2 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if((playerEntity2 as IMovable).isMoving)
               {
                  this._movementFrame.setFollowingMessage(pfra);
                  (playerEntity2 as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(gppfrm);
               }
               return true;
            case msg is PlayerFightFriendlyAnswerAction:
               pffaa = PlayerFightFriendlyAnswerAction(msg);
               grppffam2 = new GameRolePlayPlayerFightFriendlyAnswerMessage();
               grppffam2.initGameRolePlayPlayerFightFriendlyAnswerMessage(this._currentWaitingFightId,pffaa.accept);
               grppffam2.accept = pffaa.accept;
               grppffam2.fightId = this._currentWaitingFightId;
               ConnectionsHandler.getConnection().send(grppffam2);
               return true;
            case msg is GameRolePlayPlayerFightFriendlyAnsweredMessage:
               grppffam = msg as GameRolePlayPlayerFightFriendlyAnsweredMessage;
               if(this._currentWaitingFightId == grppffam.fightId)
               {
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered,grppffam.accept);
               }
               return true;
            case msg is GameRolePlayFightRequestCanceledMessage:
               grpfrcm = msg as GameRolePlayFightRequestCanceledMessage;
               if(this._currentWaitingFightId == grpfrcm.fightId)
               {
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered,false);
               }
               return true;
            case msg is GameRolePlayPlayerFightFriendlyRequestedMessage:
               grppffrm = msg as GameRolePlayPlayerFightFriendlyRequestedMessage;
               this._currentWaitingFightId = grppffrm.fightId;
               if(grppffrm.sourceId != PlayedCharacterManager.getInstance().id)
               {
                  if(this._entitiesFrame.getEntityInfos(grppffrm.sourceId))
                  {
                     name = (this._entitiesFrame.getEntityInfos(grppffrm.sourceId) as GameRolePlayNamedActorInformations).name;
                  }
                  if(this.socialFrame.isIgnored(name))
                  {
                     return true;
                  }
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyRequested,name);
               }
               else
               {
                  gcai = this._entitiesFrame.getEntityInfos(grppffrm.targetId);
                  if(gcai)
                  {
                     KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightRequestSent,GameRolePlayNamedActorInformations(gcai).name,true);
                  }
               }
               return true;
            case msg is GameRolePlayFreeSoulRequestAction:
               grpfsrmmsg = new GameRolePlayFreeSoulRequestMessage();
               ConnectionsHandler.getConnection().send(grpfsrmmsg);
               return true;
            case msg is LeaveBidHouseAction:
               ldrbidHousemsg = new LeaveDialogRequestMessage();
               ldrbidHousemsg.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(ldrbidHousemsg);
               return true;
            case msg is ExchangeErrorMessage:
               ermsg = msg as ExchangeErrorMessage;
               channelId = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
               switch(ermsg.errorType)
               {
                  case ExchangeErrorEnum.REQUEST_CHARACTER_OCCUPIED:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterOccupied");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_TOOL_TOO_FAR:
                     errorMessage = I18n.getUiText("ui.craft.notNearCraftTable");
                     break;
                  case ExchangeErrorEnum.REQUEST_IMPOSSIBLE:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchange");
                     break;
                  case ExchangeErrorEnum.BID_SEARCH_ERROR:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeBIDSearchError");
                     break;
                  case ExchangeErrorEnum.BUY_ERROR:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeBuyError");
                     break;
                  case ExchangeErrorEnum.MOUNT_PADDOCK_ERROR:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeMountPaddockError");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_JOB_NOT_EQUIPED:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterJobNotEquiped");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_NOT_SUSCRIBER:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterNotSuscriber");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_OVERLOADED:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterOverloaded");
                     break;
                  case ExchangeErrorEnum.SELL_ERROR:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeSellError");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_RESTRICTED:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchangeCharacterRestricted");
                     channelId = ChatFrame.RED_CHANNEL_ID;
                     break;
                  default:
                     errorMessage = I18n.getUiText("ui.exchange.cantExchange");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorMessage,channelId,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeError,ermsg.errorType);
               return true;
            case msg is GameRolePlayAggressionMessage:
               grpamsg = msg as GameRolePlayAggressionMessage;
               message = I18n.getUiText("ui.pvp.aAttackB",[GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(grpamsg.attackerId)).name,GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(grpamsg.defenderId)).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,message,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               playerId = PlayedCharacterManager.getInstance().id;
               if(playerId == grpamsg.attackerId)
               {
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESS);
               }
               else if(playerId == grpamsg.defenderId)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.PlayerAggression,grpamsg.attackerId,GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(grpamsg.attackerId)).name);
                  if((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.ATTACK)))
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.ATTACK,[GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(grpamsg.attackerId)).name]);
                  }
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESSED);
               }
               
               return true;
            case msg is LeaveShopStockAction:
               ldrmsg = new LeaveDialogRequestMessage();
               ldrmsg.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(ldrmsg);
               return true;
            case msg is ExchangeShopStockMouvmentAddAction:
               essmaa = msg as ExchangeShopStockMouvmentAddAction;
               eompmsg = new ExchangeObjectMovePricedMessage();
               eompmsg.initExchangeObjectMovePricedMessage(essmaa.objectUID,essmaa.quantity,essmaa.price);
               ConnectionsHandler.getConnection().send(eompmsg);
               return true;
            case msg is ExchangeShopStockMouvmentRemoveAction:
               essmra = msg as ExchangeShopStockMouvmentRemoveAction;
               eommsg = new ExchangeObjectMoveMessage();
               eommsg.initExchangeObjectMoveMessage(essmra.objectUID,essmra.quantity);
               ConnectionsHandler.getConnection().send(eommsg);
               return true;
            case msg is ExchangeBuyAction:
               eba = msg as ExchangeBuyAction;
               ebmsg = new ExchangeBuyMessage();
               ebmsg.initExchangeBuyMessage(eba.objectUID,eba.quantity);
               ConnectionsHandler.getConnection().send(ebmsg);
               return true;
            case msg is ExchangeSellAction:
               esa = msg as ExchangeSellAction;
               eslmsg = new ExchangeSellMessage();
               eslmsg.initExchangeSellMessage(esa.objectUID,esa.quantity);
               ConnectionsHandler.getConnection().send(eslmsg);
               return true;
            case msg is ExchangeBuyOkMessage:
               ebomsg = msg as ExchangeBuyOkMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.BuyOk);
               return true;
            case msg is ExchangeSellOkMessage:
               esomsg = msg as ExchangeSellOkMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.SellOk);
               return true;
            case msg is ExchangePlayerRequestAction:
               epra = msg as ExchangePlayerRequestAction;
               eprmsg = new ExchangePlayerRequestMessage();
               eprmsg.initExchangePlayerRequestMessage(epra.exchangeType,epra.target);
               ConnectionsHandler.getConnection().send(eprmsg);
               return true;
            case msg is ExchangePlayerMultiCraftRequestAction:
               epmcra = msg as ExchangePlayerMultiCraftRequestAction;
               switch(epmcra.exchangeType)
               {
                  case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                     this._customerID = epmcra.target;
                     this._crafterId = PlayedCharacterManager.getInstance().id;
                     break;
                  case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                     this._crafterId = epmcra.target;
                     this._customerID = PlayedCharacterManager.getInstance().id;
                     break;
               }
               epmcrmsg = new ExchangePlayerMultiCraftRequestMessage();
               epmcrmsg.initExchangePlayerMultiCraftRequestMessage(epmcra.exchangeType,epmcra.target,epmcra.skillId);
               ConnectionsHandler.getConnection().send(epmcrmsg);
               return true;
            case msg is JobAllowMultiCraftRequestSetAction:
               jamcrsa = msg as JobAllowMultiCraftRequestSetAction;
               jamcrsmsg = new JobAllowMultiCraftRequestSetMessage();
               jamcrsmsg.initJobAllowMultiCraftRequestSetMessage(jamcrsa.isPublic);
               ConnectionsHandler.getConnection().send(jamcrsmsg);
               return true;
            case msg is JobAllowMultiCraftRequestMessage:
               jamcrmsg = msg as JobAllowMultiCraftRequestMessage;
               messId = (msg as JobAllowMultiCraftRequestMessage).getMessageId();
               switch(messId)
               {
                  case JobAllowMultiCraftRequestMessage.protocolId:
                     PlayedCharacterManager.getInstance().publicMode = jamcrmsg.enabled;
                     KernelEventsManager.getInstance().processCallback(CraftHookList.JobAllowMultiCraftRequest,jamcrmsg.enabled);
                     break;
                  case JobMultiCraftAvailableSkillsMessage.protocolId:
                     jmcasm = msg as JobMultiCraftAvailableSkillsMessage;
                     if(jmcasm.enabled)
                     {
                        mcefp = new MultiCraftEnableForPlayer();
                        mcefp.playerId = jmcasm.playerId;
                        mcefp.skills = jmcasm.skills;
                        alreadyIn = false;
                        for each(mcefplayer in this._playersMultiCraftSkill)
                        {
                           if(mcefplayer.playerId == mcefp.playerId)
                           {
                              alreadyIn = true;
                              mcefplayer.skills = jmcasm.skills;
                           }
                        }
                        if(!alreadyIn)
                        {
                           this._playersMultiCraftSkill.push(mcefp);
                        }
                     }
                     else
                     {
                        compt = 0;
                        index = -1;
                        compt = 0;
                        while(compt < this._playersMultiCraftSkill.length)
                        {
                           if(this._playersMultiCraftSkill[compt].playerId == jmcasm.playerId)
                           {
                              index = compt;
                           }
                           compt++;
                        }
                        if(index > -1)
                        {
                           this._playersMultiCraftSkill.splice(index,1);
                        }
                     }
                     break;
               }
               return true;
            case msg is SpellForgetUIMessage:
               sfuimsg = msg as SpellForgetUIMessage;
               if(sfuimsg.open)
               {
                  Kernel.getWorker().addFrame(this._spellForgetDialogFrame);
               }
               else
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this._spellForgetDialogFrame);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.SpellForgetUI,sfuimsg.open);
               return true;
            case msg is ChallengeFightJoinRefusedMessage:
               cfjrmsg = msg as ChallengeFightJoinRefusedMessage;
               switch(cfjrmsg.reason)
               {
                  case FighterRefusedReasonEnum.CHALLENGE_FULL:
                     message = I18n.getUiText("ui.fight.challengeFull");
                     break;
                  case FighterRefusedReasonEnum.TEAM_FULL:
                     message = I18n.getUiText("ui.fight.teamFull");
                     break;
                  case FighterRefusedReasonEnum.WRONG_ALIGNMENT:
                     message = I18n.getUiText("ui.wrongAlignment");
                     break;
                  case FighterRefusedReasonEnum.WRONG_GUILD:
                     message = I18n.getUiText("ui.fight.wrongGuild");
                     break;
                  case FighterRefusedReasonEnum.TOO_LATE:
                     message = I18n.getUiText("ui.fight.tooLate");
                     break;
                  case FighterRefusedReasonEnum.MUTANT_REFUSED:
                     message = I18n.getUiText("ui.fight.mutantRefused");
                     break;
                  case FighterRefusedReasonEnum.WRONG_MAP:
                     message = I18n.getUiText("ui.fight.wrongMap");
                     break;
                  case FighterRefusedReasonEnum.JUST_RESPAWNED:
                     message = I18n.getUiText("ui.fight.justRespawned");
                     break;
                  case FighterRefusedReasonEnum.IM_OCCUPIED:
                     message = I18n.getUiText("ui.fight.imOccupied");
                     break;
                  case FighterRefusedReasonEnum.OPPONENT_OCCUPIED:
                     message = I18n.getUiText("ui.fight.opponentOccupied");
                     break;
                  case FighterRefusedReasonEnum.MULTIACCOUNT_NOT_ALLOWED:
                     message = I18n.getUiText("ui.fight.onlyOneAllowedAccount");
                     break;
                  case FighterRefusedReasonEnum.INSUFFICIENT_RIGHTS:
                     message = I18n.getUiText("ui.fight.insufficientRights");
                     break;
                  case FighterRefusedReasonEnum.MEMBER_ACCOUNT_NEEDED:
                     message = I18n.getUiText("ui.fight.memberAccountNeeded");
                     break;
                  case FighterRefusedReasonEnum.OPPONENT_NOT_MEMBER:
                     message = I18n.getUiText("ui.fight.opponentNotMember");
                     break;
                  case FighterRefusedReasonEnum.TEAM_LIMITED_BY_MAINCHARACTER:
                     message = I18n.getUiText("ui.fight.teamLimitedByMainCharacter");
                     break;
                  case FighterRefusedReasonEnum.GHOST_REFUSED:
                     message = I18n.getUiText("ui.fight.ghostRefused");
                     break;
                  case FighterRefusedReasonEnum.AVA_ZONE:
                     message = I18n.getUiText("ui.fight.cantAttackAvAZone");
                     break;
                  case FighterRefusedReasonEnum.RESTRICTED_ACCOUNT:
                     message = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                     break;
                  default:
                     return true;
               }
               if(message != null)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,message,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is SpellForgottenMessage:
               sfmsg = msg as SpellForgottenMessage;
               return true;
            case msg is ExchangeCraftResultMessage:
               ecrmsg = msg as ExchangeCraftResultMessage;
               messageId = ecrmsg.getMessageId();
               if(messageId != ExchangeCraftInformationObjectMessage.protocolId)
               {
                  return false;
               }
               eciomsg = msg as ExchangeCraftInformationObjectMessage;
               switch(eciomsg.craftResult)
               {
                  case CraftResultEnum.CRAFT_SUCCESS:
                  case CraftResultEnum.CRAFT_FAILED:
                     item = Item.getItemById(eciomsg.objectGenericId);
                     iconId = item.iconId;
                     csi = new CraftSmileyItem(eciomsg.playerId,iconId,eciomsg.craftResult);
                     break;
                  case CraftResultEnum.CRAFT_IMPOSSIBLE:
                     csi = new CraftSmileyItem(eciomsg.playerId,-1,eciomsg.craftResult);
                     break;
               }
               if(DofusEntities.getEntity(eciomsg.playerId) as IDisplayable)
               {
                  absBounds = (DofusEntities.getEntity(eciomsg.playerId) as IDisplayable).absoluteBounds;
                  TooltipManager.show(csi,absBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"craftSmiley" + eciomsg.playerId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,null,false,-1);
               }
               return true;
            case msg is GameRolePlayDelayedActionMessage:
               grda = msg as GameRolePlayDelayedActionMessage;
               if(grda.delayTypeId == DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE)
               {
                  iconIdD = Item.getItemById(548).iconId;
                  csiD = new CraftSmileyItem(grda.delayedCharacterId,iconIdD,2);
                  absBoundsD = (DofusEntities.getEntity(grda.delayedCharacterId) as IDisplayable).absoluteBounds;
                  TooltipManager.show(csiD,absBoundsD,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"craftSmiley" + grda.delayedCharacterId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,null,false,-1);
               }
               return true;
            case msg is DocumentReadingBeginMessage:
               drbm = msg as DocumentReadingBeginMessage;
               TooltipManager.hideAll();
               if(!Kernel.getWorker().contains(DocumentFrame))
               {
                  Kernel.getWorker().addFrame(this._documentFrame);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.DocumentReadingBegin,drbm.documentId);
               return true;
         }
      }
      
      public function pulled() : Boolean {
         var allianceFrame:AllianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         allianceFrame.pullRoleplay();
         this._interactivesFrame.clear();
         Kernel.getWorker().removeFrame(this._entitiesFrame);
         Kernel.getWorker().removeFrame(this._delayedActionFrame);
         Kernel.getWorker().removeFrame(this._worldFrame);
         Kernel.getWorker().removeFrame(this._movementFrame);
         Kernel.getWorker().removeFrame(this._interactivesFrame);
         Kernel.getWorker().removeFrame(this._spectatorManagementFrame);
         Kernel.getWorker().removeFrame(this._npcDialogFrame);
         Kernel.getWorker().removeFrame(this._documentFrame);
         Kernel.getWorker().removeFrame(this._zaapFrame);
         Kernel.getWorker().removeFrame(this._paddockFrame);
         return true;
      }
      
      public function getActorName(actorId:int) : String {
         var actorInfos:GameRolePlayActorInformations = null;
         var tcInfos:GameRolePlayTaxCollectorInformations = null;
         actorInfos = this.getActorInfos(actorId);
         if(!actorInfos)
         {
            return "Unknown Actor";
         }
         switch(true)
         {
            case actorInfos is GameRolePlayNamedActorInformations:
               return (actorInfos as GameRolePlayNamedActorInformations).name;
            case actorInfos is GameRolePlayTaxCollectorInformations:
               tcInfos = actorInfos as GameRolePlayTaxCollectorInformations;
               return TaxCollectorFirstname.getTaxCollectorFirstnameById(tcInfos.identification.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcInfos.identification.lastNameId).name;
            case actorInfos is GameRolePlayNpcInformations:
               return Npc.getNpcById((actorInfos as GameRolePlayNpcInformations).npcId).name;
            case actorInfos is GameRolePlayGroupMonsterInformations:
            case actorInfos is GameRolePlayPrismInformations:
            case actorInfos is GameRolePlayPortalInformations:
               _log.error("Fail: getActorName called with an actorId corresponding to a monsters group or a prism or a portal (" + actorInfos + ").");
               return "<error: cannot get a name>";
            default:
               return "Unknown Actor Type";
         }
      }
      
      private function getActorInfos(actorId:int) : GameRolePlayActorInformations {
         return this.entitiesFrame.getEntityInfos(actorId) as GameRolePlayActorInformations;
      }
      
      private function executeSpellBuffer(callback:Function, hadScript:Boolean, scriptSuccess:Boolean = false, castProvider:RoleplaySpellCastProvider = null) : void {
         var step:ISequencable = null;
         var ss:SerialSequencer = new SerialSequencer();
         for each(step in castProvider.stepsBuffer)
         {
            ss.addStep(step);
         }
         ss.start();
      }
      
      private function addCraftFrame() : void {
         if(!Kernel.getWorker().contains(CraftFrame))
         {
            Kernel.getWorker().addFrame(this._craftFrame);
         }
      }
      
      private function addCommonExchangeFrame(pExchangeType:uint) : void {
         if(!Kernel.getWorker().contains(CommonExchangeManagementFrame))
         {
            this._commonExchangeFrame = new CommonExchangeManagementFrame(pExchangeType);
            Kernel.getWorker().addFrame(this._commonExchangeFrame);
         }
      }
      
      private function onListenOrientation(e:MouseEvent) : void {
         var point:Point = this._playerEntity.localToGlobal(new Point(0,0));
         var difY:Number = StageShareManager.stage.mouseY - point.y;
         var difX:Number = StageShareManager.stage.mouseX - point.x;
         var orientation:uint = AngleToOrientation.angleToOrientation(Math.atan2(difY,difX));
         var animation:String = this._playerEntity.getAnimation();
         var currentEmoticon:Emoticon = Emoticon.getEmoticonById(this._entitiesFrame.currentEmoticon);
         if((!currentEmoticon) || (currentEmoticon) && (currentEmoticon.eight_directions))
         {
            this._playerEntity.setDirection(orientation);
         }
         else if(orientation % 2 == 0)
         {
            this._playerEntity.setDirection(orientation + 1);
         }
         else
         {
            this._playerEntity.setDirection(orientation);
         }
         
      }
      
      private function onClickOrientation(e:MouseEvent) : void {
         Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onListenOrientation);
         StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onClickOrientation);
         var animation:String = this._playerEntity.getAnimation();
         var gmcormsg:GameMapChangeOrientationRequestMessage = new GameMapChangeOrientationRequestMessage();
         gmcormsg.initGameMapChangeOrientationRequestMessage(this._playerEntity.getDirection());
         ConnectionsHandler.getConnection().send(gmcormsg);
      }
      
      public function getMultiCraftSkills(pPlayerId:uint) : Vector.<uint> {
         var mcefp:MultiCraftEnableForPlayer = null;
         for each(mcefp in this._playersMultiCraftSkill)
         {
            if(mcefp.playerId == pPlayerId)
            {
               return mcefp.skills;
            }
         }
         return null;
      }
   }
}
class MultiCraftEnableForPlayer extends Object
{
   
   function MultiCraftEnableForPlayer() {
      super();
   }
   
   public var playerId:uint;
   
   public var skills:Vector.<uint>;
}

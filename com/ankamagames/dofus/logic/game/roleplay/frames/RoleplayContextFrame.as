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
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
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
   import __AS3__.vec.Vector;
   
   public class RoleplayContextFrame extends Object implements Frame
   {
      
      public function RoleplayContextFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayContextFrame));
      
      private static const ASTRUB_SUBAREA_IDS:Array = [143,92,95,96,97,98,99,100,101,173,318,306];
      
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
      
      public function set priority(param1:int) : void {
         this._priority = param1;
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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:CurrentMapMessage = null;
         var _loc3_:SubArea = null;
         var _loc4_:WorldPointWrapper = null;
         var _loc5_:ByteArray = null;
         var _loc6_:Object = null;
         var _loc7_:MapPosition = null;
         var _loc8_:ChangeWorldInteractionAction = null;
         var _loc9_:* = false;
         var _loc10_:StackManagementFrame = null;
         var _loc11_:NpcGenericActionRequestAction = null;
         var _loc12_:IEntity = null;
         var _loc13_:NpcGenericActionRequestMessage = null;
         var _loc14_:ExchangeRequestOnTaxCollectorAction = null;
         var _loc15_:ExchangeRequestOnTaxCollectorMessage = null;
         var _loc16_:IEntity = null;
         var _loc17_:GameRolePlayTaxCollectorFightRequestAction = null;
         var _loc18_:GameRolePlayTaxCollectorFightRequestMessage = null;
         var _loc19_:InteractiveElementActivationAction = null;
         var _loc20_:InteractiveElementActivationMessage = null;
         var _loc21_:DisplayContextualMenuAction = null;
         var _loc22_:GameContextActorInformations = null;
         var _loc23_:RoleplayInteractivesFrame = null;
         var _loc24_:NpcDialogCreationMessage = null;
         var _loc25_:Object = null;
         var _loc26_:ExchangeShowVendorTaxMessage = null;
         var _loc27_:ExchangeReplyTaxVendorMessage = null;
         var _loc28_:ExchangeOnHumanVendorRequestAction = null;
         var _loc29_:ExchangeRequestOnShopStockMessage = null;
         var _loc30_:ExchangeOnHumanVendorRequestAction = null;
         var _loc31_:IEntity = null;
         var _loc32_:ExchangeOnHumanVendorRequestMessage = null;
         var _loc33_:ExchangeStartOkHumanVendorMessage = null;
         var _loc34_:ExchangeShopStockStartedMessage = null;
         var _loc35_:IEntity = null;
         var _loc36_:ExchangeStartAsVendorMessage = null;
         var _loc37_:ExpectedSocketClosureMessage = null;
         var _loc38_:ExchangeStartedMountStockMessage = null;
         var _loc39_:ExchangeStartOkNpcShopMessage = null;
         var _loc40_:ExchangeStartedMessage = null;
         var _loc41_:CommonExchangeManagementFrame = null;
         var _loc42_:ObjectFoundWhileRecoltingMessage = null;
         var _loc43_:Item = null;
         var _loc44_:uint = 0;
         var _loc45_:CraftSmileyItem = null;
         var _loc46_:uint = 0;
         var _loc47_:String = null;
         var _loc48_:String = null;
         var _loc49_:String = null;
         var _loc50_:PlayerFightRequestAction = null;
         var _loc51_:GameRolePlayPlayerFightRequestMessage = null;
         var _loc52_:IEntity = null;
         var _loc53_:PlayerFightFriendlyAnswerAction = null;
         var _loc54_:GameRolePlayPlayerFightFriendlyAnswerMessage = null;
         var _loc55_:GameRolePlayPlayerFightFriendlyAnsweredMessage = null;
         var _loc56_:GameRolePlayFightRequestCanceledMessage = null;
         var _loc57_:GameRolePlayPlayerFightFriendlyRequestedMessage = null;
         var _loc58_:GameRolePlayFreeSoulRequestMessage = null;
         var _loc59_:LeaveDialogRequestMessage = null;
         var _loc60_:ExchangeErrorMessage = null;
         var _loc61_:String = null;
         var _loc62_:uint = 0;
         var _loc63_:GameRolePlayAggressionMessage = null;
         var _loc64_:LeaveDialogRequestMessage = null;
         var _loc65_:ExchangeShopStockMouvmentAddAction = null;
         var _loc66_:ExchangeObjectMovePricedMessage = null;
         var _loc67_:ExchangeShopStockMouvmentRemoveAction = null;
         var _loc68_:ExchangeObjectMoveMessage = null;
         var _loc69_:ExchangeBuyAction = null;
         var _loc70_:ExchangeBuyMessage = null;
         var _loc71_:ExchangeSellAction = null;
         var _loc72_:ExchangeSellMessage = null;
         var _loc73_:ExchangeBuyOkMessage = null;
         var _loc74_:ExchangeSellOkMessage = null;
         var _loc75_:ExchangePlayerRequestAction = null;
         var _loc76_:ExchangePlayerRequestMessage = null;
         var _loc77_:ExchangePlayerMultiCraftRequestAction = null;
         var _loc78_:ExchangePlayerMultiCraftRequestMessage = null;
         var _loc79_:JobAllowMultiCraftRequestSetAction = null;
         var _loc80_:JobAllowMultiCraftRequestSetMessage = null;
         var _loc81_:JobAllowMultiCraftRequestMessage = null;
         var _loc82_:uint = 0;
         var _loc83_:SpellForgetUIMessage = null;
         var _loc84_:ChallengeFightJoinRefusedMessage = null;
         var _loc85_:SpellForgottenMessage = null;
         var _loc86_:ExchangeCraftResultMessage = null;
         var _loc87_:uint = 0;
         var _loc88_:ExchangeCraftInformationObjectMessage = null;
         var _loc89_:CraftSmileyItem = null;
         var _loc90_:GameRolePlayDelayedActionMessage = null;
         var _loc91_:DocumentReadingBeginMessage = null;
         var _loc92_:PaddockSellBuyDialogMessage = null;
         var _loc93_:LeaveDialogRequestMessage = null;
         var _loc94_:GameRolePlaySpellAnimMessage = null;
         var _loc95_:RoleplaySpellCastProvider = null;
         var _loc96_:SpellFxRunner = null;
         var _loc97_:BasicSwitchModeAction = null;
         var _loc98_:String = null;
         var _loc99_:Object = null;
         var _loc100_:ErrorMapNotFoundMessage = null;
         var _loc101_:* = 0;
         var _loc102_:* = 0;
         var _loc103_:* = 0;
         var _loc104_:Map = null;
         var _loc105_:* = false;
         var _loc106_:GameRolePlayNpcInformations = null;
         var _loc107_:GameRolePlayTaxCollectorInformations = null;
         var _loc108_:GameRolePlayPrismInformations = null;
         var _loc109_:String = null;
         var _loc110_:IRectangle = null;
         var _loc111_:GameRolePlayCharacterInformations = null;
         var _loc112_:* = 0;
         var _loc113_:* = 0;
         var _loc114_:RoleplayContextFrame = null;
         var _loc115_:GameRolePlayActorInformations = null;
         var _loc116_:String = null;
         var _loc117_:GameContextActorInformations = null;
         var _loc118_:JobMultiCraftAvailableSkillsMessage = null;
         var _loc119_:MultiCraftEnableForPlayer = null;
         var _loc120_:* = false;
         var _loc121_:MultiCraftEnableForPlayer = null;
         var _loc122_:uint = 0;
         var _loc123_:* = 0;
         var _loc124_:Item = null;
         var _loc125_:uint = 0;
         var _loc126_:IRectangle = null;
         var _loc127_:CraftSmileyItem = null;
         var _loc128_:uint = 0;
         var _loc129_:IRectangle = null;
         var _loc130_:BasicSetAwayModeRequestMessage = null;
         switch(true)
         {
            case param1 is CurrentMapMessage:
               _loc2_ = param1 as CurrentMapMessage;
               _loc3_ = SubArea.getSubAreaByMapId(_loc2_.mapId);
               PlayedCharacterManager.getInstance().currentSubArea = _loc3_;
               Kernel.getWorker().pause(null,[SystemMessageDisplayMessage]);
               ConnectionsHandler.pause();
               if(TacticModeManager.getInstance().tacticModeActivated)
               {
                  TacticModeManager.getInstance().hide();
               }
               KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
               Atouin.getInstance().initPreDisplay(_loc4_);
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
                  _loc4_ = new WorldPointWrapper(_loc2_.mapId,true,PlayedCharacterManager.getInstance().currentMap.outdoorX,PlayedCharacterManager.getInstance().currentMap.outdoorY);
               }
               else
               {
                  _loc4_ = new WorldPointWrapper(_loc2_.mapId);
               }
               PlayedCharacterManager.getInstance().currentMap = _loc4_;
               Atouin.getInstance().clearEntities();
               if((_loc2_.mapKey) && (_loc2_.mapKey.length))
               {
                  _loc98_ = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                  if(!_loc98_)
                  {
                     _loc98_ = _loc2_.mapKey;
                  }
                  _loc5_ = Hex.toArray(Hex.fromString(_loc98_));
               }
               Atouin.getInstance().display(_loc4_,_loc5_);
               TooltipManager.hideAll();
               _loc6_ = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
               _loc6_.closeAllMenu();
               this._currentPaddock = null;
               _loc7_ = MapPosition.getMapPositionById(_loc2_.mapId);
               if((_loc7_) && !(ASTRUB_SUBAREA_IDS.indexOf(_loc7_.subAreaId) == -1))
               {
                  PartManager.getInstance().checkAndDownload("all");
               }
               KernelEventsManager.getInstance().processCallback(HookList.CurrentMap,_loc2_.mapId);
               return true;
            case param1 is MapsLoadingCompleteMessage:
               if(!Kernel.getWorker().contains(RoleplayEntitiesFrame))
               {
                  Kernel.getWorker().addFrame(this._entitiesFrame);
               }
               TooltipManager.hideAll();
               KernelEventsManager.getInstance().processCallback(HookList.MapsLoadingComplete,MapsLoadingCompleteMessage(param1).mapPoint);
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
               SoundManager.getInstance().manager.setSubArea(MapsLoadingCompleteMessage(param1).mapData);
               Atouin.getInstance().updateCursor();
               Kernel.getWorker().resume();
               Kernel.getWorker().clearUnstoppableMsgClassList();
               ConnectionsHandler.resume();
               return true;
            case param1 is MapLoadingFailedMessage:
               switch(MapLoadingFailedMessage(param1).errorReason)
               {
                  case MapLoadingFailedMessage.NO_FILE:
                     _loc99_ = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                     _loc99_.openPopup(I18n.getUiText("ui.popup.information"),I18n.getUiText("ui.popup.noMapdataFile"),[I18n.getUiText("ui.common.ok")]);
                     _loc100_ = new ErrorMapNotFoundMessage();
                     _loc100_.initErrorMapNotFoundMessage(MapLoadingFailedMessage(param1).id);
                     ConnectionsHandler.getConnection().send(_loc100_);
                     MapDisplayManager.getInstance().fromMap(new DefaultMap(MapLoadingFailedMessage(param1).id));
                     return true;
                  default:
                     return false;
               }
            case param1 is MapLoadedMessage:
               if(MapDisplayManager.getInstance().isDefaultMap)
               {
                  _loc101_ = PlayedCharacterManager.getInstance().currentMap.x;
                  _loc102_ = PlayedCharacterManager.getInstance().currentMap.y;
                  _loc103_ = PlayedCharacterManager.getInstance().currentMap.worldId;
                  _loc104_ = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
                  _loc104_.rightNeighbourId = WorldPoint.fromCoords(_loc103_,_loc101_ + 1,_loc102_).mapId;
                  _loc104_.leftNeighbourId = WorldPoint.fromCoords(_loc103_,_loc101_-1,_loc102_).mapId;
                  _loc104_.bottomNeighbourId = WorldPoint.fromCoords(_loc103_,_loc101_,_loc102_ + 1).mapId;
                  _loc104_.topNeighbourId = WorldPoint.fromCoords(_loc103_,_loc101_,_loc102_-1).mapId;
               }
               return true;
            case param1 is ChangeWorldInteractionAction:
               _loc8_ = param1 as ChangeWorldInteractionAction;
               _loc9_ = false;
               if((Kernel.getWorker().contains(BidHouseManagementFrame)) && (this._bidHouseManagementFrame.switching))
               {
                  _loc9_ = true;
               }
               this._interactionIsLimited = !_loc8_.enabled;
               switch(_loc8_.total)
               {
                  case true:
                     if(_loc8_.enabled)
                     {
                        if(!Kernel.getWorker().contains(RoleplayWorldFrame) && !_loc9_ && (SystemApi.wordInteractionEnable))
                        {
                           _log.info("Enabling interaction with the roleplay world.");
                           Kernel.getWorker().addFrame(this._worldFrame);
                        }
                        this._worldFrame.cellClickEnabled = true;
                        this._worldFrame.allowOnlyCharacterInteraction = false;
                        this._worldFrame.pivotingCharacter = false;
                     }
                     else
                     {
                        if(Kernel.getWorker().contains(RoleplayWorldFrame))
                        {
                           _log.info("Disabling interaction with the roleplay world.");
                           Kernel.getWorker().removeFrame(this._worldFrame);
                        }
                     }
                     break;
                  case false:
                     if(_loc8_.enabled)
                     {
                        if(!Kernel.getWorker().contains(RoleplayWorldFrame) && !_loc9_)
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
                     else
                     {
                        if(Kernel.getWorker().contains(RoleplayWorldFrame))
                        {
                           _log.info("Disabling partial interactions with the roleplay world.");
                           this._worldFrame.allowOnlyCharacterInteraction = true;
                        }
                     }
                     break;
               }
               _loc10_ = Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame;
               if(!(!this._interactionIsLimited && !SystemApi.wordInteractionEnable))
               {
                  _loc10_.paused = this._interactionIsLimited;
               }
               if(!_loc10_.paused && (_loc10_.waitingMessage))
               {
                  this._worldFrame.process(_loc10_.waitingMessage);
                  _loc10_.waitingMessage = null;
               }
               return true;
            case param1 is NpcGenericActionRequestAction:
               _loc11_ = param1 as NpcGenericActionRequestAction;
               _loc12_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               _loc13_ = new NpcGenericActionRequestMessage();
               _loc13_.initNpcGenericActionRequestMessage(_loc11_.npcId,_loc11_.actionId,PlayedCharacterManager.getInstance().currentMap.mapId);
               if((_loc12_ as IMovable).isMoving)
               {
                  (_loc12_ as IMovable).stop();
                  this._movementFrame.setFollowingMessage(_loc13_);
               }
               else
               {
                  ConnectionsHandler.getConnection().send(_loc13_);
               }
               return true;
            case param1 is ExchangeRequestOnTaxCollectorAction:
               _loc14_ = param1 as ExchangeRequestOnTaxCollectorAction;
               _loc15_ = new ExchangeRequestOnTaxCollectorMessage();
               _loc15_.initExchangeRequestOnTaxCollectorMessage(_loc14_.taxCollectorId);
               _loc16_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if((_loc16_ as IMovable).isMoving)
               {
                  this._movementFrame.setFollowingMessage(_loc15_);
                  (_loc16_ as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(_loc15_);
               }
               return true;
            case param1 is GameRolePlayTaxCollectorFightRequestAction:
               _loc17_ = param1 as GameRolePlayTaxCollectorFightRequestAction;
               _loc18_ = new GameRolePlayTaxCollectorFightRequestMessage();
               _loc18_.initGameRolePlayTaxCollectorFightRequestMessage(_loc17_.taxCollectorId);
               ConnectionsHandler.getConnection().send(_loc18_);
               return true;
            case param1 is InteractiveElementActivationAction:
               _loc19_ = param1 as InteractiveElementActivationAction;
               _loc20_ = new InteractiveElementActivationMessage(_loc19_.interactiveElement,_loc19_.position,_loc19_.skillInstanceId);
               Kernel.getWorker().process(_loc20_);
               return true;
            case param1 is DisplayContextualMenuAction:
               _loc21_ = param1 as DisplayContextualMenuAction;
               _loc22_ = this.entitiesFrame.getEntityInfos(_loc21_.playerId);
               if(_loc22_)
               {
                  _loc105_ = RoleplayManager.getInstance().displayCharacterContextualMenu(_loc22_);
               }
               return false;
            case param1 is PivotCharacterAction:
               _loc23_ = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               if((_loc23_) && !_loc23_.usingInteractive)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                  this._worldFrame.pivotingCharacter = true;
                  this._playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
                  StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onListenOrientation);
                  StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onClickOrientation);
               }
               return true;
            case param1 is NpcGenericActionFailureMessage:
               KernelEventsManager.getInstance().processCallback(HookList.NpcDialogCreationFailure);
               return true;
            case param1 is NpcDialogCreationMessage:
               _loc24_ = param1 as NpcDialogCreationMessage;
               _loc25_ = this._entitiesFrame.getEntityInfos(_loc24_.npcId);
               if(!Kernel.getWorker().contains(NpcDialogFrame))
               {
                  Kernel.getWorker().addFrame(this._npcDialogFrame);
               }
               Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
               TooltipManager.hideAll();
               if(_loc25_ is GameRolePlayNpcInformations)
               {
                  _loc106_ = _loc25_ as GameRolePlayNpcInformations;
                  KernelEventsManager.getInstance().processCallback(HookList.NpcDialogCreation,_loc24_.mapId,_loc106_.npcId,EntityLookAdapter.fromNetwork(_loc106_.look));
               }
               else
               {
                  if(_loc25_ is GameRolePlayTaxCollectorInformations)
                  {
                     _loc107_ = _loc25_ as GameRolePlayTaxCollectorInformations;
                     KernelEventsManager.getInstance().processCallback(HookList.PonyDialogCreation,_loc24_.mapId,_loc107_.identification.firstNameId,_loc107_.identification.lastNameId,EntityLookAdapter.fromNetwork(_loc107_.look));
                  }
                  else
                  {
                     if(_loc25_ is GameRolePlayPrismInformations)
                     {
                        _loc108_ = _loc25_ as GameRolePlayPrismInformations;
                        if(_loc108_.prism is AlliancePrismInformation)
                        {
                           _loc109_ = (_loc108_.prism as AlliancePrismInformation).alliance.allianceName;
                           if(_loc109_ == "#NONAME#")
                           {
                              _loc109_ = I18n.getUiText("ui.guild.noName");
                           }
                        }
                        else
                        {
                           if(AllianceFrame.getInstance().hasAlliance)
                           {
                              _loc109_ = AllianceFrame.getInstance().alliance.allianceName;
                           }
                        }
                        KernelEventsManager.getInstance().processCallback(HookList.PrismDialogCreation,_loc24_.mapId,_loc109_,EntityLookAdapter.fromNetwork(_loc108_.look));
                     }
                  }
               }
               return true;
            case param1 is GameContextDestroyMessage:
               TooltipManager.hide();
               Kernel.getWorker().removeFrame(this);
               return true;
            case param1 is ExchangeStartedBidBuyerMessage:
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
               }
               this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_BUY);
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
               }
               this._bidHouseManagementFrame.processExchangeStartedBidBuyerMessage(param1 as ExchangeStartedBidBuyerMessage);
               return true;
            case param1 is ExchangeStartedBidSellerMessage:
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
               }
               this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_SELL);
               if(!Kernel.getWorker().contains(BidHouseManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
               }
               this._bidHouseManagementFrame.processExchangeStartedBidSellerMessage(param1 as ExchangeStartedBidSellerMessage);
               return true;
            case param1 is ExchangeShowVendorTaxAction:
               _loc26_ = new ExchangeShowVendorTaxMessage();
               _loc26_.initExchangeShowVendorTaxMessage();
               ConnectionsHandler.getConnection().send(_loc26_);
               return true;
            case param1 is ExchangeReplyTaxVendorMessage:
               _loc27_ = param1 as ExchangeReplyTaxVendorMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeReplyTaxVendor,_loc27_.totalTaxValue);
               return true;
            case param1 is ExchangeRequestOnShopStockAction:
               _loc28_ = param1 as ExchangeOnHumanVendorRequestAction;
               _loc29_ = new ExchangeRequestOnShopStockMessage();
               _loc29_.initExchangeRequestOnShopStockMessage();
               ConnectionsHandler.getConnection().send(_loc29_);
               return true;
            case param1 is ExchangeOnHumanVendorRequestAction:
               _loc30_ = param1 as ExchangeOnHumanVendorRequestAction;
               _loc31_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               _loc32_ = new ExchangeOnHumanVendorRequestMessage();
               _loc32_.initExchangeOnHumanVendorRequestMessage(_loc30_.humanVendorId,_loc30_.humanVendorCell);
               if((_loc31_ as IMovable).isMoving)
               {
                  this._movementFrame.setFollowingMessage(_loc32_);
                  (_loc31_ as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(_loc32_);
               }
               return true;
            case param1 is ExchangeStartOkHumanVendorMessage:
               _loc33_ = param1 as ExchangeStartOkHumanVendorMessage;
               if(!Kernel.getWorker().contains(HumanVendorManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._humanVendorManagementFrame);
               }
               this._humanVendorManagementFrame.process(param1);
               return true;
            case param1 is ExchangeShopStockStartedMessage:
               _loc34_ = param1 as ExchangeShopStockStartedMessage;
               if(!Kernel.getWorker().contains(HumanVendorManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._humanVendorManagementFrame);
               }
               this._humanVendorManagementFrame.process(param1);
               return true;
            case param1 is ExchangeStartAsVendorRequestAction:
               _loc35_ = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id);
               if((_loc35_) && !DataMapProvider.getInstance().pointCanStop(_loc35_.position.x,_loc35_.position.y))
               {
                  return true;
               }
               ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR);
               _loc36_ = new ExchangeStartAsVendorMessage();
               _loc36_.initExchangeStartAsVendorMessage();
               ConnectionsHandler.getConnection().send(_loc36_);
               return true;
            case param1 is ExpectedSocketClosureMessage:
               _loc37_ = param1 as ExpectedSocketClosureMessage;
               if(_loc37_.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR)
               {
                  Kernel.getWorker().process(new ResetGameAction());
                  return true;
               }
               return false;
            case param1 is ExchangeStartedMountStockMessage:
               _loc38_ = ExchangeStartedMountStockMessage(param1);
               this.addCommonExchangeFrame(ExchangeTypeEnum.MOUNT);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               PlayedCharacterManager.getInstance().isInExchange = true;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeBankStarted,ExchangeTypeEnum.MOUNT,_loc38_.objectsInfos,0);
               this._exchangeManagementFrame.initMountStock(_loc38_.objectsInfos);
               return true;
            case param1 is ExchangeRequestedTradeMessage:
               this.addCommonExchangeFrame(ExchangeTypeEnum.PLAYER_TRADE);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                  this._exchangeManagementFrame.processExchangeRequestedTradeMessage(param1 as ExchangeRequestedTradeMessage);
               }
               return true;
            case param1 is ExchangeStartOkNpcTradeMessage:
               this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_TRADE);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                  this._exchangeManagementFrame.processExchangeStartOkNpcTradeMessage(param1 as ExchangeStartOkNpcTradeMessage);
               }
               return true;
            case param1 is ExchangeStartOkNpcShopMessage:
               _loc39_ = param1 as ExchangeStartOkNpcShopMessage;
               this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_SHOP);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               this._exchangeManagementFrame.process(param1);
               return true;
            case param1 is ExchangeStartedMessage:
               _loc40_ = param1 as ExchangeStartedMessage;
               _loc41_ = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(_loc41_)
               {
                  _loc41_.resetEchangeSequence();
               }
               switch(_loc40_.exchangeType)
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
               this.addCommonExchangeFrame(_loc40_.exchangeType);
               if(!Kernel.getWorker().contains(ExchangeManagementFrame))
               {
                  Kernel.getWorker().addFrame(this._exchangeManagementFrame);
               }
               this._exchangeManagementFrame.process(param1);
               return true;
            case param1 is ExchangeOkMultiCraftMessage:
               this.addCraftFrame();
               this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
               this._craftFrame.processExchangeOkMultiCraftMessage(param1 as ExchangeOkMultiCraftMessage);
               return true;
            case param1 is ExchangeStartOkCraftWithInformationMessage:
               this.addCraftFrame();
               this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
               this._craftFrame.processExchangeStartOkCraftWithInformationMessage(param1 as ExchangeStartOkCraftWithInformationMessage);
               return true;
            case param1 is ObjectFoundWhileRecoltingMessage:
               _loc42_ = param1 as ObjectFoundWhileRecoltingMessage;
               _loc43_ = Item.getItemById(_loc42_.genericId);
               _loc44_ = PlayedCharacterManager.getInstance().id;
               _loc45_ = new CraftSmileyItem(_loc44_,_loc43_.iconId,2);
               if(DofusEntities.getEntity(_loc44_) as IDisplayable)
               {
                  _loc110_ = (DofusEntities.getEntity(_loc44_) as IDisplayable).absoluteBounds;
                  TooltipManager.show(_loc45_,_loc110_,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"craftSmiley" + _loc44_,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null);
               }
               _loc46_ = _loc42_.quantity;
               _loc47_ = _loc42_.genericId?Item.getItemById(_loc42_.genericId).name:I18n.getUiText("ui.common.kamas");
               _loc48_ = Item.getItemById(_loc42_.ressourceGenericId).name;
               _loc49_ = I18n.getUiText("ui.common.itemFound",[_loc46_,_loc47_,_loc48_]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc49_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is PlayerFightRequestAction:
               _loc50_ = PlayerFightRequestAction(param1);
               if(!_loc50_.launch && !_loc50_.friendly)
               {
                  _loc111_ = this.entitiesFrame.getEntityInfos(_loc50_.targetedPlayerId) as GameRolePlayCharacterInformations;
                  if(_loc111_)
                  {
                     if(_loc50_.ava)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer,_loc50_.targetedPlayerId,true,_loc111_.name,_loc113_,_loc50_.cellId);
                        return true;
                     }
                     if(_loc111_.alignmentInfos.alignmentSide == 0)
                     {
                        _loc114_ = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                        _loc115_ = _loc114_.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations;
                        if(!(_loc115_ is GameRolePlayMutantInformations))
                        {
                           KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer,_loc50_.targetedPlayerId,false,_loc111_.name,2,_loc50_.cellId);
                           return true;
                        }
                     }
                     _loc112_ = _loc111_.alignmentInfos.characterPower - _loc50_.targetedPlayerId;
                     _loc113_ = PlayedCharacterManager.getInstance().levelDiff(_loc112_);
                     if(_loc113_)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer,_loc50_.targetedPlayerId,false,_loc111_.name,_loc113_,_loc50_.cellId);
                        return true;
                     }
                  }
               }
               _loc51_ = new GameRolePlayPlayerFightRequestMessage();
               _loc51_.initGameRolePlayPlayerFightRequestMessage(_loc50_.targetedPlayerId,_loc50_.cellId,_loc50_.friendly);
               _loc52_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if((_loc52_ as IMovable).isMoving)
               {
                  this._movementFrame.setFollowingMessage(_loc50_);
                  (_loc52_ as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(_loc51_);
               }
               return true;
            case param1 is PlayerFightFriendlyAnswerAction:
               _loc53_ = PlayerFightFriendlyAnswerAction(param1);
               _loc54_ = new GameRolePlayPlayerFightFriendlyAnswerMessage();
               _loc54_.initGameRolePlayPlayerFightFriendlyAnswerMessage(this._currentWaitingFightId,_loc53_.accept);
               _loc54_.accept = _loc53_.accept;
               _loc54_.fightId = this._currentWaitingFightId;
               ConnectionsHandler.getConnection().send(_loc54_);
               return true;
            case param1 is GameRolePlayPlayerFightFriendlyAnsweredMessage:
               _loc55_ = param1 as GameRolePlayPlayerFightFriendlyAnsweredMessage;
               if(this._currentWaitingFightId == _loc55_.fightId)
               {
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered,_loc55_.accept);
               }
               return true;
            case param1 is GameRolePlayFightRequestCanceledMessage:
               _loc56_ = param1 as GameRolePlayFightRequestCanceledMessage;
               if(this._currentWaitingFightId == _loc56_.fightId)
               {
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered,false);
               }
               return true;
            case param1 is GameRolePlayPlayerFightFriendlyRequestedMessage:
               _loc57_ = param1 as GameRolePlayPlayerFightFriendlyRequestedMessage;
               this._currentWaitingFightId = _loc57_.fightId;
               if(_loc57_.sourceId != PlayedCharacterManager.getInstance().id)
               {
                  if(this._entitiesFrame.getEntityInfos(_loc57_.sourceId))
                  {
                     _loc116_ = (this._entitiesFrame.getEntityInfos(_loc57_.sourceId) as GameRolePlayNamedActorInformations).name;
                  }
                  if(this.socialFrame.isIgnored(_loc116_))
                  {
                     return true;
                  }
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyRequested,_loc116_);
               }
               else
               {
                  _loc117_ = this._entitiesFrame.getEntityInfos(_loc57_.targetId);
                  if(_loc117_)
                  {
                     KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightRequestSent,GameRolePlayNamedActorInformations(_loc117_).name,true);
                  }
               }
               return true;
            case param1 is GameRolePlayFreeSoulRequestAction:
               _loc58_ = new GameRolePlayFreeSoulRequestMessage();
               ConnectionsHandler.getConnection().send(_loc58_);
               return true;
            case param1 is LeaveBidHouseAction:
               _loc59_ = new LeaveDialogRequestMessage();
               _loc59_.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(_loc59_);
               return true;
            case param1 is ExchangeErrorMessage:
               _loc60_ = param1 as ExchangeErrorMessage;
               _loc62_ = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
               switch(_loc60_.errorType)
               {
                  case ExchangeErrorEnum.REQUEST_CHARACTER_OCCUPIED:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchangeCharacterOccupied");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_TOOL_TOO_FAR:
                     _loc61_ = I18n.getUiText("ui.craft.notNearCraftTable");
                     break;
                  case ExchangeErrorEnum.REQUEST_IMPOSSIBLE:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchange");
                     break;
                  case ExchangeErrorEnum.BID_SEARCH_ERROR:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchangeBIDSearchError");
                     break;
                  case ExchangeErrorEnum.BUY_ERROR:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchangeBuyError");
                     break;
                  case ExchangeErrorEnum.MOUNT_PADDOCK_ERROR:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchangeMountPaddockError");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_JOB_NOT_EQUIPED:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchangeCharacterJobNotEquiped");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_NOT_SUSCRIBER:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchangeCharacterNotSuscriber");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_OVERLOADED:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchangeCharacterOverloaded");
                     break;
                  case ExchangeErrorEnum.SELL_ERROR:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchangeSellError");
                     break;
                  case ExchangeErrorEnum.REQUEST_CHARACTER_RESTRICTED:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchangeCharacterRestricted");
                     _loc62_ = ChatFrame.RED_CHANNEL_ID;
                     break;
                  default:
                     _loc61_ = I18n.getUiText("ui.exchange.cantExchange");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc61_,_loc62_,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeError,_loc60_.errorType);
               return true;
            case param1 is GameRolePlayAggressionMessage:
               _loc63_ = param1 as GameRolePlayAggressionMessage;
               _loc49_ = I18n.getUiText("ui.pvp.aAttackB",[GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc63_.attackerId)).name,GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc63_.defenderId)).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc49_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               _loc44_ = PlayedCharacterManager.getInstance().id;
               if(_loc44_ == _loc63_.attackerId)
               {
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESS);
               }
               else
               {
                  if(_loc44_ == _loc63_.defenderId)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.PlayerAggression,_loc63_.attackerId,GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc63_.attackerId)).name);
                     if((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.ATTACK)))
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.ATTACK,[GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc63_.attackerId)).name]);
                     }
                     SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESSED);
                  }
               }
               return true;
            case param1 is LeaveShopStockAction:
               _loc64_ = new LeaveDialogRequestMessage();
               _loc64_.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(_loc64_);
               return true;
            case param1 is ExchangeShopStockMouvmentAddAction:
               _loc65_ = param1 as ExchangeShopStockMouvmentAddAction;
               _loc66_ = new ExchangeObjectMovePricedMessage();
               _loc66_.initExchangeObjectMovePricedMessage(_loc65_.objectUID,_loc65_.quantity,_loc65_.price);
               ConnectionsHandler.getConnection().send(_loc66_);
               return true;
            case param1 is ExchangeShopStockMouvmentRemoveAction:
               _loc67_ = param1 as ExchangeShopStockMouvmentRemoveAction;
               _loc68_ = new ExchangeObjectMoveMessage();
               _loc68_.initExchangeObjectMoveMessage(_loc67_.objectUID,_loc67_.quantity);
               ConnectionsHandler.getConnection().send(_loc68_);
               return true;
            case param1 is ExchangeBuyAction:
               _loc69_ = param1 as ExchangeBuyAction;
               _loc70_ = new ExchangeBuyMessage();
               _loc70_.initExchangeBuyMessage(_loc69_.objectUID,_loc69_.quantity);
               ConnectionsHandler.getConnection().send(_loc70_);
               return true;
            case param1 is ExchangeSellAction:
               _loc71_ = param1 as ExchangeSellAction;
               _loc72_ = new ExchangeSellMessage();
               _loc72_.initExchangeSellMessage(_loc71_.objectUID,_loc71_.quantity);
               ConnectionsHandler.getConnection().send(_loc72_);
               return true;
            case param1 is ExchangeBuyOkMessage:
               _loc73_ = param1 as ExchangeBuyOkMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.BuyOk);
               return true;
            case param1 is ExchangeSellOkMessage:
               _loc74_ = param1 as ExchangeSellOkMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.SellOk);
               return true;
            case param1 is ExchangePlayerRequestAction:
               _loc75_ = param1 as ExchangePlayerRequestAction;
               _loc76_ = new ExchangePlayerRequestMessage();
               _loc76_.initExchangePlayerRequestMessage(_loc75_.exchangeType,_loc75_.target);
               ConnectionsHandler.getConnection().send(_loc76_);
               return true;
            case param1 is ExchangePlayerMultiCraftRequestAction:
               _loc77_ = param1 as ExchangePlayerMultiCraftRequestAction;
               switch(_loc77_.exchangeType)
               {
                  case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                     this._customerID = _loc77_.target;
                     this._crafterId = PlayedCharacterManager.getInstance().id;
                     break;
                  case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                     this._crafterId = _loc77_.target;
                     this._customerID = PlayedCharacterManager.getInstance().id;
                     break;
               }
               _loc78_ = new ExchangePlayerMultiCraftRequestMessage();
               _loc78_.initExchangePlayerMultiCraftRequestMessage(_loc77_.exchangeType,_loc77_.target,_loc77_.skillId);
               ConnectionsHandler.getConnection().send(_loc78_);
               return true;
            case param1 is JobAllowMultiCraftRequestSetAction:
               _loc79_ = param1 as JobAllowMultiCraftRequestSetAction;
               _loc80_ = new JobAllowMultiCraftRequestSetMessage();
               _loc80_.initJobAllowMultiCraftRequestSetMessage(_loc79_.isPublic);
               ConnectionsHandler.getConnection().send(_loc80_);
               return true;
            case param1 is JobAllowMultiCraftRequestMessage:
               _loc81_ = param1 as JobAllowMultiCraftRequestMessage;
               _loc82_ = (param1 as JobAllowMultiCraftRequestMessage).getMessageId();
               switch(_loc82_)
               {
                  case JobAllowMultiCraftRequestMessage.protocolId:
                     PlayedCharacterManager.getInstance().publicMode = _loc81_.enabled;
                     KernelEventsManager.getInstance().processCallback(CraftHookList.JobAllowMultiCraftRequest,_loc81_.enabled);
                     break;
                  case JobMultiCraftAvailableSkillsMessage.protocolId:
                     _loc118_ = param1 as JobMultiCraftAvailableSkillsMessage;
                     if(_loc118_.enabled)
                     {
                        _loc119_ = new MultiCraftEnableForPlayer();
                        _loc119_.playerId = _loc118_.playerId;
                        _loc119_.skills = _loc118_.skills;
                        _loc120_ = false;
                        for each (_loc121_ in this._playersMultiCraftSkill)
                        {
                           if(_loc121_.playerId == _loc119_.playerId)
                           {
                              _loc120_ = true;
                              _loc121_.skills = _loc118_.skills;
                           }
                        }
                        if(!_loc120_)
                        {
                           this._playersMultiCraftSkill.push(_loc119_);
                        }
                     }
                     else
                     {
                        _loc122_ = 0;
                        _loc123_ = -1;
                        _loc122_ = 0;
                        while(_loc122_ < this._playersMultiCraftSkill.length)
                        {
                           if(this._playersMultiCraftSkill[_loc122_].playerId == _loc118_.playerId)
                           {
                              _loc123_ = _loc122_;
                           }
                           _loc122_++;
                        }
                        if(_loc123_ > -1)
                        {
                           this._playersMultiCraftSkill.splice(_loc123_,1);
                        }
                     }
                     break;
               }
               return true;
            case param1 is SpellForgetUIMessage:
               _loc83_ = param1 as SpellForgetUIMessage;
               if(_loc83_.open)
               {
                  Kernel.getWorker().addFrame(this._spellForgetDialogFrame);
               }
               else
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this._spellForgetDialogFrame);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.SpellForgetUI,_loc83_.open);
               return true;
            case param1 is ChallengeFightJoinRefusedMessage:
               _loc84_ = param1 as ChallengeFightJoinRefusedMessage;
               switch(_loc84_.reason)
               {
                  case FighterRefusedReasonEnum.CHALLENGE_FULL:
                     _loc49_ = I18n.getUiText("ui.fight.challengeFull");
                     break;
                  case FighterRefusedReasonEnum.TEAM_FULL:
                     _loc49_ = I18n.getUiText("ui.fight.teamFull");
                     break;
                  case FighterRefusedReasonEnum.WRONG_ALIGNMENT:
                     _loc49_ = I18n.getUiText("ui.wrongAlignment");
                     break;
                  case FighterRefusedReasonEnum.WRONG_GUILD:
                     _loc49_ = I18n.getUiText("ui.fight.wrongGuild");
                     break;
                  case FighterRefusedReasonEnum.TOO_LATE:
                     _loc49_ = I18n.getUiText("ui.fight.tooLate");
                     break;
                  case FighterRefusedReasonEnum.MUTANT_REFUSED:
                     _loc49_ = I18n.getUiText("ui.fight.mutantRefused");
                     break;
                  case FighterRefusedReasonEnum.WRONG_MAP:
                     _loc49_ = I18n.getUiText("ui.fight.wrongMap");
                     break;
                  case FighterRefusedReasonEnum.JUST_RESPAWNED:
                     _loc49_ = I18n.getUiText("ui.fight.justRespawned");
                     break;
                  case FighterRefusedReasonEnum.IM_OCCUPIED:
                     _loc49_ = I18n.getUiText("ui.fight.imOccupied");
                     break;
                  case FighterRefusedReasonEnum.OPPONENT_OCCUPIED:
                     _loc49_ = I18n.getUiText("ui.fight.opponentOccupied");
                     break;
                  case FighterRefusedReasonEnum.MULTIACCOUNT_NOT_ALLOWED:
                     _loc49_ = I18n.getUiText("ui.fight.onlyOneAllowedAccount");
                     break;
                  case FighterRefusedReasonEnum.INSUFFICIENT_RIGHTS:
                     _loc49_ = I18n.getUiText("ui.fight.insufficientRights");
                     break;
                  case FighterRefusedReasonEnum.MEMBER_ACCOUNT_NEEDED:
                     _loc49_ = I18n.getUiText("ui.fight.memberAccountNeeded");
                     break;
                  case FighterRefusedReasonEnum.OPPONENT_NOT_MEMBER:
                     _loc49_ = I18n.getUiText("ui.fight.opponentNotMember");
                     break;
                  case FighterRefusedReasonEnum.TEAM_LIMITED_BY_MAINCHARACTER:
                     _loc49_ = I18n.getUiText("ui.fight.teamLimitedByMainCharacter");
                     break;
                  case FighterRefusedReasonEnum.GHOST_REFUSED:
                     _loc49_ = I18n.getUiText("ui.fight.ghostRefused");
                     break;
                  case FighterRefusedReasonEnum.AVA_ZONE:
                     _loc49_ = I18n.getUiText("ui.fight.cantAttackAvAZone");
                     break;
                  case FighterRefusedReasonEnum.RESTRICTED_ACCOUNT:
                     _loc49_ = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                     break;
                  default:
                     return true;
               }
               if(_loc49_ != null)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc49_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case param1 is SpellForgottenMessage:
               _loc85_ = param1 as SpellForgottenMessage;
               return true;
            case param1 is ExchangeCraftResultMessage:
               _loc86_ = param1 as ExchangeCraftResultMessage;
               _loc87_ = _loc86_.getMessageId();
               if(_loc87_ != ExchangeCraftInformationObjectMessage.protocolId)
               {
                  return false;
               }
               _loc88_ = param1 as ExchangeCraftInformationObjectMessage;
               switch(_loc88_.craftResult)
               {
                  case CraftResultEnum.CRAFT_SUCCESS:
                  case CraftResultEnum.CRAFT_FAILED:
                     _loc124_ = Item.getItemById(_loc88_.objectGenericId);
                     _loc125_ = _loc124_.iconId;
                     _loc89_ = new CraftSmileyItem(_loc88_.playerId,_loc125_,_loc88_.craftResult);
                     break;
                  case CraftResultEnum.CRAFT_IMPOSSIBLE:
                     _loc89_ = new CraftSmileyItem(_loc88_.playerId,-1,_loc88_.craftResult);
                     break;
               }
               if(DofusEntities.getEntity(_loc88_.playerId) as IDisplayable)
               {
                  _loc126_ = (DofusEntities.getEntity(_loc88_.playerId) as IDisplayable).absoluteBounds;
                  TooltipManager.show(_loc89_,_loc126_,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"craftSmiley" + _loc88_.playerId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,null,false,-1);
               }
               return true;
            case param1 is GameRolePlayDelayedActionMessage:
               _loc90_ = param1 as GameRolePlayDelayedActionMessage;
               if(_loc90_.delayTypeId == DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE)
               {
                  _loc128_ = Item.getItemById(548).iconId;
                  _loc127_ = new CraftSmileyItem(_loc90_.delayedCharacterId,_loc128_,2);
                  _loc129_ = (DofusEntities.getEntity(_loc90_.delayedCharacterId) as IDisplayable).absoluteBounds;
                  TooltipManager.show(_loc127_,_loc129_,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"craftSmiley" + _loc90_.delayedCharacterId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,null,false,-1);
               }
               return true;
            case param1 is DocumentReadingBeginMessage:
               _loc91_ = param1 as DocumentReadingBeginMessage;
               TooltipManager.hideAll();
               if(!Kernel.getWorker().contains(DocumentFrame))
               {
                  Kernel.getWorker().addFrame(this._documentFrame);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.DocumentReadingBegin,_loc91_.documentId);
               return true;
         }
      }
      
      public function pulled() : Boolean {
         var _loc1_:AllianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         _loc1_.pullRoleplay();
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
      
      public function getActorName(param1:int) : String {
         var _loc2_:GameRolePlayActorInformations = null;
         var _loc3_:GameRolePlayTaxCollectorInformations = null;
         _loc2_ = this.getActorInfos(param1);
         if(!_loc2_)
         {
            return "Unknown Actor";
         }
         switch(true)
         {
            case _loc2_ is GameRolePlayNamedActorInformations:
               return (_loc2_ as GameRolePlayNamedActorInformations).name;
            case _loc2_ is GameRolePlayTaxCollectorInformations:
               _loc3_ = _loc2_ as GameRolePlayTaxCollectorInformations;
               return TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc3_.identification.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc3_.identification.lastNameId).name;
            case _loc2_ is GameRolePlayNpcInformations:
               return Npc.getNpcById((_loc2_ as GameRolePlayNpcInformations).npcId).name;
            case _loc2_ is GameRolePlayGroupMonsterInformations:
            case _loc2_ is GameRolePlayPrismInformations:
               _log.error("Fail: getActorName called with an actorId corresponding to a monsters group or a prism (" + _loc2_ + ").");
               return "<error: cannot get a name>";
            default:
               return "Unknown Actor Type";
         }
      }
      
      private function getActorInfos(param1:int) : GameRolePlayActorInformations {
         return this.entitiesFrame.getEntityInfos(param1) as GameRolePlayActorInformations;
      }
      
      private function executeSpellBuffer(param1:Function, param2:Boolean, param3:Boolean=false, param4:RoleplaySpellCastProvider=null) : void {
         var _loc6_:ISequencable = null;
         var _loc5_:SerialSequencer = new SerialSequencer();
         for each (_loc6_ in param4.stepsBuffer)
         {
            _loc5_.addStep(_loc6_);
         }
         _loc5_.start();
      }
      
      private function addCraftFrame() : void {
         if(!Kernel.getWorker().contains(CraftFrame))
         {
            Kernel.getWorker().addFrame(this._craftFrame);
         }
      }
      
      private function addCommonExchangeFrame(param1:uint) : void {
         if(!Kernel.getWorker().contains(CommonExchangeManagementFrame))
         {
            this._commonExchangeFrame = new CommonExchangeManagementFrame(param1);
            Kernel.getWorker().addFrame(this._commonExchangeFrame);
         }
      }
      
      private function onListenOrientation(param1:MouseEvent) : void {
         var _loc2_:Point = this._playerEntity.localToGlobal(new Point(0,0));
         var _loc3_:Number = StageShareManager.stage.mouseY - _loc2_.y;
         var _loc4_:Number = StageShareManager.stage.mouseX - _loc2_.x;
         var _loc5_:uint = AngleToOrientation.angleToOrientation(Math.atan2(_loc3_,_loc4_));
         var _loc6_:String = this._playerEntity.getAnimation();
         var _loc7_:Emoticon = Emoticon.getEmoticonById(this._entitiesFrame.currentEmoticon);
         if(!_loc7_ || (_loc7_) && (_loc7_.eight_directions))
         {
            this._playerEntity.setDirection(_loc5_);
         }
         else
         {
            if(_loc5_ % 2 == 0)
            {
               this._playerEntity.setDirection(_loc5_ + 1);
            }
            else
            {
               this._playerEntity.setDirection(_loc5_);
            }
         }
      }
      
      private function onClickOrientation(param1:MouseEvent) : void {
         Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onListenOrientation);
         StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onClickOrientation);
         var _loc2_:String = this._playerEntity.getAnimation();
         var _loc3_:GameMapChangeOrientationRequestMessage = new GameMapChangeOrientationRequestMessage();
         _loc3_.initGameMapChangeOrientationRequestMessage(this._playerEntity.getDirection());
         ConnectionsHandler.getConnection().send(_loc3_);
      }
      
      public function getMultiCraftSkills(param1:uint) : Vector.<uint> {
         var _loc2_:MultiCraftEnableForPlayer = null;
         for each (_loc2_ in this._playersMultiCraftSkill)
         {
            if(_loc2_.playerId == param1)
            {
               return _loc2_.skills;
            }
         }
         return null;
      }
   }
}
import __AS3__.vec.Vector;

class MultiCraftEnableForPlayer extends Object
{
   
   function MultiCraftEnableForPlayer() {
      super();
   }
   
   public var playerId:uint;
   
   public var skills:Vector.<uint>;
}

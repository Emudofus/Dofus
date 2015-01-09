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
    import com.ankamagames.dofus.network.messages.game.inventory.items.ObtainedItemMessage;
    import com.ankamagames.berilia.components.Texture;
    import flash.text.TextFormat;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
    import flash.filters.GlowFilter;
    import com.ankamagames.dofus.logic.game.common.frames.StackManagementFrame;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import flash.utils.ByteArray;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
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
    import flash.utils.Timer;
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
    import com.ankamagames.dofus.network.messages.game.context.roleplay.document.ComicReadingBeginMessage;
    import com.ankamagames.dofus.datacenter.documents.Comic;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockSellBuyDialogMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.visual.GameRolePlaySpellAnimMessage;
    import com.ankamagames.dofus.logic.game.roleplay.types.RoleplaySpellCastProvider;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.ErrorMapNotFoundMessage;
    import com.ankamagames.atouin.data.map.Map;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
    import com.ankamagames.dofus.datacenter.world.Area;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobMultiCraftAvailableSkillsMessage;
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
    import com.ankamagames.atouin.messages.MapLoadingFailedMessage;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.atouin.data.DefaultMap;
    import com.ankamagames.jerakine.types.positions.WorldPoint;
    import com.ankamagames.atouin.messages.MapLoadedMessage;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.MouseEvent;
    import com.ankamagames.dofus.logic.game.common.actions.PivotCharacterAction;
    import com.ankamagames.dofus.misc.lists.RoleplayHookList;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcGenericActionFailureMessage;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.tiphon.types.TiphonUtility;
    import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
    import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
    import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidBuyerMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidSellerMessage;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShowVendorTaxAction;
    import com.ankamagames.dofus.misc.lists.ExchangeHookList;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeRequestOnShopStockAction;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeStartAsVendorRequestAction;
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
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ObtainedItemWithBonusMessage;
    import com.ankamagames.dofus.misc.lists.SocialHookList;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
    import com.ankamagames.dofus.logic.game.common.actions.roleplay.GameRolePlayFreeSoulRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.bid.LeaveBidHouseAction;
    import com.ankamagames.dofus.network.enums.ExchangeErrorEnum;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
    import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
    import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
    import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.LeaveShopStockAction;
    import com.ankamagames.dofus.misc.lists.CraftHookList;
    import com.ankamagames.dofus.network.enums.FighterRefusedReasonEnum;
    import com.ankamagames.dofus.network.enums.CraftResultEnum;
    import com.ankamagames.dofus.network.enums.DelayedActionTypeEnum;
    import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
    import com.ankamagames.jerakine.managers.LangManager;
    import com.ankamagames.dofus.network.messages.game.interactive.zaap.TeleportDestinationsListMessage;
    import com.ankamagames.dofus.network.messages.game.interactive.zaap.ZaapListMessage;
    import com.ankamagames.dofus.misc.lists.MountHookList;
    import com.ankamagames.dofus.logic.game.common.actions.mount.LeaveExchangeMountAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockPropertiesMessage;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.scripts.SpellScriptManager;
    import com.ankamagames.jerakine.types.Callback;
    import com.ankamagames.jerakine.messages.Message;
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
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextualManager;
    import __AS3__.vec.Vector;

    public class RoleplayContextFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayContextFrame));
        private static const ASTRUB_SUBAREA_IDS:Array = [143, 92, 95, 96, 97, 98, 99, 100, 101, 173, 318, 306];
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
        private var _obtainedItemMsg:ObtainedItemMessage;
        private var _itemIcon:Texture;
        private var _itemBonusIcon:Texture;
        private var _obtainedItemTextFormat:TextFormat;
        private var _obtainedItemBonusTextFormat:TextFormat;


        public function get crafterId():uint
        {
            return (this._crafterId);
        }

        public function get customerID():uint
        {
            return (this._customerID);
        }

        public function get priority():int
        {
            return (this._priority);
        }

        public function set priority(p:int):void
        {
            this._priority = p;
        }

        public function get entitiesFrame():RoleplayEntitiesFrame
        {
            return (this._entitiesFrame);
        }

        private function get socialFrame():SocialFrame
        {
            return ((Kernel.getWorker().getFrame(SocialFrame) as SocialFrame));
        }

        public function get hasWorldInteraction():Boolean
        {
            return (!(this._interactionIsLimited));
        }

        public function get commonExchangeFrame():CommonExchangeManagementFrame
        {
            return (this._commonExchangeFrame);
        }

        public function get hasGuildedPaddock():Boolean
        {
            return (((this._currentPaddock) && (this._currentPaddock.guildIdentity)));
        }

        public function get currentPaddock():PaddockWrapper
        {
            return (this._currentPaddock);
        }

        public function pushed():Boolean
        {
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
            if (!(Kernel.getWorker().contains(EstateFrame)))
            {
                Kernel.getWorker().addFrame(this._estateFrame);
            };
            this._allianceFrame = (Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame);
            this._allianceFrame.pushRoleplay();
            if (!(Kernel.getWorker().contains(EmoticonFrame)))
            {
                this._emoticonFrame = new EmoticonFrame();
                Kernel.getWorker().addFrame(this._emoticonFrame);
            }
            else
            {
                this._emoticonFrame = (Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame);
            };
            this._playersMultiCraftSkill = new Array();
            this._obtainedItemTextFormat = new TextFormat("Verdana", 24, 7615756, true);
            this._obtainedItemBonusTextFormat = new TextFormat("Verdana", 24, 0xFF5500, true);
            this._itemIcon = new Texture();
            this._itemBonusIcon = new Texture();
            var itemIconFilter:GlowFilter = new GlowFilter(0, 1, 2, 2, 2, 1);
            this._itemIcon.filters = [itemIconFilter];
            this._itemBonusIcon.filters = [itemIconFilter];
            var stackFrame:StackManagementFrame = (Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame);
            stackFrame.paused = false;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:CurrentMapMessage;
            var _local_3:SubArea;
            var _local_4:WorldPointWrapper;
            var _local_5:ByteArray;
            var _local_6:Object;
            var _local_7:MapPosition;
            var _local_8:ChangeWorldInteractionAction;
            var _local_9:Boolean;
            var _local_10:StackManagementFrame;
            var _local_11:NpcGenericActionRequestAction;
            var _local_12:IEntity;
            var _local_13:NpcGenericActionRequestMessage;
            var _local_14:ExchangeRequestOnTaxCollectorAction;
            var _local_15:ExchangeRequestOnTaxCollectorMessage;
            var _local_16:IEntity;
            var _local_17:GameRolePlayTaxCollectorFightRequestAction;
            var _local_18:GameRolePlayTaxCollectorFightRequestMessage;
            var _local_19:InteractiveElementActivationAction;
            var _local_20:InteractiveElementActivationMessage;
            var _local_21:DisplayContextualMenuAction;
            var _local_22:GameContextActorInformations;
            var _local_23:RoleplayInteractivesFrame;
            var _local_24:NpcDialogCreationMessage;
            var _local_25:Object;
            var _local_26:PortalUseRequestAction;
            var _local_27:PortalUseRequestMessage;
            var _local_28:ExchangeShowVendorTaxMessage;
            var _local_29:ExchangeReplyTaxVendorMessage;
            var _local_30:ExchangeOnHumanVendorRequestAction;
            var _local_31:ExchangeRequestOnShopStockMessage;
            var _local_32:ExchangeOnHumanVendorRequestAction;
            var _local_33:IEntity;
            var _local_34:ExchangeOnHumanVendorRequestMessage;
            var _local_35:ExchangeStartOkHumanVendorMessage;
            var _local_36:ExchangeShopStockStartedMessage;
            var _local_37:IEntity;
            var _local_38:ExchangeStartAsVendorMessage;
            var _local_39:ExpectedSocketClosureMessage;
            var _local_40:ExchangeStartedMountStockMessage;
            var _local_41:ExchangeStartOkNpcShopMessage;
            var _local_42:ExchangeStartedMessage;
            var _local_43:CommonExchangeManagementFrame;
            var _local_44:ObjectFoundWhileRecoltingMessage;
            var _local_45:Item;
            var _local_46:uint;
            var _local_47:CraftSmileyItem;
            var _local_48:uint;
            var _local_49:String;
            var _local_50:String;
            var _local_51:String;
            var _local_52:ObtainedItemMessage;
            var _local_53:RoleplayInteractivesFrame;
            var _local_54:AnimatedCharacter;
            var _local_55:Timer;
            var _local_56:PlayerFightRequestAction;
            var _local_57:GameRolePlayPlayerFightRequestMessage;
            var _local_58:IEntity;
            var _local_59:PlayerFightFriendlyAnswerAction;
            var _local_60:GameRolePlayPlayerFightFriendlyAnswerMessage;
            var _local_61:GameRolePlayPlayerFightFriendlyAnsweredMessage;
            var _local_62:GameRolePlayFightRequestCanceledMessage;
            var _local_63:GameRolePlayPlayerFightFriendlyRequestedMessage;
            var _local_64:GameRolePlayFreeSoulRequestMessage;
            var _local_65:LeaveDialogRequestMessage;
            var _local_66:ExchangeErrorMessage;
            var _local_67:String;
            var _local_68:uint;
            var _local_69:GameRolePlayAggressionMessage;
            var _local_70:LeaveDialogRequestMessage;
            var _local_71:ExchangeShopStockMouvmentAddAction;
            var _local_72:ExchangeObjectMovePricedMessage;
            var _local_73:ExchangeShopStockMouvmentRemoveAction;
            var _local_74:ExchangeObjectMoveMessage;
            var _local_75:ExchangeBuyAction;
            var _local_76:ExchangeBuyMessage;
            var _local_77:ExchangeSellAction;
            var _local_78:ExchangeSellMessage;
            var _local_79:ExchangeBuyOkMessage;
            var _local_80:ExchangeSellOkMessage;
            var _local_81:ExchangePlayerRequestAction;
            var _local_82:ExchangePlayerRequestMessage;
            var _local_83:ExchangePlayerMultiCraftRequestAction;
            var _local_84:ExchangePlayerMultiCraftRequestMessage;
            var _local_85:JobAllowMultiCraftRequestSetAction;
            var _local_86:JobAllowMultiCraftRequestSetMessage;
            var _local_87:JobAllowMultiCraftRequestMessage;
            var _local_88:uint;
            var _local_89:SpellForgetUIMessage;
            var _local_90:ChallengeFightJoinRefusedMessage;
            var _local_91:SpellForgottenMessage;
            var _local_92:ExchangeCraftResultMessage;
            var _local_93:uint;
            var _local_94:ExchangeCraftInformationObjectMessage;
            var _local_95:CraftSmileyItem;
            var _local_96:GameRolePlayDelayedActionMessage;
            var _local_97:DocumentReadingBeginMessage;
            var _local_98:ComicReadingBeginMessage;
            var _local_99:Comic;
            var _local_100:PaddockSellBuyDialogMessage;
            var _local_101:LeaveDialogRequestMessage;
            var _local_102:GameRolePlaySpellAnimMessage;
            var _local_103:RoleplaySpellCastProvider;
            var _local_104:int;
            var decryptionKeyString:String;
            var _local_106:Object;
            var _local_107:ErrorMapNotFoundMessage;
            var currentMapX:int;
            var currentMapY:int;
            var currentWorldId:int;
            var virtualMap:Map;
            var menuResult:Boolean;
            var npcEntity:GameRolePlayNpcInformations;
            var npcLook:TiphonEntityLook;
            var ponyEntity:GameRolePlayTaxCollectorInformations;
            var prismEntity:GameRolePlayPrismInformations;
            var allianceName:String;
            var portalEntity:GameRolePlayPortalInformations;
            var area:Area;
            var areaName:String;
            var _local_121:LeaveDialogRequestMessage;
            var absoluteBounds:IRectangle;
            var _local_123:uint;
            var infos:GameRolePlayCharacterInformations;
            var _local_125:int;
            var _local_126:int;
            var rcf:RoleplayContextFrame;
            var playerInfo:GameRolePlayActorInformations;
            var name:String;
            var _local_130:GameContextActorInformations;
            var _local_131:JobMultiCraftAvailableSkillsMessage;
            var mcefp:MultiCraftEnableForPlayer;
            var alreadyIn:Boolean;
            var mcefplayer:MultiCraftEnableForPlayer;
            var _local_135:uint;
            var _local_136:int;
            var _local_137:Item;
            var _local_138:uint;
            var absBounds:IRectangle;
            var csiD:CraftSmileyItem;
            var iconIdD:uint;
            var absBoundsD:IRectangle;
            switch (true)
            {
                case (msg is CurrentMapMessage):
                    _local_2 = (msg as CurrentMapMessage);
                    _local_3 = SubArea.getSubAreaByMapId(_local_2.mapId);
                    PlayedCharacterManager.getInstance().currentSubArea = _local_3;
                    Kernel.getWorker().pause(null, [SystemMessageDisplayMessage]);
                    ConnectionsHandler.pause();
                    if (TacticModeManager.getInstance().tacticModeActivated)
                    {
                        TacticModeManager.getInstance().hide();
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    Atouin.getInstance().initPreDisplay(_local_4);
                    if (((this._entitiesFrame) && (Kernel.getWorker().contains(RoleplayEntitiesFrame))))
                    {
                        Kernel.getWorker().removeFrame(this._entitiesFrame);
                    };
                    if (((this._worldFrame) && (Kernel.getWorker().contains(RoleplayWorldFrame))))
                    {
                        Kernel.getWorker().removeFrame(this._worldFrame);
                    };
                    if (((this._interactivesFrame) && (Kernel.getWorker().contains(RoleplayInteractivesFrame))))
                    {
                        Kernel.getWorker().removeFrame(this._interactivesFrame);
                    };
                    if (((this._movementFrame) && (Kernel.getWorker().contains(RoleplayMovementFrame))))
                    {
                        Kernel.getWorker().removeFrame(this._movementFrame);
                    };
                    if (PlayedCharacterManager.getInstance().isInHouse)
                    {
                        _local_4 = new WorldPointWrapper(_local_2.mapId, true, PlayedCharacterManager.getInstance().currentMap.outdoorX, PlayedCharacterManager.getInstance().currentMap.outdoorY);
                    }
                    else
                    {
                        _local_4 = new WorldPointWrapper(_local_2.mapId);
                    };
                    PlayedCharacterManager.getInstance().currentMap = _local_4;
                    Atouin.getInstance().clearEntities();
                    KernelEventsManager.getInstance().processCallback(HookList.MapFightCount, 0);
                    if (((_local_2.mapKey) && (_local_2.mapKey.length)))
                    {
                        decryptionKeyString = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                        if (!(decryptionKeyString))
                        {
                            decryptionKeyString = _local_2.mapKey;
                        };
                        _local_5 = Hex.toArray(Hex.fromString(decryptionKeyString));
                    };
                    Atouin.getInstance().display(_local_4, _local_5);
                    TooltipManager.hideAll();
                    _local_6 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                    _local_6.closeAllMenu();
                    this._currentPaddock = null;
                    _local_7 = MapPosition.getMapPositionById(_local_2.mapId);
                    if (((_local_7) && (!((ASTRUB_SUBAREA_IDS.indexOf(_local_7.subAreaId) == -1)))))
                    {
                        PartManager.getInstance().checkAndDownload("all");
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.CurrentMap, _local_2.mapId);
                    return (true);
                case (msg is MapsLoadingCompleteMessage):
                    if (!(Kernel.getWorker().contains(RoleplayEntitiesFrame)))
                    {
                        Kernel.getWorker().addFrame(this._entitiesFrame);
                    };
                    TooltipManager.hideAll();
                    KernelEventsManager.getInstance().processCallback(HookList.MapsLoadingComplete, MapsLoadingCompleteMessage(msg).mapPoint);
                    if (!(Kernel.getWorker().contains(RoleplayWorldFrame)))
                    {
                        Kernel.getWorker().addFrame(this._worldFrame);
                    };
                    if (!(Kernel.getWorker().contains(RoleplayInteractivesFrame)))
                    {
                        Kernel.getWorker().addFrame(this._interactivesFrame);
                    };
                    if (!(Kernel.getWorker().contains(RoleplayMovementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._movementFrame);
                    };
                    SoundManager.getInstance().manager.setSubArea(MapsLoadingCompleteMessage(msg).mapData);
                    Atouin.getInstance().updateCursor();
                    Kernel.getWorker().resume();
                    Kernel.getWorker().clearUnstoppableMsgClassList();
                    ConnectionsHandler.resume();
                    return (true);
                case (msg is MapLoadingFailedMessage):
                    switch (MapLoadingFailedMessage(msg).errorReason)
                    {
                        case MapLoadingFailedMessage.NO_FILE:
                            _local_106 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                            _local_106.openPopup(I18n.getUiText("ui.popup.information"), I18n.getUiText("ui.popup.noMapdataFile"), [I18n.getUiText("ui.common.ok")]);
                            _local_107 = new ErrorMapNotFoundMessage();
                            _local_107.initErrorMapNotFoundMessage(MapLoadingFailedMessage(msg).id);
                            ConnectionsHandler.getConnection().send(_local_107);
                            MapDisplayManager.getInstance().fromMap(new DefaultMap(MapLoadingFailedMessage(msg).id));
                            return (true);
                    };
                    return (false);
                case (msg is MapLoadedMessage):
                    if (MapDisplayManager.getInstance().isDefaultMap)
                    {
                        currentMapX = PlayedCharacterManager.getInstance().currentMap.x;
                        currentMapY = PlayedCharacterManager.getInstance().currentMap.y;
                        currentWorldId = PlayedCharacterManager.getInstance().currentMap.worldId;
                        virtualMap = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
                        virtualMap.rightNeighbourId = WorldPoint.fromCoords(currentWorldId, (currentMapX + 1), currentMapY).mapId;
                        virtualMap.leftNeighbourId = WorldPoint.fromCoords(currentWorldId, (currentMapX - 1), currentMapY).mapId;
                        virtualMap.bottomNeighbourId = WorldPoint.fromCoords(currentWorldId, currentMapX, (currentMapY + 1)).mapId;
                        virtualMap.topNeighbourId = WorldPoint.fromCoords(currentWorldId, currentMapX, (currentMapY - 1)).mapId;
                    };
                    return (true);
                case (msg is ChangeWorldInteractionAction):
                    _local_8 = (msg as ChangeWorldInteractionAction);
                    _local_9 = false;
                    if (((Kernel.getWorker().contains(BidHouseManagementFrame)) && (this._bidHouseManagementFrame.switching)))
                    {
                        _local_9 = true;
                    };
                    this._interactionIsLimited = !(_local_8.enabled);
                    switch (_local_8.total)
                    {
                        case true:
                            if (_local_8.enabled)
                            {
                                if (((((!(Kernel.getWorker().contains(RoleplayWorldFrame))) && (!(_local_9)))) && (SystemApi.wordInteractionEnable)))
                                {
                                    _log.info("Enabling interaction with the roleplay world.");
                                    Kernel.getWorker().addFrame(this._worldFrame);
                                };
                                this._worldFrame.cellClickEnabled = true;
                                this._worldFrame.allowOnlyCharacterInteraction = false;
                                this._worldFrame.pivotingCharacter = false;
                            }
                            else
                            {
                                if (Kernel.getWorker().contains(RoleplayWorldFrame))
                                {
                                    _log.info("Disabling interaction with the roleplay world.");
                                    Kernel.getWorker().removeFrame(this._worldFrame);
                                };
                            };
                            break;
                        case false:
                            if (_local_8.enabled)
                            {
                                if (((!(Kernel.getWorker().contains(RoleplayWorldFrame))) && (!(_local_9))))
                                {
                                    _log.info("Enabling total interaction with the roleplay world.");
                                    Kernel.getWorker().addFrame(this._worldFrame);
                                    this._worldFrame.cellClickEnabled = true;
                                    this._worldFrame.allowOnlyCharacterInteraction = false;
                                    this._worldFrame.pivotingCharacter = false;
                                };
                                if (!(Kernel.getWorker().contains(RoleplayInteractivesFrame)))
                                {
                                    Kernel.getWorker().addFrame(this._interactivesFrame);
                                };
                            }
                            else
                            {
                                if (Kernel.getWorker().contains(RoleplayWorldFrame))
                                {
                                    _log.info("Disabling partial interactions with the roleplay world.");
                                    this._worldFrame.allowOnlyCharacterInteraction = true;
                                };
                            };
                            break;
                    };
                    _local_10 = (Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame);
                    if (!(((!(this._interactionIsLimited)) && (!(SystemApi.wordInteractionEnable)))))
                    {
                        _local_10.paused = this._interactionIsLimited;
                    };
                    if (((!(_local_10.paused)) && (_local_10.waitingMessage)))
                    {
                        this._worldFrame.process(_local_10.waitingMessage);
                        _local_10.waitingMessage = null;
                    };
                    return (true);
                case (msg is NpcGenericActionRequestAction):
                    _local_11 = (msg as NpcGenericActionRequestAction);
                    _local_12 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    _local_13 = new NpcGenericActionRequestMessage();
                    _local_13.initNpcGenericActionRequestMessage(_local_11.npcId, _local_11.actionId, PlayedCharacterManager.getInstance().currentMap.mapId);
                    if ((_local_12 as IMovable).isMoving)
                    {
                        (_local_12 as IMovable).stop();
                        this._movementFrame.setFollowingMessage(_local_13);
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_local_13);
                    };
                    return (true);
                case (msg is ExchangeRequestOnTaxCollectorAction):
                    _local_14 = (msg as ExchangeRequestOnTaxCollectorAction);
                    _local_15 = new ExchangeRequestOnTaxCollectorMessage();
                    _local_15.initExchangeRequestOnTaxCollectorMessage(_local_14.taxCollectorId);
                    _local_16 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if ((_local_16 as IMovable).isMoving)
                    {
                        this._movementFrame.setFollowingMessage(_local_15);
                        (_local_16 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_local_15);
                    };
                    return (true);
                case (msg is GameRolePlayTaxCollectorFightRequestAction):
                    _local_17 = (msg as GameRolePlayTaxCollectorFightRequestAction);
                    _local_18 = new GameRolePlayTaxCollectorFightRequestMessage();
                    _local_18.initGameRolePlayTaxCollectorFightRequestMessage(_local_17.taxCollectorId);
                    ConnectionsHandler.getConnection().send(_local_18);
                    return (true);
                case (msg is InteractiveElementActivationAction):
                    _local_19 = (msg as InteractiveElementActivationAction);
                    _local_20 = new InteractiveElementActivationMessage(_local_19.interactiveElement, _local_19.position, _local_19.skillInstanceId);
                    Kernel.getWorker().process(_local_20);
                    return (true);
                case (msg is DisplayContextualMenuAction):
                    _local_21 = (msg as DisplayContextualMenuAction);
                    _local_22 = this.entitiesFrame.getEntityInfos(_local_21.playerId);
                    if (_local_22)
                    {
                        menuResult = RoleplayManager.getInstance().displayCharacterContextualMenu(_local_22);
                    };
                    return (false);
                case (msg is PivotCharacterAction):
                    _local_23 = (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame);
                    if (((_local_23) && (!(_local_23.usingInteractive))))
                    {
                        Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                        this._worldFrame.pivotingCharacter = true;
                        this._playerEntity = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter);
                        StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onListenOrientation);
                        StageShareManager.stage.addEventListener(MouseEvent.CLICK, this.onClickOrientation);
                    };
                    return (true);
                case (msg is NpcGenericActionFailureMessage):
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.NpcDialogCreationFailure);
                    return (true);
                case (msg is NpcDialogCreationMessage):
                    _local_24 = (msg as NpcDialogCreationMessage);
                    _local_25 = this._entitiesFrame.getEntityInfos(_local_24.npcId);
                    if (!(Kernel.getWorker().contains(NpcDialogFrame)))
                    {
                        Kernel.getWorker().addFrame(this._npcDialogFrame);
                    };
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                    TooltipManager.hideAll();
                    if ((_local_25 is GameRolePlayNpcInformations))
                    {
                        npcEntity = (_local_25 as GameRolePlayNpcInformations);
                        npcLook = EntityLookAdapter.fromNetwork(npcEntity.look);
                        npcLook = TiphonUtility.getLookWithoutMount(npcLook);
                        KernelEventsManager.getInstance().processCallback(RoleplayHookList.NpcDialogCreation, _local_24.mapId, npcEntity.npcId, npcLook);
                    }
                    else
                    {
                        if ((_local_25 is GameRolePlayTaxCollectorInformations))
                        {
                            ponyEntity = (_local_25 as GameRolePlayTaxCollectorInformations);
                            KernelEventsManager.getInstance().processCallback(RoleplayHookList.PonyDialogCreation, _local_24.mapId, ponyEntity.identification.firstNameId, ponyEntity.identification.lastNameId, EntityLookAdapter.fromNetwork(ponyEntity.look));
                        }
                        else
                        {
                            if ((_local_25 is GameRolePlayPrismInformations))
                            {
                                prismEntity = (_local_25 as GameRolePlayPrismInformations);
                                if ((prismEntity.prism is AlliancePrismInformation))
                                {
                                    allianceName = (prismEntity.prism as AlliancePrismInformation).alliance.allianceName;
                                    if (allianceName == "#NONAME#")
                                    {
                                        allianceName = I18n.getUiText("ui.guild.noName");
                                    };
                                }
                                else
                                {
                                    if (AllianceFrame.getInstance().hasAlliance)
                                    {
                                        allianceName = AllianceFrame.getInstance().alliance.allianceName;
                                    };
                                };
                                KernelEventsManager.getInstance().processCallback(RoleplayHookList.PrismDialogCreation, _local_24.mapId, allianceName, EntityLookAdapter.fromNetwork(prismEntity.look));
                            }
                            else
                            {
                                if ((_local_25 is GameRolePlayPortalInformations))
                                {
                                    portalEntity = (_local_25 as GameRolePlayPortalInformations);
                                    area = Area.getAreaById(portalEntity.portal.areaId);
                                    if (!(area))
                                    {
                                        return (true);
                                    };
                                    areaName = area.name;
                                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.PortalDialogCreation, _local_24.mapId, areaName, EntityLookAdapter.fromNetwork(portalEntity.look));
                                }
                                else
                                {
                                    _local_121 = new LeaveDialogRequestMessage();
                                    ConnectionsHandler.getConnection().send(_local_121);
                                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                                };
                            };
                        };
                    };
                    return (true);
                case (msg is PortalUseRequestAction):
                    _local_26 = (msg as PortalUseRequestAction);
                    _local_27 = new PortalUseRequestMessage();
                    _local_27.initPortalUseRequestMessage(_local_26.portalId);
                    ConnectionsHandler.getConnection().send(_local_27);
                    return (true);
                case (msg is GameContextDestroyMessage):
                    TooltipManager.hide();
                    Kernel.getWorker().removeFrame(this);
                    return (true);
                case (msg is ExchangeStartedBidBuyerMessage):
                    if (!(Kernel.getWorker().contains(BidHouseManagementFrame)))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
                    };
                    this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_BUY);
                    if (!(Kernel.getWorker().contains(BidHouseManagementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
                    };
                    this._bidHouseManagementFrame.processExchangeStartedBidBuyerMessage((msg as ExchangeStartedBidBuyerMessage));
                    return (true);
                case (msg is ExchangeStartedBidSellerMessage):
                    if (!(Kernel.getWorker().contains(BidHouseManagementFrame)))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
                    };
                    this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_SELL);
                    if (!(Kernel.getWorker().contains(BidHouseManagementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
                    };
                    this._bidHouseManagementFrame.processExchangeStartedBidSellerMessage((msg as ExchangeStartedBidSellerMessage));
                    return (true);
                case (msg is ExchangeShowVendorTaxAction):
                    _local_28 = new ExchangeShowVendorTaxMessage();
                    _local_28.initExchangeShowVendorTaxMessage();
                    ConnectionsHandler.getConnection().send(_local_28);
                    return (true);
                case (msg is ExchangeReplyTaxVendorMessage):
                    _local_29 = (msg as ExchangeReplyTaxVendorMessage);
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeReplyTaxVendor, _local_29.totalTaxValue);
                    return (true);
                case (msg is ExchangeRequestOnShopStockAction):
                    _local_30 = (msg as ExchangeOnHumanVendorRequestAction);
                    _local_31 = new ExchangeRequestOnShopStockMessage();
                    _local_31.initExchangeRequestOnShopStockMessage();
                    ConnectionsHandler.getConnection().send(_local_31);
                    return (true);
                case (msg is ExchangeOnHumanVendorRequestAction):
                    _local_32 = (msg as ExchangeOnHumanVendorRequestAction);
                    _local_33 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    _local_34 = new ExchangeOnHumanVendorRequestMessage();
                    _local_34.initExchangeOnHumanVendorRequestMessage(_local_32.humanVendorId, _local_32.humanVendorCell);
                    if ((_local_33 as IMovable).isMoving)
                    {
                        this._movementFrame.setFollowingMessage(_local_34);
                        (_local_33 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_local_34);
                    };
                    return (true);
                case (msg is ExchangeStartOkHumanVendorMessage):
                    _local_35 = (msg as ExchangeStartOkHumanVendorMessage);
                    if (!(Kernel.getWorker().contains(HumanVendorManagementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._humanVendorManagementFrame);
                    };
                    this._humanVendorManagementFrame.process(msg);
                    return (true);
                case (msg is ExchangeShopStockStartedMessage):
                    _local_36 = (msg as ExchangeShopStockStartedMessage);
                    if (!(Kernel.getWorker().contains(HumanVendorManagementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._humanVendorManagementFrame);
                    };
                    this._humanVendorManagementFrame.process(msg);
                    return (true);
                case (msg is ExchangeStartAsVendorRequestAction):
                    _local_37 = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id);
                    if (((_local_37) && (!(DataMapProvider.getInstance().pointCanStop(_local_37.position.x, _local_37.position.y)))))
                    {
                        return (true);
                    };
                    ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR);
                    _local_38 = new ExchangeStartAsVendorMessage();
                    _local_38.initExchangeStartAsVendorMessage();
                    ConnectionsHandler.getConnection().send(_local_38);
                    return (true);
                case (msg is ExpectedSocketClosureMessage):
                    _local_39 = (msg as ExpectedSocketClosureMessage);
                    if (_local_39.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR)
                    {
                        Kernel.getWorker().process(new ResetGameAction());
                        return (true);
                    };
                    return (false);
                case (msg is ExchangeStartedMountStockMessage):
                    _local_40 = ExchangeStartedMountStockMessage(msg);
                    this.addCommonExchangeFrame(ExchangeTypeEnum.MOUNT);
                    if (!(Kernel.getWorker().contains(ExchangeManagementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                    };
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeBankStarted, ExchangeTypeEnum.MOUNT, _local_40.objectsInfos, 0);
                    this._exchangeManagementFrame.initMountStock(_local_40.objectsInfos);
                    return (true);
                case (msg is ExchangeRequestedTradeMessage):
                    this.addCommonExchangeFrame(ExchangeTypeEnum.PLAYER_TRADE);
                    if (!(Kernel.getWorker().contains(ExchangeManagementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                        this._exchangeManagementFrame.processExchangeRequestedTradeMessage((msg as ExchangeRequestedTradeMessage));
                    };
                    return (true);
                case (msg is ExchangeStartOkNpcTradeMessage):
                    this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_TRADE);
                    if (!(Kernel.getWorker().contains(ExchangeManagementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                        this._exchangeManagementFrame.processExchangeStartOkNpcTradeMessage((msg as ExchangeStartOkNpcTradeMessage));
                    };
                    return (true);
                case (msg is ExchangeStartOkNpcShopMessage):
                    _local_41 = (msg as ExchangeStartOkNpcShopMessage);
                    this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_SHOP);
                    if (!(Kernel.getWorker().contains(ExchangeManagementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                    };
                    this._exchangeManagementFrame.process(msg);
                    return (true);
                case (msg is ExchangeStartedMessage):
                    _local_42 = (msg as ExchangeStartedMessage);
                    _local_43 = (Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame);
                    if (_local_43)
                    {
                        _local_43.resetEchangeSequence();
                    };
                    switch (_local_42.exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                        case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                        case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                            this.addCraftFrame();
                            break;
                        case ExchangeTypeEnum.BIDHOUSE_BUY:
                        case ExchangeTypeEnum.BIDHOUSE_SELL:
                        case ExchangeTypeEnum.PLAYER_TRADE:
                    };
                    this.addCommonExchangeFrame(_local_42.exchangeType);
                    if (!(Kernel.getWorker().contains(ExchangeManagementFrame)))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                    };
                    this._exchangeManagementFrame.process(msg);
                    return (true);
                case (msg is ExchangeOkMultiCraftMessage):
                    this.addCraftFrame();
                    this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
                    this._craftFrame.processExchangeOkMultiCraftMessage((msg as ExchangeOkMultiCraftMessage));
                    return (true);
                case (msg is ExchangeStartOkCraftWithInformationMessage):
                    this.addCraftFrame();
                    this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
                    this._craftFrame.processExchangeStartOkCraftWithInformationMessage((msg as ExchangeStartOkCraftWithInformationMessage));
                    return (true);
                case (msg is ObjectFoundWhileRecoltingMessage):
                    _local_44 = (msg as ObjectFoundWhileRecoltingMessage);
                    _local_45 = Item.getItemById(_local_44.genericId);
                    _local_46 = PlayedCharacterManager.getInstance().id;
                    _local_47 = new CraftSmileyItem(_local_46, _local_45.iconId, 2);
                    if ((DofusEntities.getEntity(_local_46) as IDisplayable))
                    {
                        absoluteBounds = (DofusEntities.getEntity(_local_46) as IDisplayable).absoluteBounds;
                        TooltipManager.show(_local_47, absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, ("craftSmiley" + _local_46), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null);
                    };
                    _local_48 = _local_44.quantity;
                    _local_49 = ((_local_44.genericId) ? Item.getItemById(_local_44.genericId).name : I18n.getUiText("ui.common.kamas"));
                    _local_50 = Item.getItemById(_local_44.resourceGenericId).name;
                    _local_51 = I18n.getUiText("ui.common.itemFound", [_local_48, _local_49, _local_50]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_51, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is ObtainedItemMessage):
                    _local_52 = (msg as ObtainedItemMessage);
                    _local_53 = (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame);
                    _local_54 = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter);
                    if (((_local_53) && (!((_local_54.getAnimation() == AnimationEnum.ANIM_STATIQUE)))))
                    {
                        _local_55 = _local_53.getInteractiveActionTimer(_local_54);
                    };
                    if (((_local_55) && (_local_55.running)))
                    {
                        this._obtainedItemMsg = _local_52;
                        _local_55.addEventListener(TimerEvent.TIMER, this.onInteractiveAnimationEnd);
                    }
                    else
                    {
                        _local_123 = (((msg is ObtainedItemWithBonusMessage)) ? (msg as ObtainedItemWithBonusMessage).bonusQuantity : 0);
                        this.displayObtainedItem(_local_52.genericId, _local_52.baseQuantity, _local_123);
                    };
                    return (true);
                case (msg is PlayerFightRequestAction):
                    _local_56 = PlayerFightRequestAction(msg);
                    if (((!(_local_56.launch)) && (!(_local_56.friendly))))
                    {
                        infos = (this.entitiesFrame.getEntityInfos(_local_56.targetedPlayerId) as GameRolePlayCharacterInformations);
                        if (infos)
                        {
                            if (_local_56.ava)
                            {
                                KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer, _local_56.targetedPlayerId, true, infos.name, _local_126, _local_56.cellId);
                                return (true);
                            };
                            if (infos.alignmentInfos.alignmentSide == 0)
                            {
                                rcf = (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
                                playerInfo = (rcf.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations);
                                if (!((playerInfo is GameRolePlayMutantInformations)))
                                {
                                    KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer, _local_56.targetedPlayerId, false, infos.name, 2, _local_56.cellId);
                                    return (true);
                                };
                            };
                            _local_125 = (infos.alignmentInfos.characterPower - _local_56.targetedPlayerId);
                            _local_126 = PlayedCharacterManager.getInstance().levelDiff(_local_125);
                            if (_local_126)
                            {
                                KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer, _local_56.targetedPlayerId, false, infos.name, _local_126, _local_56.cellId);
                                return (true);
                            };
                        };
                    };
                    _local_57 = new GameRolePlayPlayerFightRequestMessage();
                    _local_57.initGameRolePlayPlayerFightRequestMessage(_local_56.targetedPlayerId, _local_56.cellId, _local_56.friendly);
                    _local_58 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if ((_local_58 as IMovable).isMoving)
                    {
                        this._movementFrame.setFollowingMessage(_local_56);
                        (_local_58 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_local_57);
                    };
                    return (true);
                case (msg is PlayerFightFriendlyAnswerAction):
                    _local_59 = PlayerFightFriendlyAnswerAction(msg);
                    _local_60 = new GameRolePlayPlayerFightFriendlyAnswerMessage();
                    _local_60.initGameRolePlayPlayerFightFriendlyAnswerMessage(this._currentWaitingFightId, _local_59.accept);
                    _local_60.accept = _local_59.accept;
                    _local_60.fightId = this._currentWaitingFightId;
                    ConnectionsHandler.getConnection().send(_local_60);
                    return (true);
                case (msg is GameRolePlayPlayerFightFriendlyAnsweredMessage):
                    _local_61 = (msg as GameRolePlayPlayerFightFriendlyAnsweredMessage);
                    if (this._currentWaitingFightId == _local_61.fightId)
                    {
                        KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered, _local_61.accept);
                    };
                    return (true);
                case (msg is GameRolePlayFightRequestCanceledMessage):
                    _local_62 = (msg as GameRolePlayFightRequestCanceledMessage);
                    if (this._currentWaitingFightId == _local_62.fightId)
                    {
                        KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered, false);
                    };
                    return (true);
                case (msg is GameRolePlayPlayerFightFriendlyRequestedMessage):
                    _local_63 = (msg as GameRolePlayPlayerFightFriendlyRequestedMessage);
                    this._currentWaitingFightId = _local_63.fightId;
                    if (_local_63.sourceId != PlayedCharacterManager.getInstance().id)
                    {
                        if (this._entitiesFrame.getEntityInfos(_local_63.sourceId))
                        {
                            name = (this._entitiesFrame.getEntityInfos(_local_63.sourceId) as GameRolePlayNamedActorInformations).name;
                        };
                        if (this.socialFrame.isIgnored(name))
                        {
                            return (true);
                        };
                        KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyRequested, name);
                    }
                    else
                    {
                        _local_130 = this._entitiesFrame.getEntityInfos(_local_63.targetId);
                        if (_local_130)
                        {
                            KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightRequestSent, GameRolePlayNamedActorInformations(_local_130).name, true);
                        };
                    };
                    return (true);
                case (msg is GameRolePlayFreeSoulRequestAction):
                    _local_64 = new GameRolePlayFreeSoulRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_64);
                    return (true);
                case (msg is LeaveBidHouseAction):
                    _local_65 = new LeaveDialogRequestMessage();
                    _local_65.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_65);
                    return (true);
                case (msg is ExchangeErrorMessage):
                    _local_66 = (msg as ExchangeErrorMessage);
                    _local_68 = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
                    switch (_local_66.errorType)
                    {
                        case ExchangeErrorEnum.REQUEST_CHARACTER_OCCUPIED:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeCharacterOccupied");
                            break;
                        case ExchangeErrorEnum.REQUEST_CHARACTER_TOOL_TOO_FAR:
                            _local_67 = I18n.getUiText("ui.craft.notNearCraftTable");
                            break;
                        case ExchangeErrorEnum.REQUEST_IMPOSSIBLE:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchange");
                            break;
                        case ExchangeErrorEnum.BID_SEARCH_ERROR:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeBIDSearchError");
                            break;
                        case ExchangeErrorEnum.BUY_ERROR:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeBuyError");
                            break;
                        case ExchangeErrorEnum.MOUNT_PADDOCK_ERROR:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeMountPaddockError");
                            break;
                        case ExchangeErrorEnum.REQUEST_CHARACTER_JOB_NOT_EQUIPED:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeCharacterJobNotEquiped");
                            break;
                        case ExchangeErrorEnum.REQUEST_CHARACTER_NOT_SUSCRIBER:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeCharacterNotSuscriber");
                            break;
                        case ExchangeErrorEnum.REQUEST_CHARACTER_OVERLOADED:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeCharacterOverloaded");
                            break;
                        case ExchangeErrorEnum.SELL_ERROR:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeSellError");
                            break;
                        case ExchangeErrorEnum.REQUEST_CHARACTER_RESTRICTED:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeCharacterRestricted");
                            _local_68 = ChatFrame.RED_CHANNEL_ID;
                            break;
                        case ExchangeErrorEnum.REQUEST_CHARACTER_GUEST:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchangeCharacterGuest");
                            _local_68 = ChatFrame.RED_CHANNEL_ID;
                            break;
                        default:
                            _local_67 = I18n.getUiText("ui.exchange.cantExchange");
                    };
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_67, _local_68, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeError, _local_66.errorType);
                    return (true);
                case (msg is GameRolePlayAggressionMessage):
                    _local_69 = (msg as GameRolePlayAggressionMessage);
                    _local_51 = I18n.getUiText("ui.pvp.aAttackB", [GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_local_69.attackerId)).name, GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_local_69.defenderId)).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_51, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    _local_46 = PlayedCharacterManager.getInstance().id;
                    if (_local_46 == _local_69.attackerId)
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESS);
                    }
                    else
                    {
                        if (_local_46 == _local_69.defenderId)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.PlayerAggression, _local_69.attackerId, GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_local_69.attackerId)).name);
                            if (((AirScanner.hasAir()) && (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.ATTACK))))
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.ATTACK, [GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_local_69.attackerId)).name]);
                            };
                            SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESSED);
                        };
                    };
                    return (true);
                case (msg is LeaveShopStockAction):
                    _local_70 = new LeaveDialogRequestMessage();
                    _local_70.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_70);
                    return (true);
                case (msg is ExchangeShopStockMouvmentAddAction):
                    _local_71 = (msg as ExchangeShopStockMouvmentAddAction);
                    _local_72 = new ExchangeObjectMovePricedMessage();
                    _local_72.initExchangeObjectMovePricedMessage(_local_71.objectUID, _local_71.quantity, _local_71.price);
                    ConnectionsHandler.getConnection().send(_local_72);
                    return (true);
                case (msg is ExchangeShopStockMouvmentRemoveAction):
                    _local_73 = (msg as ExchangeShopStockMouvmentRemoveAction);
                    _local_74 = new ExchangeObjectMoveMessage();
                    _local_74.initExchangeObjectMoveMessage(_local_73.objectUID, _local_73.quantity);
                    ConnectionsHandler.getConnection().send(_local_74);
                    return (true);
                case (msg is ExchangeBuyAction):
                    _local_75 = (msg as ExchangeBuyAction);
                    _local_76 = new ExchangeBuyMessage();
                    _local_76.initExchangeBuyMessage(_local_75.objectUID, _local_75.quantity);
                    ConnectionsHandler.getConnection().send(_local_76);
                    return (true);
                case (msg is ExchangeSellAction):
                    _local_77 = (msg as ExchangeSellAction);
                    _local_78 = new ExchangeSellMessage();
                    _local_78.initExchangeSellMessage(_local_77.objectUID, _local_77.quantity);
                    ConnectionsHandler.getConnection().send(_local_78);
                    return (true);
                case (msg is ExchangeBuyOkMessage):
                    _local_79 = (msg as ExchangeBuyOkMessage);
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.BuyOk);
                    return (true);
                case (msg is ExchangeSellOkMessage):
                    _local_80 = (msg as ExchangeSellOkMessage);
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.SellOk);
                    return (true);
                case (msg is ExchangePlayerRequestAction):
                    _local_81 = (msg as ExchangePlayerRequestAction);
                    _local_82 = new ExchangePlayerRequestMessage();
                    _local_82.initExchangePlayerRequestMessage(_local_81.exchangeType, _local_81.target);
                    ConnectionsHandler.getConnection().send(_local_82);
                    return (true);
                case (msg is ExchangePlayerMultiCraftRequestAction):
                    _local_83 = (msg as ExchangePlayerMultiCraftRequestAction);
                    switch (_local_83.exchangeType)
                    {
                        case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                            this._customerID = _local_83.target;
                            this._crafterId = PlayedCharacterManager.getInstance().id;
                            break;
                        case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                            this._crafterId = _local_83.target;
                            this._customerID = PlayedCharacterManager.getInstance().id;
                            break;
                    };
                    _local_84 = new ExchangePlayerMultiCraftRequestMessage();
                    _local_84.initExchangePlayerMultiCraftRequestMessage(_local_83.exchangeType, _local_83.target, _local_83.skillId);
                    ConnectionsHandler.getConnection().send(_local_84);
                    return (true);
                case (msg is JobAllowMultiCraftRequestSetAction):
                    _local_85 = (msg as JobAllowMultiCraftRequestSetAction);
                    _local_86 = new JobAllowMultiCraftRequestSetMessage();
                    _local_86.initJobAllowMultiCraftRequestSetMessage(_local_85.isPublic);
                    ConnectionsHandler.getConnection().send(_local_86);
                    return (true);
                case (msg is JobAllowMultiCraftRequestMessage):
                    _local_87 = (msg as JobAllowMultiCraftRequestMessage);
                    _local_88 = (msg as JobAllowMultiCraftRequestMessage).getMessageId();
                    switch (_local_88)
                    {
                        case JobAllowMultiCraftRequestMessage.protocolId:
                            PlayedCharacterManager.getInstance().publicMode = _local_87.enabled;
                            KernelEventsManager.getInstance().processCallback(CraftHookList.JobAllowMultiCraftRequest, _local_87.enabled);
                            break;
                        case JobMultiCraftAvailableSkillsMessage.protocolId:
                            _local_131 = (msg as JobMultiCraftAvailableSkillsMessage);
                            if (_local_131.enabled)
                            {
                                mcefp = new MultiCraftEnableForPlayer();
                                mcefp.playerId = _local_131.playerId;
                                mcefp.skills = _local_131.skills;
                                alreadyIn = false;
                                for each (mcefplayer in this._playersMultiCraftSkill)
                                {
                                    if (mcefplayer.playerId == mcefp.playerId)
                                    {
                                        alreadyIn = true;
                                        mcefplayer.skills = _local_131.skills;
                                    };
                                };
                                if (!(alreadyIn))
                                {
                                    this._playersMultiCraftSkill.push(mcefp);
                                };
                            }
                            else
                            {
                                _local_135 = 0;
                                _local_136 = -1;
                                _local_135 = 0;
                                while (_local_135 < this._playersMultiCraftSkill.length)
                                {
                                    if (this._playersMultiCraftSkill[_local_135].playerId == _local_131.playerId)
                                    {
                                        _local_136 = _local_135;
                                    };
                                    _local_135++;
                                };
                                if (_local_136 > -1)
                                {
                                    this._playersMultiCraftSkill.splice(_local_136, 1);
                                };
                            };
                            break;
                    };
                    return (true);
                case (msg is SpellForgetUIMessage):
                    _local_89 = (msg as SpellForgetUIMessage);
                    if (_local_89.open)
                    {
                        Kernel.getWorker().addFrame(this._spellForgetDialogFrame);
                    }
                    else
                    {
                        Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                        Kernel.getWorker().removeFrame(this._spellForgetDialogFrame);
                    };
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.SpellForgetUI, _local_89.open);
                    return (true);
                case (msg is ChallengeFightJoinRefusedMessage):
                    _local_90 = (msg as ChallengeFightJoinRefusedMessage);
                    switch (_local_90.reason)
                    {
                        case FighterRefusedReasonEnum.CHALLENGE_FULL:
                            _local_51 = I18n.getUiText("ui.fight.challengeFull");
                            break;
                        case FighterRefusedReasonEnum.TEAM_FULL:
                            _local_51 = I18n.getUiText("ui.fight.teamFull");
                            break;
                        case FighterRefusedReasonEnum.WRONG_ALIGNMENT:
                            _local_51 = I18n.getUiText("ui.wrongAlignment");
                            break;
                        case FighterRefusedReasonEnum.WRONG_GUILD:
                            _local_51 = I18n.getUiText("ui.fight.wrongGuild");
                            break;
                        case FighterRefusedReasonEnum.TOO_LATE:
                            _local_51 = I18n.getUiText("ui.fight.tooLate");
                            break;
                        case FighterRefusedReasonEnum.MUTANT_REFUSED:
                            _local_51 = I18n.getUiText("ui.fight.mutantRefused");
                            break;
                        case FighterRefusedReasonEnum.WRONG_MAP:
                            _local_51 = I18n.getUiText("ui.fight.wrongMap");
                            break;
                        case FighterRefusedReasonEnum.JUST_RESPAWNED:
                            _local_51 = I18n.getUiText("ui.fight.justRespawned");
                            break;
                        case FighterRefusedReasonEnum.IM_OCCUPIED:
                            _local_51 = I18n.getUiText("ui.fight.imOccupied");
                            break;
                        case FighterRefusedReasonEnum.OPPONENT_OCCUPIED:
                            _local_51 = I18n.getUiText("ui.fight.opponentOccupied");
                            break;
                        case FighterRefusedReasonEnum.MULTIACCOUNT_NOT_ALLOWED:
                            _local_51 = I18n.getUiText("ui.fight.onlyOneAllowedAccount");
                            break;
                        case FighterRefusedReasonEnum.INSUFFICIENT_RIGHTS:
                            _local_51 = I18n.getUiText("ui.fight.insufficientRights");
                            break;
                        case FighterRefusedReasonEnum.MEMBER_ACCOUNT_NEEDED:
                            _local_51 = I18n.getUiText("ui.fight.memberAccountNeeded");
                            break;
                        case FighterRefusedReasonEnum.GUEST_ACCOUNT:
                            _local_51 = I18n.getUiText("ui.fight.guestAccount");
                            break;
                        case FighterRefusedReasonEnum.OPPONENT_NOT_MEMBER:
                            _local_51 = I18n.getUiText("ui.fight.opponentNotMember");
                            break;
                        case FighterRefusedReasonEnum.TEAM_LIMITED_BY_MAINCHARACTER:
                            _local_51 = I18n.getUiText("ui.fight.teamLimitedByMainCharacter");
                            break;
                        case FighterRefusedReasonEnum.GHOST_REFUSED:
                            _local_51 = I18n.getUiText("ui.fight.ghostRefused");
                            break;
                        case FighterRefusedReasonEnum.AVA_ZONE:
                            _local_51 = I18n.getUiText("ui.fight.cantAttackAvAZone");
                            break;
                        case FighterRefusedReasonEnum.RESTRICTED_ACCOUNT:
                            _local_51 = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                            break;
                        default:
                            return (true);
                    };
                    if (_local_51 != null)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_51, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is SpellForgottenMessage):
                    _local_91 = (msg as SpellForgottenMessage);
                    return (true);
                case (msg is ExchangeCraftResultMessage):
                    _local_92 = (msg as ExchangeCraftResultMessage);
                    _local_93 = _local_92.getMessageId();
                    if (_local_93 != ExchangeCraftInformationObjectMessage.protocolId)
                    {
                        return (false);
                    };
                    _local_94 = (msg as ExchangeCraftInformationObjectMessage);
                    switch (_local_94.craftResult)
                    {
                        case CraftResultEnum.CRAFT_SUCCESS:
                        case CraftResultEnum.CRAFT_FAILED:
                            _local_137 = Item.getItemById(_local_94.objectGenericId);
                            _local_138 = _local_137.iconId;
                            _local_95 = new CraftSmileyItem(_local_94.playerId, _local_138, _local_94.craftResult);
                            break;
                        case CraftResultEnum.CRAFT_IMPOSSIBLE:
                            _local_95 = new CraftSmileyItem(_local_94.playerId, -1, _local_94.craftResult);
                            break;
                    };
                    if ((DofusEntities.getEntity(_local_94.playerId) as IDisplayable))
                    {
                        absBounds = (DofusEntities.getEntity(_local_94.playerId) as IDisplayable).absoluteBounds;
                        TooltipManager.show(_local_95, absBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, ("craftSmiley" + _local_94.playerId), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, null, null, false, -1);
                    };
                    return (true);
                case (msg is GameRolePlayDelayedActionMessage):
                    _local_96 = (msg as GameRolePlayDelayedActionMessage);
                    if (_local_96.delayTypeId == DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE)
                    {
                        iconIdD = Item.getItemById(548).iconId;
                        csiD = new CraftSmileyItem(_local_96.delayedCharacterId, iconIdD, 2);
                        absBoundsD = (DofusEntities.getEntity(_local_96.delayedCharacterId) as IDisplayable).absoluteBounds;
                        TooltipManager.show(csiD, absBoundsD, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, ("craftSmiley" + _local_96.delayedCharacterId), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, null, null, false, -1);
                    };
                    return (true);
                case (msg is DocumentReadingBeginMessage):
                    _local_97 = (msg as DocumentReadingBeginMessage);
                    TooltipManager.hideAll();
                    if (!(Kernel.getWorker().contains(DocumentFrame)))
                    {
                        Kernel.getWorker().addFrame(this._documentFrame);
                    };
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.DocumentReadingBegin, _local_97.documentId);
                    return (true);
                case (msg is ComicReadingBeginMessage):
                    _local_98 = (msg as ComicReadingBeginMessage);
                    _local_99 = Comic.getComicById(_local_98.comicId);
                    if (_local_99)
                    {
                        TooltipManager.hideAll();
                        if (!(Kernel.getWorker().contains(DocumentFrame)))
                        {
                            Kernel.getWorker().addFrame(this._documentFrame);
                        };
                        KernelEventsManager.getInstance().processCallback(ExternalGameHookList.OpenComic, _local_99.remoteId, _local_99.readerUrl, LangManager.getInstance().getEntry("config.lang.current"));
                    };
                    return (true);
                case (((msg is ZaapListMessage)) || ((msg is TeleportDestinationsListMessage))):
                    if (!(Kernel.getWorker().contains(ZaapFrame)))
                    {
                        Kernel.getWorker().addFrame(this._zaapFrame);
                        Kernel.getWorker().process(msg);
                    };
                    return (false);
                case (msg is PaddockSellBuyDialogMessage):
                    _local_100 = (msg as PaddockSellBuyDialogMessage);
                    TooltipManager.hideAll();
                    if (!(Kernel.getWorker().contains(PaddockFrame)))
                    {
                        Kernel.getWorker().addFrame(this._paddockFrame);
                    };
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                    KernelEventsManager.getInstance().processCallback(MountHookList.PaddockSellBuyDialog, _local_100.bsell, _local_100.ownerId, _local_100.price);
                    return (true);
                case (msg is LeaveExchangeMountAction):
                    _local_101 = new LeaveDialogRequestMessage();
                    _local_101.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_101);
                    return (true);
                case (msg is PaddockPropertiesMessage):
                    this._currentPaddock = PaddockWrapper.create(PaddockPropertiesMessage(msg).properties);
                    return (true);
                case (msg is GameRolePlaySpellAnimMessage):
                    _local_102 = (msg as GameRolePlaySpellAnimMessage);
                    _local_103 = new RoleplaySpellCastProvider();
                    _local_103.castingSpell.casterId = _local_102.casterId;
                    _local_103.castingSpell.spell = Spell.getSpellById(_local_102.spellId);
                    _local_103.castingSpell.spellRank = _local_103.castingSpell.spell.getSpellLevel(_local_102.spellLevel);
                    _local_103.castingSpell.targetedCell = MapPoint.fromCellId(_local_102.targetCellId);
                    _local_104 = _local_103.castingSpell.spell.getScriptId(_local_103.castingSpell.isCriticalHit);
                    SpellScriptManager.getInstance().runSpellScript(_local_104, _local_103, new Callback(this.executeSpellBuffer, null, true, true, _local_103), new Callback(this.executeSpellBuffer, null, true, false, _local_103));
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            var allianceFrame:AllianceFrame = (Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame);
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
            return (true);
        }

        public function getActorName(actorId:int):String
        {
            var actorInfos:GameRolePlayActorInformations;
            var _local_3:GameRolePlayTaxCollectorInformations;
            actorInfos = this.getActorInfos(actorId);
            if (!(actorInfos))
            {
                return ("Unknown Actor");
            };
            switch (true)
            {
                case (actorInfos is GameRolePlayNamedActorInformations):
                    return ((actorInfos as GameRolePlayNamedActorInformations).name);
                case (actorInfos is GameRolePlayTaxCollectorInformations):
                    _local_3 = (actorInfos as GameRolePlayTaxCollectorInformations);
                    return (((TaxCollectorFirstname.getTaxCollectorFirstnameById(_local_3.identification.firstNameId).firstname + " ") + TaxCollectorName.getTaxCollectorNameById(_local_3.identification.lastNameId).name));
                case (actorInfos is GameRolePlayNpcInformations):
                    return (Npc.getNpcById((actorInfos as GameRolePlayNpcInformations).npcId).name);
                case (actorInfos is GameRolePlayGroupMonsterInformations):
                case (actorInfos is GameRolePlayPrismInformations):
                case (actorInfos is GameRolePlayPortalInformations):
                    _log.error((("Fail: getActorName called with an actorId corresponding to a monsters group or a prism or a portal (" + actorInfos) + ")."));
                    return ("<error: cannot get a name>");
            };
            return ("Unknown Actor Type");
        }

        private function getActorInfos(actorId:int):GameRolePlayActorInformations
        {
            return ((this.entitiesFrame.getEntityInfos(actorId) as GameRolePlayActorInformations));
        }

        private function executeSpellBuffer(callback:Function, hadScript:Boolean, scriptSuccess:Boolean=false, castProvider:RoleplaySpellCastProvider=null):void
        {
            var step:ISequencable;
            var ss:SerialSequencer = new SerialSequencer();
            for each (step in castProvider.stepsBuffer)
            {
                ss.addStep(step);
            };
            ss.start();
        }

        private function addCraftFrame():void
        {
            if (!(Kernel.getWorker().contains(CraftFrame)))
            {
                Kernel.getWorker().addFrame(this._craftFrame);
            };
        }

        private function addCommonExchangeFrame(pExchangeType:uint):void
        {
            if (!(Kernel.getWorker().contains(CommonExchangeManagementFrame)))
            {
                this._commonExchangeFrame = new CommonExchangeManagementFrame(pExchangeType);
                Kernel.getWorker().addFrame(this._commonExchangeFrame);
            };
        }

        private function onListenOrientation(e:MouseEvent):void
        {
            var point:Point = this._playerEntity.localToGlobal(new Point(0, 0));
            var difY:Number = (StageShareManager.stage.mouseY - point.y);
            var difX:Number = (StageShareManager.stage.mouseX - point.x);
            var orientation:uint = AngleToOrientation.angleToOrientation(Math.atan2(difY, difX));
            var animation:String = this._playerEntity.getAnimation();
            var currentEmoticon:Emoticon = Emoticon.getEmoticonById(this._entitiesFrame.currentEmoticon);
            if (((!(currentEmoticon)) || (((currentEmoticon) && (currentEmoticon.eight_directions)))))
            {
                this._playerEntity.setDirection(orientation);
            }
            else
            {
                if ((orientation % 2) == 0)
                {
                    this._playerEntity.setDirection((orientation + 1));
                }
                else
                {
                    this._playerEntity.setDirection(orientation);
                };
            };
        }

        private function onClickOrientation(e:MouseEvent):void
        {
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onListenOrientation);
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK, this.onClickOrientation);
            var animation:String = this._playerEntity.getAnimation();
            var gmcormsg:GameMapChangeOrientationRequestMessage = new GameMapChangeOrientationRequestMessage();
            gmcormsg.initGameMapChangeOrientationRequestMessage(this._playerEntity.getDirection());
            ConnectionsHandler.getConnection().send(gmcormsg);
        }

        private function onInteractiveAnimationEnd(pTimerEvent:TimerEvent):void
        {
            var bonusQty:uint;
            pTimerEvent.currentTarget.removeEventListener(TimerEvent.TIMER, this.onInteractiveAnimationEnd);
            if (this._obtainedItemMsg)
            {
                bonusQty = (((this._obtainedItemMsg is ObtainedItemWithBonusMessage)) ? (this._obtainedItemMsg as ObtainedItemWithBonusMessage).bonusQuantity : 0);
                this.displayObtainedItem(this._obtainedItemMsg.genericId, this._obtainedItemMsg.baseQuantity, bonusQty);
            };
            this._obtainedItemMsg = null;
        }

        private function displayObtainedItem(pItemGID:uint, pItemQuantity:uint, pItemBonusQuantity:uint=0):void
        {
            var entity:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            var itemW:ItemWrapper = ItemWrapper.create(0, 0, pItemGID, 1, null);
            var iconUri:Uri = itemW.getIconUri();
            this._itemIcon.uri = iconUri;
            this._itemIcon.finalize();
            CharacteristicContextualManager.getInstance().addStatContextualWithIcon(this._itemIcon, pItemQuantity.toString(), entity, this._obtainedItemTextFormat, 1, 1, 1500);
            if (pItemBonusQuantity > 0)
            {
                this._itemBonusIcon.uri = iconUri;
                this._itemBonusIcon.finalize();
                CharacteristicContextualManager.getInstance().addStatContextualWithIcon(this._itemBonusIcon, pItemBonusQuantity.toString(), entity, this._obtainedItemBonusTextFormat, 1, 1, 1500);
            };
        }

        public function getMultiCraftSkills(pPlayerId:uint):Vector.<uint>
        {
            var mcefp:MultiCraftEnableForPlayer;
            for each (mcefp in this._playersMultiCraftSkill)
            {
                if (mcefp.playerId == pPlayerId)
                {
                    return (mcefp.skills);
                };
            };
            return (null);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.frames

import __AS3__.vec.Vector;

class MultiCraftEnableForPlayer 
{

    public var playerId:uint;
    public var skills:Vector.<uint>;


}


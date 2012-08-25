package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.approach.managers.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.bid.*;
    import com.ankamagames.dofus.logic.game.common.actions.craft.*;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.*;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.*;
    import com.ankamagames.dofus.logic.game.common.actions.mount.*;
    import com.ankamagames.dofus.logic.game.common.actions.roleplay.*;
    import com.ankamagames.dofus.logic.game.common.actions.taxCollector.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.messages.*;
    import com.ankamagames.dofus.logic.game.roleplay.types.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.basic.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.death.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.document.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.visual.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.guild.*;
    import com.ankamagames.dofus.network.messages.game.guild.tax.*;
    import com.ankamagames.dofus.network.messages.game.interactive.zaap.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.messages.game.inventory.items.*;
    import com.ankamagames.dofus.network.messages.game.script.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.scripts.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.script.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.hurlant.util.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class RoleplayContextFrame extends Object implements Frame
    {
        private var _priority:int = 0;
        private var _entitiesFrame:RoleplayEntitiesFrame;
        private var _worldFrame:RoleplayWorldFrame;
        private var _interactivesFrame:RoleplayInteractivesFrame;
        private var _npcDialogFrame:NpcDialogFrame;
        private var _documentFrame:DocumentFrame;
        private var _zaapFrame:ZaapFrame;
        private var _paddockFrame:PaddockFrame;
        private var _emoticonFrame:RoleplayEmoticonFrame;
        private var _exchangeManagementFrame:ExchangeManagementFrame;
        private var _humanVendorManagementFrame:HumanVendorManagementFrame;
        private var _spectatorManagementFrame:SpectatorManagementFrame;
        private var _bidHouseManagementFrame:BidHouseManagementFrame;
        private var _estateFrame:EstateFrame;
        private var _prismFrame:PrismFrame;
        private var _craftFrame:CraftFrame;
        private var _commonExchangeFrame:CommonExchangeManagementFrame;
        private var _movementFrame:RoleplayMovementFrame;
        private var _spellForgetDialogFrame:SpellForgetDialogFrame;
        private var _currentWaitingFightId:uint;
        private var _crafterId:uint;
        private var _customerID:uint;
        private var _playersMultiCraftSkill:Array;
        private var _currentPaddock:PaddockWrapper;
        private var _playerEntity:AnimatedCharacter;
        private var _intercationIsLimited:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayContextFrame));
        private static const ASTRUB_SUBAREA_IDS:Array = [143, 92, 95, 96, 97, 98, 99, 100, 101, 173, 318, 306];
        private static const GENERIC_MAP:uint = 7604237;
        private static var currentStatus:int = -1;

        public function RoleplayContextFrame()
        {
            return;
        }// end function

        public function get crafterId() : uint
        {
            return this._crafterId;
        }// end function

        public function get customerID() : uint
        {
            return this._customerID;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function set priority(param1:int) : void
        {
            this._priority = param1;
            return;
        }// end function

        public function get entitiesFrame() : RoleplayEntitiesFrame
        {
            return this._entitiesFrame;
        }// end function

        public function get hasWorldInteraction() : Boolean
        {
            return !this._intercationIsLimited;
        }// end function

        public function get commonExchangeFrame() : CommonExchangeManagementFrame
        {
            return this._commonExchangeFrame;
        }// end function

        public function get hasGuildedPaddock() : Boolean
        {
            return this._currentPaddock && this._currentPaddock.guildIdentity;
        }// end function

        public function get currentPaddock() : PaddockWrapper
        {
            return this._currentPaddock;
        }// end function

        public function pushed() : Boolean
        {
            this._entitiesFrame = new RoleplayEntitiesFrame();
            this._movementFrame = new RoleplayMovementFrame();
            this._worldFrame = new RoleplayWorldFrame();
            this._interactivesFrame = new RoleplayInteractivesFrame();
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
            if (!Kernel.getWorker().contains(EstateFrame))
            {
                Kernel.getWorker().addFrame(this._estateFrame);
            }
            this._prismFrame = Kernel.getWorker().getFrame(PrismFrame) as PrismFrame;
            this._prismFrame.pushRoleplay();
            if (!Kernel.getWorker().contains(RoleplayEmoticonFrame))
            {
                this._emoticonFrame = new RoleplayEmoticonFrame();
                Kernel.getWorker().addFrame(this._emoticonFrame);
            }
            else
            {
                this._emoticonFrame = Kernel.getWorker().getFrame(RoleplayEmoticonFrame) as RoleplayEmoticonFrame;
            }
            this._playersMultiCraftSkill = new Array();
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:CurrentMapMessage = null;
            var _loc_3:WorldPointWrapper = null;
            var _loc_4:ByteArray = null;
            var _loc_5:Object = null;
            var _loc_6:MapPosition = null;
            var _loc_7:ChangeWorldInteractionAction = null;
            var _loc_8:Boolean = false;
            var _loc_9:NpcGenericActionRequestAction = null;
            var _loc_10:IEntity = null;
            var _loc_11:NpcGenericActionRequestMessage = null;
            var _loc_12:ExchangeRequestOnTaxCollectorAction = null;
            var _loc_13:ExchangeRequestOnTaxCollectorMessage = null;
            var _loc_14:IEntity = null;
            var _loc_15:GameRolePlayTaxCollectorFightRequestAction = null;
            var _loc_16:GameRolePlayTaxCollectorFightRequestMessage = null;
            var _loc_17:InteractiveElementActivationAction = null;
            var _loc_18:InteractiveElementActivationMessage = null;
            var _loc_19:DisplayContextualMenuAction = null;
            var _loc_20:GameContextActorInformations = null;
            var _loc_21:RoleplayInteractivesFrame = null;
            var _loc_22:NpcDialogCreationMessage = null;
            var _loc_23:Object = null;
            var _loc_24:ExchangeStartedMountStockMessage = null;
            var _loc_25:ExchangeStartOkNpcShopMessage = null;
            var _loc_26:ExchangeStartedMessage = null;
            var _loc_27:ObjectFoundWhileRecoltingMessage = null;
            var _loc_28:Item = null;
            var _loc_29:uint = 0;
            var _loc_30:CraftSmileyItem = null;
            var _loc_31:uint = 0;
            var _loc_32:String = null;
            var _loc_33:String = null;
            var _loc_34:String = null;
            var _loc_35:PlayerFightRequestAction = null;
            var _loc_36:GameRolePlayPlayerFightRequestMessage = null;
            var _loc_37:IEntity = null;
            var _loc_38:PlayerFightFriendlyAnswerAction = null;
            var _loc_39:GameRolePlayPlayerFightFriendlyAnswerMessage = null;
            var _loc_40:GameRolePlayPlayerFightFriendlyAnsweredMessage = null;
            var _loc_41:GameRolePlayFightRequestCanceledMessage = null;
            var _loc_42:GameRolePlayPlayerFightFriendlyRequestedMessage = null;
            var _loc_43:GameRolePlayFreeSoulRequestMessage = null;
            var _loc_44:LeaveDialogRequestMessage = null;
            var _loc_45:ExchangeErrorMessage = null;
            var _loc_46:String = null;
            var _loc_47:GameRolePlayAggressionMessage = null;
            var _loc_48:LeaveDialogRequestMessage = null;
            var _loc_49:ExchangeShopStockMouvmentAddAction = null;
            var _loc_50:ExchangeObjectMovePricedMessage = null;
            var _loc_51:ExchangeShopStockMouvmentRemoveAction = null;
            var _loc_52:ExchangeObjectMoveMessage = null;
            var _loc_53:ExchangeBuyAction = null;
            var _loc_54:ExchangeBuyMessage = null;
            var _loc_55:ExchangeSellAction = null;
            var _loc_56:ExchangeSellMessage = null;
            var _loc_57:ExchangeBuyOkMessage = null;
            var _loc_58:ExchangeSellOkMessage = null;
            var _loc_59:ExchangePlayerRequestAction = null;
            var _loc_60:ExchangePlayerRequestMessage = null;
            var _loc_61:ExchangePlayerMultiCraftRequestAction = null;
            var _loc_62:ExchangePlayerMultiCraftRequestMessage = null;
            var _loc_63:JobAllowMultiCraftRequestSetAction = null;
            var _loc_64:JobAllowMultiCraftRequestSetMessage = null;
            var _loc_65:JobAllowMultiCraftRequestMessage = null;
            var _loc_66:uint = 0;
            var _loc_67:SpellForgetUIMessage = null;
            var _loc_68:ChallengeFightJoinRefusedMessage = null;
            var _loc_69:SpellForgottenMessage = null;
            var _loc_70:ExchangeCraftResultMessage = null;
            var _loc_71:uint = 0;
            var _loc_72:ExchangeCraftInformationObjectMessage = null;
            var _loc_73:CraftSmileyItem = null;
            var _loc_74:DocumentReadingBeginMessage = null;
            var _loc_75:PaddockSellBuyDialogMessage = null;
            var _loc_76:GameRolePlaySpellAnimMessage = null;
            var _loc_77:RoleplaySpellCastProvider = null;
            var _loc_78:Uri = null;
            var _loc_79:SpellFxRunner = null;
            var _loc_80:CinematicMessage = null;
            var _loc_81:BasicSwitchModeAction = null;
            var _loc_82:String = null;
            var _loc_83:Object = null;
            var _loc_84:ErrorMapNotFoundMessage = null;
            var _loc_85:WorldPoint = null;
            var _loc_86:int = 0;
            var _loc_87:int = 0;
            var _loc_88:int = 0;
            var _loc_89:Map = null;
            var _loc_90:Boolean = false;
            var _loc_91:GameRolePlayNpcInformations = null;
            var _loc_92:GameRolePlayTaxCollectorInformations = null;
            var _loc_93:IRectangle = null;
            var _loc_94:GameRolePlayCharacterInformations = null;
            var _loc_95:int = 0;
            var _loc_96:int = 0;
            var _loc_97:RoleplayContextFrame = null;
            var _loc_98:GameRolePlayActorInformations = null;
            var _loc_99:GameContextActorInformations = null;
            var _loc_100:JobMultiCraftAvailableSkillsMessage = null;
            var _loc_101:MultiCraftEnableForPlayer = null;
            var _loc_102:Boolean = false;
            var _loc_103:uint = 0;
            var _loc_104:uint = 0;
            var _loc_105:MultiCraftEnableForPlayer = null;
            var _loc_106:Item = null;
            var _loc_107:uint = 0;
            var _loc_108:IRectangle = null;
            var _loc_109:BasicSetAwayModeRequestMessage = null;
            switch(true)
            {
                case param1 is CurrentMapMessage:
                {
                    _loc_2 = param1 as CurrentMapMessage;
                    ConnectionsHandler.pause();
                    Kernel.getWorker().pause();
                    if (TacticModeManager.getInstance().tacticModeActivated)
                    {
                        TacticModeManager.getInstance().hide();
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    if (this._entitiesFrame && Kernel.getWorker().contains(RoleplayEntitiesFrame))
                    {
                        Kernel.getWorker().removeFrame(this._entitiesFrame);
                    }
                    if (this._worldFrame && Kernel.getWorker().contains(RoleplayWorldFrame))
                    {
                        Kernel.getWorker().removeFrame(this._worldFrame);
                    }
                    if (this._interactivesFrame && Kernel.getWorker().contains(RoleplayInteractivesFrame))
                    {
                        Kernel.getWorker().removeFrame(this._interactivesFrame);
                    }
                    if (this._movementFrame && Kernel.getWorker().contains(RoleplayMovementFrame))
                    {
                        Kernel.getWorker().removeFrame(this._movementFrame);
                    }
                    if (PlayedCharacterManager.getInstance().isInHouse)
                    {
                        _loc_3 = new WorldPointWrapper(_loc_2.mapId, true, PlayedCharacterManager.getInstance().currentMap.outdoorX, PlayedCharacterManager.getInstance().currentMap.outdoorY);
                    }
                    else
                    {
                        _loc_3 = new WorldPointWrapper(_loc_2.mapId);
                    }
                    Atouin.getInstance().initPreDisplay(_loc_3);
                    Atouin.getInstance().clearEntities();
                    if (_loc_2.mapKey && _loc_2.mapKey.length)
                    {
                        _loc_82 = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                        _loc_82 = "649ae451ca33ec53bbcbcc33becf15f4";
                        if (!_loc_82)
                        {
                            _loc_82 = _loc_2.mapKey;
                        }
                        _loc_4 = Hex.toArray(Hex.fromString(_loc_82));
                    }
                    Atouin.getInstance().display(_loc_3, _loc_4);
                    PlayedCharacterManager.getInstance().currentMap = _loc_3;
                    TooltipManager.hideAll();
                    _loc_5 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                    _loc_5.closeAllMenu();
                    this._currentPaddock = null;
                    _loc_6 = MapPosition.getMapPositionById(_loc_2.mapId);
                    if (_loc_6 && ASTRUB_SUBAREA_IDS.indexOf(_loc_6.subAreaId) != -1)
                    {
                        PartManager.getInstance().checkAndDownload("all");
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.CurrentMap, _loc_2.mapId);
                    return true;
                }
                case param1 is MapsLoadingCompleteMessage:
                {
                    if (!Kernel.getWorker().contains(RoleplayEntitiesFrame))
                    {
                        Kernel.getWorker().addFrame(this._entitiesFrame);
                    }
                    TooltipManager.hideAll();
                    KernelEventsManager.getInstance().processCallback(HookList.MapsLoadingComplete, MapsLoadingCompleteMessage(param1).mapPoint);
                    if (!Kernel.getWorker().contains(RoleplayWorldFrame))
                    {
                        Kernel.getWorker().addFrame(this._worldFrame);
                    }
                    if (!Kernel.getWorker().contains(RoleplayInteractivesFrame))
                    {
                        Kernel.getWorker().addFrame(this._interactivesFrame);
                    }
                    if (!Kernel.getWorker().contains(RoleplayMovementFrame))
                    {
                        Kernel.getWorker().addFrame(this._movementFrame);
                    }
                    SoundManager.getInstance().manager.setSubArea(MapsLoadingCompleteMessage(param1).mapData);
                    Atouin.getInstance().updateCursor();
                    Kernel.getWorker().resume();
                    ConnectionsHandler.resume();
                    return true;
                }
                case param1 is MapLoadingFailedMessage:
                {
                    switch(MapLoadingFailedMessage(param1).errorReason)
                    {
                        case MapLoadingFailedMessage.NO_FILE:
                        {
                            _loc_83 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                            _loc_83.openPopup(I18n.getUiText("ui.popup.information"), I18n.getUiText("ui.no.mapdata.file"), [I18n.getUiText("ui.common.ok")]);
                            _loc_84 = new ErrorMapNotFoundMessage();
                            _loc_84.initErrorMapNotFoundMessage(MapLoadingFailedMessage(param1).id);
                            ConnectionsHandler.getConnection().send(_loc_84);
                            if (MapMessage(param1).id != GENERIC_MAP)
                            {
                                _loc_85 = new WorldPoint();
                                _loc_85.mapId = GENERIC_MAP;
                                Atouin.getInstance().display(_loc_85);
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case param1 is MapLoadedMessage:
                {
                    if (MapLoadedMessage(param1).id == GENERIC_MAP)
                    {
                        _loc_86 = PlayedCharacterManager.getInstance().currentMap.x;
                        _loc_87 = PlayedCharacterManager.getInstance().currentMap.y;
                        _loc_88 = PlayedCharacterManager.getInstance().currentMap.worldId;
                        _loc_89 = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
                        _loc_89.rightNeighbourId = WorldPoint.fromCoords(_loc_88, (_loc_86 + 1), _loc_87).mapId;
                        _loc_89.leftNeighbourId = WorldPoint.fromCoords(_loc_88, (_loc_86 - 1), _loc_87).mapId;
                        _loc_89.bottomNeighbourId = WorldPoint.fromCoords(_loc_88, _loc_86, (_loc_87 + 1)).mapId;
                        _loc_89.topNeighbourId = WorldPoint.fromCoords(_loc_88, _loc_86, (_loc_87 - 1)).mapId;
                    }
                    return false;
                }
                case param1 is ChangeWorldInteractionAction:
                {
                    _loc_7 = param1 as ChangeWorldInteractionAction;
                    _loc_8 = false;
                    if (Kernel.getWorker().contains(BidHouseManagementFrame) && this._bidHouseManagementFrame.switching)
                    {
                        _loc_8 = true;
                    }
                    this._intercationIsLimited = !_loc_7.enabled;
                    switch(_loc_7.total)
                    {
                        case true:
                        {
                            if (_loc_7.enabled)
                            {
                                if (!Kernel.getWorker().contains(RoleplayWorldFrame) && !_loc_8 && SystemApi.wordInterfactionEnable)
                                {
                                    _log.info("Enabling interaction with the roleplay world.");
                                    Kernel.getWorker().addFrame(this._worldFrame);
                                }
                                this._worldFrame.allowOnlyCharacterInteraction = false;
                            }
                            else if (Kernel.getWorker().contains(RoleplayWorldFrame))
                            {
                                _log.info("Disabling interaction with the roleplay world.");
                                Kernel.getWorker().removeFrame(this._worldFrame);
                            }
                            break;
                        }
                        case false:
                        {
                            if (_loc_7.enabled)
                            {
                                if (!Kernel.getWorker().contains(RoleplayWorldFrame) && !_loc_8)
                                {
                                    _log.info("Enabling total interaction with the roleplay world.");
                                    Kernel.getWorker().addFrame(this._worldFrame);
                                    this._worldFrame.allowOnlyCharacterInteraction = false;
                                }
                                if (!Kernel.getWorker().contains(RoleplayInteractivesFrame))
                                {
                                    Kernel.getWorker().addFrame(this._interactivesFrame);
                                }
                            }
                            else if (Kernel.getWorker().contains(RoleplayWorldFrame))
                            {
                                _log.info("Disabling partial interactions with the roleplay world.");
                                this._worldFrame.allowOnlyCharacterInteraction = true;
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case param1 is NpcGenericActionRequestAction:
                {
                    _loc_9 = param1 as NpcGenericActionRequestAction;
                    _loc_10 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    _loc_11 = new NpcGenericActionRequestMessage();
                    _loc_11.initNpcGenericActionRequestMessage(_loc_9.npcId, _loc_9.actionId, PlayedCharacterManager.getInstance().currentMap.mapId);
                    if ((_loc_10 as IMovable).isMoving)
                    {
                        (_loc_10 as IMovable).stop();
                        this._movementFrame.setFollowingMessage(_loc_11);
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_loc_11);
                    }
                    return true;
                }
                case param1 is ExchangeRequestOnTaxCollectorAction:
                {
                    _loc_12 = param1 as ExchangeRequestOnTaxCollectorAction;
                    _loc_13 = new ExchangeRequestOnTaxCollectorMessage();
                    _loc_13.initExchangeRequestOnTaxCollectorMessage(_loc_12.taxCollectorId);
                    _loc_14 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if ((_loc_14 as IMovable).isMoving)
                    {
                        this._movementFrame.setFollowingMessage(_loc_13);
                        (_loc_14 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_loc_13);
                    }
                    return true;
                }
                case param1 is GameRolePlayTaxCollectorFightRequestAction:
                {
                    _loc_15 = param1 as GameRolePlayTaxCollectorFightRequestAction;
                    _loc_16 = new GameRolePlayTaxCollectorFightRequestMessage();
                    _loc_16.initGameRolePlayTaxCollectorFightRequestMessage(_loc_15.taxCollectorId);
                    ConnectionsHandler.getConnection().send(_loc_16);
                    return true;
                }
                case param1 is InteractiveElementActivationAction:
                {
                    _loc_17 = param1 as InteractiveElementActivationAction;
                    _loc_18 = new InteractiveElementActivationMessage(_loc_17.interactiveElement, _loc_17.position, _loc_17.skillInstanceId);
                    Kernel.getWorker().process(_loc_18);
                    return true;
                }
                case param1 is DisplayContextualMenuAction:
                {
                    _loc_19 = param1 as DisplayContextualMenuAction;
                    _loc_20 = this.entitiesFrame.getEntityInfos(_loc_19.playerId);
                    if (_loc_20)
                    {
                        _loc_90 = RoleplayManager.getInstance().displayCharacterContextualMenu(_loc_20);
                    }
                    return false;
                }
                case param1 is PivotCharacterAction:
                {
                    _loc_21 = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
                    if (_loc_21 && !_loc_21.usingInteractive)
                    {
                        Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                        this._playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().infos.id) as AnimatedCharacter;
                        StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onListenOrientation);
                        StageShareManager.stage.addEventListener(MouseEvent.CLICK, this.onClickOrientation);
                    }
                    return true;
                }
                case param1 is NpcGenericActionFailureMessage:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.NpcDialogCreationFailure);
                    return true;
                }
                case param1 is NpcDialogCreationMessage:
                {
                    _loc_22 = param1 as NpcDialogCreationMessage;
                    _loc_23 = this._entitiesFrame.getEntityInfos(_loc_22.npcId);
                    if (!Kernel.getWorker().contains(NpcDialogFrame))
                    {
                        Kernel.getWorker().addFrame(this._npcDialogFrame);
                    }
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                    if (_loc_23 is GameRolePlayNpcInformations)
                    {
                        _loc_91 = _loc_23 as GameRolePlayNpcInformations;
                        KernelEventsManager.getInstance().processCallback(HookList.NpcDialogCreation, _loc_22.mapId, _loc_91.npcId, EntityLookAdapter.fromNetwork(_loc_91.look));
                    }
                    else if (_loc_23 is GameRolePlayTaxCollectorInformations)
                    {
                        _loc_92 = _loc_23 as GameRolePlayTaxCollectorInformations;
                        KernelEventsManager.getInstance().processCallback(HookList.PonyDialogCreation, _loc_22.mapId, _loc_92.firstNameId, _loc_92.lastNameId, EntityLookAdapter.fromNetwork(_loc_92.look));
                    }
                    return true;
                }
                case param1 is GameContextDestroyMessage:
                {
                    TooltipManager.hide();
                    Kernel.getWorker().removeFrame(this);
                    return true;
                }
                case param1 is ExchangeStartedBidBuyerMessage:
                {
                    if (!Kernel.getWorker().contains(BidHouseManagementFrame))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
                    }
                    this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_BUY);
                    if (!Kernel.getWorker().contains(BidHouseManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
                    }
                    this._bidHouseManagementFrame.processExchangeStartedBidBuyerMessage(param1 as ExchangeStartedBidBuyerMessage);
                    return true;
                }
                case param1 is ExchangeStartedBidSellerMessage:
                {
                    if (!Kernel.getWorker().contains(BidHouseManagementFrame))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
                    }
                    this.addCommonExchangeFrame(ExchangeTypeEnum.BIDHOUSE_SELL);
                    if (!Kernel.getWorker().contains(BidHouseManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._bidHouseManagementFrame);
                    }
                    this._bidHouseManagementFrame.processExchangeStartedBidSellerMessage(param1 as ExchangeStartedBidSellerMessage);
                    return true;
                }
                case param1 is ExchangeRequestOnShopStockAction:
                case param1 is ExchangeStartAsVendorRequestAction:
                case param1 is ExchangeShowVendorTaxAction:
                case param1 is ExchangeOnHumanVendorRequestAction:
                {
                    if (!Kernel.getWorker().contains(HumanVendorManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._humanVendorManagementFrame);
                    }
                    this._humanVendorManagementFrame.process(param1);
                    return true;
                }
                case param1 is ExchangeStartedMountStockMessage:
                {
                    _loc_24 = ExchangeStartedMountStockMessage(param1);
                    this.addCommonExchangeFrame(ExchangeTypeEnum.MOUNT);
                    if (!Kernel.getWorker().contains(ExchangeManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                    }
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeBankStarted, ExchangeTypeEnum.MOUNT, _loc_24.objectsInfos, 0);
                    this._exchangeManagementFrame.initMountStock(_loc_24.objectsInfos);
                    return true;
                }
                case param1 is ExchangeRequestedTradeMessage:
                {
                    this.addCommonExchangeFrame(ExchangeTypeEnum.PLAYER_TRADE);
                    if (!Kernel.getWorker().contains(ExchangeManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                        this._exchangeManagementFrame.processExchangeRequestedTradeMessage(param1 as ExchangeRequestedTradeMessage);
                    }
                    return true;
                }
                case param1 is ExchangeStartOkNpcTradeMessage:
                {
                    this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_TRADE);
                    if (!Kernel.getWorker().contains(ExchangeManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                        this._exchangeManagementFrame.processExchangeStartOkNpcTradeMessage(param1 as ExchangeStartOkNpcTradeMessage);
                    }
                    return true;
                }
                case param1 is ExchangeStartOkNpcShopMessage:
                {
                    _loc_25 = param1 as ExchangeStartOkNpcShopMessage;
                    this.addCommonExchangeFrame(ExchangeTypeEnum.NPC_SHOP);
                    if (!Kernel.getWorker().contains(ExchangeManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                    }
                    this._exchangeManagementFrame.process(param1);
                    return true;
                }
                case param1 is ExchangeStartedMessage:
                {
                    _loc_26 = param1 as ExchangeStartedMessage;
                    switch(_loc_26.exchangeType)
                    {
                        case ExchangeTypeEnum.CRAFT:
                        case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                        case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                        {
                            this.addCraftFrame();
                            break;
                        }
                        case ExchangeTypeEnum.BIDHOUSE_BUY:
                        case ExchangeTypeEnum.BIDHOUSE_SELL:
                        case ExchangeTypeEnum.PLAYER_TRADE:
                        {
                        }
                        default:
                        {
                            break;
                            break;
                        }
                    }
                    this.addCommonExchangeFrame(_loc_26.exchangeType);
                    if (!Kernel.getWorker().contains(ExchangeManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                    }
                    this._exchangeManagementFrame.process(param1);
                    return true;
                }
                case param1 is ExchangeOkMultiCraftMessage:
                {
                    this.addCraftFrame();
                    this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
                    this._craftFrame.processExchangeOkMultiCraftMessage(param1 as ExchangeOkMultiCraftMessage);
                    return true;
                }
                case param1 is ExchangeStartOkCraftWithInformationMessage:
                {
                    this.addCraftFrame();
                    this.addCommonExchangeFrame(ExchangeTypeEnum.CRAFT);
                    this._craftFrame.processExchangeStartOkCraftWithInformationMessage(param1 as ExchangeStartOkCraftWithInformationMessage);
                    return true;
                }
                case param1 is ObjectFoundWhileRecoltingMessage:
                {
                    _loc_27 = param1 as ObjectFoundWhileRecoltingMessage;
                    _loc_28 = Item.getItemById(_loc_27.genericId);
                    _loc_29 = PlayedCharacterManager.getInstance().id;
                    _loc_30 = new CraftSmileyItem(_loc_29, _loc_28.iconId, 2);
                    if (DofusEntities.getEntity(_loc_29) as IDisplayable)
                    {
                        _loc_93 = (DofusEntities.getEntity(_loc_29) as IDisplayable).absoluteBounds;
                        TooltipManager.show(_loc_30, _loc_93, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "craftSmiley" + _loc_29, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null);
                    }
                    _loc_31 = _loc_27.quantity;
                    _loc_32 = _loc_27.genericId ? (Item.getItemById(_loc_27.genericId).name) : (I18n.getUiText("ui.common.kamas"));
                    _loc_33 = Item.getItemById(_loc_27.ressourceGenericId).name;
                    _loc_34 = I18n.getUiText("ui.common.itemFound", [_loc_31, _loc_32, _loc_33]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_34, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is PlayerFightRequestAction:
                {
                    _loc_35 = PlayerFightRequestAction(param1);
                    if (!_loc_35.launch && !_loc_35.friendly)
                    {
                        _loc_94 = this.entitiesFrame.getEntityInfos(_loc_35.targetedPlayerId) as GameRolePlayCharacterInformations;
                        if (_loc_94)
                        {
                            if (_loc_94.alignmentInfos.alignmentSide == 0)
                            {
                                _loc_97 = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                                _loc_98 = _loc_97.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations;
                                if (!(_loc_98 is GameRolePlayMutantInformations))
                                {
                                    KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer, _loc_35.targetedPlayerId, _loc_94.name, 2, _loc_35.cellId);
                                    return true;
                                }
                            }
                            _loc_95 = _loc_94.alignmentInfos.characterPower - _loc_35.targetedPlayerId;
                            _loc_96 = PlayedCharacterManager.getInstance().levelDiff(_loc_95);
                            if (_loc_96)
                            {
                                KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer, _loc_35.targetedPlayerId, _loc_94.name, _loc_96, _loc_35.cellId);
                                return true;
                            }
                        }
                    }
                    _loc_36 = new GameRolePlayPlayerFightRequestMessage();
                    _loc_36.initGameRolePlayPlayerFightRequestMessage(_loc_35.targetedPlayerId, _loc_35.cellId, _loc_35.friendly);
                    _loc_37 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if ((_loc_37 as IMovable).isMoving)
                    {
                        this._movementFrame.setFollowingMessage(_loc_35);
                        (_loc_37 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_loc_36);
                    }
                    return true;
                }
                case param1 is PlayerFightFriendlyAnswerAction:
                {
                    _loc_38 = PlayerFightFriendlyAnswerAction(param1);
                    _loc_39 = new GameRolePlayPlayerFightFriendlyAnswerMessage();
                    _loc_39.initGameRolePlayPlayerFightFriendlyAnswerMessage(this._currentWaitingFightId, _loc_38.accept);
                    _loc_39.accept = _loc_38.accept;
                    _loc_39.fightId = this._currentWaitingFightId;
                    ConnectionsHandler.getConnection().send(_loc_39);
                    return true;
                }
                case param1 is GameRolePlayPlayerFightFriendlyAnsweredMessage:
                {
                    _loc_40 = param1 as GameRolePlayPlayerFightFriendlyAnsweredMessage;
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered, _loc_40.accept);
                    return true;
                }
                case param1 is GameRolePlayFightRequestCanceledMessage:
                {
                    _loc_41 = param1 as GameRolePlayFightRequestCanceledMessage;
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered, false);
                    return true;
                }
                case param1 is GameRolePlayPlayerFightFriendlyRequestedMessage:
                {
                    _loc_42 = param1 as GameRolePlayPlayerFightFriendlyRequestedMessage;
                    this._currentWaitingFightId = _loc_42.fightId;
                    if (_loc_42.sourceId != PlayedCharacterManager.getInstance().infos.id)
                    {
                        if (this._entitiesFrame.getEntityInfos(_loc_42.sourceId))
                        {
                            KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyRequested, GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc_42.sourceId)).name);
                        }
                    }
                    else
                    {
                        _loc_99 = this._entitiesFrame.getEntityInfos(_loc_42.targetId);
                        if (_loc_99)
                        {
                            KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightRequestSent, GameRolePlayNamedActorInformations(_loc_99).name, true);
                        }
                    }
                    return true;
                }
                case param1 is GameRolePlayFreeSoulRequestAction:
                {
                    _loc_43 = new GameRolePlayFreeSoulRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_43);
                    return true;
                }
                case param1 is LeaveBidHouseAction:
                {
                    _loc_44 = new LeaveDialogRequestMessage();
                    _loc_44.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_44);
                    return true;
                }
                case param1 is ExchangeErrorMessage:
                {
                    _loc_45 = param1 as ExchangeErrorMessage;
                    switch(_loc_45.errorType)
                    {
                        case ExchangeErrorEnum.REQUEST_CHARACTER_OCCUPIED:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchangeCharacterOccupied");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_CHARACTER_TOOL_TOO_FAR:
                        {
                            _loc_46 = I18n.getUiText("ui.craft.notNearCraftTable");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_IMPOSSIBLE:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchange");
                            break;
                        }
                        case ExchangeErrorEnum.BID_SEARCH_ERROR:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchangeBIDSearchError");
                            break;
                        }
                        case ExchangeErrorEnum.BUY_ERROR:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchangeBuyError");
                            break;
                        }
                        case ExchangeErrorEnum.MOUNT_PADDOCK_ERROR:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchangeMountPaddockError");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_CHARACTER_JOB_NOT_EQUIPED:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchangeCharacterJobNotEquiped");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_CHARACTER_NOT_SUSCRIBER:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchangeCharacterNotSuscriber");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_CHARACTER_OVERLOADED:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchangeCharacterOverloaded");
                            break;
                        }
                        case ExchangeErrorEnum.SELL_ERROR:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchangeSellError");
                            break;
                        }
                        default:
                        {
                            _loc_46 = I18n.getUiText("ui.exchange.cantExchange");
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_46, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeError, _loc_45.errorType);
                    return true;
                }
                case param1 is GameRolePlayAggressionMessage:
                {
                    _loc_47 = param1 as GameRolePlayAggressionMessage;
                    _loc_34 = I18n.getUiText("ui.pvp.aAttackB", [GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc_47.attackerId)).name, GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc_47.defenderId)).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_34, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    _loc_29 = PlayedCharacterManager.getInstance().infos.id;
                    if (_loc_29 == _loc_47.attackerId)
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESS);
                    }
                    else if (_loc_29 == _loc_47.defenderId)
                    {
                        SystemManager.getSingleton().notifyUser();
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESSED);
                    }
                    return true;
                }
                case param1 is LeaveShopStockAction:
                {
                    _loc_48 = new LeaveDialogRequestMessage();
                    _loc_48.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_48);
                    return true;
                }
                case param1 is ExchangeShopStockMouvmentAddAction:
                {
                    _loc_49 = param1 as ExchangeShopStockMouvmentAddAction;
                    _loc_50 = new ExchangeObjectMovePricedMessage();
                    _loc_50.initExchangeObjectMovePricedMessage(_loc_49.objectUID, _loc_49.quantity, _loc_49.price);
                    ConnectionsHandler.getConnection().send(_loc_50);
                    return true;
                }
                case param1 is ExchangeShopStockMouvmentRemoveAction:
                {
                    _loc_51 = param1 as ExchangeShopStockMouvmentRemoveAction;
                    _loc_52 = new ExchangeObjectMoveMessage();
                    _loc_52.initExchangeObjectMoveMessage(_loc_51.objectUID, _loc_51.quantity);
                    ConnectionsHandler.getConnection().send(_loc_52);
                    return true;
                }
                case param1 is ExchangeBuyAction:
                {
                    _loc_53 = param1 as ExchangeBuyAction;
                    _loc_54 = new ExchangeBuyMessage();
                    _loc_54.initExchangeBuyMessage(_loc_53.objectUID, _loc_53.quantity);
                    ConnectionsHandler.getConnection().send(_loc_54);
                    return true;
                }
                case param1 is ExchangeSellAction:
                {
                    _loc_55 = param1 as ExchangeSellAction;
                    _loc_56 = new ExchangeSellMessage();
                    _loc_56.initExchangeSellMessage(_loc_55.objectUID, _loc_55.quantity);
                    ConnectionsHandler.getConnection().send(_loc_56);
                    return true;
                }
                case param1 is ExchangeBuyOkMessage:
                {
                    _loc_57 = param1 as ExchangeBuyOkMessage;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.BuyOk);
                    return true;
                }
                case param1 is ExchangeSellOkMessage:
                {
                    _loc_58 = param1 as ExchangeSellOkMessage;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.SellOk);
                    return true;
                }
                case param1 is ExchangePlayerRequestAction:
                {
                    _loc_59 = param1 as ExchangePlayerRequestAction;
                    _loc_60 = new ExchangePlayerRequestMessage();
                    _loc_60.initExchangePlayerRequestMessage(_loc_59.exchangeType, _loc_59.target);
                    ConnectionsHandler.getConnection().send(_loc_60);
                    return true;
                }
                case param1 is ExchangePlayerMultiCraftRequestAction:
                {
                    _loc_61 = param1 as ExchangePlayerMultiCraftRequestAction;
                    switch(_loc_61.exchangeType)
                    {
                        case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                        {
                            this._customerID = _loc_61.target;
                            this._crafterId = PlayedCharacterManager.getInstance().infos.id;
                            break;
                        }
                        case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                        {
                            this._crafterId = _loc_61.target;
                            this._customerID = PlayedCharacterManager.getInstance().infos.id;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_62 = new ExchangePlayerMultiCraftRequestMessage();
                    _loc_62.initExchangePlayerMultiCraftRequestMessage(_loc_61.exchangeType, _loc_61.target, _loc_61.skillId);
                    ConnectionsHandler.getConnection().send(_loc_62);
                    return true;
                }
                case param1 is JobAllowMultiCraftRequestSetAction:
                {
                    _loc_63 = param1 as JobAllowMultiCraftRequestSetAction;
                    _loc_64 = new JobAllowMultiCraftRequestSetMessage();
                    _loc_64.initJobAllowMultiCraftRequestSetMessage(_loc_63.isPublic);
                    ConnectionsHandler.getConnection().send(_loc_64);
                    return true;
                }
                case param1 is JobAllowMultiCraftRequestMessage:
                {
                    _loc_65 = param1 as JobAllowMultiCraftRequestMessage;
                    _loc_66 = (param1 as JobAllowMultiCraftRequestMessage).getMessageId();
                    switch(_loc_66)
                    {
                        case JobAllowMultiCraftRequestMessage.protocolId:
                        {
                            break;
                        }
                        case JobMultiCraftAvailableSkillsMessage.protocolId:
                        {
                            _loc_100 = param1 as JobMultiCraftAvailableSkillsMessage;
                            if (_loc_100.enabled)
                            {
                                _loc_101 = new MultiCraftEnableForPlayer();
                                _loc_101.playerId = _loc_100.playerId;
                                _loc_101.skills = _loc_100.skills;
                                _loc_102 = false;
                                _loc_103 = 0;
                                _loc_104 = 0;
                                for each (_loc_105 in this._playersMultiCraftSkill)
                                {
                                    
                                    if (_loc_105.playerId == _loc_101.playerId)
                                    {
                                        _loc_102 = true;
                                        _loc_105.skills = _loc_100.skills;
                                    }
                                }
                                if (!_loc_102)
                                {
                                    this._playersMultiCraftSkill.push(_loc_101);
                                }
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    PlayedCharacterManager.getInstance().publicMode = _loc_65.enabled;
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobAllowMultiCraftRequest, _loc_65.enabled);
                    return true;
                }
                case param1 is SpellForgetUIMessage:
                {
                    _loc_67 = param1 as SpellForgetUIMessage;
                    Kernel.getWorker().addFrame(this._spellForgetDialogFrame);
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.SpellForgetUI, _loc_67.open);
                    return true;
                }
                case param1 is ChallengeFightJoinRefusedMessage:
                {
                    _loc_68 = param1 as ChallengeFightJoinRefusedMessage;
                    switch(_loc_68.reason)
                    {
                        case FighterRefusedReasonEnum.CHALLENGE_FULL:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.challengeFull");
                            break;
                        }
                        case FighterRefusedReasonEnum.TEAM_FULL:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.teamFull");
                            break;
                        }
                        case FighterRefusedReasonEnum.WRONG_ALIGNMENT:
                        {
                            _loc_34 = I18n.getUiText("ui.wrongAlignment");
                            break;
                        }
                        case FighterRefusedReasonEnum.WRONG_GUILD:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.wrongGuild");
                            break;
                        }
                        case FighterRefusedReasonEnum.TOO_LATE:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.tooLate");
                            break;
                        }
                        case FighterRefusedReasonEnum.MUTANT_REFUSED:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.mutantRefused");
                            break;
                        }
                        case FighterRefusedReasonEnum.WRONG_MAP:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.wrongMap");
                            break;
                        }
                        case FighterRefusedReasonEnum.JUST_RESPAWNED:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.justRespawned");
                            break;
                        }
                        case FighterRefusedReasonEnum.IM_OCCUPIED:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.imOccupied");
                            break;
                        }
                        case FighterRefusedReasonEnum.OPPONENT_OCCUPIED:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.opponentOccupied");
                            break;
                        }
                        case FighterRefusedReasonEnum.MULTIACCOUNT_NOT_ALLOWED:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.onlyOneAllowedAccount");
                            break;
                        }
                        case FighterRefusedReasonEnum.INSUFFICIENT_RIGHTS:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.insufficientRights");
                            break;
                        }
                        case FighterRefusedReasonEnum.MEMBER_ACCOUNT_NEEDED:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.memberAccountNeeded");
                            break;
                        }
                        case FighterRefusedReasonEnum.OPPONENT_NOT_MEMBER:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.opponentNotMember");
                            break;
                        }
                        case FighterRefusedReasonEnum.TEAM_LIMITED_BY_MAINCHARACTER:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.teamLimitedByMainCharacter");
                            break;
                        }
                        case FighterRefusedReasonEnum.GHOST_REFUSED:
                        {
                            _loc_34 = I18n.getUiText("ui.fight.ghostRefused");
                            break;
                        }
                        default:
                        {
                            return true;
                            break;
                        }
                    }
                    if (_loc_34 != null)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_34, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is SpellForgottenMessage:
                {
                    _loc_69 = param1 as SpellForgottenMessage;
                    return true;
                }
                case param1 is ExchangeCraftResultMessage:
                {
                    _loc_70 = param1 as ExchangeCraftResultMessage;
                    _loc_71 = _loc_70.getMessageId();
                    if (_loc_71 != ExchangeCraftInformationObjectMessage.protocolId)
                    {
                        return false;
                    }
                    _loc_72 = param1 as ExchangeCraftInformationObjectMessage;
                    switch(_loc_72.craftResult)
                    {
                        case CraftResultEnum.CRAFT_SUCCESS:
                        case CraftResultEnum.CRAFT_FAILED:
                        {
                            _loc_106 = Item.getItemById(_loc_72.objectGenericId);
                            _loc_107 = _loc_106.iconId;
                            _loc_73 = new CraftSmileyItem(_loc_72.playerId, _loc_107, _loc_72.craftResult);
                            break;
                        }
                        case CraftResultEnum.CRAFT_IMPOSSIBLE:
                        {
                            _loc_73 = new CraftSmileyItem(_loc_72.playerId, -1, _loc_72.craftResult);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (DofusEntities.getEntity(_loc_72.playerId) as IDisplayable)
                    {
                        _loc_108 = (DofusEntities.getEntity(_loc_72.playerId) as IDisplayable).absoluteBounds;
                        TooltipManager.show(_loc_73, _loc_108, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "craftSmiley" + _loc_72.playerId, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, null, null, false, -1);
                    }
                    return true;
                }
                case param1 is DocumentReadingBeginMessage:
                {
                    _loc_74 = param1 as DocumentReadingBeginMessage;
                    TooltipManager.hideAll();
                    if (!Kernel.getWorker().contains(DocumentFrame))
                    {
                        Kernel.getWorker().addFrame(this._documentFrame);
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.DocumentReadingBegin, _loc_74.documentId);
                    return true;
                }
                case param1 is ZaapListMessage || param1 is TeleportDestinationsListMessage:
                {
                    if (!Kernel.getWorker().contains(ZaapFrame))
                    {
                        Kernel.getWorker().addFrame(this._zaapFrame);
                        Kernel.getWorker().process(param1);
                    }
                    return false;
                }
                case param1 is PaddockSellBuyDialogMessage:
                {
                    _loc_75 = param1 as PaddockSellBuyDialogMessage;
                    TooltipManager.hideAll();
                    if (!Kernel.getWorker().contains(PaddockFrame))
                    {
                        Kernel.getWorker().addFrame(this._paddockFrame);
                    }
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                    KernelEventsManager.getInstance().processCallback(MountHookList.PaddockSellBuyDialog, _loc_75.bsell, _loc_75.ownerId, _loc_75.price);
                    return true;
                }
                case param1 is LeaveExchangeMountAction:
                {
                    _loc_48 = new LeaveDialogRequestMessage();
                    _loc_48.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_48);
                    return true;
                }
                case param1 is PaddockPropertiesMessage:
                {
                    this._currentPaddock = PaddockWrapper.create(PaddockPropertiesMessage(param1).properties);
                    return true;
                }
                case param1 is GameRolePlaySpellAnimMessage:
                {
                    _loc_76 = param1 as GameRolePlaySpellAnimMessage;
                    _loc_77 = new RoleplaySpellCastProvider();
                    _loc_77.castingSpell.casterId = _loc_76.casterId;
                    _loc_77.castingSpell.spell = Spell.getSpellById(_loc_76.spellId);
                    _loc_77.castingSpell.spellRank = _loc_77.castingSpell.spell.getSpellLevel(_loc_76.spellLevel);
                    _loc_77.castingSpell.targetedCell = MapPoint.fromCellId(_loc_76.targetCellId);
                    _loc_78 = new Uri(XmlConfig.getInstance().getEntry("config.script.spellFx") + _loc_77.castingSpell.spell.getScriptId(_loc_77.castingSpell.isCriticalHit) + ".dx");
                    _log.debug("GameRolePlaySpellAnimMessage de " + _loc_77.castingSpell.casterId + " sur " + _loc_77.castingSpell.targetedCell.cellId + "     uri : " + XmlConfig.getInstance().getEntry("config.script.spellFx") + _loc_77.castingSpell.spell.getScriptId(_loc_77.castingSpell.isCriticalHit) + ".dx");
                    _loc_79 = new SpellFxRunner(_loc_77);
                    ScriptExec.exec(_loc_78, _loc_79, false, new Callback(this.executeSpellBuffer, null, true, true, _loc_77), new Callback(this.executeSpellBuffer, null, true, false, _loc_77));
                    return true;
                }
                case param1 is CinematicMessage:
                {
                    _loc_80 = param1 as CinematicMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.Cinematic, _loc_80.cinematicId);
                    return true;
                }
                case param1 is BasicSwitchModeAction:
                {
                    _loc_81 = param1 as BasicSwitchModeAction;
                    if (_loc_81.type != currentStatus)
                    {
                        _loc_109 = new BasicSetAwayModeRequestMessage();
                        switch(_loc_81.type)
                        {
                            case -1:
                            {
                                _loc_109.initBasicSetAwayModeRequestMessage(false, currentStatus == 0);
                                break;
                            }
                            case 0:
                            {
                                _loc_109.initBasicSetAwayModeRequestMessage(true, true);
                                break;
                            }
                            case 1:
                            {
                                _loc_109.initBasicSetAwayModeRequestMessage(true, false);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        currentStatus = _loc_81.type;
                        ConnectionsHandler.getConnection().send(_loc_109);
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
            var _loc_1:* = Kernel.getWorker().getFrame(PrismFrame) as PrismFrame;
            _loc_1.pullRoleplay();
            this._interactivesFrame.clear();
            Kernel.getWorker().removeFrame(this._entitiesFrame);
            Kernel.getWorker().removeFrame(this._worldFrame);
            Kernel.getWorker().removeFrame(this._movementFrame);
            Kernel.getWorker().removeFrame(this._interactivesFrame);
            Kernel.getWorker().removeFrame(this._spectatorManagementFrame);
            Kernel.getWorker().removeFrame(this._npcDialogFrame);
            Kernel.getWorker().removeFrame(this._documentFrame);
            Kernel.getWorker().removeFrame(this._zaapFrame);
            Kernel.getWorker().removeFrame(this._paddockFrame);
            return true;
        }// end function

        public function getActorName(param1:int) : String
        {
            var _loc_2:GameRolePlayActorInformations = null;
            var _loc_3:GameRolePlayTaxCollectorInformations = null;
            _loc_2 = this.getActorInfos(param1);
            if (!_loc_2)
            {
                return "Unknown Actor";
            }
            switch(true)
            {
                case _loc_2 is GameRolePlayNamedActorInformations:
                {
                    return (_loc_2 as GameRolePlayNamedActorInformations).name;
                }
                case _loc_2 is GameRolePlayTaxCollectorInformations:
                {
                    _loc_3 = _loc_2 as GameRolePlayTaxCollectorInformations;
                    return TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_3.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_3.lastNameId).name;
                }
                case _loc_2 is GameRolePlayNpcInformations:
                {
                    return Npc.getNpcById((_loc_2 as GameRolePlayNpcInformations).npcId).name;
                }
                case _loc_2 is GameRolePlayGroupMonsterInformations:
                case _loc_2 is GameRolePlayPrismInformations:
                {
                    _log.error("Fail: getActorName called with an actorId corresponding to a monsters group or a prism (" + _loc_2 + ").");
                    return "<error: cannot get a name>";
                }
                default:
                {
                    break;
                }
            }
            return "Unknown Actor Type";
        }// end function

        private function getActorInfos(param1:int) : GameRolePlayActorInformations
        {
            return this.entitiesFrame.getEntityInfos(param1) as GameRolePlayActorInformations;
        }// end function

        private function executeSpellBuffer(param1:Function, param2:Boolean, param3:Boolean = false, param4:RoleplaySpellCastProvider = null) : void
        {
            var _loc_6:ISequencable = null;
            var _loc_5:* = new SerialSequencer();
            for each (_loc_6 in param4.stepsBuffer)
            {
                
                _loc_5.addStep(_loc_6);
            }
            _loc_5.start();
            return;
        }// end function

        private function addCraftFrame() : void
        {
            if (!Kernel.getWorker().contains(CraftFrame))
            {
                Kernel.getWorker().addFrame(this._craftFrame);
            }
            return;
        }// end function

        private function addCommonExchangeFrame(param1:uint) : void
        {
            if (!Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
                this._commonExchangeFrame = new CommonExchangeManagementFrame(param1);
                Kernel.getWorker().addFrame(this._commonExchangeFrame);
            }
            return;
        }// end function

        private function onListenOrientation(event:MouseEvent) : void
        {
            var _loc_2:* = this._playerEntity.localToGlobal(new Point(0, 0));
            var _loc_3:* = StageShareManager.stage.mouseY - _loc_2.y;
            var _loc_4:* = StageShareManager.stage.mouseX - _loc_2.x;
            var _loc_5:* = AngleToOrientation.angleToOrientation(Math.atan2(_loc_3, _loc_4));
            var _loc_6:* = this._playerEntity.getAnimation();
            var _loc_7:* = Emoticon.getEmoticonById(this._entitiesFrame.currentEmoticon);
            if (_loc_6.indexOf(AnimationEnum.ANIM_STATIQUE) != -1 || _loc_7 && _loc_7.eight_directions)
            {
                this._playerEntity.setDirection(_loc_5);
            }
            else if (_loc_5 % 2 == 0)
            {
                this._playerEntity.setDirection((_loc_5 + 1));
            }
            else
            {
                this._playerEntity.setDirection(_loc_5);
            }
            return;
        }// end function

        private function onClickOrientation(event:MouseEvent) : void
        {
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onListenOrientation);
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK, this.onClickOrientation);
            var _loc_2:* = this._playerEntity.getAnimation();
            var _loc_3:* = new GameMapChangeOrientationRequestMessage();
            _loc_3.initGameMapChangeOrientationRequestMessage(this._playerEntity.getDirection());
            ConnectionsHandler.getConnection().send(_loc_3);
            return;
        }// end function

        public function getMultiCraftSkills(param1:uint) : Vector.<uint>
        {
            var _loc_2:MultiCraftEnableForPlayer = null;
            for each (_loc_2 in this._playersMultiCraftSkill)
            {
                
                if (_loc_2.playerId == param1)
                {
                    return _loc_2.skills;
                }
            }
            return null;
        }// end function

    }
}

class MultiCraftEnableForPlayer extends Object
{
    public var playerId:uint;
    public var skills:Vector.<uint>;

    function MultiCraftEnableForPlayer()
    {
        return;
    }// end function

}


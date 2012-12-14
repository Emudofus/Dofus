package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.externalnotification.*;
    import com.ankamagames.dofus.externalnotification.enums.*;
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
    import com.ankamagames.jerakine.network.messages.*;
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
        private var _emoticonFrame:EmoticonFrame;
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
            if (!Kernel.getWorker().contains(EmoticonFrame))
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
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = false;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = null;
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_42:* = 0;
            var _loc_43:* = null;
            var _loc_44:* = 0;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = null;
            var _loc_48:* = null;
            var _loc_49:* = null;
            var _loc_50:* = null;
            var _loc_51:* = null;
            var _loc_52:* = null;
            var _loc_53:* = null;
            var _loc_54:* = null;
            var _loc_55:* = null;
            var _loc_56:* = null;
            var _loc_57:* = null;
            var _loc_58:* = null;
            var _loc_59:* = null;
            var _loc_60:* = null;
            var _loc_61:* = null;
            var _loc_62:* = null;
            var _loc_63:* = null;
            var _loc_64:* = null;
            var _loc_65:* = null;
            var _loc_66:* = null;
            var _loc_67:* = null;
            var _loc_68:* = null;
            var _loc_69:* = null;
            var _loc_70:* = null;
            var _loc_71:* = null;
            var _loc_72:* = null;
            var _loc_73:* = null;
            var _loc_74:* = null;
            var _loc_75:* = null;
            var _loc_76:* = null;
            var _loc_77:* = null;
            var _loc_78:* = null;
            var _loc_79:* = 0;
            var _loc_80:* = null;
            var _loc_81:* = null;
            var _loc_82:* = null;
            var _loc_83:* = null;
            var _loc_84:* = 0;
            var _loc_85:* = null;
            var _loc_86:* = null;
            var _loc_87:* = null;
            var _loc_88:* = null;
            var _loc_89:* = null;
            var _loc_90:* = null;
            var _loc_91:* = null;
            var _loc_92:* = null;
            var _loc_93:* = null;
            var _loc_94:* = null;
            var _loc_95:* = null;
            var _loc_96:* = null;
            var _loc_97:* = null;
            var _loc_98:* = 0;
            var _loc_99:* = 0;
            var _loc_100:* = 0;
            var _loc_101:* = null;
            var _loc_102:* = false;
            var _loc_103:* = null;
            var _loc_104:* = null;
            var _loc_105:* = null;
            var _loc_106:* = null;
            var _loc_107:* = 0;
            var _loc_108:* = 0;
            var _loc_109:* = null;
            var _loc_110:* = null;
            var _loc_111:* = null;
            var _loc_112:* = null;
            var _loc_113:* = null;
            var _loc_114:* = false;
            var _loc_115:* = 0;
            var _loc_116:* = 0;
            var _loc_117:* = null;
            var _loc_118:* = null;
            var _loc_119:* = 0;
            var _loc_120:* = null;
            var _loc_121:* = null;
            switch(true)
            {
                case param1 is CurrentMapMessage:
                {
                    _loc_2 = param1 as CurrentMapMessage;
                    Kernel.getWorker().pause();
                    ConnectionsHandler.pause();
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
                        _loc_95 = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                        if (!_loc_95)
                        {
                            _loc_95 = _loc_2.mapKey;
                        }
                        _loc_4 = Hex.toArray(Hex.fromString(_loc_95));
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
                            _loc_96 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                            _loc_96.openPopup(I18n.getUiText("ui.popup.information"), I18n.getUiText("ui.popup.noMapdataFile"), [I18n.getUiText("ui.common.ok")]);
                            _loc_97 = new ErrorMapNotFoundMessage();
                            _loc_97.initErrorMapNotFoundMessage(MapLoadingFailedMessage(param1).id);
                            ConnectionsHandler.getConnection().send(_loc_97);
                            MapDisplayManager.getInstance().fromMap(new DefaultMap(MapLoadingFailedMessage(param1).id));
                            return true;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return false;
                }
                case param1 is MapLoadedMessage:
                {
                    if (MapDisplayManager.getInstance().isDefaultMap)
                    {
                        _loc_98 = PlayedCharacterManager.getInstance().currentMap.x;
                        _loc_99 = PlayedCharacterManager.getInstance().currentMap.y;
                        _loc_100 = PlayedCharacterManager.getInstance().currentMap.worldId;
                        _loc_101 = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
                        _loc_101.rightNeighbourId = WorldPoint.fromCoords(_loc_100, (_loc_98 + 1), _loc_99).mapId;
                        _loc_101.leftNeighbourId = WorldPoint.fromCoords(_loc_100, (_loc_98 - 1), _loc_99).mapId;
                        _loc_101.bottomNeighbourId = WorldPoint.fromCoords(_loc_100, _loc_98, (_loc_99 + 1)).mapId;
                        _loc_101.topNeighbourId = WorldPoint.fromCoords(_loc_100, _loc_98, (_loc_99 - 1)).mapId;
                    }
                    return true;
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
                        _loc_102 = RoleplayManager.getInstance().displayCharacterContextualMenu(_loc_20);
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
                        _loc_103 = _loc_23 as GameRolePlayNpcInformations;
                        KernelEventsManager.getInstance().processCallback(HookList.NpcDialogCreation, _loc_22.mapId, _loc_103.npcId, EntityLookAdapter.fromNetwork(_loc_103.look));
                    }
                    else if (_loc_23 is GameRolePlayTaxCollectorInformations)
                    {
                        _loc_104 = _loc_23 as GameRolePlayTaxCollectorInformations;
                        KernelEventsManager.getInstance().processCallback(HookList.PonyDialogCreation, _loc_22.mapId, _loc_104.firstNameId, _loc_104.lastNameId, EntityLookAdapter.fromNetwork(_loc_104.look));
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
                case param1 is ExchangeShowVendorTaxAction:
                {
                    _loc_24 = new ExchangeShowVendorTaxMessage();
                    _loc_24.initExchangeShowVendorTaxMessage();
                    ConnectionsHandler.getConnection().send(_loc_24);
                    return true;
                }
                case param1 is ExchangeReplyTaxVendorMessage:
                {
                    _loc_25 = param1 as ExchangeReplyTaxVendorMessage;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeReplyTaxVendor, _loc_25.totalTaxValue);
                    return true;
                }
                case param1 is ExchangeRequestOnShopStockAction:
                {
                    _loc_26 = param1 as ExchangeOnHumanVendorRequestAction;
                    _loc_27 = new ExchangeRequestOnShopStockMessage();
                    _loc_27.initExchangeRequestOnShopStockMessage();
                    ConnectionsHandler.getConnection().send(_loc_27);
                    return true;
                }
                case param1 is ExchangeOnHumanVendorRequestAction:
                {
                    _loc_28 = param1 as ExchangeOnHumanVendorRequestAction;
                    _loc_29 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    _loc_30 = new ExchangeOnHumanVendorRequestMessage();
                    _loc_30.initExchangeOnHumanVendorRequestMessage(_loc_28.humanVendorId, _loc_28.humanVendorCell);
                    if ((_loc_29 as IMovable).isMoving)
                    {
                        this._movementFrame.setFollowingMessage(_loc_30);
                        (_loc_29 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_loc_30);
                    }
                    return true;
                }
                case param1 is ExchangeStartOkHumanVendorMessage:
                {
                    _loc_31 = param1 as ExchangeStartOkHumanVendorMessage;
                    if (!Kernel.getWorker().contains(HumanVendorManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._humanVendorManagementFrame);
                    }
                    this._humanVendorManagementFrame.process(param1);
                    return true;
                }
                case param1 is ExchangeShopStockStartedMessage:
                {
                    _loc_32 = param1 as ExchangeShopStockStartedMessage;
                    if (!Kernel.getWorker().contains(HumanVendorManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._humanVendorManagementFrame);
                    }
                    this._humanVendorManagementFrame.process(param1);
                    return true;
                }
                case param1 is ExchangeStartAsVendorRequestAction:
                {
                    _loc_33 = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id);
                    if (_loc_33 && !DataMapProvider.getInstance().pointCanStop(_loc_33.position.x, _loc_33.position.y))
                    {
                        return true;
                    }
                    ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR);
                    _loc_34 = new ExchangeStartAsVendorMessage();
                    _loc_34.initExchangeStartAsVendorMessage();
                    ConnectionsHandler.getConnection().send(_loc_34);
                    return true;
                }
                case param1 is ExpectedSocketClosureMessage:
                {
                    _loc_35 = param1 as ExpectedSocketClosureMessage;
                    if (_loc_35.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR)
                    {
                        Kernel.getWorker().process(new ResetGameAction());
                        return true;
                    }
                    return false;
                }
                case param1 is ExchangeStartedMountStockMessage:
                {
                    _loc_36 = ExchangeStartedMountStockMessage(param1);
                    this.addCommonExchangeFrame(ExchangeTypeEnum.MOUNT);
                    if (!Kernel.getWorker().contains(ExchangeManagementFrame))
                    {
                        Kernel.getWorker().addFrame(this._exchangeManagementFrame);
                    }
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeBankStarted, ExchangeTypeEnum.MOUNT, _loc_36.objectsInfos, 0);
                    this._exchangeManagementFrame.initMountStock(_loc_36.objectsInfos);
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
                    _loc_37 = param1 as ExchangeStartOkNpcShopMessage;
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
                    _loc_38 = param1 as ExchangeStartedMessage;
                    _loc_39 = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
                    if (_loc_39)
                    {
                        _loc_39.resetEchangeSequence();
                    }
                    switch(_loc_38.exchangeType)
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
                    this.addCommonExchangeFrame(_loc_38.exchangeType);
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
                    _loc_40 = param1 as ObjectFoundWhileRecoltingMessage;
                    _loc_41 = Item.getItemById(_loc_40.genericId);
                    _loc_42 = PlayedCharacterManager.getInstance().id;
                    _loc_43 = new CraftSmileyItem(_loc_42, _loc_41.iconId, 2);
                    if (DofusEntities.getEntity(_loc_42) as IDisplayable)
                    {
                        _loc_105 = (DofusEntities.getEntity(_loc_42) as IDisplayable).absoluteBounds;
                        TooltipManager.show(_loc_43, _loc_105, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "craftSmiley" + _loc_42, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null);
                    }
                    _loc_44 = _loc_40.quantity;
                    _loc_45 = _loc_40.genericId ? (Item.getItemById(_loc_40.genericId).name) : (I18n.getUiText("ui.common.kamas"));
                    _loc_46 = Item.getItemById(_loc_40.ressourceGenericId).name;
                    _loc_47 = I18n.getUiText("ui.common.itemFound", [_loc_44, _loc_45, _loc_46]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_47, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is PlayerFightRequestAction:
                {
                    _loc_48 = PlayerFightRequestAction(param1);
                    if (!_loc_48.launch && !_loc_48.friendly)
                    {
                        _loc_106 = this.entitiesFrame.getEntityInfos(_loc_48.targetedPlayerId) as GameRolePlayCharacterInformations;
                        if (_loc_106)
                        {
                            if (_loc_106.alignmentInfos.alignmentSide == 0)
                            {
                                _loc_109 = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
                                _loc_110 = _loc_109.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations;
                                if (!(_loc_110 is GameRolePlayMutantInformations))
                                {
                                    KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer, _loc_48.targetedPlayerId, _loc_106.name, 2, _loc_48.cellId);
                                    return true;
                                }
                            }
                            _loc_107 = _loc_106.alignmentInfos.characterPower - _loc_48.targetedPlayerId;
                            _loc_108 = PlayedCharacterManager.getInstance().levelDiff(_loc_107);
                            if (_loc_108)
                            {
                                KernelEventsManager.getInstance().processCallback(SocialHookList.AttackPlayer, _loc_48.targetedPlayerId, _loc_106.name, _loc_108, _loc_48.cellId);
                                return true;
                            }
                        }
                    }
                    _loc_49 = new GameRolePlayPlayerFightRequestMessage();
                    _loc_49.initGameRolePlayPlayerFightRequestMessage(_loc_48.targetedPlayerId, _loc_48.cellId, _loc_48.friendly);
                    _loc_50 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                    if ((_loc_50 as IMovable).isMoving)
                    {
                        this._movementFrame.setFollowingMessage(_loc_48);
                        (_loc_50 as IMovable).stop();
                    }
                    else
                    {
                        ConnectionsHandler.getConnection().send(_loc_49);
                    }
                    return true;
                }
                case param1 is PlayerFightFriendlyAnswerAction:
                {
                    _loc_51 = PlayerFightFriendlyAnswerAction(param1);
                    _loc_52 = new GameRolePlayPlayerFightFriendlyAnswerMessage();
                    _loc_52.initGameRolePlayPlayerFightFriendlyAnswerMessage(this._currentWaitingFightId, _loc_51.accept);
                    _loc_52.accept = _loc_51.accept;
                    _loc_52.fightId = this._currentWaitingFightId;
                    ConnectionsHandler.getConnection().send(_loc_52);
                    return true;
                }
                case param1 is GameRolePlayPlayerFightFriendlyAnsweredMessage:
                {
                    _loc_53 = param1 as GameRolePlayPlayerFightFriendlyAnsweredMessage;
                    if (this._currentWaitingFightId == _loc_53.fightId)
                    {
                        KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered, _loc_53.accept);
                    }
                    return true;
                }
                case param1 is GameRolePlayFightRequestCanceledMessage:
                {
                    _loc_54 = param1 as GameRolePlayFightRequestCanceledMessage;
                    if (this._currentWaitingFightId == _loc_54.fightId)
                    {
                        KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyAnswered, false);
                    }
                    return true;
                }
                case param1 is GameRolePlayPlayerFightFriendlyRequestedMessage:
                {
                    _loc_55 = param1 as GameRolePlayPlayerFightFriendlyRequestedMessage;
                    this._currentWaitingFightId = _loc_55.fightId;
                    if (_loc_55.sourceId != PlayedCharacterManager.getInstance().infos.id)
                    {
                        if (this._entitiesFrame.getEntityInfos(_loc_55.sourceId))
                        {
                            KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightFriendlyRequested, GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc_55.sourceId)).name);
                        }
                    }
                    else
                    {
                        _loc_111 = this._entitiesFrame.getEntityInfos(_loc_55.targetId);
                        if (_loc_111)
                        {
                            KernelEventsManager.getInstance().processCallback(RoleplayHookList.PlayerFightRequestSent, GameRolePlayNamedActorInformations(_loc_111).name, true);
                        }
                    }
                    return true;
                }
                case param1 is GameRolePlayFreeSoulRequestAction:
                {
                    _loc_56 = new GameRolePlayFreeSoulRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_56);
                    return true;
                }
                case param1 is LeaveBidHouseAction:
                {
                    _loc_57 = new LeaveDialogRequestMessage();
                    _loc_57.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_57);
                    return true;
                }
                case param1 is ExchangeErrorMessage:
                {
                    _loc_58 = param1 as ExchangeErrorMessage;
                    switch(_loc_58.errorType)
                    {
                        case ExchangeErrorEnum.REQUEST_CHARACTER_OCCUPIED:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchangeCharacterOccupied");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_CHARACTER_TOOL_TOO_FAR:
                        {
                            _loc_59 = I18n.getUiText("ui.craft.notNearCraftTable");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_IMPOSSIBLE:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchange");
                            break;
                        }
                        case ExchangeErrorEnum.BID_SEARCH_ERROR:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchangeBIDSearchError");
                            break;
                        }
                        case ExchangeErrorEnum.BUY_ERROR:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchangeBuyError");
                            break;
                        }
                        case ExchangeErrorEnum.MOUNT_PADDOCK_ERROR:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchangeMountPaddockError");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_CHARACTER_JOB_NOT_EQUIPED:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchangeCharacterJobNotEquiped");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_CHARACTER_NOT_SUSCRIBER:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchangeCharacterNotSuscriber");
                            break;
                        }
                        case ExchangeErrorEnum.REQUEST_CHARACTER_OVERLOADED:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchangeCharacterOverloaded");
                            break;
                        }
                        case ExchangeErrorEnum.SELL_ERROR:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchangeSellError");
                            break;
                        }
                        default:
                        {
                            _loc_59 = I18n.getUiText("ui.exchange.cantExchange");
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_59, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeError, _loc_58.errorType);
                    return true;
                }
                case param1 is GameRolePlayAggressionMessage:
                {
                    _loc_60 = param1 as GameRolePlayAggressionMessage;
                    _loc_47 = I18n.getUiText("ui.pvp.aAttackB", [GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc_60.attackerId)).name, GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc_60.defenderId)).name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_47, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    _loc_42 = PlayedCharacterManager.getInstance().infos.id;
                    if (_loc_42 == _loc_60.attackerId)
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESS);
                    }
                    else if (_loc_42 == _loc_60.defenderId)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.PlayerAggression, _loc_60.attackerId, GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc_60.attackerId)).name);
                        if (AirScanner.hasAir() && ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.ATTACK))
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.ATTACK, [GameRolePlayNamedActorInformations(this._entitiesFrame.getEntityInfos(_loc_60.attackerId)).name]);
                        }
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_AGRESSED);
                    }
                    return true;
                }
                case param1 is LeaveShopStockAction:
                {
                    _loc_61 = new LeaveDialogRequestMessage();
                    _loc_61.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_61);
                    return true;
                }
                case param1 is ExchangeShopStockMouvmentAddAction:
                {
                    _loc_62 = param1 as ExchangeShopStockMouvmentAddAction;
                    _loc_63 = new ExchangeObjectMovePricedMessage();
                    _loc_63.initExchangeObjectMovePricedMessage(_loc_62.objectUID, _loc_62.quantity, _loc_62.price);
                    ConnectionsHandler.getConnection().send(_loc_63);
                    return true;
                }
                case param1 is ExchangeShopStockMouvmentRemoveAction:
                {
                    _loc_64 = param1 as ExchangeShopStockMouvmentRemoveAction;
                    _loc_65 = new ExchangeObjectMoveMessage();
                    _loc_65.initExchangeObjectMoveMessage(_loc_64.objectUID, _loc_64.quantity);
                    ConnectionsHandler.getConnection().send(_loc_65);
                    return true;
                }
                case param1 is ExchangeBuyAction:
                {
                    _loc_66 = param1 as ExchangeBuyAction;
                    _loc_67 = new ExchangeBuyMessage();
                    _loc_67.initExchangeBuyMessage(_loc_66.objectUID, _loc_66.quantity);
                    ConnectionsHandler.getConnection().send(_loc_67);
                    return true;
                }
                case param1 is ExchangeSellAction:
                {
                    _loc_68 = param1 as ExchangeSellAction;
                    _loc_69 = new ExchangeSellMessage();
                    _loc_69.initExchangeSellMessage(_loc_68.objectUID, _loc_68.quantity);
                    ConnectionsHandler.getConnection().send(_loc_69);
                    return true;
                }
                case param1 is ExchangeBuyOkMessage:
                {
                    _loc_70 = param1 as ExchangeBuyOkMessage;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.BuyOk);
                    return true;
                }
                case param1 is ExchangeSellOkMessage:
                {
                    _loc_71 = param1 as ExchangeSellOkMessage;
                    KernelEventsManager.getInstance().processCallback(ExchangeHookList.SellOk);
                    return true;
                }
                case param1 is ExchangePlayerRequestAction:
                {
                    _loc_72 = param1 as ExchangePlayerRequestAction;
                    _loc_73 = new ExchangePlayerRequestMessage();
                    _loc_73.initExchangePlayerRequestMessage(_loc_72.exchangeType, _loc_72.target);
                    ConnectionsHandler.getConnection().send(_loc_73);
                    return true;
                }
                case param1 is ExchangePlayerMultiCraftRequestAction:
                {
                    _loc_74 = param1 as ExchangePlayerMultiCraftRequestAction;
                    switch(_loc_74.exchangeType)
                    {
                        case ExchangeTypeEnum.MULTICRAFT_CRAFTER:
                        {
                            this._customerID = _loc_74.target;
                            this._crafterId = PlayedCharacterManager.getInstance().infos.id;
                            break;
                        }
                        case ExchangeTypeEnum.MULTICRAFT_CUSTOMER:
                        {
                            this._crafterId = _loc_74.target;
                            this._customerID = PlayedCharacterManager.getInstance().infos.id;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_75 = new ExchangePlayerMultiCraftRequestMessage();
                    _loc_75.initExchangePlayerMultiCraftRequestMessage(_loc_74.exchangeType, _loc_74.target, _loc_74.skillId);
                    ConnectionsHandler.getConnection().send(_loc_75);
                    return true;
                }
                case param1 is JobAllowMultiCraftRequestSetAction:
                {
                    _loc_76 = param1 as JobAllowMultiCraftRequestSetAction;
                    _loc_77 = new JobAllowMultiCraftRequestSetMessage();
                    _loc_77.initJobAllowMultiCraftRequestSetMessage(_loc_76.isPublic);
                    ConnectionsHandler.getConnection().send(_loc_77);
                    return true;
                }
                case param1 is JobAllowMultiCraftRequestMessage:
                {
                    _loc_78 = param1 as JobAllowMultiCraftRequestMessage;
                    _loc_79 = (param1 as JobAllowMultiCraftRequestMessage).getMessageId();
                    switch(_loc_79)
                    {
                        case JobAllowMultiCraftRequestMessage.protocolId:
                        {
                            break;
                        }
                        case JobMultiCraftAvailableSkillsMessage.protocolId:
                        {
                            _loc_112 = param1 as JobMultiCraftAvailableSkillsMessage;
                            if (_loc_112.enabled)
                            {
                                _loc_113 = new MultiCraftEnableForPlayer();
                                _loc_113.playerId = _loc_112.playerId;
                                _loc_113.skills = _loc_112.skills;
                                _loc_114 = false;
                                _loc_115 = 0;
                                _loc_116 = 0;
                                for each (_loc_117 in this._playersMultiCraftSkill)
                                {
                                    
                                    if (_loc_117.playerId == _loc_113.playerId)
                                    {
                                        _loc_114 = true;
                                        _loc_117.skills = _loc_112.skills;
                                    }
                                }
                                if (!_loc_114)
                                {
                                    this._playersMultiCraftSkill.push(_loc_113);
                                }
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    PlayedCharacterManager.getInstance().publicMode = _loc_78.enabled;
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobAllowMultiCraftRequest, _loc_78.enabled);
                    return true;
                }
                case param1 is SpellForgetUIMessage:
                {
                    _loc_80 = param1 as SpellForgetUIMessage;
                    if (_loc_80.open)
                    {
                        Kernel.getWorker().addFrame(this._spellForgetDialogFrame);
                    }
                    else
                    {
                        Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                        Kernel.getWorker().removeFrame(this._spellForgetDialogFrame);
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.SpellForgetUI, _loc_80.open);
                    return true;
                }
                case param1 is ChallengeFightJoinRefusedMessage:
                {
                    _loc_81 = param1 as ChallengeFightJoinRefusedMessage;
                    switch(_loc_81.reason)
                    {
                        case FighterRefusedReasonEnum.CHALLENGE_FULL:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.challengeFull");
                            break;
                        }
                        case FighterRefusedReasonEnum.TEAM_FULL:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.teamFull");
                            break;
                        }
                        case FighterRefusedReasonEnum.WRONG_ALIGNMENT:
                        {
                            _loc_47 = I18n.getUiText("ui.wrongAlignment");
                            break;
                        }
                        case FighterRefusedReasonEnum.WRONG_GUILD:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.wrongGuild");
                            break;
                        }
                        case FighterRefusedReasonEnum.TOO_LATE:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.tooLate");
                            break;
                        }
                        case FighterRefusedReasonEnum.MUTANT_REFUSED:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.mutantRefused");
                            break;
                        }
                        case FighterRefusedReasonEnum.WRONG_MAP:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.wrongMap");
                            break;
                        }
                        case FighterRefusedReasonEnum.JUST_RESPAWNED:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.justRespawned");
                            break;
                        }
                        case FighterRefusedReasonEnum.IM_OCCUPIED:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.imOccupied");
                            break;
                        }
                        case FighterRefusedReasonEnum.OPPONENT_OCCUPIED:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.opponentOccupied");
                            break;
                        }
                        case FighterRefusedReasonEnum.MULTIACCOUNT_NOT_ALLOWED:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.onlyOneAllowedAccount");
                            break;
                        }
                        case FighterRefusedReasonEnum.INSUFFICIENT_RIGHTS:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.insufficientRights");
                            break;
                        }
                        case FighterRefusedReasonEnum.MEMBER_ACCOUNT_NEEDED:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.memberAccountNeeded");
                            break;
                        }
                        case FighterRefusedReasonEnum.OPPONENT_NOT_MEMBER:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.opponentNotMember");
                            break;
                        }
                        case FighterRefusedReasonEnum.TEAM_LIMITED_BY_MAINCHARACTER:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.teamLimitedByMainCharacter");
                            break;
                        }
                        case FighterRefusedReasonEnum.GHOST_REFUSED:
                        {
                            _loc_47 = I18n.getUiText("ui.fight.ghostRefused");
                            break;
                        }
                        default:
                        {
                            return true;
                            break;
                        }
                    }
                    if (_loc_47 != null)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_47, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    }
                    return true;
                }
                case param1 is SpellForgottenMessage:
                {
                    _loc_82 = param1 as SpellForgottenMessage;
                    return true;
                }
                case param1 is ExchangeCraftResultMessage:
                {
                    _loc_83 = param1 as ExchangeCraftResultMessage;
                    _loc_84 = _loc_83.getMessageId();
                    if (_loc_84 != ExchangeCraftInformationObjectMessage.protocolId)
                    {
                        return false;
                    }
                    _loc_85 = param1 as ExchangeCraftInformationObjectMessage;
                    switch(_loc_85.craftResult)
                    {
                        case CraftResultEnum.CRAFT_SUCCESS:
                        case CraftResultEnum.CRAFT_FAILED:
                        {
                            _loc_118 = Item.getItemById(_loc_85.objectGenericId);
                            _loc_119 = _loc_118.iconId;
                            _loc_86 = new CraftSmileyItem(_loc_85.playerId, _loc_119, _loc_85.craftResult);
                            break;
                        }
                        case CraftResultEnum.CRAFT_IMPOSSIBLE:
                        {
                            _loc_86 = new CraftSmileyItem(_loc_85.playerId, -1, _loc_85.craftResult);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (DofusEntities.getEntity(_loc_85.playerId) as IDisplayable)
                    {
                        _loc_120 = (DofusEntities.getEntity(_loc_85.playerId) as IDisplayable).absoluteBounds;
                        TooltipManager.show(_loc_86, _loc_120, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "craftSmiley" + _loc_85.playerId, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, null, null, false, -1);
                    }
                    return true;
                }
                case param1 is DocumentReadingBeginMessage:
                {
                    _loc_87 = param1 as DocumentReadingBeginMessage;
                    TooltipManager.hideAll();
                    if (!Kernel.getWorker().contains(DocumentFrame))
                    {
                        Kernel.getWorker().addFrame(this._documentFrame);
                    }
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.DocumentReadingBegin, _loc_87.documentId);
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
                    _loc_88 = param1 as PaddockSellBuyDialogMessage;
                    TooltipManager.hideAll();
                    if (!Kernel.getWorker().contains(PaddockFrame))
                    {
                        Kernel.getWorker().addFrame(this._paddockFrame);
                    }
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(false));
                    KernelEventsManager.getInstance().processCallback(MountHookList.PaddockSellBuyDialog, _loc_88.bsell, _loc_88.ownerId, _loc_88.price);
                    return true;
                }
                case param1 is LeaveExchangeMountAction:
                {
                    _loc_89 = new LeaveDialogRequestMessage();
                    _loc_89.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_89);
                    return true;
                }
                case param1 is PaddockPropertiesMessage:
                {
                    this._currentPaddock = PaddockWrapper.create(PaddockPropertiesMessage(param1).properties);
                    return true;
                }
                case param1 is GameRolePlaySpellAnimMessage:
                {
                    _loc_90 = param1 as GameRolePlaySpellAnimMessage;
                    _loc_91 = new RoleplaySpellCastProvider();
                    _loc_91.castingSpell.casterId = _loc_90.casterId;
                    _loc_91.castingSpell.spell = Spell.getSpellById(_loc_90.spellId);
                    _loc_91.castingSpell.spellRank = _loc_91.castingSpell.spell.getSpellLevel(_loc_90.spellLevel);
                    _loc_91.castingSpell.targetedCell = MapPoint.fromCellId(_loc_90.targetCellId);
                    _loc_92 = new SpellFxRunner(_loc_91);
                    ScriptExec.exec(DofusEmbedScript.getScript(_loc_91.castingSpell.spell.getScriptId(_loc_91.castingSpell.isCriticalHit)), _loc_92, false, new Callback(this.executeSpellBuffer, null, true, true, _loc_91), new Callback(this.executeSpellBuffer, null, true, false, _loc_91));
                    return true;
                }
                case param1 is CinematicMessage:
                {
                    _loc_93 = param1 as CinematicMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.Cinematic, _loc_93.cinematicId);
                    return true;
                }
                case param1 is BasicSwitchModeAction:
                {
                    _loc_94 = param1 as BasicSwitchModeAction;
                    if (_loc_94.type != currentStatus)
                    {
                        _loc_121 = new BasicSetAwayModeRequestMessage();
                        switch(_loc_94.type)
                        {
                            case -1:
                            {
                                _loc_121.initBasicSetAwayModeRequestMessage(false, currentStatus == 0);
                                break;
                            }
                            case 0:
                            {
                                _loc_121.initBasicSetAwayModeRequestMessage(true, true);
                                break;
                            }
                            case 1:
                            {
                                _loc_121.initBasicSetAwayModeRequestMessage(true, false);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        currentStatus = _loc_94.type;
                        ConnectionsHandler.getConnection().send(_loc_121);
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
            var _loc_2:* = null;
            var _loc_3:* = null;
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
            var _loc_6:* = null;
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
            var _loc_2:* = null;
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

import __AS3__.vec.*;

import com.ankamagames.atouin.*;

import com.ankamagames.atouin.data.*;

import com.ankamagames.atouin.data.map.*;

import com.ankamagames.atouin.managers.*;

import com.ankamagames.atouin.messages.*;

import com.ankamagames.atouin.utils.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.*;

import com.ankamagames.dofus.datacenter.communication.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.datacenter.npcs.*;

import com.ankamagames.dofus.datacenter.spells.*;

import com.ankamagames.dofus.datacenter.world.*;

import com.ankamagames.dofus.externalnotification.*;

import com.ankamagames.dofus.externalnotification.enums.*;

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

import com.ankamagames.jerakine.network.messages.*;

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

class MultiCraftEnableForPlayer extends Object
{
    public var playerId:uint;
    public var skills:Vector.<uint>;

    function MultiCraftEnableForPlayer()
    {
        return;
    }// end function

}


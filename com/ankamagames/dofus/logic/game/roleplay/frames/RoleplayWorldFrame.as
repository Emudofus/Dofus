package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.interactives.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.internalDatacenter.house.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.guild.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.messages.*;
    import com.ankamagames.dofus.logic.game.roleplay.types.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.party.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;

    public class RoleplayWorldFrame extends Object implements Frame
    {
        private const _common:String;
        private var _mouseTop:Texture;
        private var _mouseBottom:Texture;
        private var _mouseRight:Texture;
        private var _mouseLeft:Texture;
        private var _texturesReady:Boolean;
        private var _playerEntity:AnimatedCharacter;
        private var _playerName:String;
        private var _allowOnlyCharacterInteraction:Boolean;
        public var cellClickEnabled:Boolean;
        private var _infoEntitiesFrame:InfoEntitiesFrame;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayWorldFrame));
        private static const NO_CURSOR:int = -1;
        private static const FIGHT_CURSOR:int = 3;
        private static const NPC_CURSOR:int = 1;
        private static const INTERACTIVE_CURSOR_OFFSET:Point = new Point(0, 0);

        public function RoleplayWorldFrame()
        {
            this._common = XmlConfig.getInstance().getEntry("config.ui.skin");
            this._infoEntitiesFrame = new InfoEntitiesFrame();
            return;
        }// end function

        public function set allowOnlyCharacterInteraction(param1:Boolean) : void
        {
            this._allowOnlyCharacterInteraction = param1;
            return;
        }// end function

        public function get allowOnlyCharacterInteraction() : Boolean
        {
            return this._allowOnlyCharacterInteraction;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        private function get roleplayContextFrame() : RoleplayContextFrame
        {
            return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
        }// end function

        private function get roleplayMovementFrame() : RoleplayMovementFrame
        {
            return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
        }// end function

        public function pushed() : Boolean
        {
            FrustumManager.getInstance().setBorderInteraction(true);
            this._allowOnlyCharacterInteraction = false;
            this.cellClickEnabled = true;
            if (this._texturesReady)
            {
                return true;
            }
            this._mouseBottom = new Texture();
            this._mouseBottom.uri = new Uri(this._common + "assets.swf|cursorBottom");
            this._mouseBottom.finalize();
            this._mouseTop = new Texture();
            this._mouseTop.uri = new Uri(this._common + "assets.swf|cursorTop");
            this._mouseTop.finalize();
            this._mouseRight = new Texture();
            this._mouseRight.uri = new Uri(this._common + "assets.swf|cursorRight");
            this._mouseRight.finalize();
            this._mouseLeft = new Texture();
            this._mouseLeft.uri = new Uri(this._common + "assets.swf|cursorLeft");
            this._mouseLeft.finalize();
            this._texturesReady = true;
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
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
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
            var _loc_22:* = false;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = 0;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_39:* = null;
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_42:* = false;
            var _loc_43:* = null;
            var _loc_44:* = null;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = 0;
            var _loc_48:* = null;
            var _loc_49:* = null;
            var _loc_50:* = null;
            var _loc_51:* = null;
            var _loc_52:* = 0;
            var _loc_53:* = 0;
            var _loc_54:* = null;
            var _loc_55:* = null;
            var _loc_56:* = null;
            var _loc_57:* = null;
            var _loc_58:* = 0;
            var _loc_59:* = 0;
            var _loc_60:* = 0;
            var _loc_61:* = null;
            var _loc_62:* = null;
            var _loc_63:* = 0;
            var _loc_64:* = null;
            var _loc_65:* = null;
            var _loc_66:* = null;
            var _loc_67:* = null;
            var _loc_68:* = null;
            var _loc_69:* = null;
            var _loc_70:* = null;
            var _loc_71:* = null;
            switch(true)
            {
                case param1 is CellClickMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    if (this.cellClickEnabled)
                    {
                        _loc_37 = param1 as CellClickMessage;
                        this.roleplayMovementFrame.resetNextMoveMapChange();
                        _log.debug("Player clicked on cell " + _loc_37.cellId + ".");
                        this.roleplayMovementFrame.setFollowingInteraction(null);
                        this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(_loc_37.cellId));
                    }
                    return true;
                }
                case param1 is AdjacentMapClickMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    if (this.cellClickEnabled)
                    {
                        _loc_38 = param1 as AdjacentMapClickMessage;
                        _loc_39 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        if (!_loc_39)
                        {
                            _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                            return false;
                        }
                        this.roleplayMovementFrame.setNextMoveMapChange(_loc_38.adjacentMapId);
                        if (!_loc_39.position.equals(MapPoint.fromCellId(_loc_38.cellId)))
                        {
                            this.roleplayMovementFrame.setFollowingInteraction(null);
                            this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(_loc_38.cellId));
                        }
                        else
                        {
                            this.roleplayMovementFrame.setFollowingInteraction(null);
                            this.roleplayMovementFrame.askMapChange();
                        }
                    }
                    return true;
                }
                case param1 is AdjacentMapOutMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
                    return true;
                }
                case param1 is AdjacentMapOverMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    _loc_2 = AdjacentMapOverMessage(param1);
                    _loc_3 = CellIdConverter.cellIdToCoord(_loc_2.cellId);
                    _loc_4 = InteractiveCellManager.getInstance().getCell(_loc_2.cellId);
                    _loc_5 = new LinkedCursorData();
                    switch(_loc_2.direction)
                    {
                        case DirectionsEnum.LEFT:
                        {
                            _loc_5.sprite = this._mouseLeft;
                            _loc_5.lockX = true;
                            _loc_5.sprite.x = _loc_2.zone.x + _loc_2.zone.width / 2;
                            _loc_5.offset = new Point(0, 0);
                            _loc_5.lockY = true;
                            _loc_5.sprite.y = _loc_4.y + AtouinConstants.CELL_HEIGHT / 2;
                            break;
                        }
                        case DirectionsEnum.UP:
                        {
                            _loc_5.sprite = this._mouseTop;
                            _loc_5.lockY = true;
                            _loc_5.sprite.y = _loc_2.zone.y + _loc_2.zone.height / 2;
                            _loc_5.offset = new Point(0, 0);
                            _loc_5.lockX = true;
                            _loc_5.sprite.x = _loc_4.x + AtouinConstants.CELL_WIDTH / 2;
                            break;
                        }
                        case DirectionsEnum.DOWN:
                        {
                            _loc_5.sprite = this._mouseBottom;
                            _loc_5.lockY = true;
                            _loc_5.sprite.y = _loc_2.zone.getBounds(_loc_2.zone).top;
                            _loc_5.offset = new Point(0, 0);
                            _loc_5.lockX = true;
                            _loc_5.sprite.x = _loc_4.x + AtouinConstants.CELL_WIDTH / 2;
                            break;
                        }
                        case DirectionsEnum.RIGHT:
                        {
                            _loc_5.sprite = this._mouseRight;
                            _loc_5.lockX = true;
                            _loc_5.sprite.x = _loc_2.zone.getBounds(_loc_2.zone).left + _loc_2.zone.width / 2;
                            _loc_5.offset = new Point(0, 0);
                            _loc_5.lockY = true;
                            _loc_5.sprite.y = _loc_4.y + AtouinConstants.CELL_HEIGHT / 2;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    LinkedCursorSpriteManager.getInstance().addItem("changeMapCursor", _loc_5);
                    return true;
                }
                case param1 is EntityMouseOverMessage:
                {
                    _loc_6 = param1 as EntityMouseOverMessage;
                    _loc_7 = "entity_" + _loc_6.entity.id;
                    this.displayCursor(NO_CURSOR);
                    _loc_8 = _loc_6.entity as IInteractive;
                    _loc_9 = _loc_8 as AnimatedCharacter;
                    if (_loc_9)
                    {
                        _loc_9 = _loc_9.getRootEntity();
                        _loc_9.highLightCharacterAndFollower(true);
                        _loc_8 = _loc_9;
                    }
                    _loc_10 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_8.id) as GameRolePlayActorInformations;
                    if (_loc_8 is TiphonSprite)
                    {
                        _loc_40 = _loc_8 as TiphonSprite;
                        _loc_41 = (_loc_8 as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite;
                        _loc_42 = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) && RoleplayEntitiesFrame(Kernel.getWorker().getFrame(RoleplayEntitiesFrame)).isCreatureMode;
                        if (_loc_41 && !_loc_42)
                        {
                            _loc_40 = _loc_41;
                        }
                        _loc_43 = _loc_40.getSlot("Tete");
                        if (_loc_43)
                        {
                            _loc_44 = _loc_43.getBounds(StageShareManager.stage);
                            _loc_45 = new Rectangle2(_loc_44.x, _loc_44.y, _loc_44.width, _loc_44.height);
                            _loc_11 = _loc_45;
                        }
                    }
                    if (!_loc_11)
                    {
                        _loc_11 = (_loc_8 as IDisplayable).absoluteBounds;
                    }
                    _loc_12 = null;
                    if (this.roleplayContextFrame.entitiesFrame.isFight(_loc_8.id))
                    {
                        if (this.allowOnlyCharacterInteraction)
                        {
                            return false;
                        }
                        _loc_46 = this.roleplayContextFrame.entitiesFrame.getFightTeam(_loc_8.id);
                        _loc_10 = new RoleplayTeamFightersTooltipInformation(_loc_46);
                        _loc_12 = "roleplayFight";
                        this.displayCursor(FIGHT_CURSOR, !PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                    }
                    else
                    {
                        switch(true)
                        {
                            case _loc_10 is GameRolePlayCharacterInformations:
                            {
                                if (_loc_10.contextualId == PlayedCharacterManager.getInstance().id)
                                {
                                    _loc_47 = 0;
                                }
                                else
                                {
                                    _loc_52 = _loc_10.alignmentInfos.characterPower - _loc_10.contextualId;
                                    _loc_53 = PlayedCharacterManager.getInstance().infos.level;
                                    _loc_47 = PlayedCharacterManager.getInstance().levelDiff(_loc_52);
                                }
                                _loc_10 = new CharacterTooltipInformation(_loc_10 as GameRolePlayCharacterInformations, _loc_47);
                                _loc_13 = "CharacterCache";
                                break;
                            }
                            case _loc_10 is GameRolePlayMutantInformations:
                            {
                                if ((_loc_10 as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                                {
                                    _loc_10 = new CharacterTooltipInformation(_loc_10, 0);
                                }
                                else
                                {
                                    _loc_10 = new MutantTooltipInformation(_loc_10 as GameRolePlayMutantInformations);
                                }
                                break;
                            }
                            case _loc_10 is GameRolePlayTaxCollectorInformations:
                            {
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return false;
                                }
                                _loc_48 = (_loc_10 as GameRolePlayTaxCollectorInformations).guildIdentity;
                                _loc_49 = GuildWrapper.create(_loc_48.guildId, _loc_48.guildName, _loc_48.guildEmblem, 0, true);
                                _loc_10 = new TaxCollectorTooltipInformation(TaxCollectorName.getTaxCollectorNameById((_loc_10 as GameRolePlayTaxCollectorInformations).lastNameId).name, TaxCollectorFirstname.getTaxCollectorFirstnameById((_loc_10 as GameRolePlayTaxCollectorInformations).firstNameId).firstname, _loc_49, (_loc_10 as GameRolePlayTaxCollectorInformations).taxCollectorAttack);
                                break;
                            }
                            case _loc_10 is GameRolePlayNpcInformations:
                            {
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return false;
                                }
                                _loc_50 = _loc_10 as GameRolePlayNpcInformations;
                                _loc_51 = Npc.getNpcById(_loc_50.npcId);
                                if (_loc_51.actions.length == 0)
                                {
                                    break;
                                }
                                this.displayCursor(NPC_CURSOR);
                                _loc_10 = new TextTooltipInfo(_loc_51.name, XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css", "green", 0);
                                _loc_10.bgCornerRadius = 10;
                                _loc_13 = "NPCCacheName";
                                break;
                            }
                            case _loc_10 is GameRolePlayGroupMonsterInformations:
                            {
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return false;
                                }
                                this.displayCursor(FIGHT_CURSOR, !PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                                _loc_13 = "GroupMonsterCache";
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    if (!_loc_10)
                    {
                        _log.warn("Rolling over a unknown entity (" + _loc_6.entity.id + ").");
                        return false;
                    }
                    _loc_14 = new SystemApi();
                    TooltipManager.show(_loc_10, _loc_11, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, _loc_7, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, _loc_12, null, null, _loc_13, false, StrataEnum.STRATA_TOOLTIP, _loc_14.getCurrentZoom());
                    return true;
                }
                case param1 is MouseRightClickMessage:
                {
                    _loc_15 = param1 as MouseRightClickMessage;
                    _loc_16 = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                    _loc_17 = _loc_15.target as IInteractive;
                    if (_loc_17)
                    {
                        _loc_54 = this.roleplayContextFrame;
                        _loc_55 = _loc_54.entitiesFrame.getEntityInfos(_loc_17.id);
                        if (_loc_55 is GameRolePlayNamedActorInformations)
                        {
                            if (!(_loc_17 is AnimatedCharacter))
                            {
                                _log.error("L\'entity " + _loc_17.id + " est un GameRolePlayNamedActorInformations mais n\'est pas un AnimatedCharacter");
                                return true;
                            }
                            _loc_17 = (_loc_17 as AnimatedCharacter).getRootEntity();
                            _loc_56 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_17.id);
                            _loc_57 = MenusFactory.create(_loc_56, "multiplayer", [_loc_17]);
                            if (_loc_57)
                            {
                                _loc_16.createContextMenu(_loc_57);
                            }
                            return true;
                        }
                    }
                    return false;
                }
                case param1 is EntityMouseOutMessage:
                {
                    _loc_18 = param1 as EntityMouseOutMessage;
                    this.displayCursor(NO_CURSOR);
                    TooltipManager.hide("entity_" + _loc_18.entity.id);
                    _loc_9 = _loc_18.entity as AnimatedCharacter;
                    if (_loc_9)
                    {
                        _loc_9 = _loc_9.getRootEntity();
                        _loc_9.highLightCharacterAndFollower(false);
                    }
                    return true;
                }
                case param1 is EntityClickMessage:
                {
                    _loc_19 = param1 as EntityClickMessage;
                    _loc_20 = _loc_19.entity as IInteractive;
                    if (_loc_20 is AnimatedCharacter)
                    {
                        _loc_20 = (_loc_20 as AnimatedCharacter).getRootEntity();
                    }
                    _loc_21 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_20.id);
                    _loc_22 = RoleplayManager.getInstance().displayContextualMenu(_loc_21, _loc_20);
                    if (this.roleplayContextFrame.entitiesFrame.isFight(_loc_20.id))
                    {
                        _loc_58 = this.roleplayContextFrame.entitiesFrame.getFightId(_loc_20.id);
                        _loc_59 = this.roleplayContextFrame.entitiesFrame.getFightLeaderId(_loc_20.id);
                        _loc_60 = this.roleplayContextFrame.entitiesFrame.getFightTeamType(_loc_20.id);
                        if (_loc_60 == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR)
                        {
                            _loc_64 = this.roleplayContextFrame.entitiesFrame.getFightTeam(_loc_20.id) as FightTeam;
                            for each (_loc_65 in _loc_64.teamInfos.teamMembers)
                            {
                                
                                if (_loc_65 is FightTeamMemberTaxCollectorInformations)
                                {
                                    _loc_63 = (_loc_65 as FightTeamMemberTaxCollectorInformations).guildId;
                                }
                            }
                            _loc_66 = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
                            if (_loc_66 && _loc_63 == _loc_66.guildId)
                            {
                                KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial, 1, 2);
                                Kernel.getWorker().process(GuildFightJoinRequestAction.create(PlayedCharacterManager.getInstance().currentMap.mapId));
                                return true;
                            }
                        }
                        _loc_61 = new GameFightJoinRequestMessage();
                        _loc_61.initGameFightJoinRequestMessage(_loc_59, _loc_58);
                        _loc_62 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        if ((_loc_62 as IMovable).isMoving)
                        {
                            this.roleplayMovementFrame.setFollowingMessage(_loc_61);
                            (_loc_62 as IMovable).stop();
                        }
                        else
                        {
                            ConnectionsHandler.getConnection().send(_loc_61);
                        }
                    }
                    else if (_loc_20.id != PlayedCharacterManager.getInstance().id && !_loc_22)
                    {
                        this.roleplayMovementFrame.setFollowingInteraction(null);
                        this.roleplayMovementFrame.askMoveTo(_loc_20.position);
                    }
                    return true;
                }
                case param1 is InteractiveElementActivationMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    _loc_23 = param1 as InteractiveElementActivationMessage;
                    _loc_24 = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
                    if (_loc_24 && _loc_24.usingInteractive)
                    {
                    }
                    else
                    {
                        _loc_67 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        _loc_68 = _loc_23.position.getNearestFreeCellInDirection(_loc_23.position.advancedOrientationTo(_loc_67.position), DataMapProvider.getInstance(), true);
                        if (!_loc_68)
                        {
                            _loc_68 = _loc_23.position;
                        }
                        this.roleplayMovementFrame.setFollowingInteraction({ie:_loc_23.interactiveElement, skillInstanceId:_loc_23.skillInstanceId});
                        this.roleplayMovementFrame.askMoveTo(_loc_68);
                    }
                    return true;
                }
                case param1 is InteractiveElementMouseOverMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    _loc_25 = param1 as InteractiveElementMouseOverMessage;
                    _loc_29 = _loc_25.interactiveElement;
                    for each (_loc_30 in _loc_29.enabledSkills)
                    {
                        
                        if (_loc_30.skillId == 175)
                        {
                            _loc_26 = this.roleplayContextFrame.currentPaddock;
                            break;
                        }
                    }
                    _loc_31 = Interactive.getInteractiveById(_loc_29.elementTypeId);
                    _loc_32 = _loc_25.interactiveElement.elementId;
                    _loc_33 = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                    _loc_34 = _loc_33.housesInformations[_loc_32];
                    _loc_35 = _loc_25.sprite.getRect(StageShareManager.stage);
                    if (_loc_34)
                    {
                        _loc_26 = _loc_34;
                    }
                    else if (_loc_26 == null && _loc_31)
                    {
                        _loc_69 = new Object();
                        _loc_69.interactive = _loc_31.name;
                        _loc_70 = "";
                        for each (_loc_30 in _loc_29.enabledSkills)
                        {
                            
                            _loc_70 = _loc_70 + (Skill.getSkillById(_loc_30.skillId).name + "\n");
                        }
                        _loc_69.enabledSkills = _loc_70;
                        _loc_71 = "";
                        for each (_loc_30 in _loc_29.disabledSkills)
                        {
                            
                            _loc_71 = _loc_71 + (Skill.getSkillById(_loc_30.skillId).name + "\n");
                        }
                        _loc_69.disabledSkills = _loc_71;
                        _loc_26 = _loc_69;
                        _loc_27 = "interactiveElement";
                        _loc_28 = "InteractiveElementCache";
                    }
                    if (_loc_26)
                    {
                        TooltipManager.show(_loc_26, new Rectangle(_loc_35.right, int(_loc_35.y + _loc_35.height - AtouinConstants.CELL_HEIGHT), 0, 0), UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, TooltipManager.TOOLTIP_STANDAR_NAME, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOP, 0, true, _loc_27, null, null, _loc_28);
                    }
                    return true;
                }
                case param1 is InteractiveElementMouseOutMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    _loc_36 = param1 as InteractiveElementMouseOutMessage;
                    TooltipManager.hide();
                    return true;
                }
                case param1 is ShowAllNamesAction:
                {
                    if (Kernel.getWorker().contains(InfoEntitiesFrame))
                    {
                        Kernel.getWorker().removeFrame(this._infoEntitiesFrame);
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(this._infoEntitiesFrame);
                    }
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
            Mouse.show();
            LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
            LinkedCursorSpriteManager.getInstance().removeItem("interactiveCursor");
            FrustumManager.getInstance().setBorderInteraction(false);
            return true;
        }// end function

        private function displayCursor(param1:int, param2:Boolean = true) : void
        {
            if (param1 == -1)
            {
                Mouse.show();
                LinkedCursorSpriteManager.getInstance().removeItem("interactiveCursor");
                return;
            }
            if (PlayedCharacterManager.getInstance().state != PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
            {
                return;
            }
            var _loc_3:* = new LinkedCursorData();
            _loc_3.sprite = RoleplayInteractivesFrame.getCursor(param1, param2);
            _loc_3.offset = INTERACTIVE_CURSOR_OFFSET;
            Mouse.hide();
            LinkedCursorSpriteManager.getInstance().addItem("interactiveCursor", _loc_3);
            return;
        }// end function

        private function onWisperMessage(param1:String) : void
        {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ChatFocus, param1);
            return;
        }// end function

        private function onMerchantPlayerBuyClick(param1:int, param2:uint) : void
        {
            var _loc_3:* = new ExchangeOnHumanVendorRequestMessage();
            _loc_3.initExchangeOnHumanVendorRequestMessage(param1, param2);
            ConnectionsHandler.getConnection().send(_loc_3);
            return;
        }// end function

        private function onInviteMenuClicked(param1:String) : void
        {
            var _loc_2:* = new PartyInvitationRequestMessage();
            _loc_2.initPartyInvitationRequestMessage(param1);
            ConnectionsHandler.getConnection().send(_loc_2);
            return;
        }// end function

        private function onMerchantHouseKickOff(param1:uint) : void
        {
            var _loc_2:* = new HouseKickIndoorMerchantRequestMessage();
            _loc_2.initHouseKickIndoorMerchantRequestMessage(param1);
            ConnectionsHandler.getConnection().send(_loc_2);
            return;
        }// end function

    }
}

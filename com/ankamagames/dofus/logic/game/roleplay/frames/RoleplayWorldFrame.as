package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
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
            var _loc_2:AdjacentMapOverMessage = null;
            var _loc_3:Point = null;
            var _loc_4:Sprite = null;
            var _loc_5:DisplayObject = null;
            var _loc_6:LinkedCursorData = null;
            var _loc_7:EntityMouseOverMessage = null;
            var _loc_8:String = null;
            var _loc_9:IInteractive = null;
            var _loc_10:AnimatedCharacter = null;
            var _loc_11:* = undefined;
            var _loc_12:IRectangle = null;
            var _loc_13:String = null;
            var _loc_14:Dictionary = null;
            var _loc_15:IEntity = null;
            var _loc_16:String = null;
            var _loc_17:MouseRightClickMessage = null;
            var _loc_18:Object = null;
            var _loc_19:IInteractive = null;
            var _loc_20:EntityMouseOutMessage = null;
            var _loc_21:EntityClickMessage = null;
            var _loc_22:IInteractive = null;
            var _loc_23:GameContextActorInformations = null;
            var _loc_24:Boolean = false;
            var _loc_25:InteractiveElementActivationMessage = null;
            var _loc_26:RoleplayInteractivesFrame = null;
            var _loc_27:InteractiveElementMouseOverMessage = null;
            var _loc_28:Object = null;
            var _loc_29:String = null;
            var _loc_30:String = null;
            var _loc_31:InteractiveElement = null;
            var _loc_32:InteractiveElementSkill = null;
            var _loc_33:Interactive = null;
            var _loc_34:uint = 0;
            var _loc_35:RoleplayEntitiesFrame = null;
            var _loc_36:HouseWrapper = null;
            var _loc_37:Rectangle = null;
            var _loc_38:InteractiveElementMouseOutMessage = null;
            var _loc_39:CellClickMessage = null;
            var _loc_40:AdjacentMapClickMessage = null;
            var _loc_41:IEntity = null;
            var _loc_42:TiphonSprite = null;
            var _loc_43:TiphonSprite = null;
            var _loc_44:Boolean = false;
            var _loc_45:DisplayObject = null;
            var _loc_46:Rectangle = null;
            var _loc_47:Rectangle2 = null;
            var _loc_48:FightTeam = null;
            var _loc_49:int = 0;
            var _loc_50:GuildInformations = null;
            var _loc_51:GuildWrapper = null;
            var _loc_52:GameRolePlayNpcInformations = null;
            var _loc_53:Npc = null;
            var _loc_54:uint = 0;
            var _loc_55:uint = 0;
            var _loc_56:RoleplayContextFrame = null;
            var _loc_57:GameContextActorInformations = null;
            var _loc_58:GameContextActorInformations = null;
            var _loc_59:Object = null;
            var _loc_60:uint = 0;
            var _loc_61:int = 0;
            var _loc_62:uint = 0;
            var _loc_63:GameFightJoinRequestMessage = null;
            var _loc_64:IEntity = null;
            var _loc_65:int = 0;
            var _loc_66:FightTeam = null;
            var _loc_67:FightTeamMemberInformations = null;
            var _loc_68:GuildWrapper = null;
            var _loc_69:IEntity = null;
            var _loc_70:MapPoint = null;
            var _loc_71:Object = null;
            var _loc_72:String = null;
            var _loc_73:String = null;
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
                        _loc_39 = param1 as CellClickMessage;
                        this.roleplayMovementFrame.resetNextMoveMapChange();
                        _log.debug("Player clicked on cell " + _loc_39.cellId + ".");
                        this.roleplayMovementFrame.setFollowingInteraction(null);
                        this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(_loc_39.cellId));
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
                        _loc_40 = param1 as AdjacentMapClickMessage;
                        _loc_41 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        if (!_loc_41)
                        {
                            _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                            return false;
                        }
                        this.roleplayMovementFrame.setNextMoveMapChange(_loc_40.adjacentMapId);
                        if (!_loc_41.position.equals(MapPoint.fromCellId(_loc_40.cellId)))
                        {
                            this.roleplayMovementFrame.setFollowingInteraction(null);
                            this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(_loc_40.cellId));
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
                    _loc_5 = Berilia.getInstance().strataTooltip;
                    _loc_6 = new LinkedCursorData();
                    switch(_loc_2.direction)
                    {
                        case DirectionsEnum.LEFT:
                        {
                            _loc_6.sprite = Sprite(this._mouseLeft);
                            _loc_6.lockX = true;
                            _loc_6.sprite.x = _loc_2.zone.x + _loc_2.zone.width / 2;
                            _loc_6.offset = new Point(0, 0);
                            _loc_6.lockY = true;
                            _loc_6.sprite.y = _loc_4.y + _loc_4.height / 2;
                            break;
                        }
                        case DirectionsEnum.UP:
                        {
                            _loc_6.sprite = Sprite(this._mouseTop);
                            _loc_6.lockY = true;
                            _loc_6.sprite.y = _loc_2.zone.y + _loc_2.zone.height / 2;
                            _loc_6.offset = new Point(0, 0);
                            _loc_6.lockX = true;
                            _loc_6.sprite.x = _loc_4.x + _loc_4.width / 2;
                            break;
                        }
                        case DirectionsEnum.DOWN:
                        {
                            _loc_6.sprite = Sprite(this._mouseBottom);
                            _loc_6.lockY = true;
                            _loc_6.sprite.y = _loc_2.zone.getBounds(_loc_2.zone).top;
                            _loc_6.offset = new Point(0, 0);
                            _loc_6.lockX = true;
                            _loc_6.sprite.x = _loc_4.x + _loc_4.width / 2;
                            break;
                        }
                        case DirectionsEnum.RIGHT:
                        {
                            _loc_6.sprite = Sprite(this._mouseRight);
                            _loc_6.lockX = true;
                            _loc_6.sprite.x = _loc_2.zone.getBounds(_loc_2.zone).left + _loc_2.zone.width / 2;
                            _loc_6.offset = new Point(0, 0);
                            _loc_6.lockY = true;
                            _loc_6.sprite.y = _loc_4.y + _loc_4.height / 2;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    LinkedCursorSpriteManager.getInstance().addItem("changeMapCursor", _loc_6);
                    return true;
                }
                case param1 is EntityMouseOverMessage:
                {
                    _loc_7 = param1 as EntityMouseOverMessage;
                    _loc_8 = "entity_" + _loc_7.entity.id;
                    this.displayCursor(NO_CURSOR);
                    _loc_9 = _loc_7.entity as IInteractive;
                    _loc_10 = _loc_9 as AnimatedCharacter;
                    if (_loc_10)
                    {
                        _loc_10 = _loc_10.getRootEntity();
                        _loc_10.highLightCharacterAndFollower(true);
                        _loc_9 = _loc_10;
                    }
                    _loc_11 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_9.id) as GameRolePlayActorInformations;
                    if (_loc_9 is TiphonSprite)
                    {
                        _loc_42 = _loc_9 as TiphonSprite;
                        _loc_43 = (_loc_9 as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite;
                        _loc_44 = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) && RoleplayEntitiesFrame(Kernel.getWorker().getFrame(RoleplayEntitiesFrame)).isCreatureMode;
                        if (_loc_43 && !_loc_44)
                        {
                            _loc_42 = _loc_43;
                        }
                        _loc_45 = _loc_42.getSlot("Tete");
                        if (_loc_45)
                        {
                            _loc_46 = _loc_45.getBounds(StageShareManager.stage);
                            _loc_47 = new Rectangle2(_loc_46.x, _loc_46.y, _loc_46.width, _loc_46.height);
                            _loc_12 = _loc_47;
                        }
                    }
                    if (!_loc_12)
                    {
                        _loc_12 = (_loc_9 as IDisplayable).absoluteBounds;
                    }
                    _loc_13 = null;
                    _loc_14 = this.roleplayContextFrame.entitiesFrame.fights;
                    _loc_15 = DofusEntities.getEntity(_loc_9.id);
                    if (this.roleplayContextFrame.entitiesFrame.isFight(_loc_9.id))
                    {
                        if (this.allowOnlyCharacterInteraction)
                        {
                            return false;
                        }
                        _loc_48 = this.roleplayContextFrame.entitiesFrame.getFightTeam(_loc_9.id);
                        _loc_11 = new RoleplayTeamFightersTooltipInformation(_loc_48);
                        _loc_13 = "roleplayFight";
                        this.displayCursor(FIGHT_CURSOR, !PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                    }
                    else
                    {
                        switch(true)
                        {
                            case _loc_11 is GameRolePlayCharacterInformations:
                            {
                                if (_loc_11.contextualId == PlayedCharacterManager.getInstance().id)
                                {
                                    _loc_49 = 0;
                                }
                                else
                                {
                                    _loc_54 = _loc_11.alignmentInfos.characterPower - _loc_11.contextualId;
                                    _loc_55 = PlayedCharacterManager.getInstance().infos.level;
                                    _loc_49 = PlayedCharacterManager.getInstance().levelDiff(_loc_54);
                                }
                                _loc_11 = new CharacterTooltipInformation(_loc_11 as GameRolePlayCharacterInformations, _loc_49);
                                _loc_16 = "CharacterCache";
                                break;
                            }
                            case _loc_11 is GameRolePlayMutantInformations:
                            {
                                if ((_loc_11 as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                                {
                                    _loc_11 = new CharacterTooltipInformation(_loc_11, 0);
                                }
                                else
                                {
                                    _loc_11 = new MutantTooltipInformation(_loc_11 as GameRolePlayMutantInformations);
                                }
                                break;
                            }
                            case _loc_11 is GameRolePlayTaxCollectorInformations:
                            {
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return false;
                                }
                                _loc_50 = (_loc_11 as GameRolePlayTaxCollectorInformations).guildIdentity;
                                _loc_51 = GuildWrapper.create(_loc_50.guildId, _loc_50.guildName, _loc_50.guildEmblem, 0);
                                _loc_11 = new TaxCollectorTooltipInformation(TaxCollectorName.getTaxCollectorNameById((_loc_11 as GameRolePlayTaxCollectorInformations).lastNameId).name, TaxCollectorFirstname.getTaxCollectorFirstnameById((_loc_11 as GameRolePlayTaxCollectorInformations).firstNameId).firstname, _loc_51, (_loc_11 as GameRolePlayTaxCollectorInformations).taxCollectorAttack);
                                break;
                            }
                            case _loc_11 is GameRolePlayNpcInformations:
                            {
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return false;
                                }
                                _loc_52 = _loc_11 as GameRolePlayNpcInformations;
                                _loc_53 = Npc.getNpcById(_loc_52.npcId);
                                if (_loc_53.actions.length == 0)
                                {
                                    break;
                                }
                                this.displayCursor(NPC_CURSOR);
                                _loc_11 = new TextTooltipInfo(_loc_53.name, XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css", "green", 0);
                                _loc_11.bgCornerRadius = 10;
                                _loc_16 = "NPCCacheName";
                                break;
                            }
                            case _loc_11 is GameRolePlayGroupMonsterInformations:
                            {
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return false;
                                }
                                this.displayCursor(FIGHT_CURSOR, !PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                                _loc_16 = "GroupMonsterCache";
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    if (!_loc_11)
                    {
                        _log.warn("Rolling over a unknown entity (" + _loc_7.entity.id + ").");
                        return false;
                    }
                    TooltipManager.show(_loc_11, _loc_12, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, _loc_8, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, _loc_13, null, null, _loc_16);
                    return true;
                }
                case param1 is MouseRightClickMessage:
                {
                    _loc_17 = param1 as MouseRightClickMessage;
                    _loc_18 = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                    _loc_19 = _loc_17.target as IInteractive;
                    if (_loc_19)
                    {
                        _loc_56 = this.roleplayContextFrame;
                        _loc_57 = _loc_56.entitiesFrame.getEntityInfos(_loc_19.id);
                        if (_loc_57 is GameRolePlayNamedActorInformations)
                        {
                            if (!(_loc_19 is AnimatedCharacter))
                            {
                                _log.error("L\'entity " + _loc_19.id + " est un GameRolePlayNamedActorInformations mais n\'est pas un AnimatedCharacter");
                                return true;
                            }
                            _loc_19 = (_loc_19 as AnimatedCharacter).getRootEntity();
                            _loc_58 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_19.id);
                            _loc_59 = MenusFactory.create(_loc_58, "multiplayer", [_loc_19]);
                            if (_loc_59)
                            {
                                _loc_18.createContextMenu(_loc_59);
                            }
                            return true;
                        }
                    }
                    return false;
                }
                case param1 is EntityMouseOutMessage:
                {
                    _loc_20 = param1 as EntityMouseOutMessage;
                    this.displayCursor(NO_CURSOR);
                    TooltipManager.hide("entity_" + _loc_20.entity.id);
                    _loc_10 = _loc_20.entity as AnimatedCharacter;
                    if (_loc_10)
                    {
                        _loc_10 = _loc_10.getRootEntity();
                        _loc_10.highLightCharacterAndFollower(false);
                    }
                    return true;
                }
                case param1 is EntityClickMessage:
                {
                    _loc_21 = param1 as EntityClickMessage;
                    _loc_22 = _loc_21.entity as IInteractive;
                    if (_loc_22 is AnimatedCharacter)
                    {
                        _loc_22 = (_loc_22 as AnimatedCharacter).getRootEntity();
                    }
                    _loc_23 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc_22.id);
                    _loc_24 = RoleplayManager.getInstance().displayContextualMenu(_loc_23, _loc_22);
                    if (this.roleplayContextFrame.entitiesFrame.isFight(_loc_22.id))
                    {
                        _loc_60 = this.roleplayContextFrame.entitiesFrame.getFightId(_loc_22.id);
                        _loc_61 = this.roleplayContextFrame.entitiesFrame.getFightLeaderId(_loc_22.id);
                        _loc_62 = this.roleplayContextFrame.entitiesFrame.getFightTeamType(_loc_22.id);
                        if (_loc_62 == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR)
                        {
                            _loc_66 = this.roleplayContextFrame.entitiesFrame.getFightTeam(_loc_22.id) as FightTeam;
                            for each (_loc_67 in _loc_66.teamInfos.teamMembers)
                            {
                                
                                if (_loc_67 is FightTeamMemberTaxCollectorInformations)
                                {
                                    _loc_65 = (_loc_67 as FightTeamMemberTaxCollectorInformations).guildId;
                                }
                            }
                            _loc_68 = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
                            if (_loc_68 && _loc_65 == _loc_68.guildId)
                            {
                                KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial, 1, 2);
                                Kernel.getWorker().process(GuildFightJoinRequestAction.create(PlayedCharacterManager.getInstance().currentMap.mapId));
                                return true;
                            }
                        }
                        _loc_63 = new GameFightJoinRequestMessage();
                        _loc_63.initGameFightJoinRequestMessage(_loc_61, _loc_60);
                        _loc_64 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        if ((_loc_64 as IMovable).isMoving)
                        {
                            this.roleplayMovementFrame.setFollowingMessage(_loc_63);
                            (_loc_64 as IMovable).stop();
                        }
                        else
                        {
                            ConnectionsHandler.getConnection().send(_loc_63);
                        }
                    }
                    else if (_loc_22.id != PlayedCharacterManager.getInstance().id && !_loc_24)
                    {
                        this.roleplayMovementFrame.setFollowingInteraction(null);
                        this.roleplayMovementFrame.askMoveTo(_loc_22.position);
                    }
                    return true;
                }
                case param1 is InteractiveElementActivationMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    _loc_25 = param1 as InteractiveElementActivationMessage;
                    _loc_26 = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
                    if (_loc_26 && _loc_26.usingInteractive)
                    {
                    }
                    else
                    {
                        _loc_69 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        if (_loc_69.position.distanceTo(_loc_25.position) <= 1)
                        {
                            this.roleplayMovementFrame.activateSkill(_loc_25.skillInstanceId, _loc_25.interactiveElement);
                        }
                        else
                        {
                            _loc_70 = _loc_25.position.getNearestFreeCellInDirection(_loc_25.position.advancedOrientationTo(_loc_69.position), DataMapProvider.getInstance(), true);
                            if (!_loc_70)
                            {
                                _loc_70 = _loc_25.position;
                            }
                            this.roleplayMovementFrame.setFollowingInteraction({ie:_loc_25.interactiveElement, skillInstanceId:_loc_25.skillInstanceId});
                            this.roleplayMovementFrame.askMoveTo(_loc_70);
                        }
                    }
                    return true;
                }
                case param1 is InteractiveElementMouseOverMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    _loc_27 = param1 as InteractiveElementMouseOverMessage;
                    _loc_31 = _loc_27.interactiveElement;
                    for each (_loc_32 in _loc_31.enabledSkills)
                    {
                        
                        if (_loc_32.skillId == 175)
                        {
                            _loc_28 = this.roleplayContextFrame.currentPaddock;
                            break;
                        }
                    }
                    _loc_33 = Interactive.getInteractiveById(_loc_31.elementTypeId);
                    _loc_34 = _loc_27.interactiveElement.elementId;
                    _loc_35 = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                    _loc_36 = _loc_35.housesInformations[_loc_34];
                    _loc_37 = _loc_27.sprite.getRect(StageShareManager.stage);
                    if (_loc_36)
                    {
                        _loc_28 = _loc_36;
                    }
                    else if (_loc_28 == null && _loc_33)
                    {
                        _loc_71 = new Object();
                        _loc_71.interactive = _loc_33.name;
                        _loc_72 = "";
                        for each (_loc_32 in _loc_31.enabledSkills)
                        {
                            
                            _loc_72 = _loc_72 + (Skill.getSkillById(_loc_32.skillId).name + "\n");
                        }
                        _loc_71.enabledSkills = _loc_72;
                        _loc_73 = "";
                        for each (_loc_32 in _loc_31.disabledSkills)
                        {
                            
                            _loc_73 = _loc_73 + (Skill.getSkillById(_loc_32.skillId).name + "\n");
                        }
                        _loc_71.disabledSkills = _loc_73;
                        _loc_28 = _loc_71;
                        _loc_29 = "interactiveElement";
                        _loc_30 = "InteractiveElementCache";
                    }
                    if (_loc_28)
                    {
                        TooltipManager.show(_loc_28, new Rectangle(_loc_37.right, int(_loc_37.y + _loc_37.height - AtouinConstants.CELL_HEIGHT), 0, 0), UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, TooltipManager.TOOLTIP_STANDAR_NAME, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOP, 0, true, _loc_29, null, null, _loc_30);
                    }
                    return true;
                }
                case param1 is InteractiveElementMouseOutMessage:
                {
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return false;
                    }
                    _loc_38 = param1 as InteractiveElementMouseOutMessage;
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

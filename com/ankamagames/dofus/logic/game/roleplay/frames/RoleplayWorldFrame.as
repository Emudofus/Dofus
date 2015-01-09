package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.geom.Point;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.atouin.managers.FrustumManager;
    import com.ankamagames.berilia.frames.ShortcutsFrame;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.Event;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
    import com.ankamagames.atouin.types.GraphicCell;
    import com.ankamagames.berilia.types.data.LinkedCursorData;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
    import com.ankamagames.jerakine.entities.interfaces.IInteractive;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
    import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
    import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOverMessage;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
    import com.ankamagames.dofus.datacenter.interactives.Interactive;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import flash.geom.Rectangle;
    import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOutMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.ShowMonstersInfoAction;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
    import com.ankamagames.atouin.messages.CellClickMessage;
    import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import flash.display.DisplayObject;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.jerakine.utils.display.Rectangle2;
    import com.ankamagames.dofus.logic.game.roleplay.types.FightTeam;
    import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
    import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.dofus.datacenter.npcs.Npc;
    import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayTreasureHintInformations;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinRequestMessage;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.datacenter.jobs.Skill;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementWithAgeBonus;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
    import com.ankamagames.atouin.messages.AdjacentMapOutMessage;
    import com.ankamagames.atouin.utils.CellIdConverter;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.jerakine.types.enums.DirectionsEnum;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.atouin.types.FrustumShape;
    import flash.events.MouseEvent;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.jerakine.enum.OptionEnum;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.dofus.logic.game.roleplay.types.RoleplayTeamFightersTooltipInformation;
    import com.ankamagames.dofus.logic.game.roleplay.types.CharacterTooltipInformation;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
    import com.ankamagames.dofus.logic.game.roleplay.types.MutantTooltipInformation;
    import com.ankamagames.dofus.network.types.game.context.TaxCollectorStaticExtendedInformations;
    import com.ankamagames.dofus.logic.game.roleplay.types.TaxCollectorTooltipInformation;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
    import com.ankamagames.berilia.types.data.TextTooltipInfo;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
    import com.ankamagames.dofus.logic.game.roleplay.types.PrismTooltipInformation;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
    import com.ankamagames.dofus.logic.game.roleplay.types.PortalTooltipInformation;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
    import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
    import com.ankamagames.berilia.factories.MenusFactory;
    import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
    import com.ankamagames.dofus.network.enums.TeamTypeEnum;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberTaxCollectorInformations;
    import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.SocialHookList;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightJoinRequestAction;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.enum.OperatingSystem;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
    import com.ankamagames.jerakine.messages.Message;
    import flash.ui.Mouse;
    import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOnHumanVendorRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickIndoorMerchantRequestMessage;

    public class RoleplayWorldFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayWorldFrame));
        private static const NO_CURSOR:int = -1;
        private static const FIGHT_CURSOR:int = 3;
        private static const NPC_CURSOR:int = 1;
        private static const INTERACTIVE_CURSOR_OFFSET:Point = new Point(0, 0);
        private static const COLLECTABLE_INTERACTIVE_ACTION_ID:uint = 1;
        private static var _monstersInfoFrame:MonstersInfoFrame = new MonstersInfoFrame();

        private const _common:String = XmlConfig.getInstance().getEntry("config.ui.skin");

        private var _mouseLabel:Label;
        private var _mouseTop:Texture;
        private var _mouseBottom:Texture;
        private var _mouseRight:Texture;
        private var _mouseLeft:Texture;
        private var _mouseTopBlue:Texture;
        private var _mouseBottomBlue:Texture;
        private var _mouseRightBlue:Texture;
        private var _mouseLeftBlue:Texture;
        private var _texturesReady:Boolean;
        private var _playerEntity:AnimatedCharacter;
        private var _playerName:String;
        private var _allowOnlyCharacterInteraction:Boolean;
        public var cellClickEnabled:Boolean;
        private var _infoEntitiesFrame:InfoEntitiesFrame;
        private var _mouseOverEntityId:int;
        private var sysApi:SystemApi;
        private var _entityTooltipData:Dictionary;
        private var _mouseDown:Boolean;
        public var pivotingCharacter:Boolean;

        public function RoleplayWorldFrame()
        {
            this._infoEntitiesFrame = new InfoEntitiesFrame();
            this.sysApi = new SystemApi();
            this._entityTooltipData = new Dictionary();
            super();
        }

        public function get mouseOverEntityId():int
        {
            return (this._mouseOverEntityId);
        }

        public function set allowOnlyCharacterInteraction(pAllow:Boolean):void
        {
            this._allowOnlyCharacterInteraction = pAllow;
        }

        public function get allowOnlyCharacterInteraction():Boolean
        {
            return (this._allowOnlyCharacterInteraction);
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        private function get roleplayContextFrame():RoleplayContextFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame));
        }

        private function get roleplayMovementFrame():RoleplayMovementFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame));
        }

        public function pushed():Boolean
        {
            FrustumManager.getInstance().setBorderInteraction(true);
            this._allowOnlyCharacterInteraction = false;
            this.cellClickEnabled = true;
            this.pivotingCharacter = false;
            var shortcutsFrame:ShortcutsFrame = (Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame);
            if (((!((shortcutsFrame.heldShortcuts.indexOf("showMonstersInfo") == -1))) && (!(Kernel.getWorker().contains(MonstersInfoFrame)))))
            {
                Kernel.getWorker().addFrame(_monstersInfoFrame);
            }
            else
            {
                if (Kernel.getWorker().contains(MonstersInfoFrame))
                {
                    Kernel.getWorker().removeFrame(_monstersInfoFrame);
                };
            };
            StageShareManager.stage.addEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            if (this._texturesReady)
            {
                return (true);
            };
            this._mouseBottom = new Texture();
            this._mouseBottom.uri = new Uri((this._common + "assets.swf|cursorBottom"));
            this._mouseBottom.finalize();
            this._mouseTop = new Texture();
            this._mouseTop.uri = new Uri((this._common + "assets.swf|cursorTop"));
            this._mouseTop.finalize();
            this._mouseRight = new Texture();
            this._mouseRight.uri = new Uri((this._common + "assets.swf|cursorRight"));
            this._mouseRight.finalize();
            this._mouseLeft = new Texture();
            this._mouseLeft.uri = new Uri((this._common + "assets.swf|cursorLeft"));
            this._mouseLeft.finalize();
            this._mouseBottomBlue = new Texture();
            this._mouseBottomBlue.uri = new Uri((this._common + "assets.swf|cursorBottomBlue"));
            this._mouseBottomBlue.finalize();
            this._mouseTopBlue = new Texture();
            this._mouseTopBlue.uri = new Uri((this._common + "assets.swf|cursorTopBlue"));
            this._mouseTopBlue.finalize();
            this._mouseRightBlue = new Texture();
            this._mouseRightBlue.uri = new Uri((this._common + "assets.swf|cursorRightBlue"));
            this._mouseRightBlue.finalize();
            this._mouseLeftBlue = new Texture();
            this._mouseLeftBlue.uri = new Uri((this._common + "assets.swf|cursorLeftBlue"));
            this._mouseLeftBlue.finalize();
            this._mouseLabel = new Label();
            this._mouseLabel.css = new Uri((XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css"));
            this._texturesReady = true;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:AdjacentMapOverMessage;
            var _local_3:Point;
            var _local_4:GraphicCell;
            var _local_5:Point;
            var _local_6:LinkedCursorData;
            var _local_7:WorldPointWrapper;
            var _local_8:int;
            var _local_9:SubArea;
            var _local_10:Boolean;
            var _local_11:int;
            var _local_12:int;
            var _local_13:String;
            var _local_14:String;
            var _local_15:Point;
            var _local_16:EntityMouseOverMessage;
            var _local_17:String;
            var _local_18:IInteractive;
            var _local_19:AnimatedCharacter;
            var _local_20:*;
            var _local_21:IRectangle;
            var _local_22:String;
            var _local_23:String;
            var _local_24:Number;
            var _local_25:MouseRightClickMessage;
            var _local_26:Object;
            var _local_27:IInteractive;
            var _local_28:EntityMouseOutMessage;
            var _local_29:EntityClickMessage;
            var _local_30:IInteractive;
            var _local_31:GameContextActorInformations;
            var _local_32:Boolean;
            var _local_33:InteractiveElementActivationMessage;
            var _local_34:RoleplayInteractivesFrame;
            var _local_35:InteractiveElementMouseOverMessage;
            var _local_36:Object;
            var _local_37:String;
            var _local_38:String;
            var _local_39:InteractiveElement;
            var _local_40:InteractiveElementSkill;
            var _local_41:Interactive;
            var _local_42:uint;
            var _local_43:RoleplayEntitiesFrame;
            var _local_44:HouseWrapper;
            var _local_45:Rectangle;
            var _local_46:InteractiveElementMouseOutMessage;
            var _local_47:ShowMonstersInfoAction;
            var _local_48:MouseUpMessage;
            var _local_49:ShortcutsFrame;
            var climsg:CellClickMessage;
            var amcmsg:AdjacentMapClickMessage;
            var playedEntity:IEntity;
            var mapPos:MapPosition;
            var text2:String;
            var target2:Rectangle;
            var param:Object;
            var objectsUnder:Array;
            var o:DisplayObject;
            var tooltipTarget:TiphonSprite;
            var rider:TiphonSprite;
            var isCreatureMode:Boolean;
            var head:DisplayObject;
            var r1:Rectangle;
            var r2:Rectangle2;
            var fight:FightTeam;
            var _local_66:AllianceInformations;
            var _local_67:int;
            var _local_68:GameRolePlayTaxCollectorInformations;
            var _local_69:GuildInformations;
            var _local_70:GuildWrapper;
            var _local_71:AllianceWrapper;
            var _local_72:GameRolePlayNpcInformations;
            var _local_73:Npc;
            var _local_74:AllianceFrame;
            var _local_75:GameRolePlayTreasureHintInformations;
            var _local_76:Npc;
            var _local_77:uint;
            var _local_78:uint;
            var rcf:RoleplayContextFrame;
            var actorInfos:GameContextActorInformations;
            var menu:Object;
            var rightClickedinfos:GameContextActorInformations;
            var fightId:uint;
            var fightTeamLeader:int;
            var teamType:uint;
            var gfjrmsg:GameFightJoinRequestMessage;
            var playerEntity3:IEntity;
            var guildId:int;
            var team:FightTeam;
            var fighter:FightTeamMemberInformations;
            var guild:GuildWrapper;
            var _local_92:IEntity;
            var _local_93:Array;
            var _local_94:int;
            var _local_95:MapPoint;
            var mp:MapPoint;
            var elem:Object;
            var enabledSkills:String;
            var disabledSkills:String;
            var collectSkill:Skill;
            var showBonus:Boolean;
            var iewab:InteractiveElementWithAgeBonus;
            switch (true)
            {
                case (msg is CellClickMessage):
                    if (this.pivotingCharacter)
                    {
                        return (false);
                    };
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return (false);
                    };
                    if (this.cellClickEnabled)
                    {
                        climsg = (msg as CellClickMessage);
                        (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).currentEmoticon = 0;
                        this.roleplayMovementFrame.resetNextMoveMapChange();
                        this.roleplayMovementFrame.setFollowingInteraction(null);
                        this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(climsg.cellId));
                    };
                    return (true);
                case (msg is AdjacentMapClickMessage):
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return (false);
                    };
                    if (this.cellClickEnabled)
                    {
                        amcmsg = (msg as AdjacentMapClickMessage);
                        playedEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        if (!(playedEntity))
                        {
                            _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                            return (false);
                        };
                        this.roleplayMovementFrame.setNextMoveMapChange(amcmsg.adjacentMapId);
                        if (!(playedEntity.position.equals(MapPoint.fromCellId(amcmsg.cellId))))
                        {
                            this.roleplayMovementFrame.setFollowingInteraction(null);
                            this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(amcmsg.cellId));
                        }
                        else
                        {
                            this.roleplayMovementFrame.setFollowingInteraction(null);
                            this.roleplayMovementFrame.askMapChange();
                        };
                    };
                    return (true);
                case (msg is AdjacentMapOutMessage):
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return (false);
                    };
                    TooltipManager.hide("subareaChange");
                    LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
                    return (true);
                case (msg is AdjacentMapOverMessage):
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return (false);
                    };
                    _local_2 = AdjacentMapOverMessage(msg);
                    _local_3 = CellIdConverter.cellIdToCoord(_local_2.cellId);
                    _local_4 = InteractiveCellManager.getInstance().getCell(_local_2.cellId);
                    _local_5 = _local_4.parent.localToGlobal(new Point(_local_4.x, _local_4.y));
                    _local_6 = new LinkedCursorData();
                    if ((((((((PlayedCharacterManager.getInstance().currentMap.leftNeighbourId == -1)) && ((PlayedCharacterManager.getInstance().currentMap.rightNeighbourId == -1)))) && ((PlayedCharacterManager.getInstance().currentMap.topNeighbourId == -1)))) && ((PlayedCharacterManager.getInstance().currentMap.bottomNeighbourId == -1))))
                    {
                        _local_7 = new WorldPointWrapper(MapDisplayManager.getInstance().getDataMapContainer().id);
                    }
                    else
                    {
                        _local_7 = PlayedCharacterManager.getInstance().currentMap;
                    };
                    if (_local_2.direction == DirectionsEnum.RIGHT)
                    {
                        _local_8 = _local_7.rightNeighbourId;
                    }
                    else
                    {
                        if (_local_2.direction == DirectionsEnum.DOWN)
                        {
                            _local_8 = _local_7.bottomNeighbourId;
                        }
                        else
                        {
                            if (_local_2.direction == DirectionsEnum.LEFT)
                            {
                                _local_8 = _local_7.leftNeighbourId;
                            }
                            else
                            {
                                if (_local_2.direction == DirectionsEnum.UP)
                                {
                                    _local_8 = _local_7.topNeighbourId;
                                };
                            };
                        };
                    };
                    _local_9 = SubArea.getSubAreaByMapId(_local_8);
                    _local_10 = false;
                    _local_11 = 0;
                    _local_12 = 0;
                    if (_local_9)
                    {
                        if (_local_9.id != PlayedCharacterManager.getInstance().currentSubArea.id)
                        {
                            _local_10 = true;
                            _local_14 = I18n.getUiText("ui.common.toward", [_local_9.name]);
                            text2 = ((I18n.getUiText("ui.common.level") + " ") + _local_9.level);
                        };
                        mapPos = MapPosition.getMapPositionById(_local_8);
                        if (((mapPos.showNameOnFingerpost) && (mapPos.name)))
                        {
                            _local_14 = I18n.getUiText("ui.common.toward", [mapPos.name]);
                        };
                        if (((_local_14) && (!((_local_14 == "")))))
                        {
                            this._mouseLabel.text = (((_local_14.length > text2.length)) ? _local_14 : text2);
                            _local_13 = ((_local_14 + "\n") + text2);
                        };
                    };
                    switch (_local_2.direction)
                    {
                        case DirectionsEnum.LEFT:
                            _local_6.sprite = ((_local_10) ? this._mouseLeftBlue : this._mouseLeft);
                            _local_6.lockX = true;
                            _local_6.sprite.x = (_local_2.zone.x + (_local_2.zone.width / 2));
                            _local_6.offset = new Point(0, 0);
                            _local_6.lockY = true;
                            _local_6.sprite.y = (_local_5.y + ((AtouinConstants.CELL_HEIGHT / 2) * Atouin.getInstance().currentZoom));
                            if (_local_10)
                            {
                                _local_11 = 0;
                                _local_12 = (_local_6.sprite.height / 2);
                            };
                            break;
                        case DirectionsEnum.UP:
                            _local_6.sprite = ((_local_10) ? this._mouseTopBlue : this._mouseTop);
                            _local_6.lockY = true;
                            _local_6.sprite.y = (_local_2.zone.y + (_local_2.zone.height / 2));
                            _local_6.offset = new Point(0, 0);
                            _local_6.lockX = true;
                            _local_6.sprite.x = (_local_5.x + ((AtouinConstants.CELL_WIDTH / 2) * Atouin.getInstance().currentZoom));
                            if (_local_10)
                            {
                                _local_11 = (-(this._mouseLabel.textWidth) / 2);
                                _local_12 = (_local_6.sprite.height + 5);
                            };
                            break;
                        case DirectionsEnum.DOWN:
                            _local_6.sprite = ((_local_10) ? this._mouseBottomBlue : this._mouseBottom);
                            _local_6.lockY = true;
                            _local_6.sprite.y = _local_2.zone.getBounds(_local_2.zone).top;
                            _local_6.offset = new Point(0, 0);
                            _local_6.lockX = true;
                            _local_6.sprite.x = (_local_5.x + ((AtouinConstants.CELL_WIDTH / 2) * Atouin.getInstance().currentZoom));
                            if (_local_10)
                            {
                                _local_11 = (-(this._mouseLabel.textWidth) / 2);
                                _local_12 = ((-(_local_6.sprite.height) - this._mouseLabel.textHeight) - 34);
                            };
                            break;
                        case DirectionsEnum.RIGHT:
                            _local_6.sprite = ((_local_10) ? this._mouseRightBlue : this._mouseRight);
                            _local_6.lockX = true;
                            _local_6.sprite.x = (_local_2.zone.getBounds(_local_2.zone).left + (_local_2.zone.width / 2));
                            _local_6.offset = new Point(0, 0);
                            _local_6.lockY = true;
                            _local_6.sprite.y = (_local_5.y + ((AtouinConstants.CELL_HEIGHT / 2) * Atouin.getInstance().currentZoom));
                            if (_local_10)
                            {
                                _local_11 = -(this._mouseLabel.textWidth);
                                _local_12 = (_local_6.sprite.height / 2);
                            };
                            break;
                    };
                    if (_local_10)
                    {
                        target2 = new Rectangle((_local_6.sprite.x + _local_11), (_local_6.sprite.y + _local_12), 1, 1);
                        param = new Object();
                        param.classCss = "center";
                        TooltipManager.show(_local_13, target2, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "subareaChange", 0, 0, 0, true, null, null, param, ("Text" + _local_8), false, StrataEnum.STRATA_TOOLTIP, 1);
                    };
                    LinkedCursorSpriteManager.getInstance().addItem("changeMapCursor", _local_6);
                    return (true);
                case (msg is MapComplementaryInformationsDataMessage):
                    if (!(StageShareManager.mouseOnStage))
                    {
                        return (false);
                    };
                    _local_15 = new Point(StageShareManager.stage.mouseX, StageShareManager.stage.mouseY);
                    if (Atouin.getInstance().options.frustum.containsPoint(_local_15))
                    {
                        objectsUnder = StageShareManager.stage.getObjectsUnderPoint(_local_15);
                        for each (o in objectsUnder)
                        {
                            if ((((o is GraphicContainer)) && (!(((o as GraphicContainer).customUnicName.indexOf("banner") == -1)))))
                            {
                                return (false);
                            };
                        };
                        for each (o in objectsUnder)
                        {
                            if ((o.parent is FrustumShape))
                            {
                                o.parent.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
                                break;
                            };
                        };
                    };
                    return (false);
                case (msg is EntityMouseOverMessage):
                    _local_16 = (msg as EntityMouseOverMessage);
                    this._mouseOverEntityId = _local_16.entity.id;
                    _local_17 = ("entity_" + _local_16.entity.id);
                    this.displayCursor(NO_CURSOR);
                    _local_18 = (_local_16.entity as IInteractive);
                    _local_19 = (_local_18 as AnimatedCharacter);
                    if (_local_19)
                    {
                        _local_19 = _local_19.getRootEntity();
                        _local_19.highLightCharacterAndFollower(true);
                        _local_18 = _local_19;
                        if ((((OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER)) && ((_local_19.getDirection() == DirectionsEnum.DOWN))))
                        {
                            _local_19.visibleAura = true;
                        };
                    };
                    _local_20 = (this.roleplayContextFrame.entitiesFrame.getEntityInfos(_local_18.id) as GameRolePlayActorInformations);
                    if ((_local_18 is TiphonSprite))
                    {
                        tooltipTarget = (_local_18 as TiphonSprite);
                        rider = ((_local_18 as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite);
                        isCreatureMode = ((Kernel.getWorker().getFrame(RoleplayEntitiesFrame)) && (RoleplayEntitiesFrame(Kernel.getWorker().getFrame(RoleplayEntitiesFrame)).isCreatureMode));
                        if (((rider) && (!(isCreatureMode))))
                        {
                            tooltipTarget = rider;
                        };
                        head = tooltipTarget.getSlot("Tete");
                        if (head)
                        {
                            r1 = head.getBounds(StageShareManager.stage);
                            r2 = new Rectangle2(r1.x, r1.y, r1.width, r1.height);
                            _local_21 = r2;
                        };
                    };
                    if (((!(_local_21)) || ((((_local_21.width == 0)) && ((_local_21.height == 0))))))
                    {
                        _local_21 = (_local_18 as IDisplayable).absoluteBounds;
                    };
                    _local_22 = null;
                    _local_24 = 0;
                    if (this.roleplayContextFrame.entitiesFrame.isFight(_local_18.id))
                    {
                        if (this.allowOnlyCharacterInteraction)
                        {
                            return (false);
                        };
                        fight = this.roleplayContextFrame.entitiesFrame.getFightTeam(_local_18.id);
                        _local_20 = new RoleplayTeamFightersTooltipInformation(fight);
                        _local_22 = "roleplayFight";
                        this.displayCursor(FIGHT_CURSOR, !(PlayedCharacterManager.getInstance().restrictions.cantAttackMonster));
                        if (((fight.hasOptions()) || (fight.hasGroupMember())))
                        {
                            _local_24 = 35;
                        };
                    }
                    else
                    {
                        switch (true)
                        {
                            case (_local_20 is GameRolePlayCharacterInformations):
                                if (_local_20.contextualId == PlayedCharacterManager.getInstance().id)
                                {
                                    _local_67 = 0;
                                }
                                else
                                {
                                    _local_77 = (_local_20.alignmentInfos.characterPower - _local_20.contextualId);
                                    _local_78 = PlayedCharacterManager.getInstance().infos.level;
                                    _local_67 = PlayedCharacterManager.getInstance().levelDiff(_local_77);
                                };
                                _local_20 = new CharacterTooltipInformation((_local_20 as GameRolePlayCharacterInformations), _local_67);
                                _local_23 = "CharacterCache";
                                break;
                            case (_local_20 is GameRolePlayMerchantInformations):
                                _local_23 = "MerchantCharacterCache";
                                break;
                            case (_local_20 is GameRolePlayMutantInformations):
                                if ((_local_20 as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                                {
                                    _local_20 = new CharacterTooltipInformation(_local_20, 0);
                                }
                                else
                                {
                                    _local_20 = new MutantTooltipInformation((_local_20 as GameRolePlayMutantInformations));
                                };
                                break;
                            case (_local_20 is GameRolePlayTaxCollectorInformations):
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return (false);
                                };
                                _local_68 = (_local_20 as GameRolePlayTaxCollectorInformations);
                                _local_69 = _local_68.identification.guildIdentity;
                                _local_66 = (((_local_68.identification is TaxCollectorStaticExtendedInformations)) ? ((_local_68.identification as TaxCollectorStaticExtendedInformations).allianceIdentity) : null);
                                _local_70 = GuildWrapper.create(_local_69.guildId, _local_69.guildName, _local_69.guildEmblem, 0, true);
                                _local_71 = ((_local_66) ? (AllianceWrapper.create(_local_66.allianceId, _local_66.allianceTag, _local_66.allianceName, _local_66.allianceEmblem)) : null);
                                _local_20 = new TaxCollectorTooltipInformation(TaxCollectorName.getTaxCollectorNameById((_local_20 as GameRolePlayTaxCollectorInformations).identification.lastNameId).name, TaxCollectorFirstname.getTaxCollectorFirstnameById((_local_20 as GameRolePlayTaxCollectorInformations).identification.firstNameId).firstname, _local_70, _local_71, (_local_20 as GameRolePlayTaxCollectorInformations).taxCollectorAttack);
                                break;
                            case (_local_20 is GameRolePlayNpcInformations):
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return (false);
                                };
                                _local_72 = (_local_20 as GameRolePlayNpcInformations);
                                _local_73 = Npc.getNpcById(_local_72.npcId);
                                _local_20 = new TextTooltipInfo(_local_73.name, (XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css"), "green", 0);
                                _local_20.bgCornerRadius = 10;
                                _local_23 = "NPCCacheName";
                                if (_local_73.actions.length == 0)
                                {
                                    break;
                                };
                                this.displayCursor(NPC_CURSOR);
                                break;
                            case (_local_20 is GameRolePlayGroupMonsterInformations):
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return (false);
                                };
                                this.displayCursor(FIGHT_CURSOR, !(PlayedCharacterManager.getInstance().restrictions.cantAttackMonster));
                                if (Kernel.getWorker().contains(MonstersInfoFrame))
                                {
                                    _local_17 = ("MonstersInfo_" + _local_20.contextualId);
                                    _local_23 = (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).getCacheName(_local_20.contextualId);
                                }
                                else
                                {
                                    _local_23 = "GroupMonsterCache";
                                };
                                break;
                            case (_local_20 is GameRolePlayPrismInformations):
                                _local_74 = (Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame);
                                _local_20 = new PrismTooltipInformation(_local_74.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id).alliance);
                                break;
                            case (_local_20 is GameRolePlayPortalInformations):
                                _local_20 = new PortalTooltipInformation((_local_20 as GameRolePlayPortalInformations).portal.areaId);
                                break;
                            case (_local_20 is GameContextPaddockItemInformations):
                                _local_23 = "PaddockItemCache";
                                break;
                            case (_local_20 is GameRolePlayTreasureHintInformations):
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return (false);
                                };
                                _local_75 = (_local_20 as GameRolePlayTreasureHintInformations);
                                _local_76 = Npc.getNpcById(_local_75.npcId);
                                _local_20 = new TextTooltipInfo(_local_76.name, (XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css"), "orange", 0);
                                _local_20.bgCornerRadius = 10;
                                _local_23 = "TrHintCacheName";
                                break;
                        };
                    };
                    if (!(_local_20))
                    {
                        _log.warn((("Rolling over a unknown entity (" + _local_16.entity.id) + ")."));
                        return (false);
                    };
                    if (this.roleplayContextFrame.entitiesFrame.hasIcon(_local_18.id))
                    {
                        _local_24 = 45;
                    };
                    if (((((_local_19) && (!(_local_19.rawAnimation)))) && (!(this._entityTooltipData[_local_19]))))
                    {
                        this._entityTooltipData[_local_19] = {
                            "data":_local_20,
                            "name":_local_17,
                            "tooltipMaker":_local_22,
                            "tooltipOffset":_local_24,
                            "cacheName":_local_23
                        };
                        _local_19.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityAnimRendered);
                        _local_19.addEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityAnimRendered);
                    }
                    else
                    {
                        TooltipManager.show(_local_20, _local_21, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, _local_17, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, _local_24, true, _local_22, null, null, _local_23, false, StrataEnum.STRATA_WORLD, this.sysApi.getCurrentZoom());
                    };
                    return (true);
                case (msg is MouseRightClickMessage):
                    _local_25 = (msg as MouseRightClickMessage);
                    _local_26 = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                    _local_27 = (_local_25.target as IInteractive);
                    if (_local_27)
                    {
                        rcf = this.roleplayContextFrame;
                        if (((!((_local_27 as AnimatedCharacter))) || (((_local_27 as AnimatedCharacter).followed == null))))
                        {
                            actorInfos = rcf.entitiesFrame.getEntityInfos(_local_27.id);
                        }
                        else
                        {
                            actorInfos = rcf.entitiesFrame.getEntityInfos((_local_27 as AnimatedCharacter).followed.id);
                        };
                        if ((actorInfos is GameRolePlayNamedActorInformations))
                        {
                            if (!((_local_27 is AnimatedCharacter)))
                            {
                                _log.error((("L'entity " + _local_27.id) + " est un GameRolePlayNamedActorInformations mais n'est pas un AnimatedCharacter"));
                                return (true);
                            };
                            _local_27 = (_local_27 as AnimatedCharacter).getRootEntity();
                            rightClickedinfos = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_local_27.id);
                            menu = MenusFactory.create(rightClickedinfos, "multiplayer", [_local_27]);
                            if (menu)
                            {
                                _local_26.createContextMenu(menu);
                            };
                            return (true);
                        };
                        if ((actorInfos is GameRolePlayGroupMonsterInformations))
                        {
                            menu = MenusFactory.create(actorInfos, "monsterGroup", [_local_27]);
                            if (menu)
                            {
                                _local_26.createContextMenu(menu);
                            };
                            return (true);
                        };
                    };
                    return (false);
                case (msg is EntityMouseOutMessage):
                    _local_28 = (msg as EntityMouseOutMessage);
                    this._mouseOverEntityId = 0;
                    this.displayCursor(NO_CURSOR);
                    TooltipManager.hide(("entity_" + _local_28.entity.id));
                    _local_19 = (_local_28.entity as AnimatedCharacter);
                    if (_local_19)
                    {
                        _local_19 = _local_19.getRootEntity();
                        _local_19.highLightCharacterAndFollower(false);
                        if (!(Kernel.getWorker().getFrame(MonstersInfoFrame)))
                        {
                            TooltipManager.hide(("MonstersInfo_" + _local_19.id));
                        };
                        if (OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER)
                        {
                            _local_19.visibleAura = false;
                        };
                    };
                    return (true);
                case (msg is EntityClickMessage):
                    _local_29 = (msg as EntityClickMessage);
                    _local_30 = (_local_29.entity as IInteractive);
                    if ((_local_30 is AnimatedCharacter))
                    {
                        _local_30 = (_local_30 as AnimatedCharacter).getRootEntity();
                    };
                    _local_31 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_local_30.id);
                    _local_32 = RoleplayManager.getInstance().displayContextualMenu(_local_31, _local_30);
                    if (this.roleplayContextFrame.entitiesFrame.isFight(_local_30.id))
                    {
                        fightId = this.roleplayContextFrame.entitiesFrame.getFightId(_local_30.id);
                        fightTeamLeader = this.roleplayContextFrame.entitiesFrame.getFightLeaderId(_local_30.id);
                        teamType = this.roleplayContextFrame.entitiesFrame.getFightTeamType(_local_30.id);
                        if (teamType == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR)
                        {
                            team = (this.roleplayContextFrame.entitiesFrame.getFightTeam(_local_30.id) as FightTeam);
                            for each (fighter in team.teamInfos.teamMembers)
                            {
                                if ((fighter is FightTeamMemberTaxCollectorInformations))
                                {
                                    guildId = (fighter as FightTeamMemberTaxCollectorInformations).guildId;
                                };
                            };
                            guild = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
                            if (((guild) && ((guildId == guild.guildId))))
                            {
                                KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial, 1, 2);
                                Kernel.getWorker().process(GuildFightJoinRequestAction.create(PlayedCharacterManager.getInstance().currentMap.mapId));
                                return (true);
                            };
                        };
                        gfjrmsg = new GameFightJoinRequestMessage();
                        gfjrmsg.initGameFightJoinRequestMessage(fightTeamLeader, fightId);
                        playerEntity3 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        if ((playerEntity3 as IMovable).isMoving)
                        {
                            this.roleplayMovementFrame.setFollowingMessage(gfjrmsg);
                            (playerEntity3 as IMovable).stop();
                        }
                        else
                        {
                            ConnectionsHandler.getConnection().send(gfjrmsg);
                        };
                    }
                    else
                    {
                        if (((!((_local_30.id == PlayedCharacterManager.getInstance().id))) && (!(_local_32))))
                        {
                            this.roleplayMovementFrame.setFollowingInteraction(null);
                            if ((((_local_31 is GameRolePlayActorInformations)) && ((_local_31 is GameRolePlayGroupMonsterInformations))))
                            {
                                this.roleplayMovementFrame.setFollowingMonsterFight(_local_30);
                            };
                            this.roleplayMovementFrame.askMoveTo(_local_30.position);
                        };
                    };
                    return (true);
                case (msg is InteractiveElementActivationMessage):
                    if (((this.allowOnlyCharacterInteraction) || (((!(AirScanner.isStreamingVersion())) && ((((OptionManager.getOptionManager("dofus")["enableForceWalk"] == true)) && (((ShortcutsFrame.ctrlKeyDown) || ((((SystemManager.getSingleton().os == OperatingSystem.MAC_OS)) && (ShortcutsFrame.altKeyDown)))))))))))
                    {
                        return (false);
                    };
                    _local_33 = (msg as InteractiveElementActivationMessage);
                    _local_34 = (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame);
                    if (!((_local_34) && (_local_34.usingInteractive)))
                    {
                        _local_92 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        if (((!(DataMapProvider.getInstance().farmCell(_local_92.position.x, _local_92.position.y))) && ((_local_33.interactiveElement.elementTypeId == 120))))
                        {
                            _local_94 = 0;
                            while (_local_94 < 8)
                            {
                                mp = _local_33.position.getNearestCellInDirection(_local_94);
                                if (((mp) && (DataMapProvider.getInstance().farmCell(mp.x, mp.y))))
                                {
                                    if (!(_local_93))
                                    {
                                        _local_93 = [];
                                    };
                                    _local_93.push(mp.cellId);
                                };
                                _local_94++;
                            };
                        };
                        _local_95 = _local_33.position.getNearestFreeCellInDirection(_local_33.position.advancedOrientationTo(_local_92.position), DataMapProvider.getInstance(), true, true, false, _local_93);
                        if (!(_local_95))
                        {
                            _local_95 = _local_33.position;
                        };
                        this.roleplayMovementFrame.setFollowingInteraction({
                            "ie":_local_33.interactiveElement,
                            "skillInstanceId":_local_33.skillInstanceId
                        });
                        this.roleplayMovementFrame.askMoveTo(_local_95);
                    };
                    return (true);
                case (msg is InteractiveElementMouseOverMessage):
                    if (((this.allowOnlyCharacterInteraction) || (((!(AirScanner.isStreamingVersion())) && ((((OptionManager.getOptionManager("dofus")["enableForceWalk"] == true)) && (((ShortcutsFrame.ctrlKeyDown) || ((((SystemManager.getSingleton().os == OperatingSystem.MAC_OS)) && (ShortcutsFrame.altKeyDown)))))))))))
                    {
                        return (false);
                    };
                    _local_35 = (msg as InteractiveElementMouseOverMessage);
                    _local_39 = _local_35.interactiveElement;
                    for each (_local_40 in _local_39.enabledSkills)
                    {
                        if (_local_40.skillId == 175)
                        {
                            _local_36 = this.roleplayContextFrame.currentPaddock;
                            break;
                        };
                    };
                    _local_41 = Interactive.getInteractiveById(_local_39.elementTypeId);
                    _local_42 = _local_35.interactiveElement.elementId;
                    _local_43 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    _local_44 = _local_43.housesInformations[_local_42];
                    _local_45 = _local_35.sprite.getRect(StageShareManager.stage);
                    if (_local_44)
                    {
                        _local_36 = _local_44;
                    }
                    else
                    {
                        if ((((_local_36 == null)) && (_local_41)))
                        {
                            elem = new Object();
                            elem.interactive = _local_41.name;
                            enabledSkills = "";
                            for each (_local_40 in _local_39.enabledSkills)
                            {
                                enabledSkills = (enabledSkills + (Skill.getSkillById(_local_40.skillId).name + "\n"));
                            };
                            elem.enabledSkills = enabledSkills;
                            disabledSkills = "";
                            for each (_local_40 in _local_39.disabledSkills)
                            {
                                disabledSkills = (disabledSkills + (Skill.getSkillById(_local_40.skillId).name + "\n"));
                            };
                            elem.disabledSkills = disabledSkills;
                            elem.isCollectable = (_local_41.actionId == COLLECTABLE_INTERACTIVE_ACTION_ID);
                            if (elem.isCollectable)
                            {
                                showBonus = true;
                                iewab = (_local_39 as InteractiveElementWithAgeBonus);
                                if (_local_39.enabledSkills.length > 0)
                                {
                                    collectSkill = Skill.getSkillById(_local_39.enabledSkills[0].skillId);
                                    if (collectSkill.parentJobId == 1)
                                    {
                                        showBonus = false;
                                    };
                                }
                                else
                                {
                                    if (!(iewab))
                                    {
                                        showBonus = false;
                                    };
                                };
                                if (showBonus)
                                {
                                    elem.collectSkill = collectSkill;
                                    elem.ageBonus = ((iewab) ? iewab.ageBonus : 0);
                                };
                            };
                            _local_36 = elem;
                            _local_37 = "interactiveElement";
                            _local_38 = "InteractiveElementCache";
                        };
                    };
                    if (_local_36)
                    {
                        TooltipManager.show(_local_36, new Rectangle(_local_45.right, int(((_local_45.y + _local_45.height) - AtouinConstants.CELL_HEIGHT)), 0, 0), UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, TooltipManager.TOOLTIP_STANDAR_NAME, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOP, 0, true, _local_37, null, null, _local_38);
                    };
                    return (true);
                case (msg is InteractiveElementMouseOutMessage):
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return (false);
                    };
                    _local_46 = (msg as InteractiveElementMouseOutMessage);
                    TooltipManager.hide();
                    return (true);
                case (msg is ShowAllNamesAction):
                    if (Kernel.getWorker().contains(InfoEntitiesFrame))
                    {
                        Kernel.getWorker().removeFrame(this._infoEntitiesFrame);
                        KernelEventsManager.getInstance().processCallback(HookList.ShowPlayersNames, false);
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(this._infoEntitiesFrame);
                        KernelEventsManager.getInstance().processCallback(HookList.ShowPlayersNames, true);
                    };
                    return (true);
                case (msg is ShowMonstersInfoAction):
                    _local_47 = (msg as ShowMonstersInfoAction);
                    _monstersInfoFrame.triggeredByShortcut = _local_47.fromShortcut;
                    if (Kernel.getWorker().contains(MonstersInfoFrame))
                    {
                        Kernel.getWorker().removeFrame(_monstersInfoFrame);
                    }
                    else
                    {
                        if (((StageShareManager.isActive) && (!(((!(_monstersInfoFrame.triggeredByShortcut)) && (!(this._mouseDown)))))))
                        {
                            Kernel.getWorker().addFrame(_monstersInfoFrame);
                        };
                    };
                    return (true);
                case (msg is MouseDownMessage):
                    this._mouseDown = true;
                    break;
                case (msg is MouseUpMessage):
                    this._mouseDown = false;
                    _local_48 = (msg as MouseUpMessage);
                    _local_49 = (Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame);
                    if ((((_local_49.heldShortcuts.indexOf("showMonstersInfo") == -1)) && (Kernel.getWorker().contains(MonstersInfoFrame))))
                    {
                        Kernel.getWorker().removeFrame(_monstersInfoFrame);
                    };
                    break;
            };
            return (false);
        }

        public function pulled():Boolean
        {
            StageShareManager.stage.removeEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            Mouse.show();
            LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
            LinkedCursorSpriteManager.getInstance().removeItem("interactiveCursor");
            FrustumManager.getInstance().setBorderInteraction(false);
            return (true);
        }

        private function onEntityAnimRendered(pEvent:TiphonEvent):void
        {
            var ac:AnimatedCharacter = (pEvent.currentTarget as AnimatedCharacter);
            ac.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityAnimRendered);
            var tooltipData:Object = this._entityTooltipData[ac];
            TooltipManager.show(tooltipData.data, ac.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, tooltipData.name, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, tooltipData.tooltipOffset, true, tooltipData.tooltipMaker, null, null, tooltipData.cacheName, false, StrataEnum.STRATA_WORLD, this.sysApi.getCurrentZoom());
            delete this._entityTooltipData[ac];
        }

        private function displayCursor(type:int, pEnable:Boolean=true):void
        {
            if (type == -1)
            {
                Mouse.show();
                LinkedCursorSpriteManager.getInstance().removeItem("interactiveCursor");
                return;
            };
            if (PlayedCharacterManager.getInstance().state != PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
            {
                return;
            };
            var lcd:LinkedCursorData = new LinkedCursorData();
            lcd.sprite = RoleplayInteractivesFrame.getCursor(type, pEnable);
            lcd.offset = INTERACTIVE_CURSOR_OFFSET;
            Mouse.hide();
            LinkedCursorSpriteManager.getInstance().addItem("interactiveCursor", lcd);
        }

        private function onWisperMessage(playerName:String):void
        {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ChatFocus, playerName);
        }

        private function onMerchantPlayerBuyClick(vendorId:int, vendorCellId:uint):void
        {
            var eohvrmsg:ExchangeOnHumanVendorRequestMessage = new ExchangeOnHumanVendorRequestMessage();
            eohvrmsg.initExchangeOnHumanVendorRequestMessage(vendorId, vendorCellId);
            ConnectionsHandler.getConnection().send(eohvrmsg);
        }

        private function onInviteMenuClicked(playerName:String):void
        {
            var invitemsg:PartyInvitationRequestMessage = new PartyInvitationRequestMessage();
            invitemsg.initPartyInvitationRequestMessage(playerName);
            ConnectionsHandler.getConnection().send(invitemsg);
        }

        private function onMerchantHouseKickOff(cellId:uint):void
        {
            var kickRequest:HouseKickIndoorMerchantRequestMessage = new HouseKickIndoorMerchantRequestMessage();
            kickRequest.initHouseKickIndoorMerchantRequestMessage(cellId);
            ConnectionsHandler.getConnection().send(kickRequest);
        }

        private function onWindowDeactivate(pEvent:Event):void
        {
            if (Kernel.getWorker().contains(MonstersInfoFrame))
            {
                Kernel.getWorker().removeFrame(_monstersInfoFrame);
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.frames


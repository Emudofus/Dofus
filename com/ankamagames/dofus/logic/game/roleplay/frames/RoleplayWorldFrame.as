package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.DataStoreType;
    import flash.utils.Timer;
    import flash.geom.Point;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.types.enums.LanguageEnum;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import flash.events.TimerEvent;
    import com.ankamagames.atouin.managers.FrustumManager;
    import com.ankamagames.berilia.frames.ShortcutsFrame;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.Event;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
    import com.ankamagames.atouin.types.GraphicCell;
    import com.ankamagames.berilia.types.data.LinkedCursorData;
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
    import com.ankamagames.jerakine.types.enums.DirectionsEnum;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.atouin.Atouin;
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
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
    import com.ankamagames.jerakine.messages.Message;
    import flash.ui.Mouse;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.enum.WebBrowserEnum;
    import flash.external.ExternalInterface;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOnHumanVendorRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickIndoorMerchantRequestMessage;

    public class RoleplayWorldFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayWorldFrame));
        private static var _streamingFeedbackDelay:uint = 900000;
        private static var _dataStoreType:DataStoreType;
        private static var _streamingFeebackTimer:Timer;
        private static var _feedbackPopupOnNextPush:Boolean = false;
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
            if (((AirScanner.isStreamingVersion()) && ((XmlConfig.getInstance().getEntry("config.lang.current") == LanguageEnum.LANG_FR))))
            {
                if (!(_dataStoreType))
                {
                    _dataStoreType = new DataStoreType("betaStreaming", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
                };
                if (((_streamingFeebackTimer) && (_feedbackPopupOnNextPush)))
                {
                    _streamingFeebackTimer.reset();
                    _streamingFeebackTimer.delay = 30000;
                    _streamingFeebackTimer.start();
                }
                else
                {
                    if (((!(_streamingFeebackTimer)) && (!(StoreDataManager.getInstance().getData(_dataStoreType, "hasClickedFeedbackLink")))))
                    {
                        if (StoreDataManager.getInstance().getData(_dataStoreType, "hasRefusedToOpenFeedbackLink"))
                        {
                            _streamingFeedbackDelay = 3600000;
                        };
                        _streamingFeebackTimer = new Timer(_streamingFeedbackDelay, 1);
                        _streamingFeebackTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.openFeedbackPopup);
                        _streamingFeebackTimer.start();
                    };
                };
            };
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
            if (AirScanner.hasAir())
            {
                StageShareManager.stage.nativeWindow.addEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            };
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
            var _local_5:LinkedCursorData;
            var _local_6:int;
            var _local_7:SubArea;
            var _local_8:Boolean;
            var _local_9:int;
            var _local_10:int;
            var _local_11:String;
            var _local_12:Point;
            var _local_13:EntityMouseOverMessage;
            var _local_14:String;
            var _local_15:IInteractive;
            var _local_16:AnimatedCharacter;
            var _local_17:*;
            var _local_18:IRectangle;
            var _local_19:String;
            var _local_20:String;
            var _local_21:Number;
            var _local_22:MouseRightClickMessage;
            var _local_23:Object;
            var _local_24:IInteractive;
            var _local_25:EntityMouseOutMessage;
            var _local_26:EntityClickMessage;
            var _local_27:IInteractive;
            var _local_28:GameContextActorInformations;
            var _local_29:Boolean;
            var _local_30:InteractiveElementActivationMessage;
            var _local_31:RoleplayInteractivesFrame;
            var _local_32:InteractiveElementMouseOverMessage;
            var _local_33:Object;
            var _local_34:String;
            var _local_35:String;
            var _local_36:InteractiveElement;
            var _local_37:InteractiveElementSkill;
            var _local_38:Interactive;
            var _local_39:uint;
            var _local_40:RoleplayEntitiesFrame;
            var _local_41:HouseWrapper;
            var _local_42:Rectangle;
            var _local_43:InteractiveElementMouseOutMessage;
            var _local_44:ShowMonstersInfoAction;
            var _local_45:MouseUpMessage;
            var _local_46:ShortcutsFrame;
            var climsg:CellClickMessage;
            var amcmsg:AdjacentMapClickMessage;
            var playedEntity:IEntity;
            var text:String;
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
            var _local_63:AllianceInformations;
            var _local_64:int;
            var _local_65:GameRolePlayTaxCollectorInformations;
            var _local_66:GuildInformations;
            var _local_67:GuildWrapper;
            var _local_68:AllianceWrapper;
            var _local_69:GameRolePlayNpcInformations;
            var _local_70:Npc;
            var _local_71:AllianceFrame;
            var _local_72:uint;
            var _local_73:uint;
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
            var _local_87:IEntity;
            var _local_88:Array;
            var _local_89:int;
            var _local_90:MapPoint;
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
                    _local_5 = new LinkedCursorData();
                    if (_local_2.direction == DirectionsEnum.RIGHT)
                    {
                        _local_6 = PlayedCharacterManager.getInstance().currentMap.rightNeighbourId;
                    }
                    else
                    {
                        if (_local_2.direction == DirectionsEnum.DOWN)
                        {
                            _local_6 = PlayedCharacterManager.getInstance().currentMap.bottomNeighbourId;
                        }
                        else
                        {
                            if (_local_2.direction == DirectionsEnum.LEFT)
                            {
                                _local_6 = PlayedCharacterManager.getInstance().currentMap.leftNeighbourId;
                            }
                            else
                            {
                                if (_local_2.direction == DirectionsEnum.UP)
                                {
                                    _local_6 = PlayedCharacterManager.getInstance().currentMap.topNeighbourId;
                                };
                            };
                        };
                    };
                    _local_7 = SubArea.getSubAreaByMapId(_local_6);
                    _local_8 = false;
                    _local_9 = 0;
                    _local_10 = 0;
                    if (((_local_7) && (!((_local_7.id == PlayedCharacterManager.getInstance().currentSubArea.id)))))
                    {
                        _local_8 = true;
                        text = I18n.getUiText("ui.common.toward", [_local_7.name]);
                        text2 = ((I18n.getUiText("ui.common.level") + " ") + _local_7.level);
                        this._mouseLabel.text = (((text.length > text2.length)) ? text : text2);
                        _local_11 = ((text + "\n") + text2);
                    };
                    switch (_local_2.direction)
                    {
                        case DirectionsEnum.LEFT:
                            _local_5.sprite = ((_local_8) ? this._mouseLeftBlue : this._mouseLeft);
                            _local_5.lockX = true;
                            _local_5.sprite.x = (_local_2.zone.x + (_local_2.zone.width / 2));
                            _local_5.offset = new Point(0, 0);
                            _local_5.lockY = true;
                            _local_5.sprite.y = (_local_4.y + (AtouinConstants.CELL_HEIGHT / 2));
                            if (_local_8)
                            {
                                _local_9 = 0;
                                _local_10 = (_local_5.sprite.height / 2);
                            };
                            break;
                        case DirectionsEnum.UP:
                            _local_5.sprite = ((_local_8) ? this._mouseTopBlue : this._mouseTop);
                            _local_5.lockY = true;
                            _local_5.sprite.y = (_local_2.zone.y + (_local_2.zone.height / 2));
                            _local_5.offset = new Point(0, 0);
                            _local_5.lockX = true;
                            _local_5.sprite.x = (_local_4.x + (AtouinConstants.CELL_WIDTH / 2));
                            if (_local_8)
                            {
                                _local_9 = (-(this._mouseLabel.textWidth) / 2);
                                _local_10 = (_local_5.sprite.height + 5);
                            };
                            break;
                        case DirectionsEnum.DOWN:
                            _local_5.sprite = ((_local_8) ? this._mouseBottomBlue : this._mouseBottom);
                            _local_5.lockY = true;
                            _local_5.sprite.y = _local_2.zone.getBounds(_local_2.zone).top;
                            _local_5.offset = new Point(0, 0);
                            _local_5.lockX = true;
                            _local_5.sprite.x = (_local_4.x + (AtouinConstants.CELL_WIDTH / 2));
                            if (_local_8)
                            {
                                _local_9 = (-(this._mouseLabel.textWidth) / 2);
                                _local_10 = ((-(_local_5.sprite.height) - this._mouseLabel.textHeight) - 34);
                            };
                            break;
                        case DirectionsEnum.RIGHT:
                            _local_5.sprite = ((_local_8) ? this._mouseRightBlue : this._mouseRight);
                            _local_5.lockX = true;
                            _local_5.sprite.x = (_local_2.zone.getBounds(_local_2.zone).left + (_local_2.zone.width / 2));
                            _local_5.offset = new Point(0, 0);
                            _local_5.lockY = true;
                            _local_5.sprite.y = (_local_4.y + (AtouinConstants.CELL_HEIGHT / 2));
                            if (_local_8)
                            {
                                _local_9 = -(this._mouseLabel.textWidth);
                                _local_10 = (_local_5.sprite.height / 2);
                            };
                            break;
                    };
                    if (_local_8)
                    {
                        target2 = new Rectangle((_local_5.sprite.x + _local_9), (_local_5.sprite.y + _local_10), 1, 1);
                        param = new Object();
                        param.classCss = "center";
                        TooltipManager.show(_local_11, target2, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "subareaChange", 0, 0, 0, true, null, null, param, ("Text" + _local_6), false, StrataEnum.STRATA_TOOLTIP, 1);
                    };
                    LinkedCursorSpriteManager.getInstance().addItem("changeMapCursor", _local_5);
                    return (true);
                case (msg is MapComplementaryInformationsDataMessage):
                    _local_12 = new Point(StageShareManager.stage.mouseX, StageShareManager.stage.mouseY);
                    if (Atouin.getInstance().options.frustum.containsPoint(_local_12))
                    {
                        objectsUnder = StageShareManager.stage.getObjectsUnderPoint(_local_12);
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
                    _local_13 = (msg as EntityMouseOverMessage);
                    this._mouseOverEntityId = _local_13.entity.id;
                    _local_14 = ("entity_" + _local_13.entity.id);
                    this.displayCursor(NO_CURSOR);
                    _local_15 = (_local_13.entity as IInteractive);
                    _local_16 = (_local_15 as AnimatedCharacter);
                    if (_local_16)
                    {
                        _local_16 = _local_16.getRootEntity();
                        _local_16.highLightCharacterAndFollower(true);
                        _local_15 = _local_16;
                        if ((((OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER)) && ((_local_16.getDirection() == DirectionsEnum.DOWN))))
                        {
                            _local_16.visibleAura = true;
                        };
                    };
                    _local_17 = (this.roleplayContextFrame.entitiesFrame.getEntityInfos(_local_15.id) as GameRolePlayActorInformations);
                    if ((_local_15 is TiphonSprite))
                    {
                        tooltipTarget = (_local_15 as TiphonSprite);
                        rider = ((_local_15 as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite);
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
                            _local_18 = r2;
                        };
                    };
                    if (((!(_local_18)) || ((((_local_18.width == 0)) && ((_local_18.height == 0))))))
                    {
                        _local_18 = (_local_15 as IDisplayable).absoluteBounds;
                    };
                    _local_19 = null;
                    _local_21 = 0;
                    if (this.roleplayContextFrame.entitiesFrame.isFight(_local_15.id))
                    {
                        if (this.allowOnlyCharacterInteraction)
                        {
                            return (false);
                        };
                        fight = this.roleplayContextFrame.entitiesFrame.getFightTeam(_local_15.id);
                        _local_17 = new RoleplayTeamFightersTooltipInformation(fight);
                        _local_19 = "roleplayFight";
                        this.displayCursor(FIGHT_CURSOR, !(PlayedCharacterManager.getInstance().restrictions.cantAttackMonster));
                        if (((fight.hasOptions()) || (fight.hasGroupMember())))
                        {
                            _local_21 = 35;
                        };
                    }
                    else
                    {
                        switch (true)
                        {
                            case (_local_17 is GameRolePlayCharacterInformations):
                                if (_local_17.contextualId == PlayedCharacterManager.getInstance().id)
                                {
                                    _local_64 = 0;
                                }
                                else
                                {
                                    _local_72 = (_local_17.alignmentInfos.characterPower - _local_17.contextualId);
                                    _local_73 = PlayedCharacterManager.getInstance().infos.level;
                                    _local_64 = PlayedCharacterManager.getInstance().levelDiff(_local_72);
                                };
                                _local_17 = new CharacterTooltipInformation((_local_17 as GameRolePlayCharacterInformations), _local_64);
                                _local_20 = "CharacterCache";
                                break;
                            case (_local_17 is GameRolePlayMerchantInformations):
                                _local_20 = "MerchantCharacterCache";
                                break;
                            case (_local_17 is GameRolePlayMutantInformations):
                                if ((_local_17 as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                                {
                                    _local_17 = new CharacterTooltipInformation(_local_17, 0);
                                }
                                else
                                {
                                    _local_17 = new MutantTooltipInformation((_local_17 as GameRolePlayMutantInformations));
                                };
                                break;
                            case (_local_17 is GameRolePlayTaxCollectorInformations):
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return (false);
                                };
                                _local_65 = (_local_17 as GameRolePlayTaxCollectorInformations);
                                _local_66 = _local_65.identification.guildIdentity;
                                _local_63 = (((_local_65.identification is TaxCollectorStaticExtendedInformations)) ? ((_local_65.identification as TaxCollectorStaticExtendedInformations).allianceIdentity) : null);
                                _local_67 = GuildWrapper.create(_local_66.guildId, _local_66.guildName, _local_66.guildEmblem, 0, true);
                                _local_68 = ((_local_63) ? (AllianceWrapper.create(_local_63.allianceId, _local_63.allianceTag, _local_63.allianceName, _local_63.allianceEmblem)) : null);
                                _local_17 = new TaxCollectorTooltipInformation(TaxCollectorName.getTaxCollectorNameById((_local_17 as GameRolePlayTaxCollectorInformations).identification.lastNameId).name, TaxCollectorFirstname.getTaxCollectorFirstnameById((_local_17 as GameRolePlayTaxCollectorInformations).identification.firstNameId).firstname, _local_67, _local_68, (_local_17 as GameRolePlayTaxCollectorInformations).taxCollectorAttack);
                                break;
                            case (_local_17 is GameRolePlayNpcInformations):
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return (false);
                                };
                                _local_69 = (_local_17 as GameRolePlayNpcInformations);
                                _local_70 = Npc.getNpcById(_local_69.npcId);
                                _local_17 = new TextTooltipInfo(_local_70.name, (XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css"), "green", 0);
                                _local_17.bgCornerRadius = 10;
                                _local_20 = "NPCCacheName";
                                if (_local_70.actions.length == 0)
                                {
                                    break;
                                };
                                this.displayCursor(NPC_CURSOR);
                                break;
                            case (_local_17 is GameRolePlayGroupMonsterInformations):
                                if (this.allowOnlyCharacterInteraction)
                                {
                                    return (false);
                                };
                                this.displayCursor(FIGHT_CURSOR, !(PlayedCharacterManager.getInstance().restrictions.cantAttackMonster));
                                if (Kernel.getWorker().contains(MonstersInfoFrame))
                                {
                                    _local_14 = ("MonstersInfo_" + _local_17.contextualId);
                                    _local_20 = (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).getCacheName(_local_17.contextualId);
                                }
                                else
                                {
                                    _local_20 = "GroupMonsterCache";
                                };
                                break;
                            case (_local_17 is GameRolePlayPrismInformations):
                                _local_71 = (Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame);
                                _local_17 = new PrismTooltipInformation(_local_71.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id).alliance);
                                break;
                            case (_local_17 is GameRolePlayPortalInformations):
                                _local_17 = new PortalTooltipInformation((_local_17 as GameRolePlayPortalInformations).portal.areaId);
                                break;
                            case (_local_17 is GameContextPaddockItemInformations):
                                _local_20 = "PaddockItemCache";
                                break;
                        };
                    };
                    if (!(_local_17))
                    {
                        _log.warn((("Rolling over a unknown entity (" + _local_13.entity.id) + ")."));
                        return (false);
                    };
                    if (this.roleplayContextFrame.entitiesFrame.hasIcon(_local_15.id))
                    {
                        _local_21 = 45;
                    };
                    if (((((_local_16) && (!(_local_16.rawAnimation)))) && (!(this._entityTooltipData[_local_16]))))
                    {
                        this._entityTooltipData[_local_16] = {
                            "data":_local_17,
                            "name":_local_14,
                            "tooltipMaker":_local_19,
                            "tooltipOffset":_local_21,
                            "cacheName":_local_20
                        };
                        _local_16.removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityAnimRendered);
                        _local_16.addEventListener(TiphonEvent.RENDER_SUCCEED, this.onEntityAnimRendered);
                    }
                    else
                    {
                        TooltipManager.show(_local_17, _local_18, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, _local_14, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, _local_21, true, _local_19, null, null, _local_20, false, StrataEnum.STRATA_WORLD, this.sysApi.getCurrentZoom());
                    };
                    return (true);
                case (msg is MouseRightClickMessage):
                    _local_22 = (msg as MouseRightClickMessage);
                    _local_23 = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                    _local_24 = (_local_22.target as IInteractive);
                    if (_local_24)
                    {
                        rcf = this.roleplayContextFrame;
                        if (((!((_local_24 as AnimatedCharacter))) || (((_local_24 as AnimatedCharacter).followed == null))))
                        {
                            actorInfos = rcf.entitiesFrame.getEntityInfos(_local_24.id);
                        }
                        else
                        {
                            actorInfos = rcf.entitiesFrame.getEntityInfos((_local_24 as AnimatedCharacter).followed.id);
                        };
                        if ((actorInfos is GameRolePlayNamedActorInformations))
                        {
                            if (!((_local_24 is AnimatedCharacter)))
                            {
                                _log.error((("L'entity " + _local_24.id) + " est un GameRolePlayNamedActorInformations mais n'est pas un AnimatedCharacter"));
                                return (true);
                            };
                            _local_24 = (_local_24 as AnimatedCharacter).getRootEntity();
                            rightClickedinfos = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_local_24.id);
                            menu = MenusFactory.create(rightClickedinfos, "multiplayer", [_local_24]);
                            if (menu)
                            {
                                _local_23.createContextMenu(menu);
                            };
                            return (true);
                        };
                        if ((actorInfos is GameRolePlayGroupMonsterInformations))
                        {
                            menu = MenusFactory.create(actorInfos, "monsterGroup", [_local_24]);
                            if (menu)
                            {
                                _local_23.createContextMenu(menu);
                            };
                            return (true);
                        };
                    };
                    return (false);
                case (msg is EntityMouseOutMessage):
                    _local_25 = (msg as EntityMouseOutMessage);
                    this._mouseOverEntityId = 0;
                    this.displayCursor(NO_CURSOR);
                    TooltipManager.hide(("entity_" + _local_25.entity.id));
                    _local_16 = (_local_25.entity as AnimatedCharacter);
                    if (_local_16)
                    {
                        _local_16 = _local_16.getRootEntity();
                        _local_16.highLightCharacterAndFollower(false);
                        if (!(Kernel.getWorker().getFrame(MonstersInfoFrame)))
                        {
                            TooltipManager.hide(("MonstersInfo_" + _local_16.id));
                        };
                        if (OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER)
                        {
                            _local_16.visibleAura = false;
                        };
                    };
                    return (true);
                case (msg is EntityClickMessage):
                    _local_26 = (msg as EntityClickMessage);
                    _local_27 = (_local_26.entity as IInteractive);
                    if ((_local_27 is AnimatedCharacter))
                    {
                        _local_27 = (_local_27 as AnimatedCharacter).getRootEntity();
                    };
                    _local_28 = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_local_27.id);
                    _local_29 = RoleplayManager.getInstance().displayContextualMenu(_local_28, _local_27);
                    if (this.roleplayContextFrame.entitiesFrame.isFight(_local_27.id))
                    {
                        fightId = this.roleplayContextFrame.entitiesFrame.getFightId(_local_27.id);
                        fightTeamLeader = this.roleplayContextFrame.entitiesFrame.getFightLeaderId(_local_27.id);
                        teamType = this.roleplayContextFrame.entitiesFrame.getFightTeamType(_local_27.id);
                        if (teamType == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR)
                        {
                            team = (this.roleplayContextFrame.entitiesFrame.getFightTeam(_local_27.id) as FightTeam);
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
                        if (((!((_local_27.id == PlayedCharacterManager.getInstance().id))) && (!(_local_29))))
                        {
                            this.roleplayMovementFrame.setFollowingInteraction(null);
                            this.roleplayMovementFrame.askMoveTo(_local_27.position);
                        };
                    };
                    return (true);
                case (msg is InteractiveElementActivationMessage):
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return (false);
                    };
                    _local_30 = (msg as InteractiveElementActivationMessage);
                    _local_31 = (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame);
                    if (!((_local_31) && (_local_31.usingInteractive)))
                    {
                        _local_87 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                        if (((!(DataMapProvider.getInstance().farmCell(_local_87.position.x, _local_87.position.y))) && ((_local_30.interactiveElement.elementTypeId == 120))))
                        {
                            _local_89 = 0;
                            while (_local_89 < 8)
                            {
                                mp = _local_30.position.getNearestCellInDirection(_local_89);
                                if (((mp) && (DataMapProvider.getInstance().farmCell(mp.x, mp.y))))
                                {
                                    if (!(_local_88))
                                    {
                                        _local_88 = [];
                                    };
                                    _local_88.push(mp.cellId);
                                };
                                _local_89++;
                            };
                        };
                        _local_90 = _local_30.position.getNearestFreeCellInDirection(_local_30.position.advancedOrientationTo(_local_87.position), DataMapProvider.getInstance(), true, true, _local_88);
                        if (!(_local_90))
                        {
                            _local_90 = _local_30.position;
                        };
                        this.roleplayMovementFrame.setFollowingInteraction({
                            "ie":_local_30.interactiveElement,
                            "skillInstanceId":_local_30.skillInstanceId
                        });
                        this.roleplayMovementFrame.askMoveTo(_local_90);
                    };
                    return (true);
                case (msg is InteractiveElementMouseOverMessage):
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return (false);
                    };
                    _local_32 = (msg as InteractiveElementMouseOverMessage);
                    _local_36 = _local_32.interactiveElement;
                    for each (_local_37 in _local_36.enabledSkills)
                    {
                        if (_local_37.skillId == 175)
                        {
                            _local_33 = this.roleplayContextFrame.currentPaddock;
                            break;
                        };
                    };
                    _local_38 = Interactive.getInteractiveById(_local_36.elementTypeId);
                    _local_39 = _local_32.interactiveElement.elementId;
                    _local_40 = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    _local_41 = _local_40.housesInformations[_local_39];
                    _local_42 = _local_32.sprite.getRect(StageShareManager.stage);
                    if (_local_41)
                    {
                        _local_33 = _local_41;
                    }
                    else
                    {
                        if ((((_local_33 == null)) && (_local_38)))
                        {
                            elem = new Object();
                            elem.interactive = _local_38.name;
                            enabledSkills = "";
                            for each (_local_37 in _local_36.enabledSkills)
                            {
                                enabledSkills = (enabledSkills + (Skill.getSkillById(_local_37.skillId).name + "\n"));
                            };
                            elem.enabledSkills = enabledSkills;
                            disabledSkills = "";
                            for each (_local_37 in _local_36.disabledSkills)
                            {
                                disabledSkills = (disabledSkills + (Skill.getSkillById(_local_37.skillId).name + "\n"));
                            };
                            elem.disabledSkills = disabledSkills;
                            elem.isCollectable = (_local_38.actionId == COLLECTABLE_INTERACTIVE_ACTION_ID);
                            if (elem.isCollectable)
                            {
                                showBonus = true;
                                iewab = (_local_36 as InteractiveElementWithAgeBonus);
                                if (_local_36.enabledSkills.length > 0)
                                {
                                    collectSkill = Skill.getSkillById(_local_36.enabledSkills[0].skillId);
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
                            _local_33 = elem;
                            _local_34 = "interactiveElement";
                            _local_35 = "InteractiveElementCache";
                        };
                    };
                    if (_local_33)
                    {
                        TooltipManager.show(_local_33, new Rectangle(_local_42.right, int(((_local_42.y + _local_42.height) - AtouinConstants.CELL_HEIGHT)), 0, 0), UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, TooltipManager.TOOLTIP_STANDAR_NAME, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOP, 0, true, _local_34, null, null, _local_35);
                    };
                    return (true);
                case (msg is InteractiveElementMouseOutMessage):
                    if (this.allowOnlyCharacterInteraction)
                    {
                        return (false);
                    };
                    _local_43 = (msg as InteractiveElementMouseOutMessage);
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
                    break;
                case (msg is ShowMonstersInfoAction):
                    _local_44 = (msg as ShowMonstersInfoAction);
                    _monstersInfoFrame.triggeredByShortcut = _local_44.fromShortcut;
                    if (Kernel.getWorker().contains(MonstersInfoFrame))
                    {
                        Kernel.getWorker().removeFrame(_monstersInfoFrame);
                    }
                    else
                    {
                        if (((((AirScanner.hasAir()) && (StageShareManager.stage.nativeWindow.active))) && (!(((!(_monstersInfoFrame.triggeredByShortcut)) && (!(this._mouseDown)))))))
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
                    _local_45 = (msg as MouseUpMessage);
                    _local_46 = (Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame);
                    if ((((_local_46.heldShortcuts.indexOf("showMonstersInfo") == -1)) && (Kernel.getWorker().contains(MonstersInfoFrame))))
                    {
                        Kernel.getWorker().removeFrame(_monstersInfoFrame);
                    };
                    break;
            };
            return (false);
        }

        public function pulled():Boolean
        {
            if (AirScanner.hasAir())
            {
                StageShareManager.stage.nativeWindow.removeEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            };
            Mouse.show();
            LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
            LinkedCursorSpriteManager.getInstance().removeItem("interactiveCursor");
            FrustumManager.getInstance().setBorderInteraction(false);
            return (true);
        }

        private function openFeedbackPopup(e:TimerEvent=null):void
        {
            var commonMod:Object;
            if (Kernel.getWorker().contains(RoleplayWorldFrame))
            {
                _feedbackPopupOnNextPush = false;
                _streamingFeebackTimer.stop();
                commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                commonMod.openPopup(I18n.getUiText("ui.popup.information"), "Un formulaire est disponible afin de receuillir vos retours sur la version Streaming.\nSouhaitez-vous le remplir maintenant ?", [I18n.getUiText("ui.common.yes"), I18n.getUiText("ui.common.no")], [this.openStreamingFeebackForm, this.dontOpenStreamingFeedbackForm], null, this.dontOpenStreamingFeedbackForm, null, false, true);
            }
            else
            {
                _feedbackPopupOnNextPush = true;
            };
        }

        private function openStreamingFeebackForm():void
        {
            _streamingFeebackTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.openFeedbackPopup);
            _streamingFeebackTimer = null;
            StoreDataManager.getInstance().setData(_dataStoreType, "hasClickedFeedbackLink", true);
            if (SystemManager.getSingleton().browser == WebBrowserEnum.CHROME)
            {
                ExternalInterface.call("window.open", "https://fr.surveymonkey.com/s/DofusWeb", "_blank");
            }
            else
            {
                navigateToURL(new URLRequest("https://fr.surveymonkey.com/s/DofusWeb"), "_blank");
            };
        }

        private function dontOpenStreamingFeedbackForm():void
        {
            _streamingFeedbackDelay = (_streamingFeedbackDelay + 3600000);
            _streamingFeebackTimer.delay = _streamingFeedbackDelay;
            _streamingFeebackTimer.reset();
            _streamingFeebackTimer.start();
            StoreDataManager.getInstance().setData(_dataStoreType, "hasRefusedToOpenFeedbackLink", true);
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


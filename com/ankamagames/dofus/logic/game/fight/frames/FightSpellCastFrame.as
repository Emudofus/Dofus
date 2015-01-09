package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.atouin.types.Selection;
    import flash.utils.Timer;
    import com.ankamagames.berilia.types.data.LinkedCursorData;
    import com.ankamagames.dofus.logic.game.fight.types.FightTeleportationPreview;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import flash.geom.Point;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.types.enums.Priority;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.atouin.messages.CellOverMessage;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
    import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
    import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
    import com.ankamagames.atouin.messages.CellClickMessage;
    import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
    import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityClickAction;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
    import com.ankamagames.atouin.messages.CellOutMessage;
    import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
    import com.ankamagames.dofus.logic.game.fight.actions.BannerEmptySlotClickAction;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
    import com.ankamagames.atouin.renderers.ZoneDARenderer;
    import com.ankamagames.jerakine.types.zones.IZone;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.jerakine.types.zones.Cross;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.jerakine.types.zones.Lozenge;
    import com.ankamagames.jerakine.types.zones.Custom;
    import com.ankamagames.jerakine.map.LosDetector;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
    import com.ankamagames.jerakine.utils.display.Dofus2Line;
    import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
    import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastOnTargetRequestMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastRequestMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.atouin.data.map.CellData;
    import com.ankamagames.dofus.types.entities.Glyph;
    import com.ankamagames.atouin.managers.*;
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.renderers.*;

    public class FightSpellCastFrame implements Frame 
    {

        private static const FORBIDDEN_CURSOR:Class = FightSpellCastFrame_FORBIDDEN_CURSOR;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightSpellCastFrame));
        private static const RANGE_COLOR:Color = new Color(5533093);
        private static const LOS_COLOR:Color = new Color(2241433);
        private static const PORTAL_COLOR:Color = new Color(251623);
        private static const TARGET_COLOR:Color = new Color(14487842);
        private static const SELECTION_RANGE:String = "SpellCastRange";
        private static const SELECTION_PORTALS:String = "SpellCastPortals";
        private static const SELECTION_LOS:String = "SpellCastLos";
        private static const SELECTION_TARGET:String = "SpellCastTarget";
        private static const FORBIDDEN_CURSOR_NAME:String = "SpellCastForbiddenCusror";
        private static const TELEPORTATION_EFFECTS:Array = [1100, 1104, 1105, 1106];
        private static var _currentTargetIsTargetable:Boolean;

        private var _spellLevel:Object;
        private var _spellId:uint;
        private var _rangeSelection:Selection;
        private var _losSelection:Selection;
        private var _portalsSelection:Selection;
        private var _targetSelection:Selection;
        private var _currentCell:int = -1;
        private var _virtualCast:Boolean;
        private var _cancelTimer:Timer;
        private var _cursorData:LinkedCursorData;
        private var _lastTargetStatus:Boolean = true;
        private var _isInfiniteTarget:Boolean;
        private var _usedWrapper;
        private var _targetingThroughPortal:Boolean;
        private var _clearTargetTimer:Timer;
        private var _spellmaximumRange:uint;
        private var _invocationPreview:Array;
        private var _fightTeleportationPreview:FightTeleportationPreview;

        public function FightSpellCastFrame(spellId:uint)
        {
            var i:SpellWrapper;
            var effect:EffectInstance;
            var tes:TiphonEntityLook;
            var invoquedEntityNumber:int;
            var monsterId:*;
            var monster:Monster;
            var j:int;
            var ts:IEntity;
            var _local_10:*;
            this._invocationPreview = new Array();
            super();
            this._spellId = spellId;
            this._cursorData = new LinkedCursorData();
            this._cursorData.sprite = new FORBIDDEN_CURSOR();
            this._cursorData.sprite.cacheAsBitmap = true;
            this._cursorData.offset = new Point(14, 14);
            this._cancelTimer = new Timer(50);
            this._cancelTimer.addEventListener(TimerEvent.TIMER, this.cancelCast);
            if (((spellId) || (!(PlayedCharacterManager.getInstance().currentWeapon))))
            {
                for each (i in PlayedCharacterManager.getInstance().spellsInventory)
                {
                    if (i.spellId == this._spellId)
                    {
                        this._spellLevel = i;
                        if (this._spellId == 74)
                        {
                            tes = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
                            invoquedEntityNumber = 1;
                        }
                        else
                        {
                            if (this._spellId == 2763)
                            {
                                tes = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
                                invoquedEntityNumber = 4;
                            };
                        };
                        for each (effect in this.currentSpell.effects)
                        {
                            if ((((((effect.effectId == 181)) || ((effect.effectId == 1008)))) || ((effect.effectId == 1011))))
                            {
                                monsterId = effect.parameter0;
                                monster = Monster.getMonsterById(monsterId);
                                tes = new TiphonEntityLook(monster.look);
                                invoquedEntityNumber = 1;
                                break;
                            };
                        };
                        if (tes)
                        {
                            j = 0;
                            while (j < invoquedEntityNumber)
                            {
                                ts = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(), tes);
                                (ts as AnimatedCharacter).setCanSeeThrough(true);
                                (ts as AnimatedCharacter).transparencyAllowed = true;
                                (ts as AnimatedCharacter).alpha = 0.65;
                                (ts as AnimatedCharacter).mouseEnabled = false;
                                this._invocationPreview.push(ts);
                                j++;
                            };
                        }
                        else
                        {
                            this.removeInvocationPreview();
                        };
                        break;
                    };
                };
            }
            else
            {
                _local_10 = PlayedCharacterManager.getInstance().currentWeapon;
                this._spellLevel = {
                    "effects":_local_10.effects,
                    "castTestLos":_local_10.castTestLos,
                    "castInLine":_local_10.castInLine,
                    "castInDiagonal":_local_10.castInDiagonal,
                    "minRange":_local_10.minRange,
                    "range":_local_10.range,
                    "apCost":_local_10.apCost,
                    "needFreeCell":false,
                    "needTakenCell":false,
                    "needFreeTrapCell":false
                };
            };
            this._clearTargetTimer = new Timer(50, 1);
            this._clearTargetTimer.addEventListener(TimerEvent.TIMER, this.onClearTarget);
        }

        public static function isCurrentTargetTargetable():Boolean
        {
            return (_currentTargetIsTargetable);
        }

        public static function updateRangeAndTarget():void
        {
            var castFrame:FightSpellCastFrame = (Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame);
            if (castFrame)
            {
                castFrame.removeRange();
                castFrame.drawRange();
                castFrame.refreshTarget(true);
            };
        }


        public function get priority():int
        {
            return (Priority.HIGHEST);
        }

        public function get currentSpell():Object
        {
            return (this._spellLevel);
        }

        public function pushed():Boolean
        {
            var fef:FightEntitiesFrame;
            var fighters:Dictionary;
            var actorInfos:GameContextActorInformations;
            var fighterInfos:GameFightFighterInformations;
            var char:AnimatedCharacter;
            var fbf:FightBattleFrame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
            if (fbf.playingSlaveEntity)
            {
                fef = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                fighters = fef.getEntitiesDictionnary();
                for each (actorInfos in fighters)
                {
                    fighterInfos = (actorInfos as GameFightFighterInformations);
                    char = (DofusEntities.getEntity(fighterInfos.contextualId) as AnimatedCharacter);
                    if (((((char) && (!((fighterInfos.contextualId == CurrentPlayedFighterManager.getInstance().currentFighterId))))) && ((fighterInfos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED))))
                    {
                        char.setCanSeeThrough(true);
                    };
                };
            };
            this._cancelTimer.reset();
            this._lastTargetStatus = true;
            if (this._spellId == 0)
            {
                if (PlayedCharacterManager.getInstance().currentWeapon)
                {
                    this._usedWrapper = PlayedCharacterManager.getInstance().currentWeapon;
                }
                else
                {
                    this._usedWrapper = SpellWrapper.create(-1, 0, 1, false, PlayedCharacterManager.getInstance().id);
                };
            }
            else
            {
                this._usedWrapper = SpellWrapper.getFirstSpellWrapperById(this._spellId, CurrentPlayedFighterManager.getInstance().currentFighterId);
            };
            KernelEventsManager.getInstance().processCallback(HookList.CastSpellMode, this._usedWrapper);
            this.drawRange();
            this.refreshTarget();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:CellOverMessage;
            var _local_3:EntityMouseOverMessage;
            var _local_4:TimelineEntityOverAction;
            var _local_5:IEntity;
            var _local_6:TimelineEntityOutAction;
            var _local_7:IEntity;
            var _local_8:CellClickMessage;
            var _local_9:EntityClickMessage;
            var _local_10:TimelineEntityClickAction;
            var previewEntity:IEntity;
            switch (true)
            {
                case (msg is CellOverMessage):
                    _local_2 = (msg as CellOverMessage);
                    FightContextFrame.currentCell = _local_2.cellId;
                    this.refreshTarget();
                    return (false);
                case (msg is EntityMouseOutMessage):
                    this.clearTarget();
                    return (false);
                case (msg is CellOutMessage):
                    this.clearTarget();
                    return (false);
                case (msg is EntityMouseOverMessage):
                    _local_3 = (msg as EntityMouseOverMessage);
                    FightContextFrame.currentCell = _local_3.entity.position.cellId;
                    this.refreshTarget();
                    return (false);
                case (msg is TimelineEntityOverAction):
                    _local_4 = (msg as TimelineEntityOverAction);
                    _local_5 = DofusEntities.getEntity(_local_4.targetId);
                    if (((((_local_5) && (_local_5.position))) && ((_local_5.position.cellId > -1))))
                    {
                        FightContextFrame.currentCell = _local_5.position.cellId;
                        this.refreshTarget();
                    };
                    return (false);
                case (msg is TimelineEntityOutAction):
                    _local_6 = (msg as TimelineEntityOutAction);
                    _local_7 = DofusEntities.getEntity(_local_6.targetId);
                    if (((((_local_7) && (_local_7.position))) && ((_local_7.position.cellId == this._currentCell))))
                    {
                        this.removeTeleportationPreview();
                    };
                    return (false);
                case (msg is CellClickMessage):
                    _local_8 = (msg as CellClickMessage);
                    this.castSpell(_local_8.cellId);
                    return (true);
                case (msg is EntityClickMessage):
                    _local_9 = (msg as EntityClickMessage);
                    if (this._invocationPreview.length > 0)
                    {
                        for each (previewEntity in this._invocationPreview)
                        {
                            if (previewEntity.id == _local_9.entity.id)
                            {
                                this.castSpell(_local_9.entity.position.cellId);
                                return (true);
                            };
                        };
                    };
                    this.castSpell(_local_9.entity.position.cellId, _local_9.entity.id);
                    return (true);
                case (msg is TimelineEntityClickAction):
                    _local_10 = (msg as TimelineEntityClickAction);
                    this.castSpell(0, _local_10.fighterId);
                    return (true);
                case (msg is AdjacentMapClickMessage):
                case (msg is MouseRightClickMessage):
                    this.cancelCast();
                    return (true);
                case (msg is BannerEmptySlotClickAction):
                    this.cancelCast();
                    return (true);
                case (msg is MouseUpMessage):
                    this._cancelTimer.start();
                    return (false);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            var fef:FightEntitiesFrame;
            var fighters:Dictionary;
            var actorInfos:GameContextActorInformations;
            var char:AnimatedCharacter;
            var fbf:FightBattleFrame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
            if (((fbf) && (fbf.playingSlaveEntity)))
            {
                fef = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                fighters = fef.getEntitiesDictionnary();
                for each (actorInfos in fighters)
                {
                    char = (DofusEntities.getEntity(actorInfos.contextualId) as AnimatedCharacter);
                    if (((char) && (!((actorInfos.contextualId == CurrentPlayedFighterManager.getInstance().currentFighterId)))))
                    {
                        char.setCanSeeThrough(false);
                    };
                };
            };
            this._cancelTimer.reset();
            this.hideTargetsTooltips();
            this.removeRange();
            this.removeTarget();
            this.removeInvocationPreview();
            LinkedCursorSpriteManager.getInstance().removeItem(FORBIDDEN_CURSOR_NAME);
            this.removeTeleportationPreview();
            try
            {
                KernelEventsManager.getInstance().processCallback(HookList.CancelCastSpell, SpellWrapper.getFirstSpellWrapperById(this._spellId, CurrentPlayedFighterManager.getInstance().currentFighterId));
            }
            catch(e:Error)
            {
            };
            return (true);
        }

        public function refreshTarget(force:Boolean=false):void
        {
            var newTarget:int;
            var currentFighterId:int;
            var entityInfos:GameFightFighterInformations;
            var renderer:ZoneDARenderer;
            var spellZone:IZone;
            var _local_10:Boolean;
            var playerX:int;
            var playerY:int;
            var distance:int;
            var positionArray:Array;
            var i:int;
            var _local_16:IEntity;
            var preview:IEntity;
            if (this._clearTargetTimer.running)
            {
                this._clearTargetTimer.reset();
            };
            var target:int = FightContextFrame.currentCell;
            if (target == -1)
            {
                return;
            };
            this._targetingThroughPortal = false;
            if (((((SelectionManager.getInstance().isInside(target, SELECTION_PORTALS)) && (SelectionManager.getInstance().isInside(target, SELECTION_LOS)))) && (!((this._spellId == 0)))))
            {
                newTarget = -1;
                newTarget = this.getTargetThroughPortal(target, true);
                if (newTarget != target)
                {
                    this._targetingThroughPortal = true;
                    target = newTarget;
                };
            };
            if (((!(force)) && ((this._currentCell == target))))
            {
                if (((this._targetSelection) && (this.isValidCell(target))))
                {
                    this.showTargetsTooltips(this._targetSelection);
                    this.showTeleportationPreview();
                };
                return;
            };
            this._currentCell = target;
            var fightTurnFrame:FightTurnFrame = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
            if (!(fightTurnFrame))
            {
                return;
            };
            var myTurn:Boolean = fightTurnFrame.myTurn;
            _currentTargetIsTargetable = this.isValidCell(target);
            if (_currentTargetIsTargetable)
            {
                if (!(this._targetSelection))
                {
                    this._targetSelection = new Selection();
                    this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA, 1, true);
                    (this._targetSelection.renderer as ZoneDARenderer).showFarmCell = false;
                    this._targetSelection.color = TARGET_COLOR;
                    spellZone = SpellZoneManager.getInstance().getSpellZone(this._spellLevel, true);
                    this._spellmaximumRange = spellZone.radius;
                    this._targetSelection.zone = spellZone;
                    SelectionManager.getInstance().addSelection(this._targetSelection, SELECTION_TARGET);
                };
                currentFighterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
                entityInfos = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(currentFighterId) as GameFightFighterInformations);
                if (entityInfos)
                {
                    if (this._targetingThroughPortal)
                    {
                        this._targetSelection.zone.direction = MapPoint(MapPoint.fromCellId(entityInfos.disposition.cellId)).advancedOrientationTo(MapPoint.fromCellId(FightContextFrame.currentCell), false);
                    }
                    else
                    {
                        this._targetSelection.zone.direction = MapPoint(MapPoint.fromCellId(entityInfos.disposition.cellId)).advancedOrientationTo(MapPoint.fromCellId(target), false);
                    };
                };
                renderer = (this._targetSelection.renderer as ZoneDARenderer);
                if (((Atouin.getInstance().options.transparentOverlayMode) && (!((this._spellmaximumRange == 63)))))
                {
                    renderer.currentStrata = PlacementStrataEnums.STRATA_NO_Z_ORDER;
                    SelectionManager.getInstance().update(SELECTION_TARGET, target, true);
                }
                else
                {
                    if (renderer.currentStrata == PlacementStrataEnums.STRATA_NO_Z_ORDER)
                    {
                        renderer.currentStrata = PlacementStrataEnums.STRATA_AREA;
                        _local_10 = true;
                    };
                    SelectionManager.getInstance().update(SELECTION_TARGET, target, _local_10);
                };
                if (myTurn)
                {
                    LinkedCursorSpriteManager.getInstance().removeItem(FORBIDDEN_CURSOR_NAME);
                    this._lastTargetStatus = true;
                }
                else
                {
                    if (this._lastTargetStatus)
                    {
                        LinkedCursorSpriteManager.getInstance().addItem(FORBIDDEN_CURSOR_NAME, this._cursorData, true);
                    };
                    this._lastTargetStatus = false;
                };
                this.showTargetsTooltips(this._targetSelection);
                if (this._invocationPreview.length > 0)
                {
                    if (this._spellId == 2763)
                    {
                        playerX = MapPoint.fromCellId(entityInfos.disposition.cellId).x;
                        playerY = MapPoint.fromCellId(entityInfos.disposition.cellId).y;
                        distance = MapPoint.fromCellId(entityInfos.disposition.cellId).distanceTo(MapPoint.fromCellId(this._currentCell));
                        positionArray = [MapPoint.fromCoords((playerX + distance), playerY), MapPoint.fromCoords((playerX - distance), playerY), MapPoint.fromCoords(playerX, (playerY + distance)), MapPoint.fromCoords(playerX, (playerY - distance))];
                        i = 0;
                        while (i < 4)
                        {
                            preview = this._invocationPreview[i];
                            (preview as AnimatedCharacter).visible = true;
                            preview.position = positionArray[i];
                            (preview as AnimatedCharacter).setDirection(MapPoint.fromCellId(entityInfos.disposition.cellId).advancedOrientationTo(preview.position, true));
                            if (((this.isValidCell(preview.position.cellId)) && (!((preview.position.cellId == this._currentCell)))))
                            {
                                (preview as AnimatedCharacter).display(PlacementStrataEnums.STRATA_PLAYER);
                                (preview as AnimatedCharacter).visible = true;
                            }
                            else
                            {
                                (preview as AnimatedCharacter).visible = false;
                            };
                            i++;
                        };
                    }
                    else
                    {
                        _local_16 = this._invocationPreview[0];
                        (_local_16 as AnimatedCharacter).visible = true;
                        _local_16.position = MapPoint.fromCellId(this._currentCell);
                        (_local_16 as AnimatedCharacter).setDirection(MapPoint.fromCellId(entityInfos.disposition.cellId).advancedOrientationTo(MapPoint.fromCellId(this._currentCell), true));
                        (_local_16 as AnimatedCharacter).display(PlacementStrataEnums.STRATA_PLAYER);
                    };
                };
                this.showTeleportationPreview();
            }
            else
            {
                if (this._invocationPreview.length > 0)
                {
                    for each (preview in this._invocationPreview)
                    {
                        (preview as AnimatedCharacter).visible = false;
                    };
                };
                if (this._lastTargetStatus)
                {
                    LinkedCursorSpriteManager.getInstance().addItem(FORBIDDEN_CURSOR_NAME, this._cursorData, true);
                };
                this.removeTarget();
                this._lastTargetStatus = false;
                this.hideTargetsTooltips();
                this.removeTeleportationPreview();
            };
        }

        private function removeInvocationPreview():void
        {
            var preview:IEntity;
            for each (preview in this._invocationPreview)
            {
                (preview as AnimatedCharacter).remove();
                (preview as AnimatedCharacter).destroy();
                preview = null;
            };
        }

        public function drawRange():void
        {
            var shapePlus:Cross;
            var sc:uint;
            var _local_14:Vector.<uint>;
            var _local_15:Vector.<uint>;
            var _local_16:int;
            var _local_17:int;
            var cellId:uint;
            var cAfterPortal:int;
            var exitPortal:int;
            var c:uint;
            var entryMarkPortal:MarkInstance;
            var teamPortals:Vector.<MapPoint>;
            var portalsCellIds:Vector.<uint>;
            var lastPortalMp:MapPoint;
            var newTargetMp:MapPoint;
            var cellsFromLine:Vector.<Point>;
            var mp:MapPoint;
            var cellFromLine:Point;
            var cellsWithLosOk:Vector.<uint>;
            var currentFighterId:int = CurrentPlayedFighterManager.getInstance().currentFighterId;
            var entityInfos:GameFightFighterInformations = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(currentFighterId) as GameFightFighterInformations);
            var origin:uint = entityInfos.disposition.cellId;
            var playerRange:CharacterBaseCharacteristic = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().range;
            var range:int = this._spellLevel.range;
            if (((((((!(this._spellLevel.castInLine)) && (!(this._spellLevel.castInDiagonal)))) && (!(this._spellLevel.castTestLos)))) && ((range == 63))))
            {
                this._isInfiniteTarget = true;
                return;
            };
            this._isInfiniteTarget = false;
            if (this._spellLevel["rangeCanBeBoosted"])
            {
                range = (range + (((playerRange.base + playerRange.objectsAndMountBonus) + playerRange.alignGiftBonus) + playerRange.contextModif));
                if (range < this._spellLevel.minRange)
                {
                    range = this._spellLevel.minRange;
                };
            };
            range = Math.min(range, (AtouinConstants.MAP_WIDTH * AtouinConstants.MAP_HEIGHT));
            if (range < 0)
            {
                range = 0;
            };
            this._rangeSelection = new Selection();
            this._rangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            (this._rangeSelection.renderer as ZoneDARenderer).showFarmCell = false;
            this._rangeSelection.color = RANGE_COLOR;
            this._rangeSelection.alpha = true;
            if (((this._spellLevel.castInLine) && (this._spellLevel.castInDiagonal)))
            {
                shapePlus = new Cross(this._spellLevel.minRange, range, DataMapProvider.getInstance());
                shapePlus.allDirections = true;
                this._rangeSelection.zone = shapePlus;
            }
            else
            {
                if (this._spellLevel.castInLine)
                {
                    this._rangeSelection.zone = new Cross(this._spellLevel.minRange, range, DataMapProvider.getInstance());
                }
                else
                {
                    if (this._spellLevel.castInDiagonal)
                    {
                        shapePlus = new Cross(this._spellLevel.minRange, range, DataMapProvider.getInstance());
                        shapePlus.diagonal = true;
                        this._rangeSelection.zone = shapePlus;
                    }
                    else
                    {
                        this._rangeSelection.zone = new Lozenge(this._spellLevel.minRange, range, DataMapProvider.getInstance());
                    };
                };
            };
            var untargetableCells:Vector.<uint> = new Vector.<uint>();
            this._losSelection = new Selection();
            this._losSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            (this._losSelection.renderer as ZoneDARenderer).showFarmCell = false;
            this._losSelection.color = LOS_COLOR;
            var allCells:Vector.<uint> = this._rangeSelection.zone.getCells(origin);
            if (!(this._spellLevel.castTestLos))
            {
                this._losSelection.zone = new Custom(allCells);
            }
            else
            {
                this._losSelection.zone = new Custom(LosDetector.getCell(DataMapProvider.getInstance(), allCells, MapPoint.fromCellId(origin)));
                this._rangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA, 0.5);
                (this._rangeSelection.renderer as ZoneDARenderer).showFarmCell = false;
                _local_14 = this._rangeSelection.zone.getCells(origin);
                _local_15 = this._losSelection.zone.getCells(origin);
                _local_16 = _local_14.length;
                _local_17 = 0;
                while (_local_17 < _local_16)
                {
                    cellId = _local_14[_local_17];
                    if (_local_15.indexOf(cellId) == -1)
                    {
                        untargetableCells.push(cellId);
                    };
                    _local_17++;
                };
            };
            var mpWithPortals:Vector.<MapPoint> = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL);
            var portalUsableCells:Vector.<uint> = new Vector.<uint>();
            var cells:Vector.<uint> = new Vector.<uint>();
            if (((mpWithPortals) && ((mpWithPortals.length >= 2))))
            {
                for each (c in this._losSelection.zone.getCells(origin))
                {
                    cAfterPortal = this.getTargetThroughPortal(c);
                    if (cAfterPortal != c)
                    {
                        this._targetingThroughPortal = true;
                        if (this.isValidCell(cAfterPortal, true))
                        {
                            if (this._spellLevel.castTestLos)
                            {
                                entryMarkPortal = MarkedCellsManager.getInstance().getMarkAtCellId(c, GameActionMarkTypeEnum.PORTAL);
                                teamPortals = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL, entryMarkPortal.teamId);
                                portalsCellIds = LinkedCellsManager.getInstance().getLinks(MapPoint.fromCellId(c), teamPortals);
                                exitPortal = portalsCellIds.pop();
                                lastPortalMp = MapPoint.fromCellId(exitPortal);
                                newTargetMp = MapPoint.fromCellId(cAfterPortal);
                                cellsFromLine = Dofus2Line.getLine(lastPortalMp.cellId, newTargetMp.cellId);
                                for each (cellFromLine in cellsFromLine)
                                {
                                    mp = MapPoint.fromCoords(cellFromLine.x, cellFromLine.y);
                                    cells.push(mp.cellId);
                                };
                                cellsWithLosOk = LosDetector.getCell(DataMapProvider.getInstance(), cells, lastPortalMp);
                                if (cellsWithLosOk.indexOf(cAfterPortal) > -1)
                                {
                                    portalUsableCells.push(c);
                                }
                                else
                                {
                                    untargetableCells.push(c);
                                };
                            }
                            else
                            {
                                portalUsableCells.push(c);
                            };
                        }
                        else
                        {
                            untargetableCells.push(c);
                        };
                        this._targetingThroughPortal = false;
                    };
                };
            };
            var losCells:Vector.<uint> = new Vector.<uint>();
            for each (sc in this._losSelection.zone.getCells(origin))
            {
                if (untargetableCells.indexOf(sc) == -1)
                {
                    losCells.push(sc);
                };
            };
            this._losSelection.zone = new Custom(losCells);
            SelectionManager.getInstance().addSelection(this._losSelection, SELECTION_LOS, origin);
            if (untargetableCells.length > 0)
            {
                this._rangeSelection.zone = new Custom(untargetableCells);
                SelectionManager.getInstance().addSelection(this._rangeSelection, SELECTION_RANGE, origin);
            };
            if (portalUsableCells.length > 0)
            {
                this._portalsSelection = new Selection();
                this._portalsSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
                this._portalsSelection.color = PORTAL_COLOR;
                this._portalsSelection.alpha = true;
                this._portalsSelection.zone = new Custom(portalUsableCells);
                SelectionManager.getInstance().addSelection(this._portalsSelection, SELECTION_PORTALS, origin);
            };
        }

        private function showTeleportationPreview():void
        {
            var effects:Vector.<EffectInstance>;
            var effect:EffectInstance;
            var fcf:FightContextFrame;
            var spellZone:IZone;
            var spellZoneCells:Vector.<uint>;
            var currentCell:uint;
            var entitiesIds:Vector.<int>;
            var entityId:int;
            var entityInfos:GameFightFighterInformations;
            var targetedEntities:Vector.<int>;
            var casterId:int;
            var spellWTmp:SpellWrapper;
            var tpEffectId:uint;
            var nbTeleportationEffects:int;
            var spellW:SpellWrapper = (this._usedWrapper as SpellWrapper);
            if (spellW)
            {
                effects = spellW.effects.concat(spellW.criticalEffect);
                fcf = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                currentCell = this._currentCell;
                entitiesIds = fcf.entitiesFrame.getEntitiesIdsList();
                targetedEntities = new Vector.<int>(0);
                casterId = PlayedCharacterManager.getInstance().id;
                for each (effect in effects)
                {
                    if (effect.effectId == 1160)
                    {
                        spellWTmp = SpellWrapper.create(0, (effect.parameter0 as uint), spellW.spellLevel);
                        if (this.hasTeleportation(spellWTmp))
                        {
                            for each (entityId in entitiesIds)
                            {
                                entityInfos = (fcf.entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations);
                                if (((entityInfos.alive) && (DamageUtil.verifySpellEffectMask(casterId, entityId, effect))))
                                {
                                    currentCell = entityInfos.disposition.cellId;
                                    effects = spellWTmp.effects.concat(spellWTmp.criticalEffect);
                                    break;
                                };
                            };
                            break;
                        };
                    };
                };
                for each (effect in effects)
                {
                    if (TELEPORTATION_EFFECTS.indexOf(effect.effectId) != -1)
                    {
                        tpEffectId = effect.effectId;
                        spellZone = SpellZoneManager.getInstance().getZone(effect.zoneShape, (effect.zoneSize as uint), (effect.zoneMinSize as uint));
                        spellZoneCells = spellZone.getCells(currentCell);
                        for each (entityId in entitiesIds)
                        {
                            entityInfos = (fcf.entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations);
                            if (((((((((((((entityInfos.alive) && (!((spellZoneCells.indexOf(entityInfos.disposition.cellId) == -1))))) && (DofusEntities.getEntity(entityId)))) && ((targetedEntities.indexOf(entityId) == -1)))) && (DamageUtil.verifySpellEffectMask(casterId, entityId, effect)))) && (!((((currentCell == entityInfos.disposition.cellId)) && ((((tpEffectId == 1104)) || ((tpEffectId == 1106))))))))) && (this.canTeleport(entityInfos.contextualId))))
                            {
                                targetedEntities.push(entityId);
                            };
                        };
                        nbTeleportationEffects++;
                    };
                };
                if ((((((targetedEntities.length == 0)) && ((tpEffectId == 1104)))) && (this.canTeleport(casterId))))
                {
                    targetedEntities.push(casterId);
                };
                if (this._fightTeleportationPreview)
                {
                    this._fightTeleportationPreview.remove();
                };
                if (targetedEntities.length > 0)
                {
                    this._fightTeleportationPreview = new FightTeleportationPreview(targetedEntities, tpEffectId, currentCell, fcf.entitiesFrame.getEntityInfos(casterId).disposition.cellId, (nbTeleportationEffects > 1));
                    this._fightTeleportationPreview.show();
                };
            };
        }

        private function canTeleport(pEntityId:int):Boolean
        {
            var monster:Monster;
            var fcf:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            var entityInfos:GameFightFighterInformations = (fcf.entitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations);
            if ((entityInfos is GameFightMonsterInformations))
            {
                monster = Monster.getMonsterById((entityInfos as GameFightMonsterInformations).creatureGenericId);
                if (!(monster.canSwitchPos))
                {
                    return (false);
                };
            };
            var entityStates:Array = FightersStateManager.getInstance().getStates(pEntityId);
            return (((!(entityStates)) || ((((entityStates.indexOf(6) == -1)) && ((entityStates.indexOf(97) == -1))))));
        }

        private function hasTeleportation(pSpellW:SpellWrapper):Boolean
        {
            var effect:EffectInstance;
            for each (effect in pSpellW.effects)
            {
                if (TELEPORTATION_EFFECTS.indexOf(effect.effectId) != -1)
                {
                    return (true);
                };
            };
            return (false);
        }

        private function removeTeleportationPreview():void
        {
            if (this._fightTeleportationPreview)
            {
                this._fightTeleportationPreview.remove();
            };
        }

        private function showTargetsTooltips(pSelection:Selection):void
        {
            var entityId:int;
            var entityInfos:GameFightFighterInformations;
            var fcf:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            var entitiesIds:Vector.<int> = fcf.entitiesFrame.getEntitiesIdsList();
            var zoneCells:Vector.<uint> = pSelection.zone.getCells(this._currentCell);
            var targetEntities:Vector.<int> = new Vector.<int>(0);
            for each (entityId in entitiesIds)
            {
                entityInfos = (fcf.entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations);
                if (((!((zoneCells.indexOf(entityInfos.disposition.cellId) == -1))) && (DofusEntities.getEntity(entityId))))
                {
                    targetEntities.push(entityId);
                    TooltipPlacer.waitBeforeOrder(("tooltip_tooltipOverEntity_" + entityId));
                }
                else
                {
                    if (((!(fcf.showPermanentTooltips)) || (((fcf.showPermanentTooltips) && ((fcf.battleFrame.targetedEntities.indexOf(entityId) == -1))))))
                    {
                        TooltipManager.hide(("tooltipOverEntity_" + entityId));
                    };
                };
            };
            fcf.removeSpellTargetsTooltips();
            for each (entityId in targetEntities)
            {
                entityInfos = (fcf.entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations);
                if (entityInfos.alive)
                {
                    fcf.displayEntityTooltip(entityId, this._spellLevel, null, false, this._currentCell);
                };
            };
        }

        private function hideTargetsTooltips():void
        {
            var entityId:int;
            var ac:AnimatedCharacter;
            var fcf:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            var entitiesId:Vector.<int> = fcf.entitiesFrame.getEntitiesIdsList();
            var overEntity:IEntity = EntitiesManager.getInstance().getEntityOnCell(FightContextFrame.currentCell, AnimatedCharacter);
            if (overEntity)
            {
                ac = (overEntity as AnimatedCharacter);
                if (((((ac) && (ac.parentSprite))) && ((ac.parentSprite.carriedEntity == ac))))
                {
                    overEntity = (ac.parentSprite as AnimatedCharacter);
                };
            };
            for each (entityId in entitiesId)
            {
                if (((!(fcf.showPermanentTooltips)) || (((fcf.showPermanentTooltips) && ((fcf.battleFrame.targetedEntities.indexOf(entityId) == -1))))))
                {
                    TooltipManager.hide(("tooltipOverEntity_" + entityId));
                };
            };
            if (((fcf.showPermanentTooltips) && ((fcf.battleFrame.targetedEntities.length > 0))))
            {
                for each (entityId in fcf.battleFrame.targetedEntities)
                {
                    if (((!(overEntity)) || (!((entityId == overEntity.id)))))
                    {
                        fcf.displayEntityTooltip(entityId);
                    };
                };
            };
            if (overEntity)
            {
                fcf.displayEntityTooltip(overEntity.id);
            };
        }

        private function clearTarget():void
        {
            if (!(this._clearTargetTimer.running))
            {
                this._clearTargetTimer.start();
            };
        }

        private function onClearTarget(event:TimerEvent):void
        {
            this.refreshTarget();
        }

        private function getTargetThroughPortal(target:int, drawLinks:Boolean=false):int
        {
            var targetPortal:MapPoint;
            var portalMark:MarkInstance;
            var portalp:MapPoint;
            var effect:EffectInstance;
            var _local_16:MapPoint;
            var entryVector:Vector.<uint>;
            var exitVector:Vector.<uint>;
            if (((this._spellLevel) && (this._spellLevel.effects)))
            {
                for each (effect in this._spellLevel.effects)
                {
                    if (effect.effectId == ActionIdConverter.ACTION_FIGHT_DISABLE_PORTAL)
                    {
                        return (target);
                    };
                };
            };
            var currentFighterId:int = CurrentPlayedFighterManager.getInstance().currentFighterId;
            var entityInfos:GameFightFighterInformations = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(currentFighterId) as GameFightFighterInformations);
            if (!(entityInfos))
            {
                return (target);
            };
            var markedCellsManager:MarkedCellsManager = MarkedCellsManager.getInstance();
            var mpWithPortals:Vector.<MapPoint> = markedCellsManager.getMarksMapPoint(GameActionMarkTypeEnum.PORTAL);
            if (((!(mpWithPortals)) || ((mpWithPortals.length < 2))))
            {
                return (target);
            };
            for each (portalp in mpWithPortals)
            {
                portalMark = markedCellsManager.getMarkAtCellId(portalp.cellId, GameActionMarkTypeEnum.PORTAL);
                if (((portalMark) && (portalMark.active)))
                {
                    if (portalp.cellId == target)
                    {
                        targetPortal = portalp;
                        break;
                    };
                };
            };
            if (!(targetPortal))
            {
                return (target);
            };
            mpWithPortals = markedCellsManager.getMarksMapPoint(GameActionMarkTypeEnum.PORTAL, portalMark.teamId);
            var portalsCellIds:Vector.<uint> = LinkedCellsManager.getInstance().getLinks(targetPortal, mpWithPortals);
            var exitPoint:MapPoint = MapPoint.fromCellId(portalsCellIds.pop());
            var fighterPoint:MapPoint = MapPoint.fromCellId(entityInfos.disposition.cellId);
            if (!(fighterPoint))
            {
                return (target);
            };
            var symmetricalTargetX:int = ((targetPortal.x - fighterPoint.x) + exitPoint.x);
            var symmetricalTargetY:int = ((targetPortal.y - fighterPoint.y) + exitPoint.y);
            if (!(MapPoint.isInMap(symmetricalTargetX, symmetricalTargetY)))
            {
                return ((AtouinConstants.MAP_CELLS_COUNT + 1));
            };
            _local_16 = MapPoint.fromCoords(symmetricalTargetX, symmetricalTargetY);
            if (drawLinks)
            {
                entryVector = new Vector.<uint>();
                entryVector.push(fighterPoint.cellId);
                entryVector.push(targetPortal.cellId);
                LinkedCellsManager.getInstance().drawLinks("spellEntryLink", entryVector, 10, TARGET_COLOR.color, 1);
                if (_local_16.cellId < AtouinConstants.MAP_CELLS_COUNT)
                {
                    exitVector = new Vector.<uint>();
                    exitVector.push(exitPoint.cellId);
                    exitVector.push(_local_16.cellId);
                    LinkedCellsManager.getInstance().drawLinks("spellExitLink", exitVector, 6, TARGET_COLOR.color, 1);
                };
            };
            return (_local_16.cellId);
        }

        private function castSpell(cell:uint, targetId:int=0):void
        {
            var gafcotrmsg:GameActionFightCastOnTargetRequestMessage;
            var gafcrmsg:GameActionFightCastRequestMessage;
            var fightTurnFrame:FightTurnFrame = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
            if (((!(fightTurnFrame)) || (!(fightTurnFrame.myTurn))))
            {
                return;
            };
            if (CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent < this._spellLevel.apCost)
            {
                return;
            };
            if (((!((targetId == 0))) && (!(FightEntitiesFrame.getCurrentInstance().entityIsIllusion(targetId)))))
            {
                CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = (CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent - this._spellLevel.apCost);
                gafcotrmsg = new GameActionFightCastOnTargetRequestMessage();
                gafcotrmsg.initGameActionFightCastOnTargetRequestMessage(this._spellId, targetId);
                ConnectionsHandler.getConnection().send(gafcotrmsg);
            }
            else
            {
                if (this.isValidCell(cell))
                {
                    if (this._invocationPreview.length > 0)
                    {
                        this.removeInvocationPreview();
                    };
                    CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = (CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent - this._spellLevel.apCost);
                    gafcrmsg = new GameActionFightCastRequestMessage();
                    gafcrmsg.initGameActionFightCastRequestMessage(this._spellId, cell);
                    ConnectionsHandler.getConnection().send(gafcrmsg);
                };
            };
            this.cancelCast();
        }

        private function cancelCast(... args):void
        {
            this.removeInvocationPreview();
            this._cancelTimer.reset();
            Kernel.getWorker().removeFrame(this);
        }

        private function removeRange():void
        {
            var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_RANGE);
            if (s)
            {
                s.remove();
                this._rangeSelection = null;
            };
            var los:Selection = SelectionManager.getInstance().getSelection(SELECTION_LOS);
            if (los)
            {
                los.remove();
                this._losSelection = null;
            };
            var ps:Selection = SelectionManager.getInstance().getSelection(SELECTION_PORTALS);
            if (ps)
            {
                ps.remove();
                this._portalsSelection = null;
            };
            this._isInfiniteTarget = false;
        }

        private function removeTarget():void
        {
            var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
            if (s)
            {
                s.remove();
                this._rangeSelection = null;
            };
        }

        private function isValidCell(cell:uint, ignorePortal:Boolean=false):Boolean
        {
            var spellLevel:SpellLevel;
            var entity:IEntity;
            var isGlyph:Boolean;
            var mustContinue:Boolean;
            var preview:IEntity;
            var valid:Boolean;
            var cellData:CellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cell];
            if (((!(cellData)) || (cellData.farmCell)))
            {
                return (false);
            };
            if (this._isInfiniteTarget)
            {
                return (true);
            };
            if (this._spellId)
            {
                spellLevel = this._spellLevel.spellLevelInfos;
                for each (entity in EntitiesManager.getInstance().getEntitiesOnCell(cell))
                {
                    if (this._invocationPreview.length > 0)
                    {
                        mustContinue = false;
                        for each (preview in this._invocationPreview)
                        {
                            if (entity.id == preview.id)
                            {
                                mustContinue = true;
                                break;
                            };
                        };
                        if (mustContinue)
                        {
                            continue;
                        };
                    };
                    if (!(CurrentPlayedFighterManager.getInstance().canCastThisSpell(this._spellLevel.spellId, this._spellLevel.spellLevel, entity.id)))
                    {
                        return (false);
                    };
                    isGlyph = (entity is Glyph);
                    if (((((spellLevel.needFreeTrapCell) && (isGlyph))) && (((entity as Glyph).glyphType == GameActionMarkTypeEnum.TRAP))))
                    {
                        return (false);
                    };
                    if (((this._spellLevel.needFreeCell) && (!(isGlyph))))
                    {
                        return (false);
                    };
                };
            };
            if (((this._targetingThroughPortal) && (!(ignorePortal))))
            {
                valid = this.isValidCell(this.getTargetThroughPortal(cell), true);
                if (!(valid))
                {
                    return (false);
                };
            };
            if (this._targetingThroughPortal)
            {
                if (cellData.nonWalkableDuringFight)
                {
                    return (false);
                };
                if (cellData.mov)
                {
                    return (true);
                };
                return (false);
            };
            return (SelectionManager.getInstance().isInside(cell, SELECTION_LOS));
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.frames


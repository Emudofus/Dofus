package com.ankamagames.dofus.logic.game.fight.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.actions.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.actions.fight.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import com.ankamagames.jerakine.utils.display.spellZone.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class FightSpellCastFrame extends Object implements Frame
    {
        private var _spellLevel:Object;
        private var _spellId:uint;
        private var _rangeSelection:Selection;
        private var _losSelection:Selection;
        private var _targetSelection:Selection;
        private var _currentCell:int = -1;
        private var _virtualCast:Boolean;
        private var _cancelTimer:Timer;
        private var _cursorData:LinkedCursorData;
        private var _lastTargetStatus:Boolean = true;
        private var _isInfiniteTarget:Boolean;
        private var _usedWrapper:Object;
        private var _currentTargetIsTargetable:Boolean;
        private var _clearTargetTimer:Timer;
        private static const FORBIDDEN_CURSOR:Class = FightSpellCastFrame_FORBIDDEN_CURSOR;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FightSpellCastFrame));
        private static const RANGE_COLOR:Color = new Color(5533093);
        private static const LOS_COLOR:Color = new Color(2241433);
        private static const TARGET_COLOR:Color = new Color(14487842);
        private static const SELECTION_RANGE:String = "SpellCastRange";
        private static const SELECTION_LOS:String = "SpellCastLos";
        private static const SELECTION_TARGET:String = "SpellCastTarget";
        private static const FORBIDDEN_CURSOR_NAME:String = "SpellCastForbiddenCusror";

        public function FightSpellCastFrame(param1:uint)
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            this._spellId = param1;
            this._cursorData = new LinkedCursorData();
            this._cursorData.sprite = new FORBIDDEN_CURSOR();
            this._cursorData.sprite.cacheAsBitmap = true;
            this._cursorData.offset = new Point(14, 14);
            this._cancelTimer = new Timer(50);
            this._cancelTimer.addEventListener(TimerEvent.TIMER, this.cancelCast);
            if (param1 || !PlayedCharacterManager.getInstance().currentWeapon)
            {
                for each (_loc_2 in PlayedCharacterManager.getInstance().spellsInventory)
                {
                    
                    if (_loc_2.spellId == this._spellId)
                    {
                        this._spellLevel = _loc_2;
                    }
                }
            }
            else
            {
                _loc_3 = PlayedCharacterManager.getInstance().currentWeapon;
                this._spellLevel = {effects:_loc_3.effects, castTestLos:_loc_3.castTestLos, castInLine:_loc_3.castInLine, castInDiagonal:_loc_3.castInDiagonal, minRange:_loc_3.minRange, range:_loc_3.range, apCost:_loc_3.apCost, needFreeCell:false, needTakenCell:false, needFreeTrapCell:false};
            }
            this._clearTargetTimer = new Timer(50, 1);
            this._clearTargetTimer.addEventListener(TimerEvent.TIMER, this.onClearTarget);
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        public function get currentTargetIsTargetable() : Boolean
        {
            return this._currentTargetIsTargetable;
        }// end function

        public function pushed() : Boolean
        {
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
                }
            }
            else
            {
                this._usedWrapper = SpellWrapper.getFirstSpellWrapperById(this._spellId, CurrentPlayedFighterManager.getInstance().currentFighterId);
            }
            KernelEventsManager.getInstance().processCallback(HookList.CastSpellMode, this._usedWrapper);
            this.drawRange();
            this.refreshTarget();
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
            switch(true)
            {
                case param1 is CellOverMessage:
                {
                    _loc_2 = param1 as CellOverMessage;
                    FightContextFrame.currentCell = _loc_2.cellId;
                    this.refreshTarget();
                    return false;
                }
                case param1 is EntityMouseOutMessage:
                {
                    this.clearTarget();
                    return false;
                }
                case param1 is CellOutMessage:
                {
                    this.clearTarget();
                    return false;
                }
                case param1 is EntityMouseOverMessage:
                {
                    _loc_3 = param1 as EntityMouseOverMessage;
                    FightContextFrame.currentCell = _loc_3.entity.position.cellId;
                    this.refreshTarget();
                    return false;
                }
                case param1 is TimelineEntityOverAction:
                {
                    _loc_4 = param1 as TimelineEntityOverAction;
                    _loc_5 = DofusEntities.getEntity(_loc_4.targetId);
                    if (_loc_5 && _loc_5.position && _loc_5.position.cellId > -1)
                    {
                        FightContextFrame.currentCell = _loc_5.position.cellId;
                        this.refreshTarget();
                    }
                    return false;
                }
                case param1 is CellClickMessage:
                {
                    _loc_6 = param1 as CellClickMessage;
                    this.castSpell(_loc_6.cellId);
                    return true;
                }
                case param1 is EntityClickMessage:
                {
                    _loc_7 = param1 as EntityClickMessage;
                    this.castSpell(_loc_7.entity.position.cellId, _loc_7.entity.id);
                    return true;
                }
                case param1 is TimelineEntityClickAction:
                {
                    _loc_8 = param1 as TimelineEntityClickAction;
                    this.castSpell(0, _loc_8.fighterId);
                    return true;
                }
                case param1 is AdjacentMapClickMessage:
                case param1 is MouseRightClickMessage:
                {
                    this.cancelCast();
                    return true;
                }
                case param1 is BannerEmptySlotClickAction:
                {
                    this.cancelCast();
                    return true;
                }
                case param1 is MouseUpMessage:
                {
                    this._cancelTimer.start();
                    return false;
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
            this._cancelTimer.reset();
            this.removeRange();
            this.removeTarget();
            LinkedCursorSpriteManager.getInstance().removeItem(FORBIDDEN_CURSOR_NAME);
            try
            {
                KernelEventsManager.getInstance().processCallback(HookList.CancelCastSpell, SpellWrapper.getFirstSpellWrapperById(this._spellId, CurrentPlayedFighterManager.getInstance().currentFighterId));
            }
            catch (e:Error)
            {
            }
            return true;
        }// end function

        public function refreshTarget(param1:Boolean = false) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (this._clearTargetTimer.running)
            {
                this._clearTargetTimer.reset();
            }
            var _loc_2:* = FightContextFrame.currentCell;
            if (!param1 && this._currentCell == _loc_2)
            {
                return;
            }
            this._currentCell = _loc_2;
            var _loc_3:* = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if (!_loc_3)
            {
                return;
            }
            var _loc_4:* = _loc_3.myTurn;
            this._currentTargetIsTargetable = this.isValidCell(_loc_2);
            if (_loc_2 != -1 && this._currentTargetIsTargetable)
            {
                if (!this._targetSelection)
                {
                    this._targetSelection = new Selection();
                    this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
                    this._targetSelection.color = TARGET_COLOR;
                    this._targetSelection.zone = this.getSpellZone();
                    SelectionManager.getInstance().addSelection(this._targetSelection, SELECTION_TARGET);
                }
                _loc_5 = CurrentPlayedFighterManager.getInstance().currentFighterId;
                _loc_6 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc_5) as GameFightFighterInformations;
                if (_loc_6)
                {
                    this._targetSelection.zone.direction = MapPoint(MapPoint.fromCellId(_loc_6.disposition.cellId)).advancedOrientationTo(MapPoint.fromCellId(_loc_2), false);
                }
                SelectionManager.getInstance().update(SELECTION_TARGET, _loc_2);
                if (_loc_4)
                {
                    LinkedCursorSpriteManager.getInstance().removeItem(FORBIDDEN_CURSOR_NAME);
                    this._lastTargetStatus = true;
                }
                else
                {
                    if (this._lastTargetStatus)
                    {
                        LinkedCursorSpriteManager.getInstance().addItem(FORBIDDEN_CURSOR_NAME, this._cursorData, true);
                    }
                    this._lastTargetStatus = false;
                }
            }
            else
            {
                if (this._lastTargetStatus)
                {
                    LinkedCursorSpriteManager.getInstance().addItem(FORBIDDEN_CURSOR_NAME, this._cursorData, true);
                }
                this.removeTarget();
                this._lastTargetStatus = false;
            }
            return;
        }// end function

        public function drawRange() : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_1:* = CurrentPlayedFighterManager.getInstance().currentFighterId;
            var _loc_2:* = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc_1) as GameFightFighterInformations;
            var _loc_3:* = _loc_2.disposition.cellId;
            var _loc_4:* = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().range;
            var _loc_5:* = this._spellLevel.range;
            if (!this._spellLevel.castInLine && !this._spellLevel.castInDiagonal && !this._spellLevel.castTestLos && _loc_5 == 63)
            {
                this._isInfiniteTarget = true;
                return;
            }
            this._isInfiniteTarget = false;
            if (this._spellLevel["rangeCanBeBoosted"])
            {
                _loc_5 = _loc_5 + (_loc_4.base + _loc_4.objectsAndMountBonus + _loc_4.alignGiftBonus + _loc_4.contextModif);
                if (_loc_5 < this._spellLevel.minRange)
                {
                    _loc_5 = this._spellLevel.minRange;
                }
            }
            _loc_5 = Math.min(_loc_5, AtouinConstants.MAP_WIDTH * AtouinConstants.MAP_HEIGHT);
            if (_loc_5 < 0)
            {
                _loc_5 = 0;
            }
            var _loc_6:* = this._spellLevel.castTestLos && Dofus.getInstance().options.showLineOfSight;
            this._rangeSelection = new Selection();
            this._rangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._rangeSelection.color = _loc_6 ? (RANGE_COLOR) : (LOS_COLOR);
            this._rangeSelection.alpha = true;
            if (this._spellLevel.castInLine && this._spellLevel.castInDiagonal)
            {
                _loc_7 = new Cross(this._spellLevel.minRange, _loc_5, DataMapProvider.getInstance());
                _loc_7.allDirections = true;
                this._rangeSelection.zone = _loc_7;
            }
            else if (this._spellLevel.castInLine)
            {
                this._rangeSelection.zone = new Cross(this._spellLevel.minRange, _loc_5, DataMapProvider.getInstance());
            }
            else if (this._spellLevel.castInDiagonal)
            {
                _loc_7 = new Cross(this._spellLevel.minRange, _loc_5, DataMapProvider.getInstance());
                _loc_7.diagonal = true;
                this._rangeSelection.zone = _loc_7;
            }
            else
            {
                this._rangeSelection.zone = new Lozenge(this._spellLevel.minRange, _loc_5, DataMapProvider.getInstance());
            }
            this._losSelection = null;
            if (_loc_6)
            {
                this.drawLos(_loc_3);
            }
            if (this._losSelection)
            {
                this._rangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA, 0.5);
                _loc_8 = new Vector.<uint>;
                _loc_9 = this._rangeSelection.zone.getCells(_loc_3);
                _loc_10 = _loc_9.length;
                while (_loc_11 < _loc_10)
                {
                    
                    _loc_12 = _loc_9[_loc_11];
                    if (this._losSelection.cells.indexOf(_loc_12) == -1)
                    {
                        _loc_8.push(_loc_12);
                    }
                    _loc_11++;
                }
                this._rangeSelection.zone = new Custom(_loc_8);
            }
            SelectionManager.getInstance().addSelection(this._rangeSelection, SELECTION_RANGE, _loc_3);
            return;
        }// end function

        private function clearTarget() : void
        {
            if (!this._clearTargetTimer.running)
            {
                this._clearTargetTimer.start();
            }
            return;
        }// end function

        private function onClearTarget(event:TimerEvent) : void
        {
            this.refreshTarget();
            return;
        }// end function

        private function castSpell(param1:uint, param2:int = 0) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if (!_loc_3 || !_loc_3.myTurn)
            {
                return;
            }
            if (CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent < this._spellLevel.apCost)
            {
                return;
            }
            if (param2 != 0 && !FightEntitiesFrame.getCurrentInstance().entityIsIllusion(param2))
            {
                CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent - this._spellLevel.apCost;
                _loc_4 = new GameActionFightCastOnTargetRequestMessage();
                _loc_4.initGameActionFightCastOnTargetRequestMessage(this._spellId, param2);
                ConnectionsHandler.getConnection().send(_loc_4);
            }
            else if (this.isValidCell(param1))
            {
                CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent - this._spellLevel.apCost;
                _loc_5 = new GameActionFightCastRequestMessage();
                _loc_5.initGameActionFightCastRequestMessage(this._spellId, param1);
                ConnectionsHandler.getConnection().send(_loc_5);
            }
            this.cancelCast();
            return;
        }// end function

        private function cancelCast(... args) : void
        {
            this._cancelTimer.reset();
            Kernel.getWorker().removeFrame(this);
            return;
        }// end function

        private function drawLos(param1:uint) : void
        {
            this._losSelection = new Selection();
            this._losSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._losSelection.color = LOS_COLOR;
            var _loc_2:* = this._rangeSelection.zone.getCells(param1);
            this._losSelection.zone = new Custom(LosDetector.getCell(DataMapProvider.getInstance(), _loc_2, MapPoint.fromCellId(param1)));
            SelectionManager.getInstance().addSelection(this._losSelection, SELECTION_LOS, param1);
            return;
        }// end function

        private function removeRange() : void
        {
            var _loc_1:* = SelectionManager.getInstance().getSelection(SELECTION_RANGE);
            if (_loc_1)
            {
                _loc_1.remove();
                this._rangeSelection = null;
            }
            var _loc_2:* = SelectionManager.getInstance().getSelection(SELECTION_LOS);
            if (_loc_2)
            {
                _loc_2.remove();
                this._losSelection = null;
            }
            this._isInfiniteTarget = false;
            return;
        }// end function

        private function removeTarget() : void
        {
            var _loc_1:* = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
            if (_loc_1)
            {
                _loc_1.remove();
                this._rangeSelection = null;
            }
            return;
        }// end function

        private function getSpellZone() : IZone
        {
            var _loc_2:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_1:* = 88;
            _loc_2 = 666;
            var _loc_3:* = 0;
            if (!this._spellLevel.hasOwnProperty("shape"))
            {
                for each (_loc_4 in this._spellLevel["effects"])
                {
                    
                    if (_loc_4.zoneShape != 0 && _loc_4.zoneSize > 0)
                    {
                        _loc_2 = _loc_4.zoneSize;
                        _loc_1 = _loc_4.zoneShape;
                        _loc_3 = _loc_4.zoneMinSize;
                    }
                }
            }
            else
            {
                _loc_1 = this._spellLevel.shape;
                _loc_2 = this._spellLevel.ray;
            }
            if (_loc_2 == 666)
            {
                _loc_2 = 0;
            }
            switch(_loc_1)
            {
                case SpellShapeEnum.X:
                {
                    return new Cross(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.L:
                {
                    return new Line(_loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.T:
                {
                    _loc_5 = new Cross(0, _loc_2, DataMapProvider.getInstance());
                    _loc_5.onlyPerpendicular = true;
                    return _loc_5;
                }
                case SpellShapeEnum.D:
                {
                    return new Cross(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.C:
                {
                    return new Lozenge(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.I:
                {
                    return new Lozenge(_loc_2, 63, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.O:
                {
                    return new Lozenge(_loc_2, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.Q:
                {
                    return new Cross(1, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.G:
                {
                    return new Square(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.V:
                {
                    return new Cone(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.W:
                {
                    _loc_6 = new Square(0, _loc_2, DataMapProvider.getInstance());
                    _loc_6.diagonalFree = true;
                    return _loc_6;
                }
                case SpellShapeEnum.plus:
                {
                    _loc_7 = new Cross(0, _loc_2, DataMapProvider.getInstance());
                    _loc_7.diagonal = true;
                    return _loc_7;
                }
                case SpellShapeEnum.sharp:
                {
                    _loc_8 = new Cross(1, _loc_2, DataMapProvider.getInstance());
                    _loc_8.diagonal = true;
                    return _loc_8;
                }
                case SpellShapeEnum.star:
                {
                    _loc_9 = new Cross(0, _loc_2, DataMapProvider.getInstance());
                    _loc_9.allDirections = true;
                    return _loc_9;
                }
                case SpellShapeEnum.slash:
                {
                    return new Line(_loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.minus:
                {
                    _loc_10 = new Cross(0, _loc_2, DataMapProvider.getInstance());
                    _loc_10.onlyPerpendicular = true;
                    _loc_10.diagonal = true;
                    return _loc_10;
                }
                case SpellShapeEnum.U:
                {
                    return new HalfLozenge(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.P:
                {
                }
                default:
                {
                    return new Cross(0, 0, DataMapProvider.getInstance());
                    break;
                }
            }
        }// end function

        private function isValidCell(param1:uint) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            if (this._isInfiniteTarget)
            {
                return true;
            }
            if (this._spellId)
            {
                _loc_2 = this._spellLevel.spellLevelInfos;
                for each (_loc_3 in EntitiesManager.getInstance().getEntitiesOnCell(param1))
                {
                    
                    if (!CurrentPlayedFighterManager.getInstance().canCastThisSpell(this._spellLevel.spellId, this._spellLevel.spellLevel, _loc_3.id))
                    {
                        return false;
                    }
                    _loc_4 = _loc_3 is Glyph;
                    if (_loc_2.needFreeTrapCell && _loc_4 && (_loc_3 as Glyph).glyphType == GameActionMarkTypeEnum.TRAP)
                    {
                        return false;
                    }
                    if (this._spellLevel.needFreeCell && !_loc_4)
                    {
                        return false;
                    }
                }
            }
            if (this._spellLevel.castTestLos && Dofus.getInstance().options.showLineOfSight)
            {
                return SelectionManager.getInstance().isInside(param1, SELECTION_LOS);
            }
            return SelectionManager.getInstance().isInside(param1, SELECTION_RANGE);
        }// end function

        public static function updateRangeAndTarget() : void
        {
            var _loc_1:* = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
            if (_loc_1)
            {
                _loc_1.removeRange();
                _loc_1.drawRange();
                _loc_1.refreshTarget(true);
            }
            return;
        }// end function

    }
}

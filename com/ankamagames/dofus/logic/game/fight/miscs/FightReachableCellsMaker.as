package com.ankamagames.dofus.logic.game.fight.miscs
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class FightReachableCellsMaker extends Object
    {
        private var _cellGrid:Vector.<Vector.<_ReachableCellStore>>;
        private var _reachableCells:Vector.<uint>;
        private var _unreachableCells:Vector.<uint>;
        private var _mapPoint:MapPoint;
        private var _infos:GameFightFighterInformations;
        private var _mp:int;
        private var _waitingCells:Vector.<_ReachableCellStore>;
        private var _watchedCells:Vector.<_ReachableCellStore>;

        public function FightReachableCellsMaker(param1:GameFightFighterInformations, param2:int = -1, param3:int = -1)
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_4:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            this._infos = param1;
            if (param3 != -1)
            {
                this._mp = param3;
            }
            else
            {
                this._mp = this._infos.stats.movementPoints > 0 ? (this._infos.stats.movementPoints) : (0);
            }
            this._mapPoint = MapPoint.fromCellId(param2 != -1 ? (param2) : (this._infos.disposition.cellId));
            this._cellGrid = new Vector.<Vector.<_ReachableCellStore>>(this._mp * 2 + 1);
            for (_loc_5 in this._cellGrid)
            {
                
                this._cellGrid[_loc_5] = new Vector.<_ReachableCellStore>(this._mp * 2 + 1);
            }
            for each (_loc_8 in EntitiesManager.getInstance().entities)
            {
                
                if (_loc_8.id != this._infos.contextualId)
                {
                    _loc_6 = _loc_8.position.x - this._mapPoint.x + this._mp;
                    _loc_7 = _loc_8.position.y - this._mapPoint.y + this._mp;
                    if (_loc_6 >= 0 && _loc_6 < this._mp * 2 + 1 && _loc_7 >= 0 && _loc_7 < this._mp * 2 + 1)
                    {
                        param1 = _loc_4.getEntityInfos(_loc_8.id) as GameFightFighterInformations;
                        if (param1)
                        {
                            _loc_9 = new _ReachableCellStore(_loc_8.position, _loc_6, _loc_7, this._cellGrid);
                            _loc_9.state = _ReachableCellStore.STATE_UNREACHABLE;
                            _loc_10 = TackleUtil.getTackleForFighter(param1, this._infos);
                            if (!_loc_9.evade || _loc_10 < _loc_9.evade)
                            {
                                _loc_9.evade = _loc_10;
                            }
                            this._cellGrid[_loc_6][_loc_7] = _loc_9;
                        }
                    }
                }
            }
            this._reachableCells = new Vector.<uint>;
            this._unreachableCells = new Vector.<uint>;
            this.compute();
            return;
        }// end function

        public function get reachableCells() : Vector.<uint>
        {
            return this._reachableCells;
        }// end function

        public function get unreachableCells() : Vector.<uint>
        {
            return this._unreachableCells;
        }// end function

        private function compute() : void
        {
            var _loc_1:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this._mp;
            var _loc_3:* = this._mp;
            this._waitingCells = new Vector.<_ReachableCellStore>;
            this._watchedCells = new Vector.<_ReachableCellStore>;
            this.markNode(this._mapPoint.x, this._mapPoint.y, _loc_2, _loc_3);
            while (this._waitingCells.length || this._watchedCells.length)
            {
                
                if (this._waitingCells.length)
                {
                    _loc_1 = this._waitingCells;
                    this._waitingCells = new Vector.<_ReachableCellStore>;
                }
                else
                {
                    _loc_1 = this._watchedCells;
                    this._watchedCells = new Vector.<_ReachableCellStore>;
                }
                for each (_loc_4 in _loc_1)
                {
                    
                    _loc_2 = int(_loc_4.bestMp * _loc_4.evade + 0.5) - 1;
                    _loc_3 = _loc_4.bestUntackledMp - 1;
                    if (MapPoint.isInMap((_loc_4.mapPoint.x - 1), _loc_4.mapPoint.y))
                    {
                        this.markNode((_loc_4.mapPoint.x - 1), _loc_4.mapPoint.y, _loc_2, _loc_3);
                    }
                    if (MapPoint.isInMap((_loc_4.mapPoint.x + 1), _loc_4.mapPoint.y))
                    {
                        this.markNode((_loc_4.mapPoint.x + 1), _loc_4.mapPoint.y, _loc_2, _loc_3);
                    }
                    if (MapPoint.isInMap(_loc_4.mapPoint.x, (_loc_4.mapPoint.y - 1)))
                    {
                        this.markNode(_loc_4.mapPoint.x, (_loc_4.mapPoint.y - 1), _loc_2, _loc_3);
                    }
                    if (MapPoint.isInMap(_loc_4.mapPoint.x, (_loc_4.mapPoint.y + 1)))
                    {
                        this.markNode(_loc_4.mapPoint.x, (_loc_4.mapPoint.y + 1), _loc_2, _loc_3);
                    }
                }
            }
            return;
        }// end function

        private function markNode(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_8:* = 0;
            var _loc_5:* = param1 - this._mapPoint.x + this._mp;
            var _loc_6:* = param2 - this._mapPoint.y + this._mp;
            var _loc_7:* = this._cellGrid[_loc_5][_loc_6];
            if (!this._cellGrid[_loc_5][_loc_6])
            {
                _loc_7 = new _ReachableCellStore(MapPoint.fromCoords(param1, param2), _loc_5, _loc_6, this._cellGrid);
                this._cellGrid[_loc_5][_loc_6] = _loc_7;
                _loc_7.findState(this._infos);
                if (_loc_7.state != _ReachableCellStore.STATE_UNREACHABLE)
                {
                    if (param3 >= 0)
                    {
                        this._reachableCells.push(_loc_7.mapPoint.cellId);
                    }
                    else
                    {
                        this._unreachableCells.push(_loc_7.mapPoint.cellId);
                    }
                }
            }
            if (_loc_7.state == _ReachableCellStore.STATE_UNREACHABLE)
            {
                return;
            }
            if (!_loc_7.set || param3 > _loc_7.bestMp || param4 > _loc_7.bestUntackledMp)
            {
                if (param3 >= 0 && _loc_7.bestMp < 0)
                {
                    this._reachableCells.push(_loc_7.mapPoint.cellId);
                    _loc_8 = this._unreachableCells.indexOf(_loc_7.mapPoint.cellId);
                    if (_loc_8 == -1)
                    {
                        throw new Error("INTERNAL ERROR : " + _loc_7.mapPoint.cellId + " : Can\'t delete cell because it don\'t exist");
                    }
                    this._unreachableCells.splice(_loc_8, 1);
                }
                _loc_7.updateMp(param3, param4);
                if (param4 > 0)
                {
                    if (_loc_7.state == _ReachableCellStore.STATE_REACHABLE)
                    {
                        this._waitingCells.push(_loc_7);
                    }
                    else if (_loc_7.state == _ReachableCellStore.STATE_WATCHED)
                    {
                        this._watchedCells.push(_loc_7);
                    }
                }
            }
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import com.ankamagames.atouin.managers.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.logic.game.fight.frames.*;

import com.ankamagames.dofus.network.types.game.context.fight.*;

import com.ankamagames.jerakine.entities.interfaces.*;

import com.ankamagames.jerakine.types.positions.*;

class _ReachableCellStore extends Object
{
    public var mapPoint:MapPoint;
    public var state:int;
    public var evade:Number = 1;
    public var bestMp:int;
    public var bestUntackledMp:int;
    public var set:Boolean;
    public var gridX:int;
    public var gridY:int;
    public var cellGrid:Vector.<Vector.<_ReachableCellStore>>;
    public static const STATE_UNDEFINED:int = 0;
    public static const STATE_REACHABLE:int = 1;
    public static const STATE_UNREACHABLE:int = 2;
    public static const STATE_WATCHED:int = 3;

    function _ReachableCellStore(param1:MapPoint, param2:int, param3:int, param4:Vector.<Vector.<_ReachableCellStore>>)
    {
        this.mapPoint = param1;
        this.gridX = param2;
        this.gridY = param3;
        this.cellGrid = param4;
        return;
    }// end function

    public function findState(param1:GameFightFighterInformations) : void
    {
        var _loc_3:* = null;
        var _loc_2:* = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[this.mapPoint.cellId]);
        if (!_loc_2.mov || _loc_2.nonWalkableDuringFight)
        {
            this.state = STATE_UNREACHABLE;
        }
        else
        {
            this.evade = 1;
            if (this.gridX > 0)
            {
                _loc_3 = this.cellGrid[(this.gridX - 1)][this.gridY];
                if (_loc_3 && _loc_3.state == STATE_UNREACHABLE)
                {
                    this.evade = this.evade * _loc_3.evade;
                }
            }
            if (this.gridX < (this.cellGrid.length - 1))
            {
                _loc_3 = this.cellGrid[(this.gridX + 1)][this.gridY];
                if (_loc_3 && _loc_3.state == STATE_UNREACHABLE)
                {
                    this.evade = this.evade * _loc_3.evade;
                }
            }
            if (this.gridY > 0)
            {
                _loc_3 = this.cellGrid[this.gridX][(this.gridY - 1)];
                if (_loc_3 && _loc_3.state == STATE_UNREACHABLE)
                {
                    this.evade = this.evade * _loc_3.evade;
                }
            }
            if (this.gridY < (this.cellGrid[0].length - 1))
            {
                _loc_3 = this.cellGrid[this.gridX][(this.gridY + 1)];
                if (_loc_3 && _loc_3.state == STATE_UNREACHABLE)
                {
                    this.evade = this.evade * _loc_3.evade;
                }
            }
            this.state = this.evade == 1 ? (STATE_REACHABLE) : (STATE_WATCHED);
        }
        return;
    }// end function

    public function updateMp(param1:int, param2:int) : void
    {
        this.set = true;
        if (param1 > this.bestMp)
        {
            this.bestMp = param1;
        }
        if (param2 > this.bestUntackledMp)
        {
            this.bestUntackledMp = param2;
        }
        return;
    }// end function

}


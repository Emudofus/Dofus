package 
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
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
            var _loc_3:_ReachableCellStore = null;
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
}

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
        var _loc_3:_ReachableCellStore = null;
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


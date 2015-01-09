package com.ankamagames.jerakine.pathfinding
{
    public class CellInfo 
    {

        public var heuristic:Number;
        public var parent:Array;
        public var opened:Boolean;
        public var closed:Boolean;
        public var movementCost:int;

        public function CellInfo(pHeuristic:Number, pParent:Array, pOpened:Boolean, pClosed:Boolean)
        {
            this.heuristic = pHeuristic;
            this.parent = pParent;
            this.opened = pOpened;
            this.closed = pClosed;
        }

    }
}//package com.ankamagames.jerakine.pathfinding


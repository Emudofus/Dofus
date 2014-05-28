package com.ankamagames.jerakine.pathfinding
{
   public class CellInfo extends Object
   {
      
      public function CellInfo(pHeuristic:Number, pParent:Array, pOpened:Boolean, pClosed:Boolean) {
         super();
         this.heuristic = pHeuristic;
         this.parent = pParent;
         this.opened = pOpened;
         this.closed = pClosed;
      }
      
      public var heuristic:Number;
      
      public var parent:Array;
      
      public var opened:Boolean;
      
      public var closed:Boolean;
      
      public var movementCost:int;
   }
}

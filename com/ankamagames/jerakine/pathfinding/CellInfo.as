package com.ankamagames.jerakine.pathfinding
{
   public class CellInfo extends Object
   {
      
      public function CellInfo(param1:Number, param2:Array, param3:Boolean, param4:Boolean)
      {
         super();
         this.heuristic = param1;
         this.parent = param2;
         this.opened = param3;
         this.closed = param4;
      }
      
      public var heuristic:Number;
      
      public var parent:Array;
      
      public var opened:Boolean;
      
      public var closed:Boolean;
      
      public var movementCost:int;
   }
}

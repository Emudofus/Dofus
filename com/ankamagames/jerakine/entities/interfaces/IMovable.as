package com.ankamagames.jerakine.entities.interfaces
{
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public interface IMovable extends IEntity
   {
      
      function get movementBehavior() : IMovementBehavior;
      
      function set movementBehavior(param1:IMovementBehavior) : void;
      
      function get isMoving() : Boolean;
      
      function move(param1:MovementPath, param2:Function = null) : void;
      
      function jump(param1:MapPoint) : void;
      
      function stop(param1:Boolean = false) : void;
   }
}

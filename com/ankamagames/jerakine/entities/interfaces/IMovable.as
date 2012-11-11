package com.ankamagames.jerakine.entities.interfaces
{
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;

    public interface IMovable extends IEntity
    {

        public function IMovable();

        function get movementBehavior() : IMovementBehavior;

        function set movementBehavior(param1:IMovementBehavior) : void;

        function get isMoving() : Boolean;

        function move(param1:MovementPath, param2:Function = null) : void;

        function jump(param1:MapPoint) : void;

        function stop(param1:Boolean = false) : void;

    }
}

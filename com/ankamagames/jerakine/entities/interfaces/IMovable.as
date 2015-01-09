package com.ankamagames.jerakine.entities.interfaces
{
    import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.jerakine.types.positions.MapPoint;

    public interface IMovable extends IEntity 
    {

        function get movementBehavior():IMovementBehavior;
        function set movementBehavior(_arg_1:IMovementBehavior):void;
        function get isMoving():Boolean;
        function move(_arg_1:MovementPath, _arg_2:Function=null, _arg_3:IMovementBehavior=null):void;
        function jump(_arg_1:MapPoint):void;
        function stop(_arg_1:Boolean=false):void;

    }
}//package com.ankamagames.jerakine.entities.interfaces


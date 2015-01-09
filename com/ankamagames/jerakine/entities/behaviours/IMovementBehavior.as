package com.ankamagames.jerakine.entities.behaviours
{
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import flash.display.DisplayObject;

    public interface IMovementBehavior 
    {

        function move(_arg_1:IMovable, _arg_2:MovementPath, _arg_3:Function=null):void;
        function jump(_arg_1:IMovable, _arg_2:MapPoint):void;
        function stop(_arg_1:IMovable, _arg_2:Boolean=false):void;
        function isMoving(_arg_1:IMovable):Boolean;
        function synchroniseSubEntitiesPosition(_arg_1:IMovable, _arg_2:DisplayObject=null):void;

    }
}//package com.ankamagames.jerakine.entities.behaviours


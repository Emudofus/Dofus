package com.ankamagames.dofus.logic.game.common.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.positions.PathElement;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import __AS3__.vec.*;

    public class MapMovementAdapter 
    {

        private static const DEBUG_ADAPTER:Boolean = false;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapMovementAdapter));


        public static function getServerMovement(path:MovementPath):Vector.<uint>
        {
            var pe:PathElement;
            var lastValue:int;
            var value:int;
            var movStr:String;
            var movCell:uint;
            path.compress();
            var movement:Vector.<uint> = new Vector.<uint>();
            var lastOrientation:uint;
            var moveCount:uint;
            for each (pe in path.path)
            {
                lastOrientation = pe.orientation;
                value = (((lastOrientation & 7) << 12) | (pe.step.cellId & 4095));
                movement.push(value);
                moveCount++;
            };
            lastValue = (((lastOrientation & 7) << 12) | (path.end.cellId & 4095));
            movement.push(lastValue);
            if (DEBUG_ADAPTER)
            {
                movStr = "";
                for each (movCell in movement)
                {
                    movStr = (movStr + ((movCell & 4095) + " > "));
                };
                _log.debug(("Sending path : " + movStr));
            };
            return (movement);
        }

        public static function getClientMovement(path:Vector.<uint>):MovementPath
        {
            var previousElement:PathElement;
            var movement:int;
            var destination:MapPoint;
            var pe:PathElement;
            var movStr:String;
            var movElement:PathElement;
            var mp:MovementPath = new MovementPath();
            var moveCount:uint;
            for each (movement in path)
            {
                destination = MapPoint.fromCellId((movement & 4095));
                pe = new PathElement();
                pe.step = destination;
                if (moveCount == 0)
                {
                    mp.start = destination;
                }
                else
                {
                    previousElement.orientation = previousElement.step.orientationTo(pe.step);
                };
                if (moveCount == (path.length - 1))
                {
                    mp.end = destination;
                    break;
                };
                mp.addPoint(pe);
                previousElement = pe;
                moveCount++;
            };
            mp.fill();
            if (DEBUG_ADAPTER)
            {
                movStr = (("Start : " + mp.start.cellId) + " | ");
                for each (movElement in mp.path)
                {
                    movStr = (movStr + (movElement.step.cellId + " > "));
                };
                _log.debug(((("Received path : " + movStr) + " | End : ") + mp.end.cellId));
            };
            return (mp);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.managers


package com.ankamagames.dofus.logic.game.common.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.utils.*;

    public class MapMovementAdapter extends Object
    {
        private static const DEBUG_ADAPTER:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MapMovementAdapter));

        public function MapMovementAdapter()
        {
            return;
        }// end function

        public static function getServerMovement(param1:MovementPath) : Vector.<uint>
        {
            var _loc_5:PathElement = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:String = null;
            var _loc_9:uint = 0;
            param1.compress();
            var _loc_2:* = new Vector.<uint>;
            var _loc_3:uint = 0;
            var _loc_4:uint = 0;
            for each (_loc_5 in param1.path)
            {
                
                _loc_3 = _loc_5.orientation;
                _loc_7 = (_loc_3 & 7) << 12 | _loc_5.step.cellId & 4095;
                _loc_2.push(_loc_7);
                _loc_4 = _loc_4 + 1;
            }
            _loc_6 = (_loc_3 & 7) << 12 | param1.end.cellId & 4095;
            _loc_2.push(_loc_6);
            if (DEBUG_ADAPTER)
            {
                _loc_8 = "";
                for each (_loc_9 in _loc_2)
                {
                    
                    _loc_8 = _loc_8 + ((_loc_9 & 4095) + " > ");
                }
                _log.debug("Sending path : " + _loc_8);
            }
            return _loc_2;
        }// end function

        public static function getClientMovement(param1:Vector.<uint>) : MovementPath
        {
            var _loc_4:PathElement = null;
            var _loc_5:int = 0;
            var _loc_6:MapPoint = null;
            var _loc_7:PathElement = null;
            var _loc_8:String = null;
            var _loc_9:PathElement = null;
            var _loc_2:* = new MovementPath();
            var _loc_3:uint = 0;
            for each (_loc_5 in param1)
            {
                
                _loc_6 = MapPoint.fromCellId(_loc_5 & 4095);
                _loc_7 = new PathElement();
                _loc_7.step = _loc_6;
                if (_loc_3 == 0)
                {
                    _loc_2.start = _loc_6;
                }
                else
                {
                    _loc_4.orientation = _loc_4.step.orientationTo(_loc_7.step);
                }
                if (_loc_3 == (param1.length - 1))
                {
                    _loc_2.end = _loc_6;
                    break;
                }
                _loc_2.addPoint(_loc_7);
                _loc_4 = _loc_7;
                _loc_3 = _loc_3 + 1;
            }
            _loc_2.fill();
            if (DEBUG_ADAPTER)
            {
                _loc_8 = "Start : " + _loc_2.start.cellId + " | ";
                for each (_loc_9 in _loc_2.path)
                {
                    
                    _loc_8 = _loc_8 + (_loc_9.step.cellId + " > ");
                }
                _log.debug("Received path : " + _loc_8 + " | End : " + _loc_2.end.cellId);
            }
            return _loc_2;
        }// end function

    }
}

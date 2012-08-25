package com.ankamagames.dofus.internalDatacenter.taxi
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.jerakine.interfaces.*;
    import flash.utils.*;

    public class TeleportDestinationWrapper extends Object implements IDataCenter
    {
        public var teleporterType:uint;
        public var mapId:uint;
        public var subArea:SubArea;
        public var cost:uint;
        public var spawn:Boolean;
        public var name:String;
        public var hintName:String;
        public var coord:String;
        public var hintMapId:uint;
        public var category:int;
        private static var _hints:Dictionary;
        private static var _hintsRealMap:Dictionary;

        public function TeleportDestinationWrapper(param1:uint, param2:uint, param3:uint, param4:uint, param5:Boolean = false, param6:Hint = null)
        {
            this.teleporterType = param1;
            this.mapId = param2;
            this.subArea = SubArea.getSubAreaById(param3);
            this.cost = param4;
            this.spawn = param5;
            if (param1 == 1)
            {
                if (param6)
                {
                    this.category = param6.categoryId;
                    this.name = param6.name;
                }
                else
                {
                    this.category = -1;
                }
            }
            else
            {
                this.name = Area.getAreaById(this.subArea.areaId).name + " (" + this.subArea.name + ")";
            }
            var _loc_7:* = new WorldPointWrapper(param2);
            this.coord = _loc_7.outdoorX + "," + _loc_7.outdoorY;
            return;
        }// end function

        public static function getHintsFromMapId(param1:uint) : Vector.<Hint>
        {
            var _loc_2:Vector.<Hint> = null;
            generateHintsDictionary();
            if (_hintsRealMap.hasOwnProperty(param1))
            {
                _loc_2 = _hintsRealMap[param1];
            }
            else
            {
                _loc_2 = new Vector.<Hint>;
            }
            if (_hints.hasOwnProperty(param1))
            {
                return _loc_2.concat(_hints[param1]);
            }
            return _loc_2;
        }// end function

        private static function generateHintsDictionary() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Hint = null;
            if (!_hints)
            {
                _loc_1 = Hint.getHints();
                _hints = new Dictionary();
                _hintsRealMap = new Dictionary();
                for each (_loc_2 in _loc_1)
                {
                    
                    if (_hints.hasOwnProperty(_loc_2.mapId))
                    {
                        _hints[_loc_2.mapId].push(_loc_2);
                    }
                    else
                    {
                        _hints[_loc_2.mapId] = new Vector.<Hint>;
                        _hints[_loc_2.mapId].push(_loc_2);
                    }
                    if (_hintsRealMap.hasOwnProperty(_loc_2.realMapId))
                    {
                        _hintsRealMap[_loc_2.realMapId].push(_loc_2);
                        continue;
                    }
                    _hintsRealMap[_loc_2.realMapId] = new Vector.<Hint>;
                    _hintsRealMap[_loc_2.realMapId].push(_loc_2);
                }
            }
            return;
        }// end function

    }
}

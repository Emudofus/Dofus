package com.ankamagames.atouin.utils
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class DataMapProvider extends Object implements IDataMapProvider
    {
        public var isInFight:Boolean;
        private var _updatedCell:Dictionary;
        private var _specialEffects:Dictionary;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(DataMapProvider));
        private static var _self:DataMapProvider;
        private static var _playerClass:Class;

        public function DataMapProvider()
        {
            this._updatedCell = new Dictionary();
            this._specialEffects = new Dictionary();
            return;
        }// end function

        public function pointLos(param1:int, param2:int, param3:Boolean = true) : Boolean
        {
            var _loc_6:Array = null;
            var _loc_7:IObstacle = null;
            var _loc_4:* = MapPoint.fromCoords(param1, param2).cellId;
            var _loc_5:* = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[_loc_4]).los;
            if (this._updatedCell[_loc_4] != null)
            {
                _loc_5 = this._updatedCell[_loc_4];
            }
            if (!param3)
            {
                _loc_6 = EntitiesManager.getInstance().getEntitiesOnCell(_loc_4, IObstacle);
                if (_loc_6.length)
                {
                    for each (_loc_7 in _loc_6)
                    {
                        
                        if (!IObstacle(_loc_7).canSeeThrough())
                        {
                            return false;
                        }
                    }
                }
            }
            return _loc_5;
        }// end function

        public function farmCell(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = MapPoint.fromCoords(param1, param2).cellId;
            return CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[_loc_3]).farmCell;
        }// end function

        public function pointMov(param1:int, param2:int, param3:Boolean = true) : Boolean
        {
            var _loc_4:uint = 0;
            var _loc_5:CellData = null;
            var _loc_6:Boolean = false;
            var _loc_7:Array = null;
            var _loc_8:IObstacle = null;
            if (param2 <= param1 && param2 + param1 >= 0 && param1 - param2 < 2 * AtouinConstants.MAP_HEIGHT && param1 + param2 < 2 * AtouinConstants.MAP_WIDTH)
            {
                _loc_4 = MapPoint.fromCoords(param1, param2).cellId;
                _loc_5 = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[_loc_4]);
                _loc_6 = _loc_5.mov && (!this.isInFight || !_loc_5.nonWalkableDuringFight);
                if (this._updatedCell[_loc_4] != null)
                {
                    _loc_6 = this._updatedCell[_loc_4];
                }
                if (!param3)
                {
                    _loc_7 = EntitiesManager.getInstance().getEntitiesOnCell(_loc_4, IObstacle);
                    if (_loc_7.length)
                    {
                        for each (_loc_8 in _loc_7)
                        {
                            
                            if (!IObstacle(_loc_8).canSeeThrough())
                            {
                                return false;
                            }
                        }
                    }
                }
            }
            else
            {
                _loc_6 = false;
            }
            return _loc_6;
        }// end function

        public function pointCanStop(param1:int, param2:int, param3:Boolean = true) : Boolean
        {
            var _loc_4:* = MapPoint.fromCoords(param1, param2).cellId;
            var _loc_5:* = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[_loc_4]);
            return this.pointMov(param1, param2, param3) && (this.isInFight || !_loc_5.nonWalkableDuringRP);
        }// end function

        public function pointWeight(param1:int, param2:int, param3:Boolean = true) : Number
        {
            var _loc_4:Number = 1;
            var _loc_5:* = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[MapPoint.fromCoords(param1, param2).cellId]).speed;
            if (param3)
            {
                if (_loc_5 >= 0)
                {
                    _loc_4 = _loc_4 + (5 - _loc_5);
                }
                else
                {
                    _loc_4 = _loc_4 + (11 + Math.abs(_loc_5));
                }
                if (EntitiesManager.getInstance().getEntityOnCell(Cell.cellIdByXY(param1, param2), _playerClass) != null)
                {
                    _loc_4 = 20;
                }
            }
            else
            {
                if (EntitiesManager.getInstance().getEntityOnCell(Cell.cellIdByXY(param1, param2), _playerClass) != null)
                {
                    _loc_4 = _loc_4 + 0.3;
                }
                if (EntitiesManager.getInstance().getEntityOnCell(Cell.cellIdByXY((param1 + 1), param2), _playerClass) != null)
                {
                    _loc_4 = _loc_4 + 0.3;
                }
                if (EntitiesManager.getInstance().getEntityOnCell(Cell.cellIdByXY(param1, (param2 + 1)), _playerClass) != null)
                {
                    _loc_4 = _loc_4 + 0.3;
                }
                if (EntitiesManager.getInstance().getEntityOnCell(Cell.cellIdByXY((param1 - 1), param2), _playerClass) != null)
                {
                    _loc_4 = _loc_4 + 0.3;
                }
                if (EntitiesManager.getInstance().getEntityOnCell(Cell.cellIdByXY(param1, (param2 - 1)), _playerClass) != null)
                {
                    _loc_4 = _loc_4 + 0.3;
                }
                if ((this.pointSpecialEffects(param1, param2) & 2) == 2)
                {
                    _loc_4 = _loc_4 + 0.2;
                }
            }
            return _loc_4;
        }// end function

        public function pointSpecialEffects(param1:int, param2:int) : uint
        {
            var _loc_3:* = MapPoint.fromCoords(param1, param2).cellId;
            if (this._specialEffects[_loc_3])
            {
                return this._specialEffects[_loc_3];
            }
            return 0;
        }// end function

        public function get width() : int
        {
            return AtouinConstants.MAP_HEIGHT + AtouinConstants.MAP_WIDTH - 2;
        }// end function

        public function get height() : int
        {
            return AtouinConstants.MAP_HEIGHT + AtouinConstants.MAP_WIDTH - 1;
        }// end function

        public function hasEntity(param1:int, param2:int) : Boolean
        {
            var _loc_4:IObstacle = null;
            var _loc_3:* = EntitiesManager.getInstance().getEntitiesOnCell(MapPoint.fromCoords(param1, param2).cellId, IObstacle);
            if (_loc_3.length)
            {
                for each (_loc_4 in _loc_3)
                {
                    
                    if (!IObstacle(_loc_4).canSeeThrough())
                    {
                        return true;
                    }
                }
            }
            return false;
        }// end function

        public function updateCellMovLov(param1:uint, param2:Boolean) : void
        {
            this._updatedCell[param1] = param2;
            return;
        }// end function

        public function resetUpdatedCell() : void
        {
            this._updatedCell = new Dictionary();
            return;
        }// end function

        public function setSpecialEffects(param1:uint, param2:uint) : void
        {
            this._specialEffects[param1] = param2;
            return;
        }// end function

        public function resetSpecialEffects() : void
        {
            this._specialEffects = new Dictionary();
            return;
        }// end function

        public static function getInstance() : DataMapProvider
        {
            if (!_self)
            {
                throw new SingletonError("Init function wasn\'t call");
            }
            return _self;
        }// end function

        public static function init(param1:Class) : void
        {
            _playerClass = param1;
            if (!_self)
            {
                _self = new DataMapProvider;
            }
            return;
        }// end function

    }
}

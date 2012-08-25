package com.ankamagames.dofus.logic.game.fight.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.system.*;

    public class TacticModeManager extends Object
    {
        private var _tacticReachableRangeSelection:Selection;
        private var _tacticUnreachableRangeSelection:Selection;
        private var _tacticOtherSelection:Selection;
        private var _debugSelection:Selection;
        private var _debugCellId:uint;
        private var _debugMode:Boolean = false;
        private var _debugCache:Boolean = true;
        private var _dmp:DataMapProvider;
        private var _cellsRef:Array;
        private var _cellsData:Array;
        private var _cellZones:Vector.<int>;
        private var _currentNbZone:int = 0;
        private var _zones:Array;
        private var _tacticModeActivated:Boolean = false;
        private var _currentMapId:uint;
        private var _nbMov:int;
        private var _nbLos:int;
        private var _reachablePath:Vector.<uint>;
        private var _unreachablePath:Vector.<uint>;
        private var _otherPath:Vector.<uint>;
        private var _background:Sprite;
        private static var SWF_LIB:String = XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets_tacticmod.swf");
        private static var TILES_REACHABLE:Array = ["Dalle01"];
        private static var TILES_NO_MVT:Array = ["BlocageMvt"];
        private static var TILES_NO_VIEW:Array = ["BlocageLDV"];
        private static var SHOW_BLOC_MOVE:Boolean = false;
        private static var SHOW_BACKGROUND:Boolean = false;
        private static var _self:TacticModeManager;

        public function TacticModeManager(param1:PrivateClass)
        {
            this._dmp = DataMapProvider.getInstance();
            return;
        }// end function

        public function show(param1:WorldPointWrapper, param2:Boolean = false) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:CellData = null;
            var _loc_6:CellReference = null;
            var _loc_7:int = 0;
            var _loc_8:MapPoint = null;
            var _loc_9:DisplayObjectContainer = null;
            var _loc_10:Boolean = false;
            var _loc_11:Boolean = false;
            var _loc_12:Boolean = false;
            var _loc_13:Array = null;
            var _loc_14:Object = null;
            var _loc_15:Point = null;
            var _loc_16:int = 0;
            var _loc_17:int = 0;
            var _loc_18:int = 0;
            var _loc_19:int = 0;
            var _loc_20:Object = null;
            if (!param2 && this._debugMode)
            {
                this._debugMode = false;
            }
            if (this._tacticModeActivated)
            {
                return;
            }
            this._tacticModeActivated = true;
            KernelEventsManager.getInstance().processCallback(HookList.ShowTacticMode, true);
            if (this._debugMode && this._debugCache || !this._debugMode && this._currentMapId && this._currentMapId == param1.mapId && this._cellsRef.length > 0)
            {
                if (this._cellsRef == null || this._cellsRef[0] == null)
                {
                    this._cellsRef = MapDisplayManager.getInstance().getDataMapContainer().getCell();
                    this._cellsData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells;
                }
                _loc_4 = this._cellsRef.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_4)
                {
                    
                    if (this._cellsRef[_loc_3] != null)
                    {
                        this._cellsRef[_loc_3].visible = true;
                        this._cellsRef[_loc_3].visible = false;
                        if (this._cellsData[_loc_3].floor != 0)
                        {
                            _loc_9 = InteractiveCellManager.getInstance().getCell(this._cellsRef[_loc_3].id);
                            _loc_9.y = this._cellsRef[_loc_3].elevation + this._cellsData[_loc_3].floor;
                            this.updateEntitiesOnCell(_loc_3);
                        }
                    }
                    _loc_3 = _loc_3 + 1;
                }
                SelectionManager.getInstance().addSelection(this._tacticReachableRangeSelection, "tacticReachableRange", 0);
                SelectionManager.getInstance().addSelection(this._tacticUnreachableRangeSelection, "tacticUnreachableRange", 0);
                if (SHOW_BLOC_MOVE && this._nbMov > this._nbLos)
                {
                    SelectionManager.getInstance().addSelection(this._tacticOtherSelection, "tacticOtherRange", 0);
                }
                if (this._debugMode && this._debugSelection)
                {
                    SelectionManager.getInstance().addSelection(this._debugSelection, "debugSelection", this._debugCellId);
                }
            }
            else
            {
                this._currentMapId = param1.mapId;
                this._reachablePath = new Vector.<uint>;
                this._unreachablePath = new Vector.<uint>;
                this._otherPath = new Vector.<uint>;
                this._cellsRef = MapDisplayManager.getInstance().getDataMapContainer().getCell();
                this._cellsData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells;
                _loc_4 = this._cellsRef.length;
                this._cellZones = new Vector.<int>(_loc_4);
                this._currentNbZone = 0;
                this._nbMov = 0;
                this._nbLos = 0;
                _loc_3 = 0;
                while (_loc_3 < _loc_4)
                {
                    
                    _loc_6 = this._cellsRef[_loc_3];
                    _loc_5 = this._cellsData[_loc_3];
                    _loc_6.visible = true;
                    _loc_6.visible = false;
                    if (_loc_6.isDisabled)
                    {
                    }
                    else
                    {
                        _loc_7 = this.getCellZone(_loc_3);
                        _loc_8 = MapPoint.fromCellId(_loc_3);
                        _loc_10 = this._dmp.pointMov(_loc_8.x, _loc_8.y) && !this._dmp.farmCell(_loc_8.x, _loc_8.y);
                        _loc_11 = this._dmp.pointLos(_loc_8.x, _loc_8.y);
                        _loc_12 = _loc_5.nonWalkableDuringFight;
                        if (_loc_5.floor != 0)
                        {
                            _loc_9 = InteractiveCellManager.getInstance().getCell(_loc_6.id);
                            _loc_9.y = _loc_6.elevation + _loc_5.floor;
                            this.updateEntitiesOnCell(_loc_3);
                        }
                        if (_loc_10 && !_loc_12)
                        {
                            if (_loc_7 > 0)
                            {
                                this._cellZones[_loc_3] = _loc_7;
                            }
                            else
                            {
                                var _loc_21:String = this;
                                var _loc_22:* = this._currentNbZone + 1;
                                _loc_21._currentNbZone = _loc_22;
                                this._cellZones[_loc_3] = this._currentNbZone;
                            }
                        }
                        else if (!_loc_10 && _loc_11)
                        {
                            this._cellZones[_loc_3] = 0;
                        }
                        else if (!_loc_10 && !_loc_11 || _loc_12)
                        {
                            this._cellZones[_loc_3] = -1;
                        }
                    }
                    _loc_3 = _loc_3 + 1;
                }
                this.updateCellWithRealCellZone();
                _loc_13 = new Array();
                this._zones = new Array();
                _loc_3 = 0;
                while (_loc_3 < _loc_4)
                {
                    
                    switch(this._cellZones[_loc_3])
                    {
                        case -1:
                        {
                            this._unreachablePath.push(_loc_3);
                            break;
                        }
                        case 0:
                        {
                            if (SHOW_BLOC_MOVE && this.getInformations(_loc_3)[0])
                            {
                                this._otherPath.push(_loc_3);
                                var _loc_21:String = this;
                                var _loc_22:* = this._nbLos + 1;
                                _loc_21._nbLos = _loc_22;
                            }
                            break;
                        }
                        default:
                        {
                            if (_loc_13.indexOf(this._cellZones[_loc_3]) == -1)
                            {
                                _loc_13.push(this._cellZones[_loc_3]);
                            }
                            _loc_15 = CellIdConverter.cellIdToCoord(_loc_3);
                            if (this._zones[this._cellZones[_loc_3]] == null)
                            {
                                _loc_14 = new Object();
                                _loc_14.map = new Vector.<int>;
                                _loc_14.maxX = _loc_15.x;
                                _loc_14.minX = _loc_15.x;
                                _loc_14.maxY = _loc_15.y;
                                _loc_14.minY = _loc_15.y;
                                this._zones[this._cellZones[_loc_3]] = _loc_14;
                            }
                            else
                            {
                                _loc_14 = this._zones[this._cellZones[_loc_3]];
                                if (_loc_15.x > _loc_14.maxX)
                                {
                                    _loc_14.maxX = _loc_15.x;
                                }
                                if (_loc_15.x < _loc_14.minX)
                                {
                                    _loc_14.minX = _loc_15.x;
                                }
                                if (_loc_15.y > _loc_14.maxY)
                                {
                                    _loc_14.maxY = _loc_15.y;
                                }
                                if (_loc_15.y < _loc_14.minY)
                                {
                                    _loc_14.minY = _loc_15.y;
                                }
                            }
                            this._zones[this._cellZones[_loc_3]].map.push(_loc_3);
                            if (this._reachablePath.indexOf(_loc_3) == -1)
                            {
                                this._reachablePath.push(_loc_3);
                            }
                            var _loc_21:String = this;
                            var _loc_22:* = this._nbMov + 1;
                            _loc_21._nbMov = _loc_22;
                            break;
                            break;
                        }
                    }
                    _loc_3 = _loc_3 + 1;
                }
                this._currentNbZone = _loc_13.length;
                _loc_13 = null;
                for each (_loc_20 in this._zones)
                {
                    
                    if (!_loc_18)
                    {
                        _loc_18 = _loc_20.maxX;
                    }
                    else
                    {
                        _loc_18 = Math.max(_loc_18, _loc_20.maxX);
                    }
                    if (!_loc_17)
                    {
                        _loc_19 = _loc_20.minX;
                    }
                    else
                    {
                        _loc_19 = Math.min(_loc_19, _loc_20.minX);
                    }
                    if (!_loc_16)
                    {
                        _loc_16 = _loc_20.maxY;
                    }
                    else
                    {
                        _loc_16 = Math.max(_loc_16, _loc_20.maxY);
                    }
                    if (!_loc_17)
                    {
                        _loc_17 = _loc_20.minY;
                        continue;
                    }
                    _loc_17 = Math.min(_loc_17, _loc_20.minY);
                }
                this.clearUnneededCells(_loc_18, _loc_16, _loc_19, _loc_17);
                this._tacticReachableRangeSelection = new Selection();
                this._tacticReachableRangeSelection.renderer = new ZoneClipRenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER, SWF_LIB, TILES_REACHABLE, TILES_REACHABLE.length > 1 ? (this._currentMapId) : (-1), SHOW_BLOC_MOVE);
                this._tacticReachableRangeSelection.zone = new Custom(this._reachablePath);
                SelectionManager.getInstance().addSelection(this._tacticReachableRangeSelection, "tacticReachableRange", 0);
                this._tacticUnreachableRangeSelection = new Selection();
                this._tacticUnreachableRangeSelection.renderer = new ZoneClipRenderer(PlacementStrataEnums.STRATA_AREA, SWF_LIB, TILES_NO_VIEW, TILES_NO_VIEW.length > 1 ? (this._currentMapId) : (-1), SHOW_BLOC_MOVE);
                this._tacticUnreachableRangeSelection.zone = new Custom(this._unreachablePath);
                SelectionManager.getInstance().addSelection(this._tacticUnreachableRangeSelection, "tacticUnreachableRange", 0);
                if (this._nbMov > this._nbLos && SHOW_BLOC_MOVE)
                {
                    this._tacticOtherSelection = new Selection();
                    this._tacticOtherSelection.renderer = new ZoneClipRenderer(PlacementStrataEnums.STRATA_AREA, SWF_LIB, TILES_NO_MVT, TILES_NO_MVT.length > 1 ? (this._currentMapId) : (-1), SHOW_BLOC_MOVE);
                    this._tacticOtherSelection.zone = new Custom(this._otherPath);
                    SelectionManager.getInstance().addSelection(this._tacticOtherSelection, "tacticOtherRange", 0);
                }
                if (this._debugMode && this._debugSelection)
                {
                    SelectionManager.getInstance().addSelection(this._debugSelection, "debugSelection", this._debugCellId);
                }
            }
            MapDisplayManager.getInstance().hideBackgroundForTacticMode(true);
            if (SHOW_BACKGROUND)
            {
                this.loadBackground();
            }
            return;
        }// end function

        public function hide(param1:Boolean = false) : void
        {
            var _loc_2:Selection = null;
            var _loc_3:CellReference = null;
            var _loc_4:CellData = null;
            var _loc_5:int = 0;
            var _loc_7:DisplayObjectContainer = null;
            if (!this._tacticModeActivated)
            {
                return;
            }
            this._tacticModeActivated = false;
            if (!param1)
            {
                KernelEventsManager.getInstance().processCallback(HookList.ShowTacticMode, false);
            }
            if (SHOW_BACKGROUND)
            {
                this.removeBackground();
            }
            _loc_2 = SelectionManager.getInstance().getSelection("tacticReachableRange");
            if (_loc_2)
            {
                _loc_2.remove();
            }
            _loc_2 = SelectionManager.getInstance().getSelection("tacticUnreachableRange");
            if (_loc_2)
            {
                _loc_2.remove();
            }
            if (SHOW_BLOC_MOVE)
            {
                _loc_2 = SelectionManager.getInstance().getSelection("tacticOtherRange");
                if (_loc_2)
                {
                    _loc_2.remove();
                }
            }
            if (this._debugSelection != null)
            {
                _loc_2 = SelectionManager.getInstance().getSelection("debugSelection");
                if (_loc_2)
                {
                    _loc_2.remove();
                }
            }
            var _loc_6:* = this._cellsRef.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_6)
            {
                
                _loc_3 = this._cellsRef[_loc_5];
                if (_loc_3)
                {
                    _loc_4 = this._cellsData[_loc_5];
                    if (_loc_3)
                    {
                        _loc_3.visible = true;
                    }
                    if (_loc_4.floor != 0)
                    {
                        _loc_7 = InteractiveCellManager.getInstance().getCell(_loc_3.id);
                        _loc_7.y = _loc_3.elevation;
                        this.updateEntitiesOnCell(_loc_5);
                    }
                }
                _loc_5++;
            }
            MapDisplayManager.getInstance().hideBackgroundForTacticMode(false);
            return;
        }// end function

        private function updateEntitiesOnCell(param1:uint) : void
        {
            var _loc_3:AnimatedCharacter = null;
            var _loc_4:IEntity = null;
            var _loc_2:* = EntitiesManager.getInstance().getEntitiesOnCell(param1);
            for each (_loc_4 in _loc_2)
            {
                
                _loc_3 = DofusEntities.getEntity(_loc_4.id) as AnimatedCharacter;
                if (_loc_3)
                {
                    _loc_3.jump(_loc_3.position);
                }
            }
            return;
        }// end function

        private function clearUnneededCells(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_10:uint = 0;
            var _loc_12:int = 0;
            var _loc_14:Array = null;
            var _loc_5:* = param1 - param3;
            var _loc_6:* = Math.abs(param4) + Math.abs(param2);
            var _loc_7:* = CellIdConverter.coordToCellId(_loc_5 / 2 + param3, _loc_6 / 2 + param4);
            var _loc_8:* = new ZRectangle(0, _loc_5 / 2, _loc_6 / 2, null);
            var _loc_9:* = new ZRectangle(0, _loc_5 / 2, _loc_6 / 2, null).getCells(_loc_7);
            if (this._debugMode)
            {
                this._debugSelection = new Selection();
                this._debugSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
                this._debugSelection.color = new Color(16772608);
                this._debugSelection.zone = _loc_8;
                this._debugCellId = _loc_7;
            }
            var _loc_11:* = this._unreachablePath.concat();
            var _loc_13:* = this._unreachablePath.concat().length;
            _loc_12 = 0;
            while (_loc_12 < _loc_13)
            {
                
                _loc_10 = _loc_11[_loc_12];
                _loc_14 = this.getInformations(_loc_10);
                if (_loc_14[1] || _loc_9.indexOf(_loc_10) == -1 && !_loc_14[0])
                {
                    this._unreachablePath.splice(this._unreachablePath.indexOf(_loc_10), 1);
                }
                _loc_12 = _loc_12 + 1;
            }
            _loc_11 = null;
            return;
        }// end function

        private function updateCellWithRealCellZone() : void
        {
            var _loc_1:int = 0;
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = false;
            var _loc_4:Boolean = false;
            var _loc_5:Vector.<int> = null;
            var _loc_6:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_7:* = this._cellZones.length;
            var _loc_8:* = new Array();
            _loc_6 = 0;
            while (_loc_6 < _loc_7)
            {
                
                _loc_1 = this._cellZones[_loc_6];
                if (_loc_1 <= 0)
                {
                }
                else
                {
                    _loc_2 = CellUtil.isLeftCol(_loc_6);
                    _loc_3 = CellUtil.isRightCol(_loc_6);
                    _loc_4 = CellUtil.isEvenRow(_loc_6);
                    _loc_5 = new Vector.<int>;
                    if (_loc_6 - 28 > 0 && this._cellZones[_loc_6 - 28] > 0)
                    {
                        _loc_5.push(this._cellZones[_loc_6 - 28]);
                    }
                    if (!_loc_3 && (_loc_6 + 1) < this._cellZones.length && this._cellZones[(_loc_6 + 1)] > 0)
                    {
                        _loc_5.push(this._cellZones[(_loc_6 + 1)]);
                    }
                    if (_loc_6 + 28 < this._cellZones.length && this._cellZones[_loc_6 + 28] > 0)
                    {
                        _loc_5.push(this._cellZones[_loc_6 + 28]);
                    }
                    if (!_loc_2 && (_loc_6 - 1) > 0 && this._cellZones[(_loc_6 - 1)] > 0)
                    {
                        _loc_5.push(this._cellZones[(_loc_6 - 1)]);
                    }
                    if ((!_loc_2 || _loc_2 && !_loc_4) && _loc_6 + 14 < this._cellZones.length && this._cellZones[_loc_6 + 14] > 0)
                    {
                        _loc_5.push(this._cellZones[_loc_6 + 14]);
                    }
                    if ((!_loc_2 || _loc_2 && !_loc_4) && _loc_6 - 14 > 0 && this._cellZones[_loc_6 - 14] > 0)
                    {
                        _loc_5.push(this._cellZones[_loc_6 - 14]);
                    }
                    if (_loc_4)
                    {
                        if (!_loc_2 && _loc_6 + 13 < this._cellZones.length && this._cellZones[_loc_6 + 13] > 0)
                        {
                            _loc_5.push(this._cellZones[_loc_6 + 13]);
                        }
                        if (!_loc_2 && _loc_6 - 15 > 0 && this._cellZones[_loc_6 - 15] > 0)
                        {
                            _loc_5.push(this._cellZones[_loc_6 - 15]);
                        }
                    }
                    else
                    {
                        if (!_loc_3 && _loc_6 - 13 > 0 && this._cellZones[_loc_6 - 13] > 0)
                        {
                            _loc_5.push(this._cellZones[_loc_6 - 13]);
                        }
                        if (!_loc_3 && _loc_6 + 15 < this._cellZones.length && this._cellZones[_loc_6 + 15] > 0)
                        {
                            _loc_5.push(this._cellZones[_loc_6 + 15]);
                        }
                    }
                    if (_loc_5.length > 0)
                    {
                        _loc_10 = _loc_5.length;
                        _loc_9 = 0;
                        while (_loc_9 < _loc_10)
                        {
                            
                            if (_loc_1 != _loc_5[_loc_9] && !this.containZone(_loc_8, _loc_1, _loc_5[_loc_9]))
                            {
                                _loc_8.push({z1:_loc_1, z2:_loc_5[_loc_9]});
                            }
                            if (_loc_5[_loc_9] < _loc_1)
                            {
                                _loc_1 = _loc_5[_loc_9];
                            }
                            _loc_9 = _loc_9 + 1;
                        }
                        if (_loc_1 > 0)
                        {
                            this._cellZones[_loc_6] = _loc_1;
                            if (_loc_6 - 28 > 0 && this._cellZones[_loc_6 - 28] > 0)
                            {
                                this._cellZones[_loc_6 - 28] = _loc_1;
                            }
                            if (_loc_6 - 13 > 0 && this._cellZones[_loc_6 - 13] > 0)
                            {
                                this._cellZones[_loc_6 - 13] = _loc_1;
                            }
                            if ((_loc_6 + 1) < this._cellZones.length && this._cellZones[(_loc_6 + 1)] > 0)
                            {
                                this._cellZones[(_loc_6 + 1)] = _loc_1;
                            }
                            if (_loc_6 + 15 < this._cellZones.length && this._cellZones[_loc_6 + 15] > 0)
                            {
                                this._cellZones[_loc_6 + 15] = _loc_1;
                            }
                            if (_loc_6 + 28 < this._cellZones.length && this._cellZones[_loc_6 + 28] > 0)
                            {
                                this._cellZones[_loc_6 + 28] = _loc_1;
                            }
                            if (_loc_6 + 14 < this._cellZones.length && this._cellZones[_loc_6 + 14] > 0)
                            {
                                this._cellZones[_loc_6 + 14] = _loc_1;
                            }
                            if ((_loc_6 - 1) > 0 && this._cellZones[(_loc_6 - 1)] > 0)
                            {
                                this._cellZones[(_loc_6 - 1)] = _loc_1;
                            }
                        }
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            if (_loc_8.length > 0)
            {
                _loc_9 = 0;
                while (_loc_9 < _loc_8.length)
                {
                    
                    if (this._cellZones.indexOf(_loc_8[_loc_9].z1) != -1 && this._cellZones.indexOf(_loc_8[_loc_9].z2) != -1)
                    {
                        _loc_12 = Math.min(_loc_8[_loc_9].z1, _loc_8[_loc_9].z2);
                        _loc_13 = Math.max(_loc_8[_loc_9].z1, _loc_8[_loc_9].z2);
                        _loc_11 = 0;
                        while (_loc_11 < _loc_7)
                        {
                            
                            if (this._cellZones[_loc_11] == _loc_13)
                            {
                                this._cellZones[_loc_11] = _loc_12;
                            }
                            _loc_11 = _loc_11 + 1;
                        }
                    }
                    _loc_9 = _loc_9 + 1;
                }
                _loc_8 = null;
            }
            return;
        }// end function

        private function containZone(param1:Array, param2:int, param3:int) : Boolean
        {
            var _loc_4:int = 0;
            var _loc_5:* = param1.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_5)
            {
                
                if (param1[_loc_4].z1 == param2 && param1[_loc_4].z2 == param3 || param1[_loc_4].z1 == param3 && param1[_loc_4].z2 == param2)
                {
                    return true;
                }
                _loc_4 = _loc_4 + 1;
            }
            return false;
        }// end function

        private function getCellZone(param1:int) : int
        {
            var _loc_2:int = -1;
            var _loc_3:* = CellUtil.isLeftCol(param1);
            var _loc_4:* = CellUtil.isRightCol(param1);
            var _loc_5:* = CellUtil.isEvenRow(param1);
            if (!_loc_3 && (param1 - 1) > 0 && this._cellZones[(param1 - 1)] > 0)
            {
                _loc_2 = this._cellZones[(param1 - 1)];
            }
            else if (param1 - 28 > 0 && this._cellZones[param1 - 28] > 0)
            {
                _loc_2 = this._cellZones[param1 - 28];
            }
            else if (!_loc_5 && !_loc_4 && param1 - 13 > 0 && this._cellZones[param1 - 13] > 0)
            {
                _loc_2 = this._cellZones[param1 - 13];
            }
            else if (_loc_5 && (!_loc_3 || _loc_3 && !_loc_5) && param1 - 14 > 0 && this._cellZones[param1 - 14] > 0)
            {
                _loc_2 = this._cellZones[param1 - 14];
            }
            return _loc_2;
        }// end function

        private function getInformations(param1:int) : Array
        {
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = true;
            var _loc_4:* = CellUtil.isLeftCol(param1);
            var _loc_5:* = CellUtil.isRightCol(param1);
            var _loc_6:* = CellUtil.isEvenRow(param1);
            if (!_loc_4 && (param1 - 1) > 0)
            {
                if (this._cellZones[(param1 - 1)] > 0)
                {
                    _loc_2 = true;
                }
                if (this._cellZones[(param1 - 1)] != -1)
                {
                    _loc_3 = false;
                }
            }
            if (!_loc_5 && (param1 + 1) < this._cellZones.length)
            {
                if (this._cellZones[(param1 + 1)] > 0)
                {
                    _loc_2 = true;
                }
                if (this._cellZones[(param1 + 1)] != -1)
                {
                    _loc_3 = false;
                }
            }
            if ((!_loc_4 || _loc_4 && !_loc_6) && param1 + 14 < this._cellZones.length)
            {
                if (this._cellZones[param1 + 14] > 0)
                {
                    _loc_2 = true;
                }
                if (this._cellZones[param1 + 14] != -1)
                {
                    _loc_3 = false;
                }
            }
            if (param1 + 28 < this._cellZones.length)
            {
                if (this._cellZones[param1 + 28] > 0)
                {
                    _loc_2 = true;
                }
                if (this._cellZones[param1 + 28] != -1)
                {
                    _loc_3 = false;
                }
            }
            if ((!_loc_4 || _loc_4 && !_loc_6) && param1 - 14 > 0)
            {
                if (this._cellZones[param1 - 14] > 0)
                {
                    _loc_2 = true;
                }
                if (this._cellZones[param1 - 14] != -1)
                {
                    _loc_3 = false;
                }
            }
            if (param1 - 28 > 0)
            {
                if (this._cellZones[param1 - 28] > 0)
                {
                    _loc_2 = true;
                }
                if (this._cellZones[param1 - 28] != -1)
                {
                    _loc_3 = false;
                }
            }
            if (_loc_6)
            {
                if (!_loc_4 && param1 + 13 < this._cellZones.length)
                {
                    if (this._cellZones[param1 + 13] > 0)
                    {
                        _loc_2 = true;
                    }
                    if (this._cellZones[param1 + 13] != -1)
                    {
                        _loc_3 = false;
                    }
                }
                if (!_loc_4 && param1 - 15 > 0)
                {
                    if (this._cellZones[param1 - 15] > 0)
                    {
                        _loc_2 = true;
                    }
                    if (this._cellZones[param1 - 15] != -1)
                    {
                        _loc_3 = false;
                    }
                }
            }
            else
            {
                if (!_loc_5 && param1 - 13 > 0)
                {
                    if (this._cellZones[param1 - 13] > 0)
                    {
                        _loc_2 = true;
                    }
                    if (this._cellZones[param1 - 13] != -1)
                    {
                        _loc_3 = false;
                    }
                }
                if (!_loc_5 && param1 + 15 < this._cellZones.length)
                {
                    if (this._cellZones[param1 + 15] > 0)
                    {
                        _loc_2 = true;
                    }
                    if (this._cellZones[param1 + 15] != -1)
                    {
                        _loc_3 = false;
                    }
                }
            }
            return [_loc_2, _loc_3];
        }// end function

        public function get tacticModeActivated() : Boolean
        {
            return this._tacticModeActivated;
        }// end function

        private function loadBackground() : void
        {
            var _loc_1:IResourceLoader = null;
            if (this._background == null)
            {
                _loc_1 = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
                _loc_1.addEventListener(ResourceLoadedEvent.LOADED, this.onBackgroundLoaded);
                _loc_1.load(new Uri(SWF_LIB), null, AdvancedSwfAdapter);
            }
            else
            {
                MapDisplayManager.getInstance().renderer.container.addChildAt(this._background, 0);
            }
            return;
        }// end function

        private function removeBackground() : void
        {
            if (this._background != null && MapDisplayManager.getInstance().renderer.container.contains(this._background))
            {
                MapDisplayManager.getInstance().renderer.container.removeChild(this._background);
            }
            return;
        }// end function

        private function onBackgroundLoaded(event:ResourceLoadedEvent = null) : void
        {
            event.currentTarget.removeEventListener(ResourceLoadedEvent.LOADED, this.onBackgroundLoaded);
            var _loc_2:* = event.resource.applicationDomain;
            this._background = new _loc_2.getDefinition("BG") as Sprite;
            this._background.name = "TacticModeBackground";
            MapDisplayManager.getInstance().renderer.container.addChildAt(this._background, 0);
            return;
        }// end function

        public function setDebugMode(param1:Boolean = false, param2:Boolean = false) : void
        {
            this._debugMode = param1;
            this._debugCache = param2;
            return;
        }// end function

        public static function getInstance() : TacticModeManager
        {
            if (_self == null)
            {
                _self = new TacticModeManager(new PrivateClass());
            }
            return _self;
        }// end function

    }
}

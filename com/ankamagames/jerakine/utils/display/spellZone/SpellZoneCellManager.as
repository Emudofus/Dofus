package com.ankamagames.jerakine.utils.display.spellZone
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.display.*;

    public class SpellZoneCellManager extends Sprite
    {
        private var _centerCell:SpellZoneCell;
        public var cells:Vector.<SpellZoneCell>;
        private var _spellLevel:ICellZoneProvider;
        private var _spellCellsId:Vector.<uint>;
        private var _rollOverCell:SpellZoneCell;
        private var _width:Number;
        private var _height:Number;
        private var _paddingTop:uint;
        private var _paddingLeft:uint;
        private var _zoneDisplay:Sprite;
        public static const RANGE_COLOR:uint = 65280;
        public static const CHARACTER_COLOR:uint = 16711680;
        public static const SPELL_COLOR:uint = 255;

        public function SpellZoneCellManager()
        {
            this._zoneDisplay = new Sprite();
            addChild(this._zoneDisplay);
            this.cells = new Vector.<SpellZoneCell>;
            this._spellCellsId = new Vector.<uint>;
            return;
        }// end function

        public function setDisplayZone(param1:uint, param2:uint) : void
        {
            this._width = param1;
            this._height = param2;
            return;
        }// end function

        public function set spellLevel(param1:ICellZoneProvider) : void
        {
            this._spellLevel = param1;
            return;
        }// end function

        private function addListeners() : void
        {
            addEventListener(SpellZoneEvent.CELL_ROLLOVER, this.onCellRollOver);
            addEventListener(SpellZoneEvent.CELL_ROLLOUT, this.onCellRollOut);
            return;
        }// end function

        private function removeListeners() : void
        {
            removeEventListener(SpellZoneEvent.CELL_ROLLOVER, this.onCellRollOver);
            removeEventListener(SpellZoneEvent.CELL_ROLLOUT, this.onCellRollOut);
            return;
        }// end function

        private function onCellRollOver(event:SpellZoneEvent) : void
        {
            this._rollOverCell = event.cell;
            this.showSpellZone(event.cell);
            return;
        }// end function

        private function onCellRollOut(event:SpellZoneEvent) : void
        {
            this.setLastSpellCellToNormal();
            return;
        }// end function

        public function showSpellZone(param1:SpellZoneCell) : void
        {
            if (this._spellCellsId.length > 0)
            {
                this.setLastSpellCellToNormal();
            }
            this._spellCellsId = this.getSpellZone().getCells(param1.cellId);
            this.setSpellZone(this._spellCellsId);
            return;
        }// end function

        private function setLastSpellCellToNormal() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            for each (_loc_1 in this.cells)
            {
                
                for each (_loc_2 in this._spellCellsId)
                {
                    
                    if (_loc_2 == _loc_1.cellId)
                    {
                        _loc_1.changeColorToDefault();
                    }
                }
            }
            return;
        }// end function

        private function resetCells() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.cells)
            {
                
                _loc_1.setNormalCell();
            }
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            if (this._spellLevel == null)
            {
                return;
            }
            this.resetCells();
            if (this._spellLevel.castZoneInLine)
            {
                _loc_1 = new Cross(this._spellLevel.minimalRange, this._spellLevel.maximalRange, _loc_9);
            }
            else
            {
                _loc_1 = new Lozenge(this._spellLevel.minimalRange, this._spellLevel.maximalRange, _loc_9);
            }
            if (this.cells.length == 0)
            {
                _loc_4 = 0;
                _loc_5 = 0;
                _loc_7 = 40;
                _loc_6 = 14;
                _loc_8 = 0;
                _loc_10 = this._width / (_loc_6 + 0.5);
                _loc_11 = this._height / (_loc_7 / 2 + 0.5);
                _loc_12 = 0;
                while (_loc_12 < _loc_7)
                {
                    
                    _loc_4 = Math.ceil(_loc_12 / 2);
                    _loc_5 = -Math.floor(_loc_12 / 2);
                    _loc_13 = 0;
                    while (_loc_13 < _loc_6)
                    {
                        
                        _loc_14 = new SpellZoneCell(_loc_10, _loc_11, MapPoint.fromCoords(_loc_4, _loc_5).cellId);
                        if (_loc_14.cellId == SpellZoneConstant.CENTER_CELL_ID + _loc_8)
                        {
                            this._centerCell = _loc_14;
                        }
                        else
                        {
                            _loc_14.changeColorToDefault();
                        }
                        _loc_14.addEventListener(SpellZoneEvent.CELL_ROLLOVER, this.onCellRollOver);
                        _loc_14.addEventListener(SpellZoneEvent.CELL_ROLLOUT, this.onCellRollOut);
                        this.cells.push(_loc_14);
                        _loc_14.posX = _loc_4;
                        _loc_14.posY = _loc_5;
                        if (_loc_12 == 0 || _loc_12 % 2 == 0)
                        {
                            _loc_14.x = _loc_13 * _loc_10;
                        }
                        else
                        {
                            _loc_14.x = _loc_13 * _loc_10 + _loc_10 / 2;
                        }
                        _loc_14.y = _loc_12 * _loc_11 / 2;
                        this._zoneDisplay.addChild(_loc_14);
                        _loc_4++;
                        _loc_5++;
                        _loc_13++;
                    }
                    _loc_12++;
                }
            }
            this.colorCell(this._centerCell, CHARACTER_COLOR, true);
            var _loc_2:* = 14.5 / (1 + Math.ceil(this._spellLevel.maximalRange) + Math.ceil(this.getSpellZone().radius));
            var _loc_15:* = _loc_2;
            this._zoneDisplay.scaleY = _loc_2;
            this._zoneDisplay.scaleX = _loc_15;
            this._zoneDisplay.x = (this._width - this._zoneDisplay.width) / 2 + 0.5 / 14.5 * this._zoneDisplay.width / 2;
            this._zoneDisplay.y = (this._height - this._zoneDisplay.height) / 2 + 0.5 / 20.5 * this._zoneDisplay.height / 2;
            if (this._centerCell)
            {
                this.setRangedCells(_loc_1.getCells(this._centerCell.cellId));
            }
            if (mask != null)
            {
                return;
            }
            var _loc_3:* = new Sprite();
            _loc_3.graphics.beginFill(16711680);
            _loc_3.graphics.drawRoundRect(0, 0, this._width, this._height - 3, 30, 30);
            addChild(_loc_3);
            this.mask = _loc_3;
            return;
        }// end function

        private function isInSpellArea(param1:SpellZoneCell, param2:Lozenge) : Boolean
        {
            var _loc_4:* = 0;
            if (param2 == null)
            {
                return false;
            }
            var _loc_3:* = param2.getCells(this._centerCell.cellId);
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4 == param1.cellId)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function remove() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this.cells.length;
            var _loc_2:* = _loc_1;
            while (_loc_2 > 0)
            {
                
                _loc_3 = this.cells.pop();
                this._zoneDisplay.removeChild(_loc_3);
                _loc_3 = null;
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function setRangedCells(param1:Vector.<uint>) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            for each (_loc_2 in this.cells)
            {
                
                for each (_loc_3 in param1)
                {
                    
                    if (_loc_3 == _loc_2.cellId)
                    {
                        _loc_2.setRangeCell();
                    }
                }
            }
            return;
        }// end function

        public function setSpellZone(param1:Vector.<uint>) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            for each (_loc_2 in this.cells)
            {
                
                for each (_loc_3 in param1)
                {
                    
                    if (_loc_3 == _loc_2.cellId)
                    {
                        _loc_2.setSpellCell();
                    }
                }
            }
            return;
        }// end function

        public function colorCell(param1:SpellZoneCell, param2:uint, param3:Boolean = false) : void
        {
            param1.colorCell(param2, param3);
            return;
        }// end function

        public function colorCells(param1:Vector.<uint>, param2:uint, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            for each (_loc_4 in this.cells)
            {
                
                for each (_loc_5 in param1)
                {
                    
                    if (_loc_5 == _loc_4.cellId)
                    {
                        this.colorCell(_loc_4, param2, param3);
                    }
                }
            }
            return;
        }// end function

        private function getSpellZone() : IZone
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_1:* = 88;
            _loc_2 = 666;
            for each (_loc_4 in this._spellLevel.spellZoneEffects)
            {
                
                if (_loc_4.zoneShape != 0 && _loc_4.zoneSize < _loc_2 && _loc_4.zoneSize > 0 && _loc_4.zoneSize != 63)
                {
                    _loc_2 = _loc_4.zoneSize;
                    _loc_1 = _loc_4.zoneShape;
                }
            }
            if (_loc_2 == 666)
            {
                _loc_2 = 0;
            }
            switch(_loc_1)
            {
                case SpellShapeEnum.X:
                {
                    _loc_5 = new Cross(0, _loc_2, _loc_3);
                    break;
                }
                case SpellShapeEnum.L:
                {
                    _loc_6 = new Line(_loc_2, _loc_3);
                    _loc_5 = _loc_6;
                    break;
                }
                case SpellShapeEnum.T:
                {
                    _loc_7 = new Cross(0, _loc_2, _loc_3);
                    _loc_7.onlyPerpendicular = true;
                    _loc_5 = _loc_7;
                    break;
                }
                case SpellShapeEnum.D:
                {
                    _loc_5 = new Cross(0, _loc_2, _loc_3);
                    break;
                }
                case SpellShapeEnum.C:
                {
                    _loc_5 = new Lozenge(0, _loc_2, _loc_3);
                    break;
                }
                case SpellShapeEnum.I:
                {
                    _loc_5 = new Lozenge(_loc_2, 63, _loc_3);
                    break;
                }
                case SpellShapeEnum.O:
                {
                    _loc_5 = new Lozenge(_loc_2, _loc_2, _loc_3);
                    break;
                }
                case SpellShapeEnum.Q:
                {
                    _loc_5 = new Cross(1, _loc_2, _loc_3);
                    break;
                }
                case SpellShapeEnum.G:
                {
                    _loc_5 = new Square(0, _loc_2, _loc_3);
                    break;
                }
                case SpellShapeEnum.V:
                {
                    _loc_5 = new Cone(0, _loc_2, _loc_3);
                    break;
                }
                case SpellShapeEnum.W:
                {
                    _loc_8 = new Square(0, _loc_2, _loc_3);
                    _loc_8.diagonalFree = true;
                    _loc_5 = _loc_8;
                    break;
                }
                case SpellShapeEnum.plus:
                {
                    _loc_9 = new Cross(0, _loc_2, _loc_3);
                    _loc_9.diagonal = true;
                    _loc_5 = _loc_9;
                    break;
                }
                case SpellShapeEnum.sharp:
                {
                    _loc_9 = new Cross(1, _loc_2, _loc_3);
                    _loc_9.diagonal = true;
                    _loc_5 = _loc_9;
                    break;
                }
                case SpellShapeEnum.star:
                {
                    _loc_9 = new Cross(0, _loc_2, _loc_3);
                    _loc_9.allDirections = true;
                    _loc_5 = _loc_9;
                    break;
                }
                case SpellShapeEnum.slash:
                {
                    _loc_5 = new Line(_loc_2, _loc_3);
                    break;
                }
                case SpellShapeEnum.minus:
                {
                    _loc_9 = new Cross(0, _loc_2, _loc_3);
                    _loc_9.onlyPerpendicular = true;
                    _loc_9.diagonal = true;
                    _loc_5 = _loc_9;
                    break;
                }
                case SpellShapeEnum.U:
                {
                    _loc_5 = new HalfLozenge(0, _loc_2, _loc_3);
                    break;
                }
                case SpellShapeEnum.A:
                {
                    _loc_5 = new Lozenge(0, 63, _loc_3);
                    break;
                }
                case SpellShapeEnum.P:
                {
                }
                default:
                {
                    _loc_5 = new Cross(0, 0, _loc_3);
                    break;
                }
            }
            if (this._rollOverCell)
            {
                _loc_10 = this._centerCell.posX - this._rollOverCell.posX;
                _loc_11 = this._centerCell.posY - this._rollOverCell.posY;
                _loc_5.direction = DirectionsEnum.DOWN_RIGHT;
                if (_loc_10 == 0 && _loc_11 > 0)
                {
                    _loc_5.direction = DirectionsEnum.DOWN_LEFT;
                }
                if (_loc_10 == 0 && _loc_11 < 0)
                {
                    _loc_5.direction = DirectionsEnum.UP_RIGHT;
                }
                if (_loc_10 > 0 && _loc_11 == 0)
                {
                    _loc_5.direction = DirectionsEnum.UP_LEFT;
                }
            }
            return _loc_5;
        }// end function

    }
}

package com.ankamagames.atouin.managers
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class FrustumManager extends Object
    {
        private var _frustumContainer:DisplayObjectContainer;
        private var _shapeTop:Sprite;
        private var _shapeRight:Sprite;
        private var _shapeBottom:Sprite;
        private var _shapeLeft:Sprite;
        private var _frustrum:Frustum;
        private var _lastCellId:int;
        private var _enable:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FrustumManager));
        private static var _self:FrustumManager;

        public function FrustumManager()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function init(param1:DisplayObjectContainer) : void
        {
            this._frustumContainer = param1;
            this._shapeTop = new Sprite();
            this._shapeRight = new Sprite();
            this._shapeBottom = new Sprite();
            this._shapeLeft = new Sprite();
            this._frustumContainer.addChild(this._shapeLeft);
            this._frustumContainer.addChild(this._shapeTop);
            this._frustumContainer.addChild(this._shapeRight);
            this._frustumContainer.addChild(this._shapeBottom);
            this._shapeLeft.buttonMode = true;
            this._shapeTop.buttonMode = true;
            this._shapeRight.buttonMode = true;
            this._shapeBottom.buttonMode = true;
            this._shapeLeft.addEventListener(MouseEvent.CLICK, this.click);
            this._shapeTop.addEventListener(MouseEvent.CLICK, this.click);
            this._shapeRight.addEventListener(MouseEvent.CLICK, this.click);
            this._shapeBottom.addEventListener(MouseEvent.CLICK, this.click);
            this._shapeLeft.addEventListener(MouseEvent.MOUSE_OVER, this.mouseMove);
            this._shapeTop.addEventListener(MouseEvent.MOUSE_OVER, this.mouseMove);
            this._shapeRight.addEventListener(MouseEvent.MOUSE_OVER, this.mouseMove);
            this._shapeBottom.addEventListener(MouseEvent.MOUSE_OVER, this.mouseMove);
            this._shapeLeft.addEventListener(MouseEvent.MOUSE_OUT, this.out);
            this._shapeTop.addEventListener(MouseEvent.MOUSE_OUT, this.out);
            this._shapeRight.addEventListener(MouseEvent.MOUSE_OUT, this.out);
            this._shapeBottom.addEventListener(MouseEvent.MOUSE_OUT, this.out);
            this._shapeLeft.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMove);
            this._shapeTop.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMove);
            this._shapeRight.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMove);
            this._shapeBottom.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMove);
            this.setBorderInteraction(false);
            this._lastCellId = -1;
            return;
        }// end function

        public function setBorderInteraction(param1:Boolean) : void
        {
            this._enable = param1;
            this._shapeTop.mouseEnabled = param1;
            this._shapeRight.mouseEnabled = param1;
            this._shapeBottom.mouseEnabled = param1;
            this._shapeLeft.mouseEnabled = param1;
            this.updateMap();
            return;
        }// end function

        public function updateMap() : void
        {
            if (this._enable)
            {
                this._shapeTop.mouseEnabled = this.findNearestCell(this._shapeTop) != -1;
                this._shapeRight.mouseEnabled = this.findNearestCell(this._shapeRight) != -1;
                this._shapeBottom.mouseEnabled = this.findNearestCell(this._shapeBottom) != -1;
                this._shapeLeft.mouseEnabled = this.findNearestCell(this._shapeLeft) != -1;
            }
            return;
        }// end function

        public function getShape(param1:int) : Sprite
        {
            switch(param1)
            {
                case DirectionsEnum.UP:
                {
                    return this._shapeTop;
                }
                case DirectionsEnum.LEFT:
                {
                    return this._shapeLeft;
                }
                case DirectionsEnum.RIGHT:
                {
                    return this._shapeRight;
                }
                case DirectionsEnum.DOWN:
                {
                    return this._shapeBottom;
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public function set frustum(param1:Frustum) : void
        {
            this._frustrum = param1;
            var _loc_2:* = new Point(param1.x + AtouinConstants.CELL_HALF_WIDTH * param1.scale, param1.y + AtouinConstants.CELL_HALF_HEIGHT * param1.scale);
            var _loc_3:* = new Point(param1.x - AtouinConstants.CELL_HALF_WIDTH * param1.scale + param1.width, param1.y + AtouinConstants.CELL_HALF_HEIGHT * param1.scale);
            var _loc_4:* = new Point(param1.x + AtouinConstants.CELL_HALF_WIDTH * param1.scale, param1.y - AtouinConstants.CELL_HEIGHT * param1.scale + param1.height);
            var _loc_5:* = new Point(param1.x - AtouinConstants.CELL_HALF_WIDTH * param1.scale + param1.width, param1.y - AtouinConstants.CELL_HEIGHT * param1.scale + param1.height);
            var _loc_6:* = new Point(param1.x, param1.y);
            var _loc_7:* = new Point(param1.x + param1.width, param1.y);
            var _loc_8:* = new Point(param1.x, param1.y + param1.height - AtouinConstants.CELL_HALF_HEIGHT * param1.scale);
            var _loc_9:* = new Point(param1.x + param1.width, param1.y + param1.height - AtouinConstants.CELL_HALF_HEIGHT * param1.scale);
            this._shapeTop.graphics.clear();
            this._shapeRight.graphics.clear();
            this._shapeBottom.graphics.clear();
            this._shapeLeft.graphics.clear();
            var _loc_10:Number = 0;
            this._shapeLeft.graphics.beginFill(16746564, _loc_10);
            this._shapeLeft.graphics.moveTo(0, _loc_6.y);
            this._shapeLeft.graphics.lineTo(_loc_6.x, _loc_6.y);
            this._shapeLeft.graphics.lineTo(_loc_2.x, _loc_2.y);
            this._shapeLeft.graphics.lineTo(_loc_4.x, _loc_4.y);
            this._shapeLeft.graphics.lineTo(_loc_8.x, _loc_8.y);
            this._shapeLeft.graphics.lineTo(0, _loc_8.y);
            this._shapeLeft.graphics.lineTo(0, _loc_6.y);
            this._shapeLeft.graphics.endFill();
            this._shapeTop.graphics.beginFill(7803289, _loc_10);
            this._shapeTop.graphics.moveTo(_loc_6.x, 0);
            this._shapeTop.graphics.lineTo(_loc_6.x, _loc_6.y);
            this._shapeTop.graphics.lineTo(_loc_2.x, _loc_2.y);
            this._shapeTop.graphics.lineTo(_loc_3.x, _loc_3.y);
            this._shapeTop.graphics.lineTo(_loc_7.x, _loc_7.y);
            this._shapeTop.graphics.lineTo(_loc_7.x, 0);
            this._shapeTop.graphics.lineTo(0, 0);
            this._shapeTop.graphics.endFill();
            this._shapeRight.graphics.beginFill(1218969, _loc_10);
            this._shapeRight.graphics.moveTo(StageShareManager.startWidth, _loc_7.y);
            this._shapeRight.graphics.lineTo(_loc_7.x, _loc_7.y);
            this._shapeRight.graphics.lineTo(_loc_3.x, _loc_3.y);
            this._shapeRight.graphics.lineTo(_loc_5.x, _loc_5.y);
            this._shapeRight.graphics.lineTo(_loc_9.x, _loc_9.y);
            this._shapeRight.graphics.lineTo(StageShareManager.startWidth, _loc_9.y);
            this._shapeRight.graphics.lineTo(StageShareManager.startWidth, _loc_7.y);
            this._shapeRight.graphics.endFill();
            this._shapeBottom.graphics.beginFill(7807590, _loc_10);
            this._shapeBottom.graphics.moveTo(_loc_9.x, StageShareManager.startHeight);
            this._shapeBottom.graphics.lineTo(_loc_9.x, _loc_9.y);
            this._shapeBottom.graphics.lineTo(_loc_5.x, _loc_5.y + 10);
            this._shapeBottom.graphics.lineTo(_loc_4.x, _loc_4.y + 10);
            this._shapeBottom.graphics.lineTo(_loc_8.x, _loc_8.y);
            this._shapeBottom.graphics.lineTo(_loc_8.x, StageShareManager.startHeight);
            this._shapeBottom.graphics.lineTo(_loc_9.x, StageShareManager.startHeight);
            this._shapeBottom.graphics.endFill();
            return;
        }// end function

        private function click(event:MouseEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:uint = 0;
            var _loc_4:* = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
            switch(event.target)
            {
                case this._shapeRight:
                {
                    _loc_3 = _loc_4.rightNeighbourId;
                    break;
                }
                case this._shapeLeft:
                {
                    _loc_3 = _loc_4.leftNeighbourId;
                    break;
                }
                case this._shapeBottom:
                {
                    _loc_3 = _loc_4.bottomNeighbourId;
                    break;
                }
                case this._shapeTop:
                {
                    _loc_3 = _loc_4.topNeighbourId;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2 = this.findNearestCell(event.target as Sprite);
            if (_loc_2 == -1)
            {
                return;
            }
            this.sendMsg(_loc_3, _loc_2);
            return;
        }// end function

        private function findNearestCell(param1:Sprite) : int
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Point = null;
            var _loc_7:int = 0;
            var _loc_8:Number = NaN;
            var _loc_9:uint = 0;
            var _loc_10:uint = 0;
            var _loc_12:int = 0;
            var _loc_13:Number = NaN;
            var _loc_14:CellData = null;
            var _loc_15:uint = 0;
            var _loc_11:* = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
            switch(param1)
            {
                case this._shapeRight:
                {
                    _loc_2 = AtouinConstants.MAP_WIDTH - 1;
                    _loc_3 = AtouinConstants.MAP_WIDTH - 1;
                    _loc_9 = _loc_11.rightNeighbourId;
                    break;
                }
                case this._shapeLeft:
                {
                    _loc_2 = 0;
                    _loc_3 = 0;
                    _loc_9 = _loc_11.leftNeighbourId;
                    break;
                }
                case this._shapeBottom:
                {
                    _loc_2 = AtouinConstants.MAP_HEIGHT - 1;
                    _loc_3 = -(AtouinConstants.MAP_HEIGHT - 1);
                    _loc_9 = _loc_11.bottomNeighbourId;
                    break;
                }
                case this._shapeTop:
                {
                    _loc_2 = 0;
                    _loc_3 = 0;
                    _loc_9 = _loc_11.topNeighbourId;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 == this._shapeRight || param1 == this._shapeLeft)
            {
                _loc_13 = AtouinConstants.MAP_HEIGHT * AtouinConstants.CELL_HEIGHT * this._frustrum.scale;
                _loc_10 = 0;
                while (_loc_10 < AtouinConstants.MAP_HEIGHT * 2)
                {
                    
                    _loc_12 = CellIdConverter.coordToCellId(_loc_2, _loc_3);
                    _loc_6 = Cell.cellPixelCoords(_loc_12);
                    _loc_7 = CellData(_loc_11.cells[_loc_12]).floor;
                    _loc_8 = Math.abs(param1.mouseY - this._frustrum.y - (_loc_6.y - _loc_7 + AtouinConstants.CELL_HALF_HEIGHT) * this._frustrum.scale);
                    if (_loc_8 < _loc_13)
                    {
                        _loc_14 = _loc_11.cells[_loc_12] as CellData;
                        _loc_15 = _loc_14.mapChangeData;
                        if (_loc_15 && (param1 == this._shapeRight && (_loc_15 & 1 || (_loc_12 + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0 && _loc_15 & 2 || (_loc_12 + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0 && _loc_15 & 128) || param1 == this._shapeLeft && (_loc_2 == -_loc_3 && _loc_15 & 8 || _loc_15 & 16 || _loc_2 == -_loc_3 && _loc_15 & 32)))
                        {
                            _loc_4 = _loc_2;
                            _loc_5 = _loc_3;
                            _loc_13 = _loc_8;
                        }
                    }
                    else
                    {
                        return CellIdConverter.coordToCellId(_loc_4, _loc_5);
                    }
                    if (!(_loc_10 % 2))
                    {
                        _loc_2++;
                    }
                    else
                    {
                        _loc_3 = _loc_3 - 1;
                    }
                    _loc_10 = _loc_10 + 1;
                }
                if (_loc_13 != AtouinConstants.MAP_HEIGHT * AtouinConstants.CELL_HEIGHT * this._frustrum.scale)
                {
                    return CellIdConverter.coordToCellId(_loc_4, _loc_5);
                }
            }
            else
            {
                _loc_13 = AtouinConstants.MAP_WIDTH * AtouinConstants.CELL_WIDTH * this._frustrum.scale;
                _loc_10 = 0;
                while (_loc_10 < AtouinConstants.MAP_WIDTH * 2)
                {
                    
                    _loc_12 = CellIdConverter.coordToCellId(_loc_2, _loc_3);
                    _loc_6 = Cell.cellPixelCoords(_loc_12);
                    _loc_8 = Math.abs(param1.mouseX - this._frustrum.x - (_loc_6.x + AtouinConstants.CELL_HALF_WIDTH) * this._frustrum.scale);
                    if (_loc_8 < _loc_13)
                    {
                        _loc_14 = _loc_11.cells[_loc_12] as CellData;
                        _loc_15 = _loc_14.mapChangeData;
                        if (_loc_15 && (param1 == this._shapeTop && (_loc_12 < AtouinConstants.MAP_WIDTH && _loc_15 & 32 || _loc_15 & 64 || _loc_12 < AtouinConstants.MAP_WIDTH && _loc_15 & 128) || param1 == this._shapeBottom && (_loc_12 >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH && _loc_15 & 2 || _loc_15 & 4 || _loc_12 >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH && _loc_15 & 8)))
                        {
                            _loc_4 = _loc_2;
                            _loc_5 = _loc_3;
                            _loc_13 = _loc_8;
                        }
                    }
                    else
                    {
                        return CellIdConverter.coordToCellId(_loc_4, _loc_5);
                    }
                    if (!(_loc_10 % 2))
                    {
                        _loc_2++;
                    }
                    else
                    {
                        _loc_3++;
                    }
                    _loc_10 = _loc_10 + 1;
                }
                if (_loc_13 != AtouinConstants.MAP_WIDTH * AtouinConstants.CELL_WIDTH * this._frustrum.scale)
                {
                    return CellIdConverter.coordToCellId(_loc_4, _loc_5);
                }
            }
            return -1;
        }// end function

        private function sendMsg(param1:uint, param2:uint) : void
        {
            var _loc_3:* = new AdjacentMapClickMessage();
            _loc_3.cellId = param2;
            _loc_3.adjacentMapId = param1;
            Atouin.getInstance().handler.process(_loc_3);
            return;
        }// end function

        private function out(event:MouseEvent) : void
        {
            var _loc_2:uint = 0;
            switch(event.target)
            {
                case this._shapeRight:
                {
                    _loc_2 = DirectionsEnum.RIGHT;
                    break;
                }
                case this._shapeLeft:
                {
                    _loc_2 = DirectionsEnum.LEFT;
                    break;
                }
                case this._shapeBottom:
                {
                    _loc_2 = DirectionsEnum.DOWN;
                    break;
                }
                case this._shapeTop:
                {
                    _loc_2 = DirectionsEnum.UP;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._lastCellId = -1;
            var _loc_3:* = new AdjacentMapOutMessage(_loc_2, DisplayObject(event.target));
            Atouin.getInstance().handler.process(_loc_3);
            return;
        }// end function

        private function mouseMove(event:MouseEvent) : void
        {
            var _loc_2:uint = 0;
            switch(event.target)
            {
                case this._shapeRight:
                {
                    _loc_2 = DirectionsEnum.RIGHT;
                    break;
                }
                case this._shapeLeft:
                {
                    _loc_2 = DirectionsEnum.LEFT;
                    break;
                }
                case this._shapeBottom:
                {
                    _loc_2 = DirectionsEnum.DOWN;
                    break;
                }
                case this._shapeTop:
                {
                    _loc_2 = DirectionsEnum.UP;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_3:* = this.findNearestCell(event.target as Sprite);
            if (_loc_3 == -1 || _loc_3 == this._lastCellId)
            {
                return;
            }
            this._lastCellId = _loc_3;
            var _loc_4:* = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[_loc_3] as CellData;
            var _loc_5:* = new AdjacentMapOverMessage(_loc_2, DisplayObject(event.target), _loc_3, _loc_4);
            Atouin.getInstance().handler.process(_loc_5);
            return;
        }// end function

        public static function getInstance() : FrustumManager
        {
            if (!_self)
            {
                _self = new FrustumManager;
            }
            return _self;
        }// end function

    }
}

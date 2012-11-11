package com.ankamagames.atouin.managers
{
    import __AS3__.vec.*;
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
            var _loc_10:* = 1;
            var _loc_11:* = new Vector.<int>(7, true);
            new Vector.<int>(7, true)[0] = 1;
            _loc_11[1] = 2;
            _loc_11[2] = 2;
            _loc_11[3] = 2;
            _loc_11[4] = 2;
            _loc_11[5] = 2;
            _loc_11[6] = 2;
            var _loc_12:* = new Vector.<Number>(14, true);
            new Vector.<Number>(14, true)[0] = 0;
            _loc_12[1] = _loc_6.y;
            _loc_12[2] = _loc_6.x;
            _loc_12[3] = _loc_6.y;
            _loc_12[4] = _loc_2.x;
            _loc_12[5] = _loc_2.y;
            _loc_12[6] = _loc_4.x;
            _loc_12[7] = _loc_4.y;
            _loc_12[8] = _loc_8.x;
            _loc_12[9] = _loc_8.y;
            _loc_12[10] = 0;
            _loc_12[11] = _loc_8.y;
            _loc_12[12] = 0;
            _loc_12[13] = _loc_6.y;
            var _loc_13:* = this.drawShape(16746564, _loc_11, _loc_12);
            if (this.drawShape(16746564, _loc_11, _loc_12) != null)
            {
                this._shapeLeft.addChild(_loc_13);
            }
            var _loc_14:* = new Vector.<Number>(14, true);
            new Vector.<Number>(14, true)[0] = _loc_6.x;
            _loc_14[1] = 0;
            _loc_14[2] = _loc_6.x;
            _loc_14[3] = _loc_6.y;
            _loc_14[4] = _loc_2.x;
            _loc_14[5] = _loc_2.y;
            _loc_14[6] = _loc_3.x;
            _loc_14[7] = _loc_3.y;
            _loc_14[8] = _loc_7.x;
            _loc_14[9] = _loc_7.y;
            _loc_14[10] = _loc_7.x;
            _loc_14[11] = 0;
            _loc_14[12] = 0;
            _loc_14[13] = 0;
            _loc_13 = this.drawShape(7803289, _loc_11, _loc_14);
            if (_loc_13 != null)
            {
                this._shapeTop.addChild(_loc_13);
            }
            var _loc_15:* = new Vector.<Number>(14, true);
            new Vector.<Number>(14, true)[0] = StageShareManager.startWidth;
            _loc_15[1] = _loc_7.y;
            _loc_15[2] = _loc_7.x;
            _loc_15[3] = _loc_7.y;
            _loc_15[4] = _loc_3.x;
            _loc_15[5] = _loc_3.y;
            _loc_15[6] = _loc_5.x;
            _loc_15[7] = _loc_5.y;
            _loc_15[8] = _loc_9.x;
            _loc_15[9] = _loc_9.y;
            _loc_15[10] = StageShareManager.startWidth;
            _loc_15[11] = _loc_9.y;
            _loc_15[12] = StageShareManager.startWidth;
            _loc_15[13] = _loc_7.y;
            _loc_13 = this.drawShape(1218969, _loc_11, _loc_15);
            if (_loc_13 != null)
            {
                _loc_13.x = StageShareManager.startWidth - _loc_13.width;
                _loc_13.y = 15;
                this._shapeRight.addChild(_loc_13);
            }
            var _loc_16:* = new Vector.<Number>(14, true);
            new Vector.<Number>(14, true)[0] = _loc_9.x;
            _loc_16[1] = StageShareManager.startHeight;
            _loc_16[2] = _loc_9.x;
            _loc_16[3] = _loc_9.y;
            _loc_16[4] = _loc_5.x;
            _loc_16[5] = _loc_5.y + 10;
            _loc_16[6] = _loc_4.x;
            _loc_16[7] = _loc_4.y + 10;
            _loc_16[8] = _loc_8.x;
            _loc_16[9] = _loc_8.y;
            _loc_16[10] = _loc_8.x;
            _loc_16[11] = StageShareManager.startHeight;
            _loc_16[12] = _loc_9.x;
            _loc_16[13] = StageShareManager.startHeight;
            _loc_13 = this.drawShape(7807590, _loc_11, _loc_16);
            if (_loc_13 != null)
            {
                _loc_13.y = StageShareManager.startHeight - _loc_13.height;
                this._shapeBottom.addChild(_loc_13);
            }
            return;
        }// end function

        private function drawShape(param1:uint, param2:Vector.<int>, param3:Vector.<Number>) : Bitmap
        {
            var _loc_5:* = null;
            var _loc_4:* = new Shape();
            new Shape().graphics.beginFill(param1, 0);
            _loc_4.graphics.drawPath(param2, param3);
            _loc_4.graphics.endFill();
            if (_loc_4.width > 0 && _loc_4.height > 0)
            {
                _loc_5 = new BitmapData(_loc_4.width, _loc_4.height, true, 16777215);
                _loc_5.draw(_loc_4);
                _loc_4.graphics.clear();
                _loc_4 = null;
                return new Bitmap(_loc_5);
            }
            return null;
        }// end function

        private function click(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
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
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = NaN;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_12:* = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
            switch(param1)
            {
                case this._shapeRight:
                {
                    _loc_2 = AtouinConstants.MAP_WIDTH - 1;
                    _loc_3 = AtouinConstants.MAP_WIDTH - 1;
                    _loc_9 = _loc_12.rightNeighbourId;
                    break;
                }
                case this._shapeLeft:
                {
                    _loc_2 = 0;
                    _loc_3 = 0;
                    _loc_9 = _loc_12.leftNeighbourId;
                    break;
                }
                case this._shapeBottom:
                {
                    _loc_2 = AtouinConstants.MAP_HEIGHT - 1;
                    _loc_3 = -(AtouinConstants.MAP_HEIGHT - 1);
                    _loc_9 = _loc_12.bottomNeighbourId;
                    break;
                }
                case this._shapeTop:
                {
                    _loc_2 = 0;
                    _loc_3 = 0;
                    _loc_9 = _loc_12.topNeighbourId;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 == this._shapeRight || param1 == this._shapeLeft)
            {
                _loc_14 = AtouinConstants.MAP_HEIGHT * AtouinConstants.CELL_HEIGHT * this._frustrum.scale;
                _loc_11 = AtouinConstants.MAP_HEIGHT * 2;
                _loc_10 = 0;
                while (_loc_10 < _loc_11)
                {
                    
                    _loc_13 = CellIdConverter.coordToCellId(_loc_2, _loc_3);
                    _loc_6 = Cell.cellPixelCoords(_loc_13);
                    _loc_7 = CellData(_loc_12.cells[_loc_13]).floor;
                    _loc_8 = Math.abs(param1.mouseY - this._frustrum.y - (_loc_6.y - _loc_7 + AtouinConstants.CELL_HALF_HEIGHT) * this._frustrum.scale);
                    if (_loc_8 < _loc_14)
                    {
                        _loc_15 = _loc_12.cells[_loc_13] as CellData;
                        _loc_16 = _loc_15.mapChangeData;
                        if (_loc_16 && (param1 == this._shapeRight && (_loc_16 & 1 || (_loc_13 + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0 && _loc_16 & 2 || (_loc_13 + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0 && _loc_16 & 128) || param1 == this._shapeLeft && (_loc_2 == -_loc_3 && _loc_16 & 8 || _loc_16 & 16 || _loc_2 == -_loc_3 && _loc_16 & 32)))
                        {
                            _loc_4 = _loc_2;
                            _loc_5 = _loc_3;
                            _loc_14 = _loc_8;
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
                if (_loc_14 != AtouinConstants.MAP_HEIGHT * AtouinConstants.CELL_HEIGHT * this._frustrum.scale)
                {
                    return CellIdConverter.coordToCellId(_loc_4, _loc_5);
                }
            }
            else
            {
                _loc_14 = AtouinConstants.MAP_WIDTH * AtouinConstants.CELL_WIDTH * this._frustrum.scale;
                _loc_10 = 0;
                while (_loc_10 < AtouinConstants.MAP_WIDTH * 2)
                {
                    
                    _loc_13 = CellIdConverter.coordToCellId(_loc_2, _loc_3);
                    _loc_6 = Cell.cellPixelCoords(_loc_13);
                    _loc_8 = Math.abs(param1.mouseX - this._frustrum.x - (_loc_6.x + AtouinConstants.CELL_HALF_WIDTH) * this._frustrum.scale);
                    if (_loc_8 < _loc_14)
                    {
                        _loc_15 = _loc_12.cells[_loc_13] as CellData;
                        _loc_16 = _loc_15.mapChangeData;
                        if (_loc_16 && (param1 == this._shapeTop && (_loc_13 < AtouinConstants.MAP_WIDTH && _loc_16 & 32 || _loc_16 & 64 || _loc_13 < AtouinConstants.MAP_WIDTH && _loc_16 & 128) || param1 == this._shapeBottom && (_loc_13 >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH && _loc_16 & 2 || _loc_16 & 4 || _loc_13 >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH && _loc_16 & 8)))
                        {
                            _loc_4 = _loc_2;
                            _loc_5 = _loc_3;
                            _loc_14 = _loc_8;
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
                if (_loc_14 != AtouinConstants.MAP_WIDTH * AtouinConstants.CELL_WIDTH * this._frustrum.scale)
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
            var _loc_2:* = 0;
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
            var _loc_2:* = 0;
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

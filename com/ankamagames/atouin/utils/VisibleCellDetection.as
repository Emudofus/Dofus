package com.ankamagames.atouin.utils
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.elements.*;
    import com.ankamagames.atouin.data.elements.subtypes.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.data.map.elements.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.types.miscs.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class VisibleCellDetection extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(VisibleCellDetection));

        public function VisibleCellDetection()
        {
            return;
        }// end function

        public static function detectCell(param1:Boolean, param2:Map, param3:WorldPoint, param4:Frustum, param5:WorldPoint) : PartialDataMap
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = 0;
            if (param5 == null)
            {
                _log.error("Cannot detect visible cells with no current map point.");
                return null;
            }
            var _loc_6:* = new PartialDataMap();
            var _loc_13:* = (param3.x - param5.x) * AtouinConstants.CELL_WIDTH * AtouinConstants.MAP_WIDTH;
            var _loc_14:* = (param3.y - param5.y) * AtouinConstants.CELL_HEIGHT * AtouinConstants.MAP_HEIGHT;
            var _loc_15:* = new Rectangle((-param4.x) / param4.scale, (-param4.y) / param4.scale, StageShareManager.startHeight / param4.scale, StageShareManager.stage.stageHeight / param4.scale);
            var _loc_16:* = new Rectangle();
            var _loc_17:* = new Array();
            var _loc_18:* = new Array();
            var _loc_21:* = Sprite(Atouin.getInstance().worldContainer.parent).addChild(new Sprite()) as Sprite;
            (Sprite(Atouin.getInstance().worldContainer.parent).addChild(new Sprite()) as Sprite).graphics.beginFill(0, 0);
            _loc_21.graphics.lineStyle(1, 16711680);
            var _loc_22:* = Elements.getInstance();
            for each (_loc_23 in param2.layers)
            {
                
                for each (_loc_25 in _loc_23.cells)
                {
                    
                    _loc_8 = 0;
                    _loc_9 = 0;
                    _loc_11 = 100000;
                    _loc_19 = 0;
                    _loc_18 = new Array();
                    for each (_loc_26 in _loc_25.elements)
                    {
                        
                        if (_loc_26.elementType == ElementTypesEnum.GRAPHICAL)
                        {
                            _loc_12 = _loc_22.getElementData(GraphicalElement(_loc_26).elementId);
                            _loc_20 = GraphicalElement(_loc_26).altitude * AtouinConstants.ALTITUDE_PIXEL_UNIT;
                            _loc_19 = _loc_20 < _loc_19 ? (_loc_20) : (_loc_19);
                            if (_loc_12 && _loc_12 is NormalGraphicalElementData)
                            {
                                _loc_27 = _loc_12 as NormalGraphicalElementData;
                                if (-_loc_27.origin.x + AtouinConstants.CELL_WIDTH < _loc_11)
                                {
                                    _loc_11 = -_loc_27.origin.x + AtouinConstants.CELL_WIDTH;
                                }
                                if (_loc_27.size.x > _loc_9)
                                {
                                    _loc_9 = _loc_27.size.x;
                                }
                                _loc_8 = _loc_8 + (_loc_27.origin.y + _loc_27.size.y);
                                _loc_18.push(_loc_27.gfxId);
                                continue;
                            }
                            _loc_8 = _loc_8 + Math.abs(_loc_20);
                        }
                    }
                    if (!_loc_8)
                    {
                        _loc_8 = AtouinConstants.CELL_HEIGHT;
                    }
                    if (_loc_11 == 100000)
                    {
                        _loc_11 = 0;
                    }
                    if (_loc_9 < AtouinConstants.CELL_WIDTH)
                    {
                        _loc_9 = AtouinConstants.CELL_WIDTH;
                    }
                    _loc_7 = Cell.cellPixelCoords(_loc_25.cellId);
                    _loc_16.left = _loc_7.x + _loc_13 + _loc_11 - AtouinConstants.CELL_HALF_WIDTH;
                    _loc_16.top = _loc_7.y + _loc_14 - _loc_19 - _loc_8;
                    _loc_16.width = _loc_9;
                    _loc_16.height = _loc_8 + AtouinConstants.CELL_HEIGHT * 2;
                    if (!_loc_17[_loc_25.cellId])
                    {
                        _loc_17[_loc_25.cellId] = {r:_loc_16.clone(), gfx:_loc_18};
                        continue;
                    }
                    _loc_17[_loc_25.cellId].r = _loc_17[_loc_25.cellId].r.union(_loc_16);
                    _loc_17[_loc_25.cellId].gfx = _loc_17[_loc_25.cellId].gfx.concat(_loc_18);
                }
            }
            _loc_18 = new Array();
            _loc_10 = 0;
            while (_loc_10 < _loc_17.length)
            {
                
                if (!_loc_17[_loc_10])
                {
                }
                else
                {
                    _loc_16 = _loc_17[_loc_10].r;
                    if (_loc_16 && _loc_16.intersects(_loc_15) == param1)
                    {
                        _loc_6.cell[_loc_10] = true;
                        _loc_28 = 0;
                        while (_loc_28 < _loc_17[_loc_10].gfx.length)
                        {
                            
                            _loc_18[_loc_17[_loc_10].gfx[_loc_28]] = true;
                            _loc_28 = _loc_28 + 1;
                        }
                    }
                }
                _loc_10 = _loc_10 + 1;
            }
            for (_loc_24 in _loc_18)
            {
                
                _loc_6.gfx.push(_loc_24);
            }
            return _loc_6;
        }// end function

    }
}

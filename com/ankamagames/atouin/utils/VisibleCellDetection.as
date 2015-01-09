package com.ankamagames.atouin.utils
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.geom.Point;
    import com.ankamagames.atouin.data.elements.GraphicalElementData;
    import com.ankamagames.atouin.data.map.Layer;
    import com.ankamagames.atouin.data.map.Cell;
    import com.ankamagames.atouin.data.map.elements.BasicElement;
    import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
    import com.ankamagames.atouin.types.miscs.PartialDataMap;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.display.Sprite;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.atouin.data.elements.Elements;
    import com.ankamagames.atouin.enums.ElementTypesEnum;
    import com.ankamagames.atouin.data.map.elements.GraphicalElement;
    import com.ankamagames.atouin.data.map.Map;
    import com.ankamagames.jerakine.types.positions.WorldPoint;
    import com.ankamagames.atouin.types.Frustum;

    public class VisibleCellDetection 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(VisibleCellDetection));


        public static function detectCell(visible:Boolean, map:Map, pMap:WorldPoint, frustum:Frustum, currentMapPoint:WorldPoint):PartialDataMap
        {
            var p:Point;
            var alt:int;
            var width:int;
            var i:uint;
            var left:int;
            var elementData:GraphicalElementData;
            var bottom:int;
            var bottomTmp:int;
            var layer:Layer;
            var s:String;
            var cell:Cell;
            var element:BasicElement;
            var ged:NormalGraphicalElementData;
            var j:uint;
            if (currentMapPoint == null)
            {
                _log.error("Cannot detect visible cells with no current map point.");
                return (null);
            };
            var pdm:PartialDataMap = new PartialDataMap();
            var ox:int = (((pMap.x - currentMapPoint.x) * AtouinConstants.CELL_WIDTH) * AtouinConstants.MAP_WIDTH);
            var oy:int = (((pMap.y - currentMapPoint.y) * AtouinConstants.CELL_HEIGHT) * AtouinConstants.MAP_HEIGHT);
            var rv:Rectangle = new Rectangle((-(frustum.x) / frustum.scale), (-(frustum.y) / frustum.scale), (StageShareManager.startHeight / frustum.scale), (StageShareManager.stage.stageHeight / frustum.scale));
            var rcv:Rectangle = new Rectangle();
            var aCell:Array = new Array();
            var aGfx:Array = new Array();
            var spDebug:Sprite = (Sprite(Atouin.getInstance().worldContainer.parent).addChild(new Sprite()) as Sprite);
            spDebug.graphics.beginFill(0, 0);
            spDebug.graphics.lineStyle(1, 0xFF0000);
            var ele:Elements = Elements.getInstance();
            for each (layer in map.layers)
            {
                for each (cell in layer.cells)
                {
                    alt = 0;
                    width = 0;
                    left = 100000;
                    bottom = 0;
                    aGfx = new Array();
                    for each (element in cell.elements)
                    {
                        if (element.elementType == ElementTypesEnum.GRAPHICAL)
                        {
                            elementData = ele.getElementData(GraphicalElement(element).elementId);
                            bottomTmp = (GraphicalElement(element).altitude * AtouinConstants.ALTITUDE_PIXEL_UNIT);
                            bottom = (((bottomTmp < bottom)) ? bottomTmp : bottom);
                            if (((elementData) && ((elementData is NormalGraphicalElementData))))
                            {
                                ged = (elementData as NormalGraphicalElementData);
                                if ((-(ged.origin.x) + AtouinConstants.CELL_WIDTH) < left)
                                {
                                    left = (-(ged.origin.x) + AtouinConstants.CELL_WIDTH);
                                };
                                if (ged.size.x > width)
                                {
                                    width = ged.size.x;
                                };
                                alt = (alt + (ged.origin.y + ged.size.y));
                                aGfx.push(ged.gfxId);
                            }
                            else
                            {
                                alt = (alt + Math.abs(bottomTmp));
                            };
                        };
                    };
                    if (!(alt))
                    {
                        alt = AtouinConstants.CELL_HEIGHT;
                    };
                    if (left == 100000)
                    {
                        left = 0;
                    };
                    if (width < AtouinConstants.CELL_WIDTH)
                    {
                        width = AtouinConstants.CELL_WIDTH;
                    };
                    p = Cell.cellPixelCoords(cell.cellId);
                    rcv.left = (((p.x + ox) + left) - AtouinConstants.CELL_HALF_WIDTH);
                    rcv.top = (((p.y + oy) - bottom) - alt);
                    rcv.width = width;
                    rcv.height = (alt + (AtouinConstants.CELL_HEIGHT * 2));
                    if (!(aCell[cell.cellId]))
                    {
                        aCell[cell.cellId] = {
                            "r":rcv.clone(),
                            "gfx":aGfx
                        };
                    }
                    else
                    {
                        aCell[cell.cellId].r = aCell[cell.cellId].r.union(rcv);
                        aCell[cell.cellId].gfx = aCell[cell.cellId].gfx.concat(aGfx);
                    };
                };
            };
            aGfx = new Array();
            i = 0;
            while (i < aCell.length)
            {
                if (!(aCell[i]))
                {
                }
                else
                {
                    rcv = aCell[i].r;
                    if (((rcv) && ((rcv.intersects(rv) == visible))))
                    {
                        pdm.cell[i] = true;
                        j = 0;
                        while (j < aCell[i].gfx.length)
                        {
                            aGfx[aCell[i].gfx[j]] = true;
                            j++;
                        };
                    };
                };
                i++;
            };
            for (s in aGfx)
            {
                pdm.gfx.push(s);
            };
            return (pdm);
        }


    }
}//package com.ankamagames.atouin.utils


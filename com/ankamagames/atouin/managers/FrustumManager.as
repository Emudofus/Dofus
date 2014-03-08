package com.ankamagames.atouin.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.atouin.types.FrustumShape;
   import com.ankamagames.atouin.types.Frustum;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import flash.events.MouseEvent;
   import flash.display.Sprite;
   import flash.geom.Point;
   import com.ankamagames.atouin.AtouinConstants;
   import __AS3__.vec.*;
   import flash.display.Bitmap;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.AdjacentMapOutMessage;
   import flash.display.DisplayObject;
   import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class FrustumManager extends Object
   {
      
      public function FrustumManager() {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FrustumManager));
      
      private static var _self:FrustumManager;
      
      public static function getInstance() : FrustumManager {
         if(!_self)
         {
            _self = new FrustumManager();
         }
         return _self;
      }
      
      private var _frustumContainer:DisplayObjectContainer;
      
      private var _shapeTop:FrustumShape;
      
      private var _shapeRight:FrustumShape;
      
      private var _shapeBottom:FrustumShape;
      
      private var _shapeLeft:FrustumShape;
      
      private var _frustrum:Frustum;
      
      private var _lastCellId:int;
      
      private var _enable:Boolean;
      
      public function init(frustumContainer:DisplayObjectContainer) : void {
         this._frustumContainer = frustumContainer;
         this._shapeTop = new FrustumShape(DirectionsEnum.UP);
         this._shapeRight = new FrustumShape(DirectionsEnum.RIGHT);
         this._shapeBottom = new FrustumShape(DirectionsEnum.DOWN);
         this._shapeLeft = new FrustumShape(DirectionsEnum.LEFT);
         this._frustumContainer.addChild(this._shapeLeft);
         this._frustumContainer.addChild(this._shapeTop);
         this._frustumContainer.addChild(this._shapeRight);
         this._frustumContainer.addChild(this._shapeBottom);
         this._shapeLeft.buttonMode = true;
         this._shapeTop.buttonMode = true;
         this._shapeRight.buttonMode = true;
         this._shapeBottom.buttonMode = true;
         this._shapeLeft.addEventListener(MouseEvent.CLICK,this.click);
         this._shapeTop.addEventListener(MouseEvent.CLICK,this.click);
         this._shapeRight.addEventListener(MouseEvent.CLICK,this.click);
         this._shapeBottom.addEventListener(MouseEvent.CLICK,this.click);
         this._shapeLeft.addEventListener(MouseEvent.MOUSE_OVER,this.mouseMove);
         this._shapeTop.addEventListener(MouseEvent.MOUSE_OVER,this.mouseMove);
         this._shapeRight.addEventListener(MouseEvent.MOUSE_OVER,this.mouseMove);
         this._shapeBottom.addEventListener(MouseEvent.MOUSE_OVER,this.mouseMove);
         this._shapeLeft.addEventListener(MouseEvent.MOUSE_OUT,this.out);
         this._shapeTop.addEventListener(MouseEvent.MOUSE_OUT,this.out);
         this._shapeRight.addEventListener(MouseEvent.MOUSE_OUT,this.out);
         this._shapeBottom.addEventListener(MouseEvent.MOUSE_OUT,this.out);
         this._shapeLeft.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this._shapeTop.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this._shapeRight.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this._shapeBottom.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this.setBorderInteraction(false);
         this._lastCellId = -1;
      }
      
      public function setBorderInteraction(enable:Boolean) : void {
         this._enable = enable;
         this._shapeTop.mouseEnabled = enable;
         this._shapeRight.mouseEnabled = enable;
         this._shapeBottom.mouseEnabled = enable;
         this._shapeLeft.mouseEnabled = enable;
         this.updateMap();
      }
      
      public function updateMap() : void {
         if(this._enable)
         {
            this._shapeTop.mouseEnabled = !(this.findNearestCell(this._shapeTop).cell == -1);
            this._shapeRight.mouseEnabled = !(this.findNearestCell(this._shapeRight).cell == -1);
            this._shapeBottom.mouseEnabled = !(this.findNearestCell(this._shapeBottom).cell == -1);
            this._shapeLeft.mouseEnabled = !(this.findNearestCell(this._shapeLeft).cell == -1);
         }
      }
      
      public function getShape(direction:int) : Sprite {
         switch(direction)
         {
            case DirectionsEnum.UP:
               return this._shapeTop;
            case DirectionsEnum.LEFT:
               return this._shapeLeft;
            case DirectionsEnum.RIGHT:
               return this._shapeRight;
            case DirectionsEnum.DOWN:
               return this._shapeBottom;
         }
      }
      
      public function set frustum(rFrustum:Frustum) : void {
         this._frustrum = rFrustum;
         var pTopLeftInner:Point = new Point(rFrustum.x + AtouinConstants.CELL_HALF_WIDTH * rFrustum.scale,rFrustum.y + AtouinConstants.CELL_HALF_HEIGHT * rFrustum.scale);
         var pTopRightInner:Point = new Point(rFrustum.x - AtouinConstants.CELL_HALF_WIDTH * rFrustum.scale + rFrustum.width,rFrustum.y + AtouinConstants.CELL_HALF_HEIGHT * rFrustum.scale);
         var pBottomLeftInner:Point = new Point(rFrustum.x + AtouinConstants.CELL_HALF_WIDTH * rFrustum.scale,rFrustum.y - AtouinConstants.CELL_HEIGHT * rFrustum.scale + rFrustum.height);
         var pBottomRightInner:Point = new Point(rFrustum.x - AtouinConstants.CELL_HALF_WIDTH * rFrustum.scale + rFrustum.width,rFrustum.y - AtouinConstants.CELL_HEIGHT * rFrustum.scale + rFrustum.height);
         var pTopLeft:Point = new Point(rFrustum.x,rFrustum.y);
         var pTopRight:Point = new Point(rFrustum.x + rFrustum.width,rFrustum.y);
         var pBottomLeft:Point = new Point(rFrustum.x,rFrustum.y + rFrustum.height - AtouinConstants.CELL_HALF_HEIGHT * rFrustum.scale);
         var pBottomRight:Point = new Point(rFrustum.x + rFrustum.width,rFrustum.y + rFrustum.height - AtouinConstants.CELL_HALF_HEIGHT * rFrustum.scale);
         var alphaShape:Number = 1;
         var commands:Vector.<int> = new Vector.<int>(7,true);
         commands[0] = 1;
         commands[1] = 2;
         commands[2] = 2;
         commands[3] = 2;
         commands[4] = 2;
         commands[5] = 2;
         commands[6] = 2;
         var leftCoords:Vector.<Number> = new Vector.<Number>(14,true);
         leftCoords[0] = 0;
         leftCoords[1] = pTopLeft.y;
         leftCoords[2] = pTopLeft.x;
         leftCoords[3] = pTopLeft.y;
         leftCoords[4] = pTopLeftInner.x;
         leftCoords[5] = pTopLeftInner.y;
         leftCoords[6] = pBottomLeftInner.x;
         leftCoords[7] = pBottomLeftInner.y;
         leftCoords[8] = pBottomLeft.x;
         leftCoords[9] = pBottomLeft.y;
         leftCoords[10] = 0;
         leftCoords[11] = pBottomLeft.y;
         leftCoords[12] = 0;
         leftCoords[13] = pTopLeft.y;
         var bmpShape:Bitmap = this.drawShape(16746564,commands,leftCoords);
         if(bmpShape != null)
         {
            this._shapeLeft.addChild(bmpShape);
         }
         var topCoords:Vector.<Number> = new Vector.<Number>(14,true);
         topCoords[0] = pTopLeft.x;
         topCoords[1] = 0;
         topCoords[2] = pTopLeft.x;
         topCoords[3] = pTopLeft.y;
         topCoords[4] = pTopLeftInner.x;
         topCoords[5] = pTopLeftInner.y;
         topCoords[6] = pTopRightInner.x;
         topCoords[7] = pTopRightInner.y;
         topCoords[8] = pTopRight.x;
         topCoords[9] = pTopRight.y;
         topCoords[10] = pTopRight.x;
         topCoords[11] = 0;
         topCoords[12] = 0;
         topCoords[13] = 0;
         bmpShape = this.drawShape(7803289,commands,topCoords);
         if(bmpShape != null)
         {
            this._shapeTop.addChild(bmpShape);
         }
         var rightCoords:Vector.<Number> = new Vector.<Number>(14,true);
         rightCoords[0] = StageShareManager.startWidth;
         rightCoords[1] = pTopRight.y;
         rightCoords[2] = pTopRight.x;
         rightCoords[3] = pTopRight.y;
         rightCoords[4] = pTopRightInner.x;
         rightCoords[5] = pTopRightInner.y;
         rightCoords[6] = pBottomRightInner.x;
         rightCoords[7] = pBottomRightInner.y;
         rightCoords[8] = pBottomRight.x;
         rightCoords[9] = pBottomRight.y;
         rightCoords[10] = StageShareManager.startWidth;
         rightCoords[11] = pBottomRight.y;
         rightCoords[12] = StageShareManager.startWidth;
         rightCoords[13] = pTopRight.y;
         bmpShape = this.drawShape(1218969,commands,rightCoords);
         if(bmpShape != null)
         {
            bmpShape.x = StageShareManager.startWidth - bmpShape.width;
            bmpShape.y = 15;
            this._shapeRight.addChild(bmpShape);
         }
         var bottomCoords:Vector.<Number> = new Vector.<Number>(14,true);
         bottomCoords[0] = pBottomRight.x;
         bottomCoords[1] = StageShareManager.startHeight;
         bottomCoords[2] = pBottomRight.x;
         bottomCoords[3] = pBottomRight.y;
         bottomCoords[4] = pBottomRightInner.x;
         bottomCoords[5] = pBottomRightInner.y + 10;
         bottomCoords[6] = pBottomLeftInner.x;
         bottomCoords[7] = pBottomLeftInner.y + 10;
         bottomCoords[8] = pBottomLeft.x;
         bottomCoords[9] = pBottomLeft.y;
         bottomCoords[10] = pBottomLeft.x;
         bottomCoords[11] = StageShareManager.startHeight;
         bottomCoords[12] = pBottomRight.x;
         bottomCoords[13] = StageShareManager.startHeight;
         bmpShape = this.drawShape(7807590,commands,bottomCoords);
         if(bmpShape != null)
         {
            bmpShape.y = StageShareManager.startHeight - bmpShape.height;
            this._shapeBottom.addChild(bmpShape);
         }
      }
      
      private function drawShape(pColor:uint, pCommands:Vector.<int>, pCoords:Vector.<Number>) : Bitmap {
         var sBmp:BitmapData = null;
         var sShape:Shape = new Shape();
         sShape.graphics.beginFill(pColor,0);
         sShape.graphics.drawPath(pCommands,pCoords);
         sShape.graphics.endFill();
         if((sShape.width > 0) && (sShape.height > 0))
         {
            sBmp = new BitmapData(sShape.width,sShape.height,true,16777215);
            sBmp.draw(sShape);
            sShape.graphics.clear();
            sShape = null;
            return new Bitmap(sBmp);
         }
         return null;
      }
      
      private function click(e:MouseEvent) : void {
         var destMapId:uint = 0;
         var currentMap:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         switch(e.target)
         {
            case this._shapeRight:
               destMapId = currentMap.rightNeighbourId;
               break;
            case this._shapeLeft:
               destMapId = currentMap.leftNeighbourId;
               break;
            case this._shapeBottom:
               destMapId = currentMap.bottomNeighbourId;
               break;
            case this._shapeTop:
               destMapId = currentMap.topNeighbourId;
               break;
         }
         var localMousePosition:Point = new Point(isNaN(e.localX)?Sprite(e.target).mouseX:e.localX,isNaN(e.localY)?Sprite(e.target).mouseY:e.localY);
         var cellData:Object = this.findNearestCell(e.target as Sprite,localMousePosition);
         if(cellData.cell == -1)
         {
            return;
         }
         if(!cellData.custom)
         {
            this.sendClickAdjacentMsg(destMapId,cellData.cell);
         }
         else
         {
            this.sendCellClickMsg(destMapId,cellData.cell);
         }
      }
      
      private function findCustomNearestCell(target:Sprite, localMousePosition:Point=null) : Object {
         var cellList:Array = null;
         var p:Point = null;
         var d:* = NaN;
         var floor:* = 0;
         var cellId:uint = 0;
         var currentCellId:uint = 0;
         var currentMap:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         var x:uint = 0;
         var y:uint = 0;
         if(!localMousePosition)
         {
            localMousePosition = new Point(target.mouseX,target.mouseY);
         }
         switch(target)
         {
            case this._shapeRight:
               y = 1;
               cellList = currentMap.rightArrowCell;
               break;
            case this._shapeLeft:
               y = 1;
               cellList = currentMap.leftArrowCell;
               break;
            case this._shapeBottom:
               x = 1;
               cellList = currentMap.bottomArrowCell;
               break;
            case this._shapeTop:
               x = 1;
               cellList = currentMap.topArrowCell;
               break;
         }
         if((!cellList) || (!cellList.length))
         {
            return 
               {
                  "cell":-1,
                  "distance":Number.MAX_VALUE
               };
         }
         var currentDist:Number = Number.MAX_VALUE;
         var i:uint = 0;
         while(i < cellList.length)
         {
            cellId = cellList[i];
            p = Cell.cellPixelCoords(cellId);
            floor = CellData(currentMap.cells[cellId]).floor;
            if(y == 1)
            {
               d = Math.abs(localMousePosition.x - this._frustrum.y - (p.y - floor + AtouinConstants.CELL_HALF_HEIGHT) * this._frustrum.scale);
            }
            if(x == 1)
            {
               d = Math.abs(localMousePosition.x - this._frustrum.x - (p.x + AtouinConstants.CELL_HALF_WIDTH) * this._frustrum.scale);
            }
            if(d < currentDist)
            {
               currentDist = d;
               currentCellId = cellId;
            }
            i++;
         }
         return 
            {
               "cell":currentCellId,
               "distance":currentDist
            };
      }
      
      private function findNearestCell(target:Sprite, localMousePosition:Point=null) : Object {
         var x:* = 0;
         var y:* = 0;
         var sx:* = 0;
         var sy:* = 0;
         var p:Point = null;
         var floor:* = 0;
         var d:* = NaN;
         var destMapId:uint = 0;
         var i:uint = 0;
         var limit:uint = 0;
         var cellId:* = 0;
         var cellData:CellData = null;
         var mapChangeData:uint = 0;
         var currentMap:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         var near:Number = Number.MAX_VALUE;
         if(!localMousePosition)
         {
            localMousePosition = new Point(target.mouseX,target.mouseY);
         }
         switch(target)
         {
            case this._shapeRight:
               x = AtouinConstants.MAP_WIDTH - 1;
               y = AtouinConstants.MAP_WIDTH - 1;
               destMapId = currentMap.rightNeighbourId;
               break;
            case this._shapeLeft:
               x = 0;
               y = 0;
               destMapId = currentMap.leftNeighbourId;
               break;
            case this._shapeBottom:
               x = AtouinConstants.MAP_HEIGHT - 1;
               y = -(AtouinConstants.MAP_HEIGHT - 1);
               destMapId = currentMap.bottomNeighbourId;
               break;
            case this._shapeTop:
               x = 0;
               y = 0;
               destMapId = currentMap.topNeighbourId;
               break;
         }
         var customData:Object = this.findCustomNearestCell(target);
         if(customData.cell != -1)
         {
            near = customData.distance;
            sx = CellIdConverter.cellIdToCoord(customData.cell).x;
            sy = CellIdConverter.cellIdToCoord(customData.cell).y;
         }
         if((target == this._shapeRight) || (target == this._shapeLeft))
         {
            limit = AtouinConstants.MAP_HEIGHT * 2;
            i = 0;
            while(i < limit)
            {
               cellId = CellIdConverter.coordToCellId(x,y);
               p = Cell.cellPixelCoords(cellId);
               floor = CellData(currentMap.cells[cellId]).floor;
               d = Math.abs(localMousePosition.y - this._frustrum.y - (p.y - floor + AtouinConstants.CELL_HALF_HEIGHT) * this._frustrum.scale);
               if(d < near)
               {
                  cellData = currentMap.cells[cellId] as CellData;
                  mapChangeData = cellData.mapChangeData;
                  if((mapChangeData) && ((target == this._shapeRight) && ((mapChangeData & 1) || (((cellId + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0) && (mapChangeData & 2)) || ((cellId + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0) && (mapChangeData & 128)) || (target == this._shapeLeft) && (((x == -y) && (mapChangeData & 8)) || (mapChangeData & 16) || (x == -y) && (mapChangeData & 32))))
                  {
                     sx = x;
                     sy = y;
                     near = d;
                  }
               }
               if(!(i % 2))
               {
                  x++;
               }
               else
               {
                  y--;
               }
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < AtouinConstants.MAP_WIDTH * 2)
            {
               cellId = CellIdConverter.coordToCellId(x,y);
               p = Cell.cellPixelCoords(cellId);
               d = Math.abs(localMousePosition.x - this._frustrum.x - (p.x + AtouinConstants.CELL_HALF_WIDTH) * this._frustrum.scale);
               if(d < near)
               {
                  cellData = currentMap.cells[cellId] as CellData;
                  mapChangeData = cellData.mapChangeData;
                  if((mapChangeData) && ((target == this._shapeTop) && (((cellId < AtouinConstants.MAP_WIDTH) && (mapChangeData & 32)) || (mapChangeData & 64) || (cellId < AtouinConstants.MAP_WIDTH) && (mapChangeData & 128)) || (target == this._shapeBottom) && (((cellId >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH) && (mapChangeData & 2)) || (mapChangeData & 4) || (cellId >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH) && (mapChangeData & 8))))
                  {
                     sx = x;
                     sy = y;
                     near = d;
                  }
               }
               if(!(i % 2))
               {
                  x++;
               }
               else
               {
                  y++;
               }
               i++;
            }
         }
         if(near != Number.MAX_VALUE)
         {
            return 
               {
                  "cell":CellIdConverter.coordToCellId(sx,sy),
                  "custom":near == customData.distance
               };
         }
         return 
            {
               "cell":-1,
               "custom":false
            };
      }
      
      private function sendClickAdjacentMsg(mapId:uint, cellId:uint) : void {
         var msg:AdjacentMapClickMessage = new AdjacentMapClickMessage();
         msg.cellId = cellId;
         msg.adjacentMapId = mapId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function sendCellClickMsg(mapId:uint, cellId:uint) : void {
         var msg:CellClickMessage = new CellClickMessage();
         msg.cellId = cellId;
         msg.id = mapId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function out(e:MouseEvent) : void {
         var n:uint = 0;
         switch(e.target)
         {
            case this._shapeRight:
               n = DirectionsEnum.RIGHT;
               break;
            case this._shapeLeft:
               n = DirectionsEnum.LEFT;
               break;
            case this._shapeBottom:
               n = DirectionsEnum.DOWN;
               break;
            case this._shapeTop:
               n = DirectionsEnum.UP;
               break;
         }
         this._lastCellId = -1;
         var msg:AdjacentMapOutMessage = new AdjacentMapOutMessage(n,DisplayObject(e.target));
         Atouin.getInstance().handler.process(msg);
      }
      
      private function mouseMove(e:MouseEvent) : void {
         var n:uint = 0;
         switch(e.target)
         {
            case this._shapeRight:
               n = DirectionsEnum.RIGHT;
               break;
            case this._shapeLeft:
               n = DirectionsEnum.LEFT;
               break;
            case this._shapeBottom:
               n = DirectionsEnum.DOWN;
               break;
            case this._shapeTop:
               n = DirectionsEnum.UP;
               break;
         }
         var cellId:int = this.findNearestCell(e.target as Sprite).cell;
         if((cellId == -1) || (cellId == this._lastCellId))
         {
            return;
         }
         this._lastCellId = cellId;
         var cellData:CellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId] as CellData;
         var msg:AdjacentMapOverMessage = new AdjacentMapOverMessage(n,DisplayObject(e.target),cellId,cellData);
         Atouin.getInstance().handler.process(msg);
      }
   }
}

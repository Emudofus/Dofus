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
   import __AS3__.vec.Vector;
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
      
      public function init(param1:DisplayObjectContainer) : void {
         this._frustumContainer = param1;
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
      
      public function setBorderInteraction(param1:Boolean) : void {
         this._enable = param1;
         this._shapeTop.mouseEnabled = param1;
         this._shapeRight.mouseEnabled = param1;
         this._shapeBottom.mouseEnabled = param1;
         this._shapeLeft.mouseEnabled = param1;
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
      
      public function getShape(param1:int) : Sprite {
         switch(param1)
         {
            case DirectionsEnum.UP:
               return this._shapeTop;
            case DirectionsEnum.LEFT:
               return this._shapeLeft;
            case DirectionsEnum.RIGHT:
               return this._shapeRight;
            case DirectionsEnum.DOWN:
               return this._shapeBottom;
            default:
               return null;
         }
      }
      
      public function set frustum(param1:Frustum) : void {
         this._frustrum = param1;
         var _loc2_:Point = new Point(param1.x + AtouinConstants.CELL_HALF_WIDTH * param1.scale,param1.y + AtouinConstants.CELL_HALF_HEIGHT * param1.scale);
         var _loc3_:Point = new Point(param1.x - AtouinConstants.CELL_HALF_WIDTH * param1.scale + param1.width,param1.y + AtouinConstants.CELL_HALF_HEIGHT * param1.scale);
         var _loc4_:Point = new Point(param1.x + AtouinConstants.CELL_HALF_WIDTH * param1.scale,param1.y - AtouinConstants.CELL_HEIGHT * param1.scale + param1.height);
         var _loc5_:Point = new Point(param1.x - AtouinConstants.CELL_HALF_WIDTH * param1.scale + param1.width,param1.y - AtouinConstants.CELL_HEIGHT * param1.scale + param1.height);
         var _loc6_:Point = new Point(param1.x,param1.y);
         var _loc7_:Point = new Point(param1.x + param1.width,param1.y);
         var _loc8_:Point = new Point(param1.x,param1.y + param1.height - AtouinConstants.CELL_HALF_HEIGHT * param1.scale);
         var _loc9_:Point = new Point(param1.x + param1.width,param1.y + param1.height - AtouinConstants.CELL_HALF_HEIGHT * param1.scale);
         var _loc10_:Number = 1;
         var _loc11_:Vector.<int> = new Vector.<int>(7,true);
         _loc11_[0] = 1;
         _loc11_[1] = 2;
         _loc11_[2] = 2;
         _loc11_[3] = 2;
         _loc11_[4] = 2;
         _loc11_[5] = 2;
         _loc11_[6] = 2;
         var _loc12_:Vector.<Number> = new Vector.<Number>(14,true);
         _loc12_[0] = 0;
         _loc12_[1] = _loc6_.y;
         _loc12_[2] = _loc6_.x;
         _loc12_[3] = _loc6_.y;
         _loc12_[4] = _loc2_.x;
         _loc12_[5] = _loc2_.y;
         _loc12_[6] = _loc4_.x;
         _loc12_[7] = _loc4_.y;
         _loc12_[8] = _loc8_.x;
         _loc12_[9] = _loc8_.y;
         _loc12_[10] = 0;
         _loc12_[11] = _loc8_.y;
         _loc12_[12] = 0;
         _loc12_[13] = _loc6_.y;
         var _loc13_:Bitmap = this.drawShape(16746564,_loc11_,_loc12_);
         if(_loc13_ != null)
         {
            this._shapeLeft.addChild(_loc13_);
         }
         var _loc14_:Vector.<Number> = new Vector.<Number>(14,true);
         _loc14_[0] = _loc6_.x;
         _loc14_[1] = 0;
         _loc14_[2] = _loc6_.x;
         _loc14_[3] = _loc6_.y;
         _loc14_[4] = _loc2_.x;
         _loc14_[5] = _loc2_.y;
         _loc14_[6] = _loc3_.x;
         _loc14_[7] = _loc3_.y;
         _loc14_[8] = _loc7_.x;
         _loc14_[9] = _loc7_.y;
         _loc14_[10] = _loc7_.x;
         _loc14_[11] = 0;
         _loc14_[12] = 0;
         _loc14_[13] = 0;
         _loc13_ = this.drawShape(7803289,_loc11_,_loc14_);
         if(_loc13_ != null)
         {
            this._shapeTop.addChild(_loc13_);
         }
         var _loc15_:Vector.<Number> = new Vector.<Number>(14,true);
         _loc15_[0] = StageShareManager.startWidth;
         _loc15_[1] = _loc7_.y;
         _loc15_[2] = _loc7_.x;
         _loc15_[3] = _loc7_.y;
         _loc15_[4] = _loc3_.x;
         _loc15_[5] = _loc3_.y;
         _loc15_[6] = _loc5_.x;
         _loc15_[7] = _loc5_.y;
         _loc15_[8] = _loc9_.x;
         _loc15_[9] = _loc9_.y;
         _loc15_[10] = StageShareManager.startWidth;
         _loc15_[11] = _loc9_.y;
         _loc15_[12] = StageShareManager.startWidth;
         _loc15_[13] = _loc7_.y;
         _loc13_ = this.drawShape(1218969,_loc11_,_loc15_);
         if(_loc13_ != null)
         {
            _loc13_.x = StageShareManager.startWidth - _loc13_.width;
            _loc13_.y = 15;
            this._shapeRight.addChild(_loc13_);
         }
         var _loc16_:Vector.<Number> = new Vector.<Number>(14,true);
         _loc16_[0] = _loc9_.x;
         _loc16_[1] = StageShareManager.startHeight;
         _loc16_[2] = _loc9_.x;
         _loc16_[3] = _loc9_.y;
         _loc16_[4] = _loc5_.x;
         _loc16_[5] = _loc5_.y + 10;
         _loc16_[6] = _loc4_.x;
         _loc16_[7] = _loc4_.y + 10;
         _loc16_[8] = _loc8_.x;
         _loc16_[9] = _loc8_.y;
         _loc16_[10] = _loc8_.x;
         _loc16_[11] = StageShareManager.startHeight;
         _loc16_[12] = _loc9_.x;
         _loc16_[13] = StageShareManager.startHeight;
         _loc13_ = this.drawShape(7807590,_loc11_,_loc16_);
         if(_loc13_ != null)
         {
            _loc13_.y = StageShareManager.startHeight - _loc13_.height;
            this._shapeBottom.addChild(_loc13_);
         }
      }
      
      private function drawShape(param1:uint, param2:Vector.<int>, param3:Vector.<Number>) : Bitmap {
         var _loc5_:BitmapData = null;
         var _loc4_:Shape = new Shape();
         _loc4_.graphics.beginFill(param1,0);
         _loc4_.graphics.drawPath(param2,param3);
         _loc4_.graphics.endFill();
         if(_loc4_.width > 0 && _loc4_.height > 0)
         {
            _loc5_ = new BitmapData(_loc4_.width,_loc4_.height,true,16777215);
            _loc5_.draw(_loc4_);
            _loc4_.graphics.clear();
            _loc4_ = null;
            return new Bitmap(_loc5_);
         }
         return null;
      }
      
      private function click(param1:MouseEvent) : void {
         var _loc2_:uint = 0;
         var _loc3_:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         switch(param1.target)
         {
            case this._shapeRight:
               _loc2_ = _loc3_.rightNeighbourId;
               break;
            case this._shapeLeft:
               _loc2_ = _loc3_.leftNeighbourId;
               break;
            case this._shapeBottom:
               _loc2_ = _loc3_.bottomNeighbourId;
               break;
            case this._shapeTop:
               _loc2_ = _loc3_.topNeighbourId;
               break;
         }
         var _loc4_:Point = new Point(isNaN(param1.localX)?Sprite(param1.target).mouseX:param1.localX,isNaN(param1.localY)?Sprite(param1.target).mouseY:param1.localY);
         var _loc5_:Object = this.findNearestCell(param1.target as Sprite,_loc4_);
         if(_loc5_.cell == -1)
         {
            return;
         }
         if(!_loc5_.custom)
         {
            this.sendClickAdjacentMsg(_loc2_,_loc5_.cell);
         }
         else
         {
            this.sendCellClickMsg(_loc2_,_loc5_.cell);
         }
      }
      
      private function findCustomNearestCell(param1:Sprite, param2:Point=null) : Object {
         var _loc6_:Array = null;
         var _loc7_:Point = null;
         var _loc8_:* = NaN;
         var _loc9_:* = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(!param2)
         {
            param2 = new Point(param1.mouseX,param1.mouseY);
         }
         switch(param1)
         {
            case this._shapeRight:
               _loc5_ = 1;
               _loc6_ = _loc3_.rightArrowCell;
               break;
            case this._shapeLeft:
               _loc5_ = 1;
               _loc6_ = _loc3_.leftArrowCell;
               break;
            case this._shapeBottom:
               _loc4_ = 1;
               _loc6_ = _loc3_.bottomArrowCell;
               break;
            case this._shapeTop:
               _loc4_ = 1;
               _loc6_ = _loc3_.topArrowCell;
               break;
         }
         if(!_loc6_ || !_loc6_.length)
         {
            return 
               {
                  "cell":-1,
                  "distance":Number.MAX_VALUE
               };
         }
         var _loc12_:Number = Number.MAX_VALUE;
         var _loc13_:uint = 0;
         while(_loc13_ < _loc6_.length)
         {
            _loc10_ = _loc6_[_loc13_];
            _loc7_ = Cell.cellPixelCoords(_loc10_);
            _loc9_ = CellData(_loc3_.cells[_loc10_]).floor;
            if(_loc5_ == 1)
            {
               _loc8_ = Math.abs(param2.x - this._frustrum.y - (_loc7_.y - _loc9_ + AtouinConstants.CELL_HALF_HEIGHT) * this._frustrum.scale);
            }
            if(_loc4_ == 1)
            {
               _loc8_ = Math.abs(param2.x - this._frustrum.x - (_loc7_.x + AtouinConstants.CELL_HALF_WIDTH) * this._frustrum.scale);
            }
            if(_loc8_ < _loc12_)
            {
               _loc12_ = _loc8_;
               _loc11_ = _loc10_;
            }
            _loc13_++;
         }
         return 
            {
               "cell":_loc11_,
               "distance":_loc12_
            };
      }
      
      private function findNearestCell(param1:Sprite, param2:Point=null) : Object {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:Point = null;
         var _loc8_:* = 0;
         var _loc9_:* = NaN;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc14_:* = 0;
         var _loc16_:CellData = null;
         var _loc17_:uint = 0;
         var _loc13_:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         var _loc15_:Number = Number.MAX_VALUE;
         if(!param2)
         {
            param2 = new Point(param1.mouseX,param1.mouseY);
         }
         switch(param1)
         {
            case this._shapeRight:
               _loc3_ = AtouinConstants.MAP_WIDTH-1;
               _loc4_ = AtouinConstants.MAP_WIDTH-1;
               _loc10_ = _loc13_.rightNeighbourId;
               break;
            case this._shapeLeft:
               _loc3_ = 0;
               _loc4_ = 0;
               _loc10_ = _loc13_.leftNeighbourId;
               break;
            case this._shapeBottom:
               _loc3_ = AtouinConstants.MAP_HEIGHT-1;
               _loc4_ = -(AtouinConstants.MAP_HEIGHT-1);
               _loc10_ = _loc13_.bottomNeighbourId;
               break;
            case this._shapeTop:
               _loc3_ = 0;
               _loc4_ = 0;
               _loc10_ = _loc13_.topNeighbourId;
               break;
         }
         var _loc18_:Object = this.findCustomNearestCell(param1);
         if(_loc18_.cell != -1)
         {
            _loc15_ = _loc18_.distance;
            _loc5_ = CellIdConverter.cellIdToCoord(_loc18_.cell).x;
            _loc6_ = CellIdConverter.cellIdToCoord(_loc18_.cell).y;
         }
         if(param1 == this._shapeRight || param1 == this._shapeLeft)
         {
            _loc12_ = AtouinConstants.MAP_HEIGHT * 2;
            _loc11_ = 0;
            while(_loc11_ < _loc12_)
            {
               _loc14_ = CellIdConverter.coordToCellId(_loc3_,_loc4_);
               _loc7_ = Cell.cellPixelCoords(_loc14_);
               _loc8_ = CellData(_loc13_.cells[_loc14_]).floor;
               _loc9_ = Math.abs(param2.y - this._frustrum.y - (_loc7_.y - _loc8_ + AtouinConstants.CELL_HALF_HEIGHT) * this._frustrum.scale);
               if(_loc9_ < _loc15_)
               {
                  _loc16_ = _loc13_.cells[_loc14_] as CellData;
                  _loc17_ = _loc16_.mapChangeData;
                  if((_loc17_) && ((param1 == this._shapeRight) && ((_loc17_ & 1) || (((_loc14_ + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0) && (_loc17_ & 2)) || ((_loc14_ + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0) && (_loc17_ & 128)) || (param1 == this._shapeLeft) && (((_loc3_ == -_loc4_) && (_loc17_ & 8)) || (_loc17_ & 16) || (_loc3_ == -_loc4_) && (_loc17_ & 32))))
                  {
                     _loc5_ = _loc3_;
                     _loc6_ = _loc4_;
                     _loc15_ = _loc9_;
                  }
               }
               if(!(_loc11_ % 2))
               {
                  _loc3_++;
               }
               else
               {
                  _loc4_--;
               }
               _loc11_++;
            }
         }
         else
         {
            _loc11_ = 0;
            while(_loc11_ < AtouinConstants.MAP_WIDTH * 2)
            {
               _loc14_ = CellIdConverter.coordToCellId(_loc3_,_loc4_);
               _loc7_ = Cell.cellPixelCoords(_loc14_);
               _loc9_ = Math.abs(param2.x - this._frustrum.x - (_loc7_.x + AtouinConstants.CELL_HALF_WIDTH) * this._frustrum.scale);
               if(_loc9_ < _loc15_)
               {
                  _loc16_ = _loc13_.cells[_loc14_] as CellData;
                  _loc17_ = _loc16_.mapChangeData;
                  if((_loc17_) && ((param1 == this._shapeTop) && (((_loc14_ < AtouinConstants.MAP_WIDTH) && (_loc17_ & 32)) || (_loc17_ & 64) || (_loc14_ < AtouinConstants.MAP_WIDTH) && (_loc17_ & 128)) || (param1 == this._shapeBottom) && (((_loc14_ >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH) && (_loc17_ & 2)) || (_loc17_ & 4) || (_loc14_ >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH) && (_loc17_ & 8))))
                  {
                     _loc5_ = _loc3_;
                     _loc6_ = _loc4_;
                     _loc15_ = _loc9_;
                  }
               }
               if(!(_loc11_ % 2))
               {
                  _loc3_++;
               }
               else
               {
                  _loc4_++;
               }
               _loc11_++;
            }
         }
         if(_loc15_ != Number.MAX_VALUE)
         {
            return 
               {
                  "cell":CellIdConverter.coordToCellId(_loc5_,_loc6_),
                  "custom":_loc15_ == _loc18_.distance
               };
         }
         return 
            {
               "cell":-1,
               "custom":false
            };
      }
      
      private function sendClickAdjacentMsg(param1:uint, param2:uint) : void {
         var _loc3_:AdjacentMapClickMessage = new AdjacentMapClickMessage();
         _loc3_.cellId = param2;
         _loc3_.adjacentMapId = param1;
         Atouin.getInstance().handler.process(_loc3_);
      }
      
      private function sendCellClickMsg(param1:uint, param2:uint) : void {
         var _loc3_:CellClickMessage = new CellClickMessage();
         _loc3_.cellId = param2;
         _loc3_.id = param1;
         Atouin.getInstance().handler.process(_loc3_);
      }
      
      private function out(param1:MouseEvent) : void {
         var _loc2_:uint = 0;
         switch(param1.target)
         {
            case this._shapeRight:
               _loc2_ = DirectionsEnum.RIGHT;
               break;
            case this._shapeLeft:
               _loc2_ = DirectionsEnum.LEFT;
               break;
            case this._shapeBottom:
               _loc2_ = DirectionsEnum.DOWN;
               break;
            case this._shapeTop:
               _loc2_ = DirectionsEnum.UP;
               break;
         }
         this._lastCellId = -1;
         var _loc3_:AdjacentMapOutMessage = new AdjacentMapOutMessage(_loc2_,DisplayObject(param1.target));
         Atouin.getInstance().handler.process(_loc3_);
      }
      
      private function mouseMove(param1:MouseEvent) : void {
         var _loc2_:uint = 0;
         switch(param1.target)
         {
            case this._shapeRight:
               _loc2_ = DirectionsEnum.RIGHT;
               break;
            case this._shapeLeft:
               _loc2_ = DirectionsEnum.LEFT;
               break;
            case this._shapeBottom:
               _loc2_ = DirectionsEnum.DOWN;
               break;
            case this._shapeTop:
               _loc2_ = DirectionsEnum.UP;
               break;
         }
         var _loc3_:int = this.findNearestCell(param1.target as Sprite).cell;
         if(_loc3_ == -1 || _loc3_ == this._lastCellId)
         {
            return;
         }
         this._lastCellId = _loc3_;
         var _loc4_:CellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[_loc3_] as CellData;
         var _loc5_:AdjacentMapOverMessage = new AdjacentMapOverMessage(_loc2_,DisplayObject(param1.target),_loc3_,_loc4_);
         Atouin.getInstance().handler.process(_loc5_);
      }
   }
}

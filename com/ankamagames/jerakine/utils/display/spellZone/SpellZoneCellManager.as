package com.ankamagames.jerakine.utils.display.spellZone
{
   import flash.display.Sprite;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Line;
   import com.ankamagames.jerakine.types.zones.Square;
   import com.ankamagames.jerakine.types.zones.Cone;
   import com.ankamagames.jerakine.types.zones.HalfLozenge;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   
   public class SpellZoneCellManager extends Sprite
   {
      
      public function SpellZoneCellManager() {
         super();
         this._zoneDisplay = new Sprite();
         addChild(this._zoneDisplay);
         this.cells = new Vector.<SpellZoneCell>();
         this._spellCellsId = new Vector.<uint>();
      }
      
      public static const RANGE_COLOR:uint = 65280;
      
      public static const CHARACTER_COLOR:uint = 16711680;
      
      public static const SPELL_COLOR:uint = 255;
      
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
      
      public function setDisplayZone(param1:uint, param2:uint) : void {
         this._width = param1;
         this._height = param2;
      }
      
      public function set spellLevel(param1:ICellZoneProvider) : void {
         this._spellLevel = param1;
      }
      
      private function addListeners() : void {
         addEventListener(SpellZoneEvent.CELL_ROLLOVER,this.onCellRollOver);
         addEventListener(SpellZoneEvent.CELL_ROLLOUT,this.onCellRollOut);
      }
      
      private function removeListeners() : void {
         removeEventListener(SpellZoneEvent.CELL_ROLLOVER,this.onCellRollOver);
         removeEventListener(SpellZoneEvent.CELL_ROLLOUT,this.onCellRollOut);
      }
      
      private function onCellRollOver(param1:SpellZoneEvent) : void {
         this._rollOverCell = param1.cell;
         this.showSpellZone(param1.cell);
      }
      
      private function onCellRollOut(param1:SpellZoneEvent) : void {
         this.setLastSpellCellToNormal();
      }
      
      public function showSpellZone(param1:SpellZoneCell) : void {
         if(this._spellCellsId.length > 0)
         {
            this.setLastSpellCellToNormal();
         }
         this._spellCellsId = this.getSpellZone().getCells(param1.cellId);
         this.setSpellZone(this._spellCellsId);
      }
      
      private function setLastSpellCellToNormal() : void {
         var _loc1_:SpellZoneCell = null;
         var _loc2_:uint = 0;
         for each (_loc1_ in this.cells)
         {
            for each (_loc2_ in this._spellCellsId)
            {
               if(_loc2_ == _loc1_.cellId)
               {
                  _loc1_.changeColorToDefault();
               }
            }
         }
      }
      
      private function resetCells() : void {
         var _loc1_:SpellZoneCell = null;
         for each (_loc1_ in this.cells)
         {
            _loc1_.setNormalCell();
         }
      }
      
      public function show() : void {
         var _loc1_:IZone = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:IDataMapProvider = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:SpellZoneCell = null;
         if(this._spellLevel == null)
         {
            return;
         }
         this.resetCells();
         if(this._spellLevel.castZoneInLine)
         {
            _loc1_ = new Cross(this._spellLevel.minimalRange,this._spellLevel.maximalRange,_loc9_);
         }
         else
         {
            _loc1_ = new Lozenge(this._spellLevel.minimalRange,this._spellLevel.maximalRange,_loc9_);
         }
         if(this.cells.length == 0)
         {
            _loc4_ = 0;
            _loc5_ = 0;
            _loc7_ = 40;
            _loc6_ = 14;
            _loc8_ = 0;
            _loc10_ = this._width / (_loc6_ + 0.5);
            _loc11_ = this._height / (_loc7_ / 2 + 0.5);
            _loc12_ = 0;
            while(_loc12_ < _loc7_)
            {
               _loc4_ = Math.ceil(_loc12_ / 2);
               _loc5_ = -Math.floor(_loc12_ / 2);
               _loc13_ = 0;
               while(_loc13_ < _loc6_)
               {
                  _loc14_ = new SpellZoneCell(_loc10_,_loc11_,MapPoint.fromCoords(_loc4_,_loc5_).cellId);
                  if(_loc14_.cellId == SpellZoneConstant.CENTER_CELL_ID + _loc8_)
                  {
                     this._centerCell = _loc14_;
                  }
                  else
                  {
                     _loc14_.changeColorToDefault();
                  }
                  _loc14_.addEventListener(SpellZoneEvent.CELL_ROLLOVER,this.onCellRollOver);
                  _loc14_.addEventListener(SpellZoneEvent.CELL_ROLLOUT,this.onCellRollOut);
                  this.cells.push(_loc14_);
                  _loc14_.posX = _loc4_;
                  _loc14_.posY = _loc5_;
                  if(_loc12_ == 0 || _loc12_ % 2 == 0)
                  {
                     _loc14_.x = _loc13_ * _loc10_;
                  }
                  else
                  {
                     _loc14_.x = _loc13_ * _loc10_ + _loc10_ / 2;
                  }
                  _loc14_.y = _loc12_ * _loc11_ / 2;
                  this._zoneDisplay.addChild(_loc14_);
                  _loc4_++;
                  _loc5_++;
                  _loc13_++;
               }
               _loc12_++;
            }
         }
         this.colorCell(this._centerCell,CHARACTER_COLOR,true);
         var _loc2_:Number = 14.5 / (1 + Math.ceil(this._spellLevel.maximalRange) + Math.ceil(this.getSpellZone().radius));
         this._zoneDisplay.scaleX = this._zoneDisplay.scaleY = _loc2_;
         this._zoneDisplay.x = (this._width - this._zoneDisplay.width) / 2 + 0.5 / 14.5 * this._zoneDisplay.width / 2;
         this._zoneDisplay.y = (this._height - this._zoneDisplay.height) / 2 + 0.5 / 20.5 * this._zoneDisplay.height / 2;
         if(this._centerCell)
         {
            this.setRangedCells(_loc1_.getCells(this._centerCell.cellId));
         }
         if(mask != null)
         {
            return;
         }
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16711680);
         _loc3_.graphics.drawRoundRect(0,0,this._width,this._height - 3,30,30);
         addChild(_loc3_);
         this.mask = _loc3_;
      }
      
      private function isInSpellArea(param1:SpellZoneCell, param2:Lozenge) : Boolean {
         var _loc4_:uint = 0;
         if(param2 == null)
         {
            return false;
         }
         var _loc3_:Vector.<uint> = param2.getCells(this._centerCell.cellId);
         for each (_loc4_ in _loc3_)
         {
            if(_loc4_ == param1.cellId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function remove() : void {
         var _loc3_:SpellZoneCell = null;
         var _loc1_:uint = this.cells.length;
         var _loc2_:uint = _loc1_;
         while(_loc2_ > 0)
         {
            _loc3_ = this.cells.pop();
            this._zoneDisplay.removeChild(_loc3_);
            _loc3_ = null;
            _loc2_--;
         }
      }
      
      public function setRangedCells(param1:Vector.<uint>) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function setSpellZone(param1:Vector.<uint>) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function colorCell(param1:SpellZoneCell, param2:uint, param3:Boolean=false) : void {
         param1.colorCell(param2,param3);
      }
      
      public function colorCells(param1:Vector.<uint>, param2:uint, param3:Boolean=false) : void {
         var _loc4_:SpellZoneCell = null;
         var _loc5_:uint = 0;
         for each (_loc4_ in this.cells)
         {
            for each (_loc5_ in param1)
            {
               if(_loc5_ == _loc4_.cellId)
               {
                  this.colorCell(_loc4_,param2,param3);
               }
            }
         }
      }
      
      private function getSpellZone() : IZone {
         var _loc2_:uint = 0;
         var _loc3_:IDataMapProvider = null;
         var _loc4_:IZoneShape = null;
         var _loc5_:IZone = null;
         var _loc6_:Line = null;
         var _loc7_:Cross = null;
         var _loc8_:Square = null;
         var _loc9_:Cross = null;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc1_:uint = 88;
         _loc2_ = 0;
         for each (_loc4_ in this._spellLevel.spellZoneEffects)
         {
            if(!(_loc4_.zoneShape == 0) && _loc4_.zoneSize < 63 && (_loc4_.zoneSize > _loc2_ || _loc4_.zoneSize == _loc2_ && _loc1_ == SpellShapeEnum.P))
            {
               _loc2_ = _loc4_.zoneSize;
               _loc1_ = _loc4_.zoneShape;
            }
         }
         switch(_loc1_)
         {
            case SpellShapeEnum.X:
               _loc5_ = new Cross(0,_loc2_,_loc3_);
               break;
            case SpellShapeEnum.L:
               _loc6_ = new Line(_loc2_,_loc3_);
               _loc5_ = _loc6_;
               break;
            case SpellShapeEnum.T:
               _loc7_ = new Cross(0,_loc2_,_loc3_);
               _loc7_.onlyPerpendicular = true;
               _loc5_ = _loc7_;
               break;
            case SpellShapeEnum.D:
               _loc5_ = new Cross(0,_loc2_,_loc3_);
               break;
            case SpellShapeEnum.C:
               _loc5_ = new Lozenge(0,_loc2_,_loc3_);
               break;
            case SpellShapeEnum.I:
               _loc5_ = new Lozenge(_loc2_,63,_loc3_);
               break;
            case SpellShapeEnum.O:
               _loc5_ = new Lozenge(_loc2_,_loc2_,_loc3_);
               break;
            case SpellShapeEnum.Q:
               _loc5_ = new Cross(1,_loc2_,_loc3_);
               break;
            case SpellShapeEnum.G:
               _loc5_ = new Square(0,_loc2_,_loc3_);
               break;
            case SpellShapeEnum.V:
               _loc5_ = new Cone(0,_loc2_,_loc3_);
               break;
            case SpellShapeEnum.W:
               _loc8_ = new Square(0,_loc2_,_loc3_);
               _loc8_.diagonalFree = true;
               _loc5_ = _loc8_;
               break;
            case SpellShapeEnum.plus:
               _loc9_ = new Cross(0,_loc2_,_loc3_);
               _loc9_.diagonal = true;
               _loc5_ = _loc9_;
               break;
            case SpellShapeEnum.sharp:
               _loc9_ = new Cross(1,_loc2_,_loc3_);
               _loc9_.diagonal = true;
               _loc5_ = _loc9_;
               break;
            case SpellShapeEnum.star:
               _loc9_ = new Cross(0,_loc2_,_loc3_);
               _loc9_.allDirections = true;
               _loc5_ = _loc9_;
               break;
            case SpellShapeEnum.slash:
               _loc5_ = new Line(_loc2_,_loc3_);
               break;
            case SpellShapeEnum.minus:
               _loc9_ = new Cross(0,_loc2_,_loc3_);
               _loc9_.onlyPerpendicular = true;
               _loc9_.diagonal = true;
               _loc5_ = _loc9_;
               break;
            case SpellShapeEnum.U:
               _loc5_ = new HalfLozenge(0,_loc2_,_loc3_);
               break;
            case SpellShapeEnum.A:
               _loc5_ = new Lozenge(0,63,_loc3_);
               break;
            case SpellShapeEnum.P:
            default:
               _loc5_ = new Cross(0,0,_loc3_);
         }
         if(this._rollOverCell)
         {
            _loc10_ = this._centerCell.posX - this._rollOverCell.posX;
            _loc11_ = this._centerCell.posY - this._rollOverCell.posY;
            _loc5_.direction = DirectionsEnum.DOWN_RIGHT;
            if(_loc10_ == 0 && _loc11_ > 0)
            {
               _loc5_.direction = DirectionsEnum.DOWN_LEFT;
            }
            if(_loc10_ == 0 && _loc11_ < 0)
            {
               _loc5_.direction = DirectionsEnum.UP_RIGHT;
            }
            if(_loc10_ > 0 && _loc11_ == 0)
            {
               _loc5_.direction = DirectionsEnum.UP_LEFT;
            }
         }
         return _loc5_;
      }
   }
}

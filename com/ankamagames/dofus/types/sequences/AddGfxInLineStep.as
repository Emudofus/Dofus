package com.ankamagames.dofus.types.sequences
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import __AS3__.vec.Vector;
   import flash.geom.Point;
   import com.ankamagames.jerakine.utils.display.Dofus1Line;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.jerakine.enum.AddGfxModeEnum;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   
   public class AddGfxInLineStep extends AbstractSequencable
   {
      
      public function AddGfxInLineStep(param1:uint, param2:MapPoint, param3:MapPoint, param4:int, param5:uint=0, param6:Number=0, param7:Boolean=false, param8:Boolean=false, param9:Vector.<uint>=null, param10:Boolean=false, param11:Boolean=false) {
         super();
         this._gfxId = param1;
         this._startCell = param2;
         this._endCell = param3;
         this._addOnStartCell = param7;
         this._addOnEndCell = param8;
         this._yOffset = param4;
         this._mode = param5;
         this._scale = param6;
         this._addedCells = param9;
         this._useOnlyAddedCells = param10;
         this._showUnder = param11;
      }
      
      private var _gfxId:uint;
      
      private var _startCell:MapPoint;
      
      private var _endCell:MapPoint;
      
      private var _addOnStartCell:Boolean;
      
      private var _addOnEndCell:Boolean;
      
      private var _yOffset:int;
      
      private var _mode:uint;
      
      private var _shot:Boolean = false;
      
      private var _scale:Number;
      
      private var _showUnder:Boolean;
      
      private var _useOnlyAddedCells:Boolean;
      
      private var _addedCells:Vector.<uint>;
      
      private var _cells:Array;
      
      override public function start() : void {
         var _loc1_:Array = null;
         var _loc2_:Point = null;
         var _loc3_:uint = 0;
         var _loc4_:* = false;
         var _loc5_:uint = 0;
         if(!this._useOnlyAddedCells)
         {
            _loc1_ = Dofus1Line.getLine(this._startCell.x,this._startCell.y,0,this._endCell.x,this._endCell.y,0);
         }
         else
         {
            _loc1_ = [];
         }
         this._cells = new Array();
         if(this._addOnStartCell)
         {
            this._cells.push(this._startCell);
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            if((this._addOnEndCell) && _loc3_ == _loc1_.length-1 || _loc3_ >= 0 && _loc3_ < _loc1_.length-1)
            {
               this._cells.push(MapPoint.fromCoords(_loc2_.x,_loc2_.y));
            }
            _loc3_++;
         }
         if(this._addedCells)
         {
            _loc3_ = 0;
            while(_loc3_ < this._addedCells.length)
            {
               _loc4_ = true;
               _loc5_ = 0;
               while(_loc5_ < this._cells.length)
               {
                  if(this._addedCells[_loc3_] == MapPoint(this._cells[_loc5_]).cellId)
                  {
                     _loc4_ = false;
                     break;
                  }
                  _loc5_++;
               }
               if(_loc4_)
               {
                  this._cells.push(MapPoint.fromCellId(this._addedCells[_loc3_]));
               }
               _loc3_++;
            }
         }
         this.addNextGfx();
      }
      
      private function addNextGfx() : void {
         if(!this._cells.length)
         {
            executeCallbacks();
            return;
         }
         var _loc1_:* = -10000;
         while(DofusEntities.getEntity(_loc1_))
         {
            _loc1_ = -10000 + Math.random() * 10000;
         }
         var _loc2_:Projectile = new Projectile(_loc1_,TiphonEntityLook.fromString("{" + this._gfxId + "}"));
         _loc2_.addEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         _loc2_.addEventListener(TiphonEvent.ANIMATION_END,this.remove);
         _loc2_.addEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         _loc2_.position = this._cells.shift();
         if(!_loc2_.libraryIsAvaible)
         {
            _loc2_.addEventListener(TiphonEvent.SPRITE_INIT,this.startDisplay);
            _loc2_.addEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
            _loc2_.init();
         }
         else
         {
            _loc2_.init();
            this.startDisplay(new TiphonEvent(TiphonEvent.SPRITE_INIT,_loc2_));
         }
      }
      
      private function startDisplay(param1:TiphonEvent) : void {
         var _loc2_:Projectile = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         _loc2_ = Projectile(param1.sprite);
         switch(this._mode)
         {
            case AddGfxModeEnum.NORMAL:
               break;
            case AddGfxModeEnum.RANDOM:
               _loc3_ = _loc2_.getAvaibleDirection("FX");
               _loc4_ = new Array();
               _loc5_ = 0;
               while(_loc5_ < 8)
               {
                  if(_loc3_[_loc5_])
                  {
                     _loc4_.push(_loc5_);
                  }
                  _loc5_++;
               }
               _loc2_.setDirection(_loc4_[Math.floor(Math.random() * _loc4_.length)]);
               break;
            case AddGfxModeEnum.ORIENTED:
               _loc2_.setDirection(this._startCell.advancedOrientationTo(this._endCell,true));
               break;
         }
         _loc2_.display(this._showUnder?PlacementStrataEnums.STRATA_SPELL_BACKGROUND:PlacementStrataEnums.STRATA_SPELL_FOREGROUND);
         _loc2_.y = _loc2_.y + this._yOffset;
         _loc2_.scaleX = _loc2_.scaleY = this._scale;
      }
      
      private function remove(param1:TiphonEvent) : void {
         param1.sprite.removeEventListener(TiphonEvent.ANIMATION_END,this.remove);
         param1.sprite.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         param1.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         param1.sprite.removeEventListener(TiphonEvent.SPRITE_INIT,this.startDisplay);
         param1.sprite.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
         Projectile(param1.sprite).remove();
         if(!this._shot)
         {
            this.shot(null);
         }
      }
      
      private function shot(param1:TiphonEvent) : void {
         if(param1)
         {
            param1.sprite.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         }
         this._shot = true;
         this.addNextGfx();
      }
   }
}

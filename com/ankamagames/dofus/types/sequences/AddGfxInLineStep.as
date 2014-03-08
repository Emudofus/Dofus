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
      
      public function AddGfxInLineStep(gfxId:uint, startCell:MapPoint, endCell:MapPoint, yOffset:int, mode:uint=0, scale:Number=0, addOnStartCell:Boolean=false, addOnEndCell:Boolean=false, addedCells:Vector.<uint>=null, useOnlyAddedCells:Boolean=false, showUnder:Boolean=false) {
         super();
         this._gfxId = gfxId;
         this._startCell = startCell;
         this._endCell = endCell;
         this._addOnStartCell = addOnStartCell;
         this._addOnEndCell = addOnEndCell;
         this._yOffset = yOffset;
         this._mode = mode;
         this._scale = scale;
         this._addedCells = addedCells;
         this._useOnlyAddedCells = useOnlyAddedCells;
         this._showUnder = showUnder;
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
         var cells:Array = null;
         var cell:Point = null;
         var i:uint = 0;
         var add:* = false;
         var j:uint = 0;
         if(!this._useOnlyAddedCells)
         {
            cells = Dofus1Line.getLine(this._startCell.x,this._startCell.y,0,this._endCell.x,this._endCell.y,0);
         }
         else
         {
            cells = [];
         }
         this._cells = new Array();
         if(this._addOnStartCell)
         {
            this._cells.push(this._startCell);
         }
         i = 0;
         while(i < cells.length)
         {
            cell = cells[i];
            if((this._addOnEndCell) && (i == cells.length - 1) || (i >= 0) && (i < cells.length - 1))
            {
               this._cells.push(MapPoint.fromCoords(cell.x,cell.y));
            }
            i++;
         }
         if(this._addedCells)
         {
            i = 0;
            while(i < this._addedCells.length)
            {
               add = true;
               j = 0;
               while(j < this._cells.length)
               {
                  if(this._addedCells[i] == MapPoint(this._cells[j]).cellId)
                  {
                     add = false;
                     break;
                  }
                  j++;
               }
               if(add)
               {
                  this._cells.push(MapPoint.fromCellId(this._addedCells[i]));
               }
               i++;
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
         var id:int = -10000;
         while(DofusEntities.getEntity(id))
         {
            id = -10000 + Math.random() * 10000;
         }
         var entity:Projectile = new Projectile(id,TiphonEntityLook.fromString("{" + this._gfxId + "}"));
         entity.addEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         entity.addEventListener(TiphonEvent.ANIMATION_END,this.remove);
         entity.addEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         entity.position = this._cells.shift();
         if(!entity.libraryIsAvaible)
         {
            entity.addEventListener(TiphonEvent.SPRITE_INIT,this.startDisplay);
            entity.addEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
            entity.init();
         }
         else
         {
            entity.init();
            this.startDisplay(new TiphonEvent(TiphonEvent.SPRITE_INIT,entity));
         }
      }
      
      private function startDisplay(e:TiphonEvent) : void {
         var p:Projectile = null;
         var dir:Array = null;
         var ad:Array = null;
         var i:uint = 0;
         p = Projectile(e.sprite);
         switch(this._mode)
         {
            case AddGfxModeEnum.NORMAL:
               break;
            case AddGfxModeEnum.RANDOM:
               dir = p.getAvaibleDirection("FX");
               ad = new Array();
               i = 0;
               while(i < 8)
               {
                  if(dir[i])
                  {
                     ad.push(i);
                  }
                  i++;
               }
               p.setDirection(ad[Math.floor(Math.random() * ad.length)]);
               break;
            case AddGfxModeEnum.ORIENTED:
               p.setDirection(this._startCell.advancedOrientationTo(this._endCell,true));
               break;
         }
         p.display(this._showUnder?PlacementStrataEnums.STRATA_SPELL_BACKGROUND:PlacementStrataEnums.STRATA_SPELL_FOREGROUND);
         p.y = p.y + this._yOffset;
         p.scaleX = p.scaleY = this._scale;
      }
      
      private function remove(e:TiphonEvent) : void {
         e.sprite.removeEventListener(TiphonEvent.ANIMATION_END,this.remove);
         e.sprite.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         e.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         e.sprite.removeEventListener(TiphonEvent.SPRITE_INIT,this.startDisplay);
         e.sprite.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
         Projectile(e.sprite).remove();
         if(!this._shot)
         {
            this.shot(null);
         }
      }
      
      private function shot(e:TiphonEvent) : void {
         if(e)
         {
            e.sprite.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         }
         this._shot = true;
         this.addNextGfx();
      }
   }
}

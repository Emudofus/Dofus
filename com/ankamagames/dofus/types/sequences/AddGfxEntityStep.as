package com.ankamagames.dofus.types.sequences
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.jerakine.enum.AddGfxModeEnum;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import flash.events.Event;
   import flash.events.TimerEvent;
   
   public class AddGfxEntityStep extends AbstractSequencable
   {
      
      public function AddGfxEntityStep(param1:uint, param2:uint, param3:Number=0, param4:int=0, param5:uint=0, param6:MapPoint=null, param7:MapPoint=null, param8:Boolean=false) {
         super();
         this._mode = param5;
         this._gfxId = param1;
         this._cellId = param2;
         this._angle = param3;
         this._yOffset = param4;
         this._startCell = param6;
         this._endCell = param7;
         this._popUnderPlayer = param8;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AddGfxEntityStep));
      
      private var _gfxId:uint;
      
      private var _cellId:uint;
      
      private var _entity:Projectile;
      
      private var _shot:Boolean = false;
      
      private var _angle:Number;
      
      private var _yOffset:int;
      
      private var _mode:uint;
      
      private var _startCell:MapPoint;
      
      private var _endCell:MapPoint;
      
      private var _popUnderPlayer:Boolean;
      
      override public function start() : void {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc1_:int = EntitiesManager.getInstance().getFreeEntityId();
         this._entity = new Projectile(_loc1_,TiphonEntityLook.fromString("{" + this._gfxId + "}"),true);
         this._entity.addEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         this._entity.addEventListener(TiphonEvent.ANIMATION_END,this.remove);
         this._entity.addEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         this._entity.addEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
         this._entity.rotation = this._angle;
         this._entity.mouseEnabled = false;
         this._entity.mouseChildren = false;
         switch(this._mode)
         {
            case AddGfxModeEnum.NORMAL:
               this._entity.init();
               break;
            case AddGfxModeEnum.RANDOM:
               _loc2_ = this._entity.getAvaibleDirection();
               _loc3_ = new Array();
               _loc4_ = 0;
               while(_loc4_ < 8)
               {
                  if(_loc2_[_loc4_])
                  {
                     _loc3_.push(_loc4_);
                  }
                  _loc4_++;
               }
               this._entity.init(_loc3_[Math.floor(Math.random() * _loc3_.length)]);
               break;
            case AddGfxModeEnum.ORIENTED:
               this._entity.init(this._startCell.advancedOrientationTo(this._endCell,true));
               break;
         }
         this._entity.position = MapPoint.fromCellId(this._cellId);
         if(this._popUnderPlayer)
         {
            this._entity.display(PlacementStrataEnums.STRATA_SPELL_BACKGROUND);
         }
         else
         {
            this._entity.display(PlacementStrataEnums.STRATA_SPELL_FOREGROUND);
         }
         this._entity.y = this._entity.y + this._yOffset;
      }
      
      private function remove(param1:Event) : void {
         this._entity.removeEventListener(TiphonEvent.ANIMATION_END,this.remove);
         this._entity.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         this._entity.removeEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         this._entity.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
         this._entity.destroy();
         if(!this._shot)
         {
            this.shot(null);
         }
      }
      
      private function shot(param1:Event) : void {
         this._shot = true;
         this._entity.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         executeCallbacks();
      }
      
      override protected function onTimeOut(param1:TimerEvent) : void {
         _log.error("Timeout en attendant le SHOT du bone du projectile " + this._gfxId);
         if(this._entity)
         {
            this._entity.destroy();
         }
         super.onTimeOut(param1);
      }
   }
}

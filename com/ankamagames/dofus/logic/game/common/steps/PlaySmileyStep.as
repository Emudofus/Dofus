package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import flash.utils.Timer;
   import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
   import flash.events.TimerEvent;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.atouin.Atouin;
   
   public class PlaySmileyStep extends AbstractSequencable
   {
      
      public function PlaySmileyStep(param1:AnimatedCharacter, param2:int, param3:Boolean) {
         super();
         this._entity = param1;
         this._smileyId = param2;
         this._waitForEnd = param3;
      }
      
      private var _entity:AnimatedCharacter;
      
      private var _smileyId:int;
      
      private var _waitForEnd:Boolean;
      
      private var _timer:Timer;
      
      override public function start() : void {
         var _loc1_:SmileyWrapper = new SmileyWrapper();
         _loc1_.id = this._smileyId;
         if(this._waitForEnd)
         {
            this._timer = new Timer(2500);
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer.start();
         }
         TooltipManager.show(_loc1_,this._entity.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"smiley" + this._entity.id,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,null,false,StrataEnum.STRATA_WORLD,Atouin.getInstance().currentZoom);
         if(!this._waitForEnd)
         {
            executeCallbacks();
         }
      }
      
      override public function clear() : void {
         if(this._timer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         }
         TooltipManager.hide("smiley" + this._entity.id);
      }
      
      private function onTimer(param1:TimerEvent) : void {
         param1.currentTarget.removeEventListener(TimerEvent.TIMER,this.onTimer);
         executeCallbacks();
      }
   }
}

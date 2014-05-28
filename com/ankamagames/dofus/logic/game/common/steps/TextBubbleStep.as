package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class TextBubbleStep extends AbstractSequencable
   {
      
      public function TextBubbleStep(pEntity:AnimatedCharacter, pBubble:*, pWaitForEnd:Boolean) {
         super();
         this._entity = pEntity;
         this._bubble = pBubble;
         this._waitForEnd = pWaitForEnd;
         this._timerDelay = 4000 + this._bubble.text.length * 30;
         timeout = this._timerDelay + 1000;
      }
      
      private var _entity:AnimatedCharacter;
      
      private var _bubble;
      
      private var _waitForEnd:Boolean;
      
      private var _timer:Timer;
      
      private var _timerDelay:Number;
      
      override public function start() : void {
         if(this._waitForEnd)
         {
            this._timer = new Timer(this._timerDelay);
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer.start();
         }
         TooltipManager.show(this._bubble,this._entity.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"textBubble" + this._entity.id,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,0,true,null,null,null,null,false,StrataEnum.STRATA_WORLD);
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
         TooltipManager.hide("textBubble" + this._entity.id);
      }
      
      private function onTimer(pEvent:TimerEvent) : void {
         pEvent.currentTarget.removeEventListener(TimerEvent.TIMER,this.onTimer);
         executeCallbacks();
      }
   }
}

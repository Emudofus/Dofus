package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import flash.utils.Timer;
   import flash.filters.BlurFilter;
   import flash.geom.ColorTransform;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.events.TimerEvent;
   import flash.events.Event;
   import com.ankamagames.atouin.managers.EntitiesManager;
   
   public class FightInvisibleTemporarilyDetectedStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightInvisibleTemporarilyDetectedStep(target:AnimatedCharacter, cellId:int) {
         super();
         var id:int = EntitiesManager.getInstance().getFreeEntityId();
         this._duplicateSprite = new AnimatedCharacter(id,target.look.clone());
         this._cellId = cellId;
         this._fadeTimer = new Timer(25,40);
         this._fadeTimer.addEventListener(TimerEvent.TIMER,this.onFade);
      }
      
      private var _duplicateSprite:AnimatedCharacter;
      
      private var _cellId:int;
      
      private var _fadeTimer:Timer;
      
      public function get stepType() : String {
         return "invisibleTemporarilyDetected";
      }
      
      override public function start() : void {
         this._duplicateSprite.filters = [new BlurFilter(5,5)];
         this._duplicateSprite.transform.colorTransform = new ColorTransform(0,0,0,1,30,30,30);
         EntitiesDisplayManager.getInstance().displayEntity(this._duplicateSprite,MapPoint.fromCellId(this._cellId));
         this._fadeTimer.start();
         executeCallbacks();
      }
      
      override public function clear() : void {
         if(this._fadeTimer)
         {
            this._fadeTimer.removeEventListener(TimerEvent.TIMER,this.onFade);
            this._fadeTimer = null;
            EntitiesDisplayManager.getInstance().removeEntity(this._duplicateSprite);
            this._duplicateSprite.destroy();
            this._duplicateSprite = null;
         }
      }
      
      private function onFade(e:Event) : void {
         if(!this._duplicateSprite)
         {
            return;
         }
         this._duplicateSprite.alpha = this._duplicateSprite.alpha - 0.025;
         if(this._duplicateSprite.alpha < 0.025)
         {
            this.clear();
         }
      }
   }
}

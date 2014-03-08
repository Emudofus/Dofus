package com.ankamagames.dofus.logic.game.fight.steps.abstract
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextual;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextualManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.text.TextFormat;
   import com.ankamagames.berilia.types.event.BeriliaEvent;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import flash.events.Event;
   
   public class AbstractStatContextualStep extends AbstractSequencable
   {
      
      public function AbstractStatContextualStep(param1:uint, param2:String, param3:int, param4:Boolean=true) {
         super();
         this._color = param1;
         this._value = param2;
         this._targetId = param3;
         this._blocking = param4;
      }
      
      protected var _color:uint;
      
      protected var _value:String;
      
      protected var _targetId:int;
      
      protected var _blocking:Boolean;
      
      protected var _virtual:Boolean;
      
      private var _ccm:CharacteristicContextual;
      
      override public function start() : void {
         if(!this._virtual && !(this._value == "0") && !(OptionManager.getOptionManager("tiphon").pointsOverhead == 0))
         {
            this._ccm = CharacteristicContextualManager.getInstance().addStatContextual(this._value,DofusEntities.getEntity(this._targetId),new TextFormat("Verdana",24,this._color,true),OptionManager.getOptionManager("tiphon").pointsOverhead);
         }
         if(!this._ccm)
         {
            executeCallbacks();
            return;
         }
         if(!this._blocking)
         {
            executeCallbacks();
         }
         else
         {
            this._ccm.addEventListener(BeriliaEvent.REMOVE_COMPONENT,this.remove);
         }
      }
      
      public function get target() : IEntity {
         return DofusEntities.getEntity(this._targetId);
      }
      
      private function remove(param1:Event) : void {
         this._ccm.removeEventListener(BeriliaEvent.REMOVE_COMPONENT,this.remove);
         executeCallbacks();
      }
   }
}

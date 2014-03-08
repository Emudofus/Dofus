package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextualManager;
   import flash.text.TextFormat;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextual;
   
   public class FightLossAnimStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightLossAnimStep(pTarget:IEntity, pValue:int, pColor:uint) {
         super();
         this._value = pValue;
         this._target = pTarget;
         this._color = pColor;
      }
      
      private var _value:int;
      
      private var _target:IEntity;
      
      private var _color:uint;
      
      public function get stepType() : String {
         return "lifeLossAnim";
      }
      
      override public function start() : void {
         var ccm:CharacteristicContextual = CharacteristicContextualManager.getInstance().addStatContextual(this._value.toString(),this._target,new TextFormat("Verdana",24,this._color,true),OptionManager.getOptionManager("tiphon").pointsOverhead);
         executeCallbacks();
      }
   }
}

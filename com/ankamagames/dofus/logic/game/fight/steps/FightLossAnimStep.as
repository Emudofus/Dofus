package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.types.characteristicContextual.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.sequencer.*;
    import flash.text.*;

    public class FightLossAnimStep extends AbstractSequencable implements IFightStep
    {
        private var _value:int;
        private var _target:IEntity;
        private var _color:uint;

        public function FightLossAnimStep(param1:IEntity, param2:int, param3:uint)
        {
            this._value = param2;
            this._target = param1;
            this._color = param3;
            return;
        }// end function

        public function get stepType() : String
        {
            return "lifeLossAnim";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = CharacteristicContextualManager.getInstance().addStatContextual(this._value.toString(), this._target, new TextFormat("Verdana", 24, this._color, true), OptionManager.getOptionManager("tiphon").pointsOverhead);
            executeCallbacks();
            return;
        }// end function

    }
}

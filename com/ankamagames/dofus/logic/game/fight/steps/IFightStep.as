package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.*;

    public interface IFightStep extends ISequencable
    {

        public function IFightStep();

        function get stepType() : String;

        function get castingSpellId() : int;

        function set castingSpellId(param1:int) : void;

    }
}

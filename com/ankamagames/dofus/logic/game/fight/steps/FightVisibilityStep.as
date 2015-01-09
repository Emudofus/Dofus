package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import flash.display.Sprite;

    public class FightVisibilityStep extends AbstractSequencable implements IFightStep 
    {

        private var _fighterId:int;
        private var _visibility:Boolean;

        public function FightVisibilityStep(fighterId:int, visibility:Boolean)
        {
            this._fighterId = fighterId;
            this._visibility = visibility;
        }

        public function get stepType():String
        {
            return ("visibility");
        }

        override public function start():void
        {
            var summonedCreature:Sprite = (DofusEntities.getEntity(this._fighterId) as Sprite);
            if (summonedCreature)
            {
                summonedCreature.visible = this._visibility;
            };
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps


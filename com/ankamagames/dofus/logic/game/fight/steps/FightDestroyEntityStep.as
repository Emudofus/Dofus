package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.atouin.types.sequences.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.jerakine.entities.interfaces.*;

    public class FightDestroyEntityStep extends DestroyEntityStep implements IFightStep
    {

        public function FightDestroyEntityStep(param1:IEntity)
        {
            super(param1);
            FightEntitiesHolder.getInstance().unholdEntity(param1.id);
            return;
        }// end function

        public function get stepType() : String
        {
            return "destroyEntity";
        }// end function

    }
}

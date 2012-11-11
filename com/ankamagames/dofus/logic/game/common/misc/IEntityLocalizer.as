package com.ankamagames.dofus.logic.game.common.misc
{
    import com.ankamagames.jerakine.entities.interfaces.*;

    public interface IEntityLocalizer
    {

        public function IEntityLocalizer();

        function getEntity(param1:int) : IEntity;

        function unregistered() : void;

    }
}

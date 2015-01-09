package com.ankamagames.dofus.logic.game.common.misc
{
    import com.ankamagames.jerakine.entities.interfaces.IEntity;

    public interface IEntityLocalizer 
    {

        function getEntity(_arg_1:int):IEntity;
        function unregistered():void;

    }
}//package com.ankamagames.dofus.logic.game.common.misc


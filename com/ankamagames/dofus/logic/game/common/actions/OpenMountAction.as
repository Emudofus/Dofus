package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenMountAction implements Action 
    {


        public static function create():OpenMountAction
        {
            return (new (OpenMountAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions


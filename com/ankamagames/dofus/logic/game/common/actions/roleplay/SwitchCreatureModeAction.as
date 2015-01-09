package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class SwitchCreatureModeAction implements Action 
    {

        public var isActivated:Boolean;


        public static function create(pActivated:Boolean=false):SwitchCreatureModeAction
        {
            var a:SwitchCreatureModeAction = new (SwitchCreatureModeAction)();
            a.isActivated = pActivated;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.roleplay


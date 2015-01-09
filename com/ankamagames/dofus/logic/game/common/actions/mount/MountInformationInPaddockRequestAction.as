package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class MountInformationInPaddockRequestAction implements Action 
    {

        public var mountId:uint;


        public static function create(mountId:uint):MountInformationInPaddockRequestAction
        {
            var act:MountInformationInPaddockRequestAction = new (MountInformationInPaddockRequestAction)();
            act.mountId = mountId;
            return (act);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount


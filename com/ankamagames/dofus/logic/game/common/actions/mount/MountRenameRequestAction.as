package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class MountRenameRequestAction implements Action 
    {

        public var newName:String;
        public var mountId:Number;


        public static function create(newName:String, mountId:Number):MountRenameRequestAction
        {
            var o:MountRenameRequestAction = new (MountRenameRequestAction)();
            o.newName = newName;
            o.mountId = mountId;
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount


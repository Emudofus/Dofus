package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class DownloadPartAction implements Action 
    {

        public var id:String;


        public static function create(id:String):DownloadPartAction
        {
            var a:DownloadPartAction = new (DownloadPartAction)();
            a.id = id;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions


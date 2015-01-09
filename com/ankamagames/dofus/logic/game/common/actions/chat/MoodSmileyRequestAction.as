package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class MoodSmileyRequestAction implements Action 
    {

        public var smileyId:int;


        public static function create(id:int):MoodSmileyRequestAction
        {
            var a:MoodSmileyRequestAction = new (MoodSmileyRequestAction)();
            a.smileyId = id;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat


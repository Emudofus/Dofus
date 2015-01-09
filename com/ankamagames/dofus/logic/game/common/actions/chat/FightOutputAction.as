package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class FightOutputAction implements Action 
    {

        public var content:String;
        public var channel:uint;


        public static function create(msg:String, channel:uint=0):FightOutputAction
        {
            var a:FightOutputAction = new (FightOutputAction)();
            a.content = msg;
            a.channel = channel;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat


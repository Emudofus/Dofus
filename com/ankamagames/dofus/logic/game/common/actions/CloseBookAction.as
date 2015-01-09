package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CloseBookAction implements Action 
    {

        private var _name:String;
        public var value:String;


        public static function create():CloseBookAction
        {
            return (new (CloseBookAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions


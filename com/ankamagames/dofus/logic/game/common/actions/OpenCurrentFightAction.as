package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenCurrentFightAction implements Action 
    {

        private var _name:String;
        public var value:String;


        public static function create():OpenCurrentFightAction
        {
            return (new (OpenCurrentFightAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions


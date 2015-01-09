package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenBookAction implements Action 
    {

        private var _name:String;
        public var value:String;
        public var param:Object;


        public static function create(name:String=null, param:Object=null):OpenBookAction
        {
            var action:OpenBookAction = new (OpenBookAction)();
            action.value = name;
            action.param = param;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions


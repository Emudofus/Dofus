package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PrismInfoJoinLeaveRequestAction implements Action 
    {

        public var join:Boolean;


        public static function create(join:Boolean):PrismInfoJoinLeaveRequestAction
        {
            var action:PrismInfoJoinLeaveRequestAction = new (PrismInfoJoinLeaveRequestAction)();
            action.join = join;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.prism


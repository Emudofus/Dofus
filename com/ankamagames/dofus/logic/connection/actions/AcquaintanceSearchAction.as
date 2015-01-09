package com.ankamagames.dofus.logic.connection.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AcquaintanceSearchAction implements Action 
    {

        public var friendName:String;


        public static function create(friendName:String):AcquaintanceSearchAction
        {
            var a:AcquaintanceSearchAction = new (AcquaintanceSearchAction)();
            a.friendName = friendName;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.connection.actions


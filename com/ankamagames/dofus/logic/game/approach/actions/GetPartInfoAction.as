package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GetPartInfoAction implements Action 
    {

        public var id:String;


        public static function create(id:String):GetPartInfoAction
        {
            var a:GetPartInfoAction = new (GetPartInfoAction)();
            a.id = id;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions


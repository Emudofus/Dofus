package com.ankamagames.dofus.logic.game.common.actions.alliance
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AllianceModificationNameAndTagValidAction implements Action 
    {

        public var name:String;
        public var tag:String;


        public static function create(pName:String, pTag:String):AllianceModificationNameAndTagValidAction
        {
            var action:AllianceModificationNameAndTagValidAction = new (AllianceModificationNameAndTagValidAction)();
            action.name = pName;
            action.tag = pTag;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.alliance


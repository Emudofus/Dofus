package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CharacterDeletionAction implements Action 
    {

        public var id:int;
        public var answer:String;


        public static function create(id:int, answer:String):CharacterDeletionAction
        {
            var a:CharacterDeletionAction = new (CharacterDeletionAction)();
            a.id = id;
            a.answer = answer;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions


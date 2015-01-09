package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CharacterDeselectionAction implements Action 
    {


        public static function create():CharacterDeselectionAction
        {
            var a:CharacterDeselectionAction = new (CharacterDeselectionAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions


package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GameContextKickAction implements Action 
    {

        public var targetId:uint;


        public static function create(targetId:uint):GameContextKickAction
        {
            var a:GameContextKickAction = new (GameContextKickAction)();
            a.targetId = targetId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions


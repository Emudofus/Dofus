package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShowMountsInFightAction implements Action 
    {

        private var _visibility:Boolean;


        public static function create(pVisibility:Boolean):ShowMountsInFightAction
        {
            var action:ShowMountsInFightAction = new (ShowMountsInFightAction)();
            action._visibility = pVisibility;
            return (action);
        }


        public function get visibility():Boolean
        {
            return (this._visibility);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions


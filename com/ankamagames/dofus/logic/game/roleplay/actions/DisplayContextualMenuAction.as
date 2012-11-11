package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class DisplayContextualMenuAction extends Object implements Action
    {
        public var playerId:uint;

        public function DisplayContextualMenuAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : DisplayContextualMenuAction
        {
            var _loc_2:* = new DisplayContextualMenuAction;
            _loc_2.playerId = param1;
            return _loc_2;
        }// end function

    }
}

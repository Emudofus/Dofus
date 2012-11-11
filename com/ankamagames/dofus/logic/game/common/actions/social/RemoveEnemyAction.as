package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class RemoveEnemyAction extends Object implements Action
    {
        public var name:String;

        public function RemoveEnemyAction()
        {
            return;
        }// end function

        public static function create(param1:String) : RemoveEnemyAction
        {
            var _loc_2:* = new RemoveEnemyAction;
            _loc_2.name = param1;
            return _loc_2;
        }// end function

    }
}

package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AddEnemyAction extends Object implements Action
    {
        public var name:String;

        public function AddEnemyAction()
        {
            return;
        }// end function

        public static function create(param1:String) : AddEnemyAction
        {
            var _loc_2:* = new AddEnemyAction;
            _loc_2.name = param1;
            return _loc_2;
        }// end function

    }
}

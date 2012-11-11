package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class InteractiveElementActivationAction extends Object implements Action
    {
        public var interactiveElement:InteractiveElement;
        public var position:MapPoint;
        public var skillInstanceId:uint;

        public function InteractiveElementActivationAction()
        {
            return;
        }// end function

        public static function create(param1:InteractiveElement, param2:MapPoint, param3:uint) : InteractiveElementActivationAction
        {
            var _loc_4:* = new InteractiveElementActivationAction;
            new InteractiveElementActivationAction.interactiveElement = param1;
            _loc_4.position = param2;
            _loc_4.skillInstanceId = param3;
            return _loc_4;
        }// end function

    }
}

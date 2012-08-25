package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;

    public class ChangeMapBehavior extends AbstractBehavior
    {
        private static const CHECKPOINT_CLIP_TOP:Class = ChangeMapBehavior_CHECKPOINT_CLIP_TOP;
        private static const CHECKPOINT_CLIP_LEFT:Class = ChangeMapBehavior_CHECKPOINT_CLIP_LEFT;
        private static const CHECKPOINT_CLIP_BOTTOM:Class = ChangeMapBehavior_CHECKPOINT_CLIP_BOTTOM;
        private static const CHECKPOINT_CLIP_RIGHT:Class = ChangeMapBehavior_CHECKPOINT_CLIP_RIGHT;

        public function ChangeMapBehavior()
        {
            type = STOP;
            return;
        }// end function

        override public function processInputMessage(param1:Message, param2:String) : Boolean
        {
            var _loc_3:uint = 0;
            if (pendingMessage == null && param1 is AdjacentMapClickMessage)
            {
                pendingMessage = param1;
                _loc_3 = (pendingMessage as AdjacentMapClickMessage).cellId;
                position = MapPoint.fromCellId(_loc_3);
                if (CellUtil.isLeftCol(_loc_3))
                {
                    sprite = new CHECKPOINT_CLIP_LEFT() as Sprite;
                }
                else if (CellUtil.isRightCol(_loc_3))
                {
                    sprite = new CHECKPOINT_CLIP_RIGHT() as Sprite;
                }
                else if (CellUtil.isBottomRow(_loc_3))
                {
                    sprite = new CHECKPOINT_CLIP_BOTTOM() as Sprite;
                }
                else
                {
                    sprite = new CHECKPOINT_CLIP_TOP() as Sprite;
                }
                return true;
            }
            return false;
        }// end function

        override public function processOutputMessage(param1:Message, param2:String) : Boolean
        {
            return false;
        }// end function

        override public function copy() : AbstractBehavior
        {
            var _loc_1:ChangeMapBehavior = null;
            _loc_1 = new ChangeMapBehavior();
            _loc_1.pendingMessage = this.pendingMessage;
            _loc_1.position = this.position;
            _loc_1.sprite = this.sprite;
            return _loc_1;
        }// end function

    }
}

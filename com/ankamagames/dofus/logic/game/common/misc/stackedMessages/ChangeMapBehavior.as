package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class ChangeMapBehavior extends AbstractBehavior
    {

        public function ChangeMapBehavior()
        {
            type = STOP;
            return;
        }// end function

        override public function processInputMessage(param1:Message, param2:String) : Boolean
        {
            var _loc_3:* = 0;
            if (pendingMessage == null && param1 is AdjacentMapClickMessage)
            {
                pendingMessage = param1;
                _loc_3 = (pendingMessage as AdjacentMapClickMessage).cellId;
                position = MapPoint.fromCellId(_loc_3);
                if (CellUtil.isLeftCol(_loc_3))
                {
                    sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_LEFT");
                }
                else if (CellUtil.isRightCol(_loc_3))
                {
                    sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_RIGHT");
                }
                else if (CellUtil.isBottomRow(_loc_3))
                {
                    sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_BOTTOM");
                }
                else
                {
                    sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_TOP");
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
            var _loc_1:* = new ChangeMapBehavior();
            _loc_1.pendingMessage = this.pendingMessage;
            _loc_1.position = this.position;
            _loc_1.sprite = this.sprite;
            return _loc_1;
        }// end function

    }
}

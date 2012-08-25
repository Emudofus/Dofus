package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;
    import flash.utils.*;

    public class AbstractBehavior extends Object
    {
        public var type:String;
        public var isAvailableToStart:Boolean = false;
        public var canBeStacked:Boolean = true;
        public var isActive:Boolean = true;
        public var position:MapPoint;
        public var error:Boolean = false;
        public var actionStarted:Boolean = false;
        public var sprite:Sprite;
        public var pendingMessage:Message;
        static var _log:Logger = Log.getLogger(getQualifiedClassName(AbstractBehavior));
        public static const NORMAL:String = "normal";
        public static const STOP:String = "stop";
        public static const ALWAYS:String = "always";

        public function AbstractBehavior()
        {
            return;
        }// end function

        public function processInputMessage(param1:Message, param2:String) : Boolean
        {
            throw new AbstractMethodCallError();
        }// end function

        public function processOutputMessage(param1:Message, param2:String) : Boolean
        {
            throw new AbstractMethodCallError();
        }// end function

        public function processMessageToWorker() : void
        {
            Kernel.getWorker().process(this.pendingMessage);
            this.pendingMessage = null;
            return;
        }// end function

        public function isAvailableToProcess(param1:Message) : Boolean
        {
            return true;
        }// end function

        public function copy() : AbstractBehavior
        {
            throw new AbstractMethodCallError();
        }// end function

        public function checkAvailability(param1:Message) : void
        {
            return;
        }// end function

        public function reset() : void
        {
            this.pendingMessage = null;
            this.actionStarted = false;
            return;
        }// end function

        public function getMapPoint() : MapPoint
        {
            return this.position;
        }// end function

        public function remove() : void
        {
            this.sprite = null;
            return;
        }// end function

        public function isMessageCatchable(param1:Message) : Boolean
        {
            return false;
        }// end function

        public function addIcon() : void
        {
            return;
        }// end function

        public function removeIcon() : void
        {
            return;
        }// end function

        public function get canBeRemoved() : Boolean
        {
            return true;
        }// end function

        public function get needToWait() : Boolean
        {
            return false;
        }// end function

        public function getFakePosition() : MapPoint
        {
            return null;
        }// end function

        public static function createFake(param1:String, param2:Array = null) : AbstractBehavior
        {
            var _loc_3:AbstractBehavior = null;
            switch(param1)
            {
                case StackActionEnum.MOVE:
                {
                    _loc_3 = new MoveBehavior();
                    _loc_3.position = param2[0];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

    }
}

package com.ankamagames.jerakine.tasking
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.utils.*;

    final public class TaskingManager extends Object
    {
        private var _running:Boolean;
        private var _queue:Vector.<SplittedTask>;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TaskingManager));
        private static var _self:TaskingManager;

        public function TaskingManager()
        {
            if (_self)
            {
                throw new SingletonError("Direct initialization of singleton is forbidden. Please access TaskingManager using the getInstance method.");
            }
            this._queue = new Vector.<SplittedTask>;
            return;
        }// end function

        public function get running() : Boolean
        {
            return this._running;
        }// end function

        public function get queue() : Vector.<SplittedTask>
        {
            return this._queue;
        }// end function

        public function addTask(param1:SplittedTask) : void
        {
            this._queue.push(param1);
            if (!this._running)
            {
                EnterFrameDispatcher.addEventListener(this.onEnterFrame, "TaskingManager");
                this._running = true;
            }
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_3:* = false;
            var _loc_2:* = this._queue[0] as SplittedTask;
            var _loc_4:* = 0;
            do
            {
                
                _loc_3 = _loc_2.step();
            }while (++_loc_4 < _loc_2.stepsPerFrame() && !_loc_3)
            if (_loc_3)
            {
                this._queue.shift();
                if (this._queue.length == 0)
                {
                    EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
                    this._running = false;
                }
            }
            return;
        }// end function

        public static function getInstance() : TaskingManager
        {
            if (_self == null)
            {
                _self = new TaskingManager;
            }
            return _self;
        }// end function

    }
}

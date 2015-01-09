package com.ankamagames.jerakine.tasking
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
    import flash.events.Event;
    import __AS3__.vec.*;

    public final class TaskingManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TaskingManager));
        private static var _self:TaskingManager;

        private var _running:Boolean;
        private var _queue:Vector.<SplittedTask>;

        public function TaskingManager()
        {
            if (_self)
            {
                throw (new SingletonError("Direct initialization of singleton is forbidden. Please access TaskingManager using the getInstance method."));
            };
            this._queue = new Vector.<SplittedTask>();
        }

        public static function getInstance():TaskingManager
        {
            if (_self == null)
            {
                _self = new (TaskingManager)();
            };
            return (_self);
        }


        public function get running():Boolean
        {
            return (this._running);
        }

        public function get queue():Vector.<SplittedTask>
        {
            return (this._queue);
        }

        public function addTask(task:SplittedTask):void
        {
            this._queue.push(task);
            if (!(this._running))
            {
                EnterFrameDispatcher.addEventListener(this.onEnterFrame, "TaskingManager");
                this._running = true;
            };
        }

        private function onEnterFrame(e:Event):void
        {
            var result:Boolean;
            var task:SplittedTask = (this._queue[0] as SplittedTask);
            var iter:uint;
            do 
            {
                result = task.step();
            } while ((((++iter < task.stepsPerFrame())) && (!(result))));
            if (result)
            {
                this._queue.shift();
                if (this._queue.length == 0)
                {
                    EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
                    this._running = false;
                };
            };
        }


    }
}//package com.ankamagames.jerakine.tasking


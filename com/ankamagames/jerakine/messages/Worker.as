package com.ankamagames.jerakine.messages
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.events.*;
    import flash.utils.*;

    public class Worker extends Object implements MessageHandler
    {
        private var _messagesQueue:Vector.<Message>;
        private var _framesList:Vector.<Frame>;
        private var _processingMessage:Boolean;
        private var _framesToAdd:Vector.<Frame>;
        private var _framesToRemove:Vector.<Frame>;
        private var _paused:Boolean;
        private var _pauseFilter:Class;
        private var _pausedQueue:Vector.<Message>;
        private var _framesBeingDeleted:Dictionary;
        private var _currentFrameTypesCache:Dictionary;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Worker));
        private static const DEBUG_FRAMES:Boolean = true;
        private static const DEBUG_MESSAGES:Boolean = false;
        private static const MAX_MESSAGES_PER_FRAME:uint = 100;
        private static const MAX_TIME_FRAME:uint = 200;

        public function Worker()
        {
            this._framesBeingDeleted = new Dictionary(true);
            return;
        }// end function

        public function get framesList() : Vector.<Frame>
        {
            return this._framesList;
        }// end function

        public function get isPaused() : Boolean
        {
            return this._paused;
        }// end function

        public function process(param1:Message) : Boolean
        {
            this._messagesQueue.push(param1);
            this.run();
            return true;
        }// end function

        public function addFrame(param1:Frame, param2:Boolean = false) : void
        {
            var _loc_3:Boolean = false;
            var _loc_4:Boolean = false;
            var _loc_5:Frame = null;
            var _loc_6:Frame = null;
            if (this._currentFrameTypesCache[param1["constructor"]])
            {
                _loc_3 = false;
                _loc_4 = false;
                if (this._processingMessage)
                {
                    for each (_loc_5 in this._framesToAdd)
                    {
                        
                        if (_loc_5["constructor"] == param1["constructor"])
                        {
                            _loc_4 = true;
                            break;
                        }
                    }
                    if (!_loc_4)
                    {
                        for each (_loc_6 in this._framesToRemove)
                        {
                            
                            if (_loc_6["constructor"] == param1["constructor"])
                            {
                                _loc_3 = true;
                                break;
                            }
                        }
                    }
                }
                if (!_loc_3 || _loc_4)
                {
                    _log.error("Someone asked for the frame " + param1 + " to be " + "added to the worker, but there is already another " + "frame of the same type within it.");
                    if (!param2)
                    {
                        return;
                    }
                }
            }
            if (!param1)
            {
                return;
            }
            if (DEBUG_FRAMES)
            {
                _log.info("Adding frame: " + param1);
            }
            if (this._processingMessage)
            {
                this._framesToAdd.push(param1);
            }
            else
            {
                this.pushFrame(param1);
            }
            return;
        }// end function

        public function removeFrame(param1:Frame) : void
        {
            if (!param1)
            {
                return;
            }
            if (getQualifiedClassName(param1).indexOf("LoadingModuleFrame") != -1)
            {
                trace("ici");
            }
            if (DEBUG_FRAMES)
            {
                _log.info("Removing frame: " + param1);
            }
            if (this._processingMessage)
            {
                this._framesToRemove.push(param1);
            }
            else if (!this.isBeingDeleted(param1))
            {
                this._framesBeingDeleted[param1] = true;
                this.pullFrame(param1);
            }
            return;
        }// end function

        private function isBeingDeleted(param1:Frame) : Boolean
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this._framesBeingDeleted)
            {
                
                if (_loc_2 == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function contains(param1:Class) : Boolean
        {
            return this.getFrame(param1) != null;
        }// end function

        public function getFrame(param1:Class) : Frame
        {
            return this._currentFrameTypesCache[param1];
        }// end function

        public function pause(param1:Class = null) : void
        {
            _log.info("Worker is paused, all queueable messages will be queued.");
            this._paused = true;
            this._pauseFilter = param1;
            return;
        }// end function

        public function resume() : void
        {
            if (!this._paused)
            {
                return;
            }
            _log.info("Worker is resuming, processing all queued messages.");
            this._paused = false;
            this._messagesQueue = this._messagesQueue.concat(this._pausedQueue);
            this._pausedQueue = new Vector.<Message>;
            this.processFramesInAndOut();
            this.processMessages();
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:Frame = null;
            if (DEBUG_FRAMES)
            {
                _log.info("Clearing worker (no more frames or messages in queue)");
            }
            for each (_loc_1 in this._framesList)
            {
                
                _loc_1.pulled();
            }
            this._framesList = new Vector.<Frame>;
            this._framesToAdd = new Vector.<Frame>;
            this._framesToRemove = new Vector.<Frame>;
            this._messagesQueue = new Vector.<Message>;
            this._pausedQueue = new Vector.<Message>;
            this._currentFrameTypesCache = new Dictionary();
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            FpsManager.getInstance().startTracking("DofusFrame", 16549650);
            this.processMessages();
            FpsManager.getInstance().stopTracking("DofusFrame");
            return;
        }// end function

        private function run() : void
        {
            if (EnterFrameDispatcher.hasEventListener(this.onEnterFrame))
            {
                return;
            }
            EnterFrameDispatcher.addEventListener(this.onEnterFrame, "Worker");
            return;
        }// end function

        private function pushFrame(param1:Frame) : void
        {
            if (param1.pushed())
            {
                this._framesList.push(param1);
                this._framesList.sort(PriorityComparer.compare);
                this._currentFrameTypesCache[param1["constructor"]] = param1;
            }
            else
            {
                _log.warn("Frame " + param1 + " refused to be pushed.");
            }
            return;
        }// end function

        private function pullFrame(param1:Frame) : void
        {
            var _loc_2:int = 0;
            if (param1.pulled())
            {
                _loc_2 = this._framesList.indexOf(param1);
                if (_loc_2 > -1)
                {
                    this._framesList.splice(_loc_2, 1);
                    delete this._currentFrameTypesCache[param1["constructor"]];
                    delete this._framesBeingDeleted[param1];
                }
            }
            else
            {
                _log.warn("Frame " + param1 + " refused to be pulled.");
            }
            return;
        }// end function

        private function processMessages() : void
        {
            var _loc_3:Message = null;
            var _loc_1:uint = 0;
            var _loc_2:* = getTimer();
            while (_loc_1 < MAX_MESSAGES_PER_FRAME && this._messagesQueue.length > 0 && getTimer() - _loc_2 < MAX_TIME_FRAME)
            {
                
                _loc_3 = this._messagesQueue.shift();
                if (_loc_3 is CancelableMessage && CancelableMessage(_loc_3).cancel)
                {
                    continue;
                }
                if (this._paused && _loc_3 is QueueableMessage)
                {
                    this._pausedQueue.push(_loc_3);
                    _log.warn("Queued message: " + _loc_3);
                    continue;
                }
                _log.info("Process " + _loc_3);
                this.processMessage(_loc_3);
                this.processFramesInAndOut();
                _loc_1 = _loc_1 + 1;
            }
            if (this._messagesQueue.length == 0)
            {
                EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            }
            return;
        }// end function

        private function processMessage(param1:Message) : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:Frame = null;
            var _loc_4:String = null;
            this._processingMessage = true;
            if (DEBUG_MESSAGES)
            {
                _log.info("Processing message: " + param1);
            }
            if (getQualifiedClassName(param1).indexOf("GameFightEndMessage") != -1)
            {
                _loc_4 = "";
                for each (_loc_3 in this._framesList)
                {
                    
                    _loc_4 = _loc_4 + (_loc_3 + " / " + _loc_3.priority);
                }
                _log.info("Liste des frames : " + _loc_4);
            }
            for each (_loc_3 in this._framesList)
            {
                
                if (_loc_3.process(param1))
                {
                    _log.info(param1 + " eat by " + _loc_3);
                    _loc_2 = true;
                    break;
                }
            }
            this._processingMessage = false;
            if (!_loc_2 && !(param1 is DiscardableMessage))
            {
                _log.warn("Discarded message: " + param1);
            }
            return;
        }// end function

        private function processFramesInAndOut() : void
        {
            var _loc_1:Frame = null;
            var _loc_2:Frame = null;
            if (this._framesToRemove.length > 0)
            {
                for each (_loc_1 in this._framesToRemove)
                {
                    
                    this.pullFrame(_loc_1);
                }
                this._framesToRemove.splice(0, this._framesToRemove.length);
            }
            if (this._framesToAdd.length > 0)
            {
                for each (_loc_2 in this._framesToAdd)
                {
                    
                    this.pushFrame(_loc_2);
                }
                this._framesToAdd.splice(0, this._framesToAdd.length);
            }
            return;
        }// end function

    }
}

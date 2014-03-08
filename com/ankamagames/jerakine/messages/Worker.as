package com.ankamagames.jerakine.messages
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.utils.misc.PriorityComparer;
   import com.ankamagames.jerakine.messages.events.FramePushedEvent;
   import com.ankamagames.jerakine.messages.events.FramePulledEvent;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.pools.Poolable;
   import com.ankamagames.jerakine.pools.GenericPool;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   
   public class Worker extends EventDispatcher implements MessageHandler
   {
      
      public function Worker() {
         this._unstoppableMsgClassList = new Array();
         this._framesBeingDeleted = new Dictionary(true);
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Worker));
      
      private static const DEBUG_FRAMES:Boolean = true;
      
      private static const DEBUG_MESSAGES:Boolean = true;
      
      private static const MAX_MESSAGES_PER_FRAME:uint = 100;
      
      private static const MAX_TIME_FRAME:uint = 40;
      
      private var _messagesQueue:Vector.<Message>;
      
      private var _framesList:Vector.<Frame>;
      
      private var _processingMessage:Boolean;
      
      private var _framesToAdd:Vector.<Frame>;
      
      private var _framesToRemove:Vector.<Frame>;
      
      private var _paused:Boolean;
      
      private var _pauseFilter:Class;
      
      private var _pausedQueue:Vector.<Message>;
      
      private var _unstoppableMsgClassList:Array;
      
      private var _framesBeingDeleted:Dictionary;
      
      private var _currentFrameTypesCache:Dictionary;
      
      public function get framesList() : Vector.<Frame> {
         return this._framesList;
      }
      
      public function get isPaused() : Boolean {
         return this._paused;
      }
      
      public function get pausedQueue() : Vector.<Message> {
         return this._pausedQueue;
      }
      
      public function process(msg:Message) : Boolean {
         this._messagesQueue.push(msg);
         this.run();
         return true;
      }
      
      public function addFrame(frame:Frame, allowDuplicateFrame:Boolean=false) : void {
         var frameRemoving:* = false;
         var frameAdding:* = false;
         var f:Frame = null;
         var f2:Frame = null;
         if(this._currentFrameTypesCache[frame["constructor"]])
         {
            frameRemoving = false;
            frameAdding = false;
            if(this._processingMessage)
            {
               for each (f in this._framesToAdd)
               {
                  if(f["constructor"] == frame["constructor"])
                  {
                     frameAdding = true;
                     break;
                  }
               }
               if(!frameAdding)
               {
                  for each (f2 in this._framesToRemove)
                  {
                     if(f2["constructor"] == frame["constructor"])
                     {
                        frameRemoving = true;
                        break;
                     }
                  }
               }
            }
            if((!frameRemoving) || (frameAdding))
            {
               _log.error("Someone asked for the frame " + frame + " to be " + "added to the worker, but there is already another " + "frame of the same type within it.");
               if(!allowDuplicateFrame)
               {
                  return;
               }
            }
         }
         if(!frame)
         {
            return;
         }
         if(DEBUG_FRAMES)
         {
            _log.info("Adding frame: " + frame);
         }
         if(this._processingMessage)
         {
            this._framesToAdd.push(frame);
         }
         else
         {
            this.pushFrame(frame);
         }
      }
      
      public function removeFrame(frame:Frame) : void {
         if(!frame)
         {
            return;
         }
         if(DEBUG_FRAMES)
         {
            _log.info("Removing frame: " + frame);
         }
         if(this._processingMessage)
         {
            this._framesToRemove.push(frame);
         }
         else
         {
            if(!this.isBeingDeleted(frame))
            {
               this._framesBeingDeleted[frame] = true;
               this.pullFrame(frame);
            }
         }
      }
      
      private function isBeingDeleted(frame:Frame) : Boolean {
         var fr:* = undefined;
         for (fr in this._framesBeingDeleted)
         {
            if(fr == frame)
            {
               return true;
            }
         }
         return false;
      }
      
      public function contains(frameClass:Class) : Boolean {
         return !(this.getFrame(frameClass) == null);
      }
      
      public function getFrame(frameClass:Class) : Frame {
         return this._currentFrameTypesCache[frameClass];
      }
      
      public function pause(targetClass:Class=null, unstoppableMsgClassList:Array=null) : void {
         _log.info("Worker is paused, all queueable messages will be queued : ");
         this._paused = true;
         this._pauseFilter = targetClass;
         if(unstoppableMsgClassList)
         {
            this._unstoppableMsgClassList = this._unstoppableMsgClassList.concat(unstoppableMsgClassList);
         }
      }
      
      public function clearUnstoppableMsgClassList() : void {
         this._unstoppableMsgClassList = [];
      }
      
      private function msgIsUnstoppable(msg:Message) : Boolean {
         var msgClass:Class = null;
         for each (msgClass in this._unstoppableMsgClassList)
         {
            if(msg is msgClass)
            {
               return true;
            }
         }
         return false;
      }
      
      public function resume() : void {
         if(!this._paused)
         {
            return;
         }
         _log.info("Worker is resuming, processing all queued messages.");
         this._paused = false;
         this._messagesQueue = this._messagesQueue.concat(this._pausedQueue);
         this._pausedQueue = new Vector.<Message>();
         this.processFramesInAndOut();
         this.processMessages();
      }
      
      public function clear() : void {
         var frame:Frame = null;
         if(DEBUG_FRAMES)
         {
            _log.info("Clearing worker (no more frames or messages in queue)");
         }
         var nonPulledFrameList:Vector.<Frame> = new Vector.<Frame>();
         for each (frame in this._framesList)
         {
            if(!frame.pulled())
            {
               nonPulledFrameList.push(frame);
            }
         }
         this._framesList = new Vector.<Frame>();
         this._framesToAdd = new Vector.<Frame>();
         this._framesToRemove = new Vector.<Frame>();
         this._messagesQueue = new Vector.<Message>();
         this._pausedQueue = new Vector.<Message>();
         this._currentFrameTypesCache = new Dictionary();
         for each (frame in nonPulledFrameList)
         {
            this.pushFrame(frame);
         }
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         this._paused = false;
      }
      
      private function onEnterFrame(e:Event) : void {
         FpsManager.getInstance().startTracking("DofusFrame",16549650);
         this.processMessages();
         FpsManager.getInstance().stopTracking("DofusFrame");
      }
      
      private function run() : void {
         if(EnterFrameDispatcher.hasEventListener(this.onEnterFrame))
         {
            return;
         }
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,"Worker");
      }
      
      private function pushFrame(frame:Frame) : void {
         if(frame.pushed())
         {
            this._framesList.push(frame);
            this._framesList.sort(PriorityComparer.compare);
            this._currentFrameTypesCache[frame["constructor"]] = frame;
            if(hasEventListener(FramePushedEvent.EVENT_FRAME_PUSHED))
            {
               dispatchEvent(new FramePushedEvent(frame));
            }
         }
         else
         {
            _log.warn("Frame " + frame + " refused to be pushed.");
         }
      }
      
      private function pullFrame(frame:Frame) : void {
         var index:* = 0;
         if(frame.pulled())
         {
            index = this._framesList.indexOf(frame);
            if(index > -1)
            {
               this._framesList.splice(index,1);
               delete this._currentFrameTypesCache[[frame["constructor"]]];
               delete this._framesBeingDeleted[[frame]];
            }
            if(hasEventListener(FramePulledEvent.EVENT_FRAME_PULLED))
            {
               dispatchEvent(new FramePulledEvent(frame));
            }
         }
         else
         {
            _log.warn("Frame " + frame + " refused to be pulled.");
         }
      }
      
      private function processMessages() : void {
         var msg:Message = null;
         var messagesProcessed:uint = 0;
         var startTime:uint = getTimer();
         while((messagesProcessed < MAX_MESSAGES_PER_FRAME) && (this._messagesQueue.length > 0) && (getTimer() - startTime < MAX_TIME_FRAME))
         {
            msg = this._messagesQueue.shift();
            if(!((msg is CancelableMessage) && (CancelableMessage(msg).cancel)))
            {
               if((this._paused) && (msg is QueueableMessage) && (!this.msgIsUnstoppable(msg)))
               {
                  this._pausedQueue.push(msg);
                  _log.warn("Queued message: " + msg);
               }
               else
               {
                  this.processMessage(msg);
                  if(msg is Poolable)
                  {
                     GenericPool.free(msg as Poolable);
                  }
                  this.processFramesInAndOut();
                  messagesProcessed++;
               }
            }
         }
         if(this._messagesQueue.length == 0)
         {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         }
      }
      
      private function processMessage(msg:Message) : void {
         var processed:* = false;
         var frame:Frame = null;
         this._processingMessage = true;
         for each (frame in this._framesList)
         {
            if(frame.process(msg))
            {
               processed = true;
               break;
            }
         }
         this._processingMessage = false;
         if((!processed) && (!(msg is DiscardableMessage)))
         {
            _log.debug("Discarded message: " + msg + " (at frame " + FrameIdManager.frameId + ")");
         }
      }
      
      private function processFramesInAndOut() : void {
         var frameToRemove:Frame = null;
         var frameToAdd:Frame = null;
         if(this._framesToRemove.length > 0)
         {
            for each (frameToRemove in this._framesToRemove)
            {
               this.pullFrame(frameToRemove);
            }
            this._framesToRemove.splice(0,this._framesToRemove.length);
         }
         if(this._framesToAdd.length > 0)
         {
            for each (frameToAdd in this._framesToAdd)
            {
               this.pushFrame(frameToAdd);
            }
            this._framesToAdd.splice(0,this._framesToAdd.length);
         }
      }
   }
}

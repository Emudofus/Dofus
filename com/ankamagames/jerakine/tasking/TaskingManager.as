package com.ankamagames.jerakine.tasking
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public final class TaskingManager extends Object
   {
      
      public function TaskingManager() {
         super();
         if(_self)
         {
            throw new SingletonError("Direct initialization of singleton is forbidden. Please access TaskingManager using the getInstance method.");
         }
         else
         {
            this._queue = new Vector.<SplittedTask>();
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TaskingManager));
      
      private static var _self:TaskingManager;
      
      public static function getInstance() : TaskingManager {
         if(_self == null)
         {
            _self = new TaskingManager();
         }
         return _self;
      }
      
      private var _running:Boolean;
      
      private var _queue:Vector.<SplittedTask>;
      
      public function get running() : Boolean {
         return this._running;
      }
      
      public function get queue() : Vector.<SplittedTask> {
         return this._queue;
      }
      
      public function addTask(param1:SplittedTask) : void {
         this._queue.push(param1);
         if(!this._running)
         {
            EnterFrameDispatcher.addEventListener(this.onEnterFrame,"TaskingManager");
            this._running = true;
         }
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc3_:* = false;
         var _loc2_:SplittedTask = this._queue[0] as SplittedTask;
         var _loc4_:uint = 0;
         do
         {
               _loc3_ = _loc2_.step();
            }while(++_loc4_ < _loc2_.stepsPerFrame() && !_loc3_);
            
            if(_loc3_)
            {
               this._queue.shift();
               if(this._queue.length == 0)
               {
                  EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
                  this._running = false;
               }
            }
         }
      }
   }

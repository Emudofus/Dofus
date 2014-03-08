package com.ankamagames.jerakine.tasking
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.utils.misc.Prioritizable;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import com.ankamagames.jerakine.types.enums.Priority;
   
   public class SplittedTask extends EventDispatcher implements Prioritizable
   {
      
      public function SplittedTask() {
         super();
      }
      
      private var _nPriority:int;
      
      public function step() : Boolean {
         throw new AbstractMethodCallError("step() must be redefined");
      }
      
      public function stepsPerFrame() : uint {
         throw new AbstractMethodCallError("stepsPerFrame() must be redefined");
      }
      
      public function get priority() : int {
         if(isNaN(this._nPriority))
         {
            return Priority.NORMAL;
         }
         return this._nPriority;
      }
      
      public function set priority(p:int) : void {
         this._nPriority = p;
      }
   }
}

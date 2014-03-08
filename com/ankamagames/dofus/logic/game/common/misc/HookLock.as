package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.berilia.types.data.Hook;
   import __AS3__.vec.*;
   
   public class HookLock extends Object implements IHookLock
   {
      
      public function HookLock() {
         super();
         this._hooks = new Vector.<HookLock>();
      }
      
      private var _hooks:Vector.<HookDef>;
      
      public function addHook(hook:Hook, args:Array) : void {
         var hd:HookDef = null;
         var hookDef:HookDef = new HookDef(hook,args);
         for each (hd in this._hooks)
         {
            if(hookDef.isEqual(hd))
            {
               return;
            }
         }
         this._hooks.push(hookDef);
      }
      
      public function release() : void {
         var hd:HookDef = null;
         for each (hd in this._hooks)
         {
            hd.run();
         }
         this._hooks.splice(0,this._hooks.length);
      }
   }
}
import com.ankamagames.berilia.types.data.Hook;
import com.ankamagames.berilia.managers.KernelEventsManager;

class HookDef extends Object
{
   
   function HookDef(hook:Hook, args:Array) {
      super();
      this._hook = hook;
      this._args = args;
   }
   
   private var _hook:Hook;
   
   private var _args:Array;
   
   public function get hook() : Hook {
      return this._hook;
   }
   
   public function get args() : Array {
      return this._args;
   }
   
   public function isEqual(compareTo:HookDef) : Boolean {
      if(this.hook != compareTo.hook)
      {
         return false;
      }
      if(this.args.length != compareTo.args.length)
      {
         return false;
      }
      var i:int = 0;
      while(i < this.args.length)
      {
         if(this.args[i] != compareTo.args[i])
         {
            return false;
         }
         i++;
      }
      return true;
   }
   
   public function run() : void {
      switch(this.args.length)
      {
         case 0:
            KernelEventsManager.getInstance().processCallback(this.hook);
            break;
         case 1:
            KernelEventsManager.getInstance().processCallback(this.hook,this.args[0]);
            break;
         case 2:
            KernelEventsManager.getInstance().processCallback(this.hook,this.args[0],this.args[1]);
            break;
         case 3:
            KernelEventsManager.getInstance().processCallback(this.hook,this.args[0],this.args[1],this.args[2]);
            break;
         case 4:
            KernelEventsManager.getInstance().processCallback(this.hook,this.args[0],this.args[1],this.args[2],this.args[3]);
            break;
         case 5:
            KernelEventsManager.getInstance().processCallback(this.hook,this.args[0],this.args[1],this.args[2],this.args[3],this.args[4]);
            break;
         case 6:
            KernelEventsManager.getInstance().processCallback(this.hook,this.args[0],this.args[1],this.args[2],this.args[3],this.args[4],this.args[5]);
            break;
         case 7:
            KernelEventsManager.getInstance().processCallback(this.hook,this.args[0],this.args[1],this.args[2],this.args[3],this.args[4],this.args[5],this.args[6]);
            break;
         case 8:
            KernelEventsManager.getInstance().processCallback(this.hook,this.args[0],this.args[1],this.args[2],this.args[3],this.args[4],this.args[5],this.args[6],this.args[7]);
            break;
         case 9:
            KernelEventsManager.getInstance().processCallback(this.hook,this.args[0],this.args[1],this.args[2],this.args[3],this.args[4],this.args[5],this.args[6],this.args[7],this.args[8]);
            break;
      }
   }
}

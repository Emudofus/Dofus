package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   class CProcTypemap extends CTypemap
   {
      
      function CProcTypemap(param1:CTypemap, param2:Array, param3:Boolean=false, param4:Boolean=false) {
         super();
         this.retTypemap = param1;
         this.argTypemaps = param2;
         this.varargs = param3;
         this.async = param4;
      }
      
      private var retTypemap:CTypemap;
      
      private var varargs:Boolean;
      
      override public function createC(param1:*, param2:int=0) : Array {
         var id:int = 0;
         var v:* = param1;
         var ptr:int = param2;
         id = regFunc(function():void
         {
            var args:* = undefined;
            var sp:* = undefined;
            var n:* = undefined;
            var tm:* = undefined;
            var aa:* = undefined;
            var ts:* = undefined;
            args = [];
            /*UnknownSlot*/.pop();
            sp = /*UnknownSlot*/.esp;
            n = 0;
            while(n < argTypemaps.length)
            {
               tm = argTypemaps[n];
               aa = [];
               ts = tm.typeSize;
               /*UnknownSlot*/.ds.position = sp;
               sp = sp + ts;
               while(ts)
               {
                  aa.push(/*UnknownSlot*/.ds.readInt());
                  ts = ts - 4;
               }
               args.push(tm.fromC(aa));
               n++;
            }
            if(varargs)
            {
               args.push(sp);
            }
            try
            {
               retTypemap.toReturnRegs(/*UnknownSlot*/,v.apply(null,args));
            }
            catch(e:*)
            {
               /*UnknownSlot*/.eax = 0;
               /*UnknownSlot*/.edx = 0;
               /*UnknownSlot*/.st0 = 0;
               log(2,"v.apply: " + e.toString());
            }
         });
         return [id];
      }
      
      override public function destroyC(param1:Array) : void {
         unregFunc(int(param1[0]));
      }
      
      private var argTypemaps:Array;
      
      override public function fromC(param1:Array) : * {
         var v:Array = param1;
         return function(... rest):*
         {
            var sp:* = undefined;
            var cargs:* = undefined;
            var n:* = undefined;
            var asyncHandler:* = undefined;
            var oldWorker:* = undefined;
            var arg:* = undefined;
            var carg:* = undefined;
            var args:Array = rest;
            var cleanup:Function = function():void
            {
               n = cargs.length-1;
               while(n >= 0)
               {
                  argTypemaps[n].destroyC(cargs[n]);
                  n--;
               }
               CProcTypemap.esp = sp;
               CProcTypemap.gworker = oldWorker;
            };
            sp = /*UnknownSlot*/.esp;
            cargs = [];
            oldWorker = /*UnknownSlot*/.gworker;
            if(async)
            {
               asyncHandler = args.shift();
               /*UnknownSlot*/.gworker = new NotifyMachine(function():Boolean
               {
                  var result:* = undefined;
                  result = retTypemap.fromReturnRegs(/*UnknownSlot*/);
                  cleanup();
                  try
                  {
                     asyncHandler(result);
                  }
                  catch(e:*)
                  {
                     log(1,"asyncHandler: " + e.toString());
                  }
                  return true;
               });
            }
            n = args.length-1;
            while(n >= 0)
            {
               arg = args[n];
               if(n >= argTypemaps.length)
               {
                  push(arg);
               }
               else
               {
                  carg = argTypemaps[n].createC(arg);
                  cargs[n] = carg;
                  push(carg);
               }
               n--;
            }
            /*UnknownSlot*/.push(0);
            if(!asyncHandler)
            {
               try
               {
                  /*UnknownSlot*/.funcs[int(v[0])]();
               }
               catch(e:AlchemyYield)
               {
               }
               catch(e:AlchemyDispatch)
               {
               }
               while(/*UnknownSlot*/.gworker !== oldWorker)
               {
                  try
                  {
                     while(/*UnknownSlot*/.gworker !== oldWorker)
                     {
                        /*UnknownSlot*/.gworker.work();
                     }
                  }
                  catch(e:AlchemyYield)
                  {
                     continue;
                  }
                  catch(e:AlchemyDispatch)
                  {
                     continue;
                  }
               }
               while(true)
               {
                  cleanup();
               }
            }
            else
            {
               try
               {
                  /*UnknownSlot*/.funcs[int(v[0])]();
               }
               catch(e:AlchemyYield)
               {
               }
               catch(e:AlchemyDispatch)
               {
               }
               catch(e:AlchemyBlock)
               {
               }
               catch(e:*)
               {
                  cleanup();
                  throw e;
               }
            }
            if(!asyncHandler)
            {
               return;
            }
         };
      }
      
      private function push(param1:*) : void {
         var _loc2_:* = 0;
         if(param1 is Array)
         {
            _loc2_ = param1.length-1;
            while(_loc2_ >= 0)
            {
               CProcTypemap.push(param1[_loc2_]);
               _loc2_--;
            }
         }
         else
         {
            CProcTypemap.push(param1);
         }
      }
      
      private var async:Boolean;
   }
}

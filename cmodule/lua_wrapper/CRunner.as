package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public class CRunner extends Object implements Debuggee
   {
      
      public function CRunner(param1:Boolean=false) {
         super();
         if(CRunner)
         {
            log(1,"More than one CRunner!");
         }
         var CRunner:* = this;
         this.forceSyncSystem = param1;
      }
      
      public function cancelDebug() : void {
         this.debugger = null;
      }
      
      public function get isRunning() : Boolean {
         return this.suspended <= 0;
      }
      
      var timer:Timer;
      
      public function createArgv(param1:Array) : Array {
         return this.rawAllocStringArray(param1).concat(0);
      }
      
      var forceSyncSystem:Boolean;
      
      public function createEnv(param1:Object) : Array {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         _loc2_ = [];
         for (_loc3_ in param1)
         {
            _loc2_.push(_loc3_ + "=" + param1[_loc3_]);
         }
         return this.rawAllocStringArray(_loc2_).concat(0);
      }
      
      public function startInit() : void {
         var args:Array = null;
         var env:Object = null;
         var argv:Array = null;
         var envp:Array = null;
         var startArgs:Array = null;
         var ap:int = 0;
         log(2,"Static init...");
         modStaticInit();
         args = CRunner.system.getargv();
         env = CRunner.system.getenv();
         argv = this.createArgv(args);
         envp = this.createEnv(env);
         startArgs = [args.length].concat(argv,envp);
         ap = this.rawAllocIntArray(startArgs);
         CRunner.ds.length = CRunner.ds.length + 4095 & ~4095;
         CRunner.push(ap);
         CRunner.push(0);
         log(2,"Starting work...");
         this.timer = new Timer(1);
         this.timer.addEventListener(TimerEvent.TIMER,function(param1:TimerEvent):void
         {
            work();
         });
         try
         {
            CRunner.start();
         }
         catch(e:AlchemyExit)
         {
            CRunner.system.exit(e.rv);
            return;
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
         this.startWork();
      }
      
      private function startWork() : void {
         if(!this.timer.running)
         {
            this.timer.delay = 1;
            this.timer.start();
         }
      }
      
      public function work() : void {
         var startTime:Number = NaN;
         var checkInterval:int = 0;
         var ms:int = 0;
         if(!this.isRunning)
         {
            return;
         }
         try
         {
            startTime = new Date().time;
            do
            {
                  checkInterval = 1000;
                  while(checkInterval > 0)
                  {
                     try
                     {
                        while(checkInterval-- > 0)
                        {
                           CRunner.gworker.work();
                        }
                     }
                     catch(e:AlchemyDispatch)
                     {
                        continue;
                     }
                  }
               }while(new Date().time - startTime < 1000 * 10);
               
               throw new AlchemyYield();
            }
            catch(e:AlchemyExit)
            {
               timer.stop();
               CRunner.system.exit(e.rv);
            }
            catch(e:AlchemyYield)
            {
               ms = e.ms;
               timer.delay = ms > 0?ms:1;
            }
            catch(e:AlchemyBlock)
            {
               timer.delay = 10;
            }
            catch(e:AlchemyBreakpoint)
            {
               throw e;
            }
         }
         
         public function startSystemBridge(param1:String, param2:int) : void {
            log(3,"bridge: " + param1 + " port: " + param2);
            CRunner.system = new CSystemBridge(param1,param2);
            CRunner.system.setup(this.startInit);
         }
         
         var suspended:int = 0;
         
         public function rawAllocString(param1:String) : int {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            _loc2_ = CRunner.ds.length;
            CRunner.ds.length = CRunner.ds.length + (param1.length + 1);
            CRunner.ds.position = _loc2_;
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               CRunner.ds.writeByte(param1.charCodeAt(_loc3_));
               _loc3_++;
            }
            CRunner.ds.writeByte(0);
            return _loc2_;
         }
         
         var debugger:GDBMIDebugger;
         
         public function rawAllocStringArray(param1:Array) : Array {
            var _loc2_:Array = null;
            var _loc3_:* = 0;
            _loc2_ = [];
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_.push(this.rawAllocString(param1[_loc3_]));
               _loc3_++;
            }
            return _loc2_;
         }
         
         public function resume() : void {
            if(!--this.suspended)
            {
               this.startWork();
            }
         }
         
         public function startSystem() : void {
            var request:URLRequest = null;
            var loader:URLLoader = null;
            if(!this.forceSyncSystem)
            {
               request = new URLRequest(".swfbridge");
               loader = new URLLoader();
               loader.dataFormat = URLLoaderDataFormat.TEXT;
               loader.addEventListener(Event.COMPLETE,function(param1:Event):void
               {
                  var _loc2_:XML = null;
                  _loc2_ = new XML(loader.data);
                  if((_loc2_) && (_loc2_.name() == "bridge") && (_loc2_.host) && (_loc2_.port))
                  {
                     startSystemBridge(_loc2_.host,_loc2_.port);
                  }
                  else
                  {
                     startSystemLocal();
                  }
               });
               loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
               {
                  startSystemLocal();
               });
               loader.load(request);
               return;
            }
            this.startSystemLocal(true);
         }
         
         public function rawAllocIntArray(param1:Array) : int {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            _loc2_ = CRunner.ds.length;
            CRunner.ds.length = CRunner.ds.length + (param1.length + 1) * 4;
            CRunner.ds.position = _loc2_;
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               CRunner.ds.writeInt(param1[_loc3_]);
               _loc3_++;
            }
            return _loc2_;
         }
         
         public function startSystemLocal(param1:Boolean=false) : void {
            log(3,"local system");
            CRunner.system = new CSystemLocal(param1);
            CRunner.system.setup(this.startInit);
         }
         
         public function suspend() : void {
            this.suspended++;
            if((this.timer) && (this.timer.running))
            {
               this.timer.stop();
            }
         }
      }
   }

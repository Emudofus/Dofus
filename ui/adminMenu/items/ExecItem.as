package adminMenu.items
{
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   
   public class ExecItem extends BasicItem
   {
      
      public function ExecItem(delay:int = 0, repeat:int = 0) {
         super();
         if(delay > 0)
         {
            if(repeat > 10)
            {
               repeat = 10;
            }
            this._delayTimer = new Timer(delay,repeat);
            this._delayTimer.addEventListener(TimerEvent.TIMER,this.timerCallback);
         }
      }
      
      private var _delayTimer:Timer;
      
      protected var _cmdArg:Array;
      
      override public function get label() : String {
         if((this._delayTimer) && (this._delayTimer.running))
         {
            return super.label + " (stop)";
         }
         return super.label;
      }
      
      override public function getContextMenuItem(replaceParam:Object) : Object {
         return Api.contextMod.createContextMenuItemObject(replace(this.label,replaceParam),this.beginTimerCallback,this.getcallbackArgs(replaceParam),false,null,false,true,help);
      }
      
      public function beginTimerCallback(... args) : void {
         if(this._delayTimer)
         {
            if(this._delayTimer.running)
            {
               this._delayTimer.stop();
            }
            else
            {
               this._cmdArg = args;
               this._delayTimer.reset();
               this._delayTimer.start();
            }
         }
         else
         {
            this.callbackFunction.apply(this,args);
         }
      }
      
      public function timerCallback(e:TimerEvent) : void {
         this.callbackFunction.apply(this,this._cmdArg);
      }
      
      public function get callbackFunction() : Function {
         throw new Error("callbackFunction is abstract function, should be overrided");
      }
      
      public function getcallbackArgs(replaceParam:Object) : Array {
         throw new Error("getcallbackArgs is abstract function, should be overrided");
      }
   }
}

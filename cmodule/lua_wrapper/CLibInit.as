package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public class CLibInit extends Object
   {
      
      public function CLibInit() {
         super();
      }
      
      public function init() : * {
         var runner:CRunner = null;
         var result:* = undefined;
         var saveState:MState = null;
         var regged:Boolean = false;
         runner = new CRunner(true);
         saveState = new MState(null);
         CLibInit.copyTo(saveState);
         try
         {
            runner.startSystem();
            while(true)
            {
               try
               {
                  while(true)
                  {
                     runner.work();
                  }
               }
               catch(e:AlchemyDispatch)
               {
                  continue;
               }
               catch(e:AlchemyYield)
               {
                  continue;
               }
            }
         }
         catch(e:AlchemyLibInit)
         {
            log(3,"Caught AlchemyLibInit " + e.rv);
            regged = true;
            result = CLibInit.AS3ValType.valueTracker.release(e.rv);
         }
         finally
         {
            saveState.copyTo(CLibInit);
            if(!regged)
            {
               log(1,"Lib didn\'t register");
            }
         }
         return result;
      }
      
      public function supplyFile(param1:String, param2:ByteArray) : void {
         CLibInit[param1] = param2;
      }
      
      public function putEnv(param1:String, param2:String) : void {
         CLibInit[param1] = param2;
      }
      
      public function setSprite(param1:Sprite) : void {
         var CLibInit:* = param1;
      }
   }
}

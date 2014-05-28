package com.ankamagames.sweevo.runners
{
   import com.ankamagames.jerakine.script.runners.IRunner;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import org.flintparticles.common.renderers.Renderer;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.script.ScriptErrorEnum;
   
   public class EmitterRunner extends Object implements IRunner
   {
      
      public function EmitterRunner(renderer:Renderer, onRun:Callback = null) {
         super();
         this._renderer = renderer;
         this._onRun = onRun;
      }
      
      protected static const _log:Logger;
      
      private var _renderer:Renderer;
      
      private var _onRun:Callback;
      
      private var _scriptInstance;
      
      public function get renderer() : Renderer {
         return this._renderer;
      }
      
      public function run(script:Class) : uint {
         this._scriptInstance = new script();
         this._scriptInstance["__setRunner__"](this);
         try
         {
            this._scriptInstance.main();
         }
         catch(e:Error)
         {
            _log.error("Error while executing a script :");
            _log.error(e.getStackTrace());
         }
         if(this._onRun)
         {
            this._onRun.exec();
         }
         return ScriptErrorEnum.OK;
      }
   }
}

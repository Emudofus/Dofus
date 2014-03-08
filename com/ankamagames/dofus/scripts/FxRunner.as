package com.ankamagames.dofus.scripts
{
   import com.ankamagames.jerakine.script.runners.IRunner;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.script.ScriptErrorEnum;
   
   public class FxRunner extends Object implements IRunner
   {
      
      public function FxRunner(param1:IEntity, param2:MapPoint) {
         super();
         this._fxCaster = param1;
         this._fxTarget = param2;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FxRunner));
      
      protected var _fxCaster:IEntity;
      
      protected var _fxTarget:MapPoint;
      
      public function get caster() : IEntity {
         return this._fxCaster;
      }
      
      public function get target() : MapPoint {
         return this._fxTarget;
      }
      
      public function run(param1:Class) : uint {
         var script:Class = param1;
         var scriptInstance:* = new script();
         try
         {
            scriptInstance["__setRunner__"](this);
            scriptInstance.main("");
         }
         catch(e:Error)
         {
            if(e.getStackTrace())
            {
               _log.error(e.getStackTrace());
            }
            else
            {
               _log.error("no stack trace available");
            }
            return ScriptErrorEnum.SCRIPT_ERROR;
         }
         return ScriptErrorEnum.OK;
      }
   }
}

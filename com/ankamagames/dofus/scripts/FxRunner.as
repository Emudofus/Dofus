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
      
      public function FxRunner(fxCaster:IEntity, fxTarget:MapPoint) {
         super();
         this._fxCaster = fxCaster;
         this._fxTarget = fxTarget;
      }
      
      protected static const _log:Logger;
      
      protected var _fxCaster:IEntity;
      
      protected var _fxTarget:MapPoint;
      
      public function get caster() : IEntity {
         return this._fxCaster;
      }
      
      public function get target() : MapPoint {
         return this._fxTarget;
      }
      
      public function run(script:Class) : uint {
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

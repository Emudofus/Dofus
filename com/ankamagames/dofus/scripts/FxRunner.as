package com.ankamagames.dofus.scripts
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.script.*;
    import com.ankamagames.jerakine.script.runners.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.utils.*;

    public class FxRunner extends Object implements IRunner
    {
        protected var _fxCaster:IEntity;
        protected var _fxTarget:MapPoint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FxRunner));

        public function FxRunner(param1:IEntity, param2:MapPoint)
        {
            this._fxCaster = param1;
            this._fxTarget = param2;
            return;
        }// end function

        public function get caster() : IEntity
        {
            return this._fxCaster;
        }// end function

        public function get target() : MapPoint
        {
            return this._fxTarget;
        }// end function

        public function run(param1:Class) : uint
        {
            var script:* = param1;
            var scriptInstance:* = new script;
            try
            {
                var _loc_3:* = scriptInstance;
                _loc_3.scriptInstance["__setRunner__"](this);
                scriptInstance.main("");
            }
            catch (e:Error)
            {
                if (e.getStackTrace())
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
        }// end function

    }
}

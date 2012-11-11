package com.ankamagames.sweevo.runners
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.script.*;
    import com.ankamagames.jerakine.script.runners.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;
    import org.flintparticles.common.renderers.*;

    public class EmitterRunner extends Object implements IRunner
    {
        private var _renderer:Renderer;
        private var _onRun:Callback;
        private var _scriptInstance:Object;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EmitterRunner));

        public function EmitterRunner(param1:Renderer, param2:Callback = null)
        {
            this._renderer = param1;
            this._onRun = param2;
            return;
        }// end function

        public function get renderer() : Renderer
        {
            return this._renderer;
        }// end function

        public function run(param1:Class) : uint
        {
            var script:* = param1;
            this._scriptInstance = new script;
            var _loc_3:* = this._scriptInstance;
            _loc_3.this._scriptInstance["__setRunner__"](this);
            try
            {
                this._scriptInstance.main();
            }
            catch (e:Error)
            {
                _log.error("Error while executing a script :");
                _log.error(e.getStackTrace());
            }
            if (this._onRun)
            {
                this._onRun.exec();
            }
            return ScriptErrorEnum.OK;
        }// end function

    }
}

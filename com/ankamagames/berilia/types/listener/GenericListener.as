package com.ankamagames.berilia.types.listener
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import flash.utils.*;

    public class GenericListener extends Object
    {
        private var _sEvent:String;
        private var _oListener:Object;
        private var _fCallback:Function;
        private var _nSortIndex:int;
        private var _nListenerType:uint;
        private var _nListenerContext:WeakReference;
        public static const LISTENER_TYPE_UI:uint = 0;
        public static const LISTENER_TYPE_MODULE:uint = 1;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GenericListener));

        public function GenericListener(param1:String = null, param2 = null, param3:Function = null, param4:int = 0, param5:uint = 1, param6:WeakReference = null)
        {
            if (param1 != null)
            {
                this._sEvent = param1;
            }
            if (param2 != null)
            {
                this.listener = param2;
            }
            if (param3 != null)
            {
                this._fCallback = param3;
            }
            this._nSortIndex = param4;
            this._nListenerType = param5;
            this._nListenerContext = param6;
            return;
        }// end function

        public function get event() : String
        {
            return this._sEvent;
        }// end function

        public function set event(param1:String) : void
        {
            this._sEvent = param1;
            return;
        }// end function

        public function get listener()
        {
            return this._oListener;
        }// end function

        public function set listener(param1) : void
        {
            this._oListener = param1;
            return;
        }// end function

        public function getCallback() : Function
        {
            return this._fCallback;
        }// end function

        public function set callback(param1:Function) : void
        {
            this._fCallback = param1;
            return;
        }// end function

        public function get sortIndex() : int
        {
            return this._nSortIndex;
        }// end function

        public function set sortIndex(param1:int) : void
        {
            this._nSortIndex = param1;
            return;
        }// end function

        public function get listenerType() : uint
        {
            return this._nListenerType;
        }// end function

        public function get listenerContext() : WeakReference
        {
            return this._nListenerContext;
        }// end function

    }
}

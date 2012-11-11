package com.ankamagames.jerakine.resources
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.types.*;

    public class ResourceObserverWrapper extends Object implements IResourceObserver
    {
        private var _onLoadedCallback:Function;
        private var _onFailedCallback:Function;
        private var _onProgressCallback:Function;

        public function ResourceObserverWrapper(param1:Function = null, param2:Function = null, param3:Function = null)
        {
            this._onLoadedCallback = param1;
            this._onFailedCallback = param2;
            this._onProgressCallback = param3;
            return;
        }// end function

        public function onLoaded(param1:Uri, param2:uint, param3) : void
        {
            if (this._onLoadedCallback != null)
            {
                this._onLoadedCallback(param1, param2, param3);
            }
            return;
        }// end function

        public function onFailed(param1:Uri, param2:String, param3:uint) : void
        {
            if (this._onFailedCallback != null)
            {
                this._onFailedCallback(param1, param2, param3);
            }
            return;
        }// end function

        public function onProgress(param1:Uri, param2:uint, param3:uint) : void
        {
            if (this._onProgressCallback != null)
            {
                this._onProgressCallback(param1, param2, param3);
            }
            return;
        }// end function

    }
}

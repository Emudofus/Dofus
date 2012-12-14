package com.ankamagames.atouin.utils
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class GroundMapLoader extends Object
    {
        private var _callBack:Function;
        private var _errorCallBack:Function;
        private var _loader:Loader;
        private var _map:Map;
        private var _groundIsLoaded:Boolean = false;
        private var _time:int = 0;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(GroundMapLoader));

        public function GroundMapLoader(param1:Map, param2:File, param3:Function, param4:Function)
        {
            var fileStream:FileStream;
            var rawJPG:ByteArray;
            var map:* = param1;
            var file:* = param2;
            var callBack:* = param3;
            var errorCallBack:* = param4;
            try
            {
                _log.info("Hop, on décide de charger la map.");
                this._map = map;
                this._callBack = callBack;
                this._errorCallBack = errorCallBack;
                this._loader = new Loader();
                this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onJPGReady);
                this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
                fileStream = new FileStream();
                fileStream.open(file, FileMode.READ);
                rawJPG = new ByteArray();
                fileStream.readInt();
                fileStream.readByte();
                fileStream.readInt();
                fileStream.readBytes(rawJPG);
                fileStream.close();
                this._loader.loadBytes(rawJPG);
                _log.info("Le chargement a commencé. MAJ 3");
            }
            catch (e:Error)
            {
                if (e)
                {
                    _log.fatal(e.getStackTrace());
                }
                onError(null);
            }
            return;
        }// end function

        private function onJPGReady(event:Event) : void
        {
            var bitmap:Bitmap;
            var e:* = event;
            try
            {
                this._groundIsLoaded = true;
                bitmap = this._loader.content as Bitmap;
                if (this._map.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_LOW_QUALITY || this._map.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_MEDIUM_QUALITY)
                {
                    bitmap.width = AtouinConstants.RESOLUTION_HIGH_QUALITY.x;
                    bitmap.height = AtouinConstants.RESOLUTION_HIGH_QUALITY.y;
                }
                this._loader.contentLoaderInfo.removeEventListener(Event.INIT, this.onJPGReady);
                this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
                _log.info("La map vient de finir d\'être chargée.");
                this._callBack(bitmap);
            }
            catch (e:Error)
            {
                if (e)
                {
                    _log.fatal(e.getStackTrace());
                }
                onError(null);
            }
            return;
        }// end function

        private function onError(event:Event) : void
        {
            _log.info("On a pas pu charger la map :/");
            this._errorCallBack(this._map.id);
            this._loader.contentLoaderInfo.removeEventListener(Event.INIT, this.onJPGReady);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            return;
        }// end function

        private function onProgress(event:ProgressEvent) : void
        {
            if (event.bytesLoaded == event.bytesTotal)
            {
                EnterFrameDispatcher.addEventListener(this.check, "GroundMapLoader");
            }
            return;
        }// end function

        private function check(event:Event) : void
        {
            if (this._time > 5)
            {
                if (!this._groundIsLoaded)
                {
                    this._groundIsLoaded = true;
                    this.onError(null);
                }
                EnterFrameDispatcher.removeEventListener(this.check);
            }
            else
            {
                var _loc_2:* = this;
                var _loc_3:* = this._time + 1;
                _loc_2._time = _loc_3;
            }
            return;
        }// end function

        public static function loadGroundMap(param1:Map, param2:File, param3:Function, param4:Function) : void
        {
            new GroundMapLoader(param1, param2, param3, param4);
            return;
        }// end function

    }
}

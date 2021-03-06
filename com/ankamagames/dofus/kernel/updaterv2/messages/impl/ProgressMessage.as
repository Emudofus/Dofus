﻿package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
    import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;

    public class ProgressMessage implements IUpdaterInputMessage 
    {

        private var _step:String;
        private var _progress:Number;
        private var _smooth:Number;
        private var _eta:Number;
        private var _speed:Number;
        private var _currentSize:Number;
        private var _totalSize:Number;


        public function deserialize(data:Object):void
        {
            this._step = data["step"];
            this._progress = data["progress"];
            this._smooth = data["smooth"];
            this._eta = data["eta"];
            this._speed = data["speed"];
            this._currentSize = data["currentSize"];
            this._totalSize = data["totalSize"];
        }

        public function get progress():Number
        {
            return (this._progress);
        }

        public function get smooth():Number
        {
            return (this._smooth);
        }

        public function get eta():Number
        {
            return (this._eta);
        }

        public function get speed():Number
        {
            return (this._speed);
        }

        public function get currentSize():Number
        {
            return (this._currentSize);
        }

        public function get totalSize():Number
        {
            return (this._totalSize);
        }

        public function get step():String
        {
            return (this._step);
        }

        public function toString():String
        {
            return ((((((((((((((("[ProgressMessage step=" + this._step) + " progress=") + this._progress) + ", smooth=") + this._smooth) + ", eta=") + this._eta) + ", speed=") + this._speed) + ", currentSize=") + this._currentSize) + ", totalSize=") + this._totalSize) + "]"));
        }


    }
}//package com.ankamagames.dofus.kernel.updaterv2.messages.impl


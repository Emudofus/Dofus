package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tiphon.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tiphon.events.*;
    import flash.events.*;
    import flash.utils.*;

    public class GraphicLibrary extends EventDispatcher
    {
        private var _swl:Dictionary;
        public var gfxId:uint;
        private var _swlCount:uint = 0;
        private var _isBone:Boolean;
        private var _waitingSwl:Dictionary;

        public function GraphicLibrary(param1:uint, param2:Boolean = false)
        {
            this._swl = new Dictionary();
            this._waitingSwl = new Dictionary();
            this.gfxId = param1;
            this._isBone = param2;
            return;
        }// end function

        public function addSwl(param1:Swl, param2:String) : void
        {
            if (!this._swl[param2])
            {
                var _loc_3:* = this;
                var _loc_4:* = this._swlCount + 1;
                _loc_3._swlCount = _loc_4;
            }
            this._swl[param2] = param1;
            if (this._waitingSwl[param2])
            {
                this._waitingSwl[param2] = false;
                delete this._waitingSwl[param2];
                dispatchEvent(new SwlEvent(SwlEvent.SWL_LOADED, param2));
            }
            return;
        }// end function

        public function updateSwfState(param1:Uri) : void
        {
            if (!this._swl[param1.toString()])
            {
                var _loc_2:* = this;
                var _loc_3:* = this._swlCount + 1;
                _loc_2._swlCount = _loc_3;
            }
            this._swl[param1.toString()] = false;
            return;
        }// end function

        public function hasClass(param1:String) : Boolean
        {
            var _loc_2:* = this._isBone ? (BoneIndexManager.getInstance().getBoneFile(this.gfxId, param1)) : (new Uri(TiphonConstants.SWF_SKIN_PATH + this.gfxId + ".swl"));
            return this._swl[_loc_2.toString()] != null;
        }// end function

        public function hasClassAvaible(param1:String = null) : Boolean
        {
            if (this.isSingleFile)
            {
                return this.getSwl() != null;
            }
            var _loc_2:* = this._isBone ? (BoneIndexManager.getInstance().getBoneFile(this.gfxId, param1)) : (new Uri(TiphonConstants.SWF_SKIN_PATH + this.gfxId + ".swl"));
            return this._swl[_loc_2.toString()] != null && this._swl[_loc_2.toString()] != false;
        }// end function

        public function hasSwl(param1:Uri = null) : Boolean
        {
            if (!param1)
            {
                return this._swlCount != 0;
            }
            return this._swl[param1.toString()] != null;
        }// end function

        public function getSwl(param1:String = null, param2:Boolean = false) : Swl
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            if (param1)
            {
                _loc_4 = this._isBone ? (BoneIndexManager.getInstance().getBoneFile(this.gfxId, param1)) : (new Uri(TiphonConstants.SWF_SKIN_PATH + this.gfxId + ".swl"));
                if (this._swl[_loc_4.toString()] != false)
                {
                    return this._swl[_loc_4.toString()];
                }
                if (param2)
                {
                    this._waitingSwl[_loc_4.toString()] = true;
                    return null;
                }
            }
            for each (_loc_3 in this._swl)
            {
                
                if (_loc_3 != false)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function get isSingleFile() : Boolean
        {
            return !this._isBone || !BoneIndexManager.getInstance().hasCustomBone(this.gfxId);
        }// end function

    }
}

package com.ankamagames.berilia.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SlotDataHolderManager extends Object
    {
        private var _weakHolderReference:Dictionary;
        private var _linkedSlotsData:Vector.<ISlotData>;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SlotDataHolderManager));

        public function SlotDataHolderManager(param1:ISlotData)
        {
            this._weakHolderReference = new Dictionary(true);
            this._linkedSlotsData = new Vector.<ISlotData>;
            this._linkedSlotsData.push(param1);
            return;
        }// end function

        public function setLinkedSlotData(param1:ISlotData) : void
        {
            if (!this._linkedSlotsData)
            {
                this._linkedSlotsData = new Vector.<ISlotData>;
            }
            if (this._linkedSlotsData.indexOf(param1) == -1)
            {
                this._linkedSlotsData.push(param1);
            }
            return;
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            this._weakHolderReference[param1] = true;
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            delete this._weakHolderReference[param1];
            return;
        }// end function

        public function getHolders() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for (_loc_2 in this._weakHolderReference)
            {
                
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

        public function refreshAll() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for (_loc_1 in this._weakHolderReference)
            {
                
                for each (_loc_2 in this._linkedSlotsData)
                {
                    
                    if (_loc_1 && ISlotDataHolder(_loc_1).data === _loc_2)
                    {
                        _loc_1.refresh();
                    }
                }
            }
            return;
        }// end function

    }
}

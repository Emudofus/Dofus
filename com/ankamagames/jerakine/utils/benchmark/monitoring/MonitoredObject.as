package com.ankamagames.jerakine.utils.benchmark.monitoring
{
    import __AS3__.vec.*;
    import flash.utils.*;

    public class MonitoredObject extends Object
    {
        public var name:String;
        public var list:Dictionary;
        public var data:Vector.<Number>;
        public var limits:Vector.<Number>;
        public var color:uint;
        public var selected:Boolean = false;
        private var _extendsClass:List;

        public function MonitoredObject(param1:String, param2:uint, param3:List = null) : void
        {
            this.name = param1;
            this.list = new Dictionary(true);
            this.data = new Vector.<Number>;
            this.limits = new Vector.<Number>;
            this.color = param2;
            this._extendsClass = param3;
            return;
        }// end function

        public function addNewValue(param1:Object) : void
        {
            this.list[param1] = null;
            return;
        }// end function

        public function update() : void
        {
            this.data.push(FpsManagerUtils.countKeys(this.list));
            this.limits.push(FpsManagerUtils.getVectorMaxValue(this.data));
            if (this.data.length > FpsManagerConst.BOX_WIDTH)
            {
                this.data.shift();
                this.limits.shift();
            }
            return;
        }// end function

        public function get extendsClass() : List
        {
            return this._extendsClass;
        }// end function

    }
}

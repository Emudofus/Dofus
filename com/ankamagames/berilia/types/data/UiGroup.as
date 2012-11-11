package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.interfaces.*;

    public class UiGroup extends Object implements IModuleUtil
    {
        private var _name:String;
        private var _exclusive:Boolean;
        private var _permanent:Boolean;
        private var _uisName:Array;

        public function UiGroup(param1:String, param2:Boolean, param3:Boolean, param4:Array = null)
        {
            this._name = param1;
            this._permanent = param3;
            this._exclusive = param2;
            if (param4 != null)
            {
                this._uisName = param4;
            }
            else
            {
                this._uisName = new Array();
            }
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get exclusive() : Boolean
        {
            return this._exclusive;
        }// end function

        public function get permanent() : Boolean
        {
            return this._permanent;
        }// end function

        public function get uis() : Array
        {
            return this._uisName;
        }// end function

    }
}

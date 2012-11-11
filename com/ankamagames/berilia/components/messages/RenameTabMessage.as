package com.ankamagames.berilia.components.messages
{
    import flash.display.*;

    public class RenameTabMessage extends ComponentMessage
    {
        private var _index:int;
        private var _name:String;

        public function RenameTabMessage(param1:InteractiveObject, param2:int, param3:String)
        {
            super(param1);
            this._index = param2;
            this._name = param3;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

    }
}

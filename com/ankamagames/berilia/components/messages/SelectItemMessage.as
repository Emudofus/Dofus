package com.ankamagames.berilia.components.messages
{
    import flash.display.*;

    public class SelectItemMessage extends ComponentMessage
    {
        private var _method:uint;
        private var _isNewSelection:Boolean;

        public function SelectItemMessage(param1:InteractiveObject, param2:uint = 7, param3:Boolean = true)
        {
            super(param1);
            this._method = param2;
            this._isNewSelection = param3;
            return;
        }// end function

        public function get selectMethod() : uint
        {
            return this._method;
        }// end function

        public function get isNewSelection() : Boolean
        {
            return this._isNewSelection;
        }// end function

    }
}

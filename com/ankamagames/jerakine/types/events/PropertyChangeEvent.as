package com.ankamagames.jerakine.types.events
{
    import flash.events.*;

    public class PropertyChangeEvent extends Event
    {
        private var _watchedClassInstance:Object;
        private var _propertyName:String;
        private var _propertyValue:Object;
        private var _propertyOldValue:Object;
        public static var PROPERTY_CHANGED:String = "watchPropertyChanged";

        public function PropertyChangeEvent(param1, param2:String, param3, param4)
        {
            super(PROPERTY_CHANGED, false, false);
            this._watchedClassInstance = param1;
            this._propertyName = param2;
            this._propertyValue = param3;
            this._propertyOldValue = param4;
            return;
        }// end function

        public function get watchedClassInstance()
        {
            return this._watchedClassInstance;
        }// end function

        public function get propertyName() : String
        {
            return this._propertyName;
        }// end function

        public function get propertyValue()
        {
            return this._propertyValue;
        }// end function

        public function get propertyOldValue()
        {
            return this._propertyOldValue;
        }// end function

    }
}

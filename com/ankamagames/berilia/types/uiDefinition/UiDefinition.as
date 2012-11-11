package com.ankamagames.berilia.types.uiDefinition
{
    import flash.utils.*;

    public class UiDefinition extends Object
    {
        public var name:String;
        public var debug:Boolean = false;
        public var graphicTree:Array;
        public var kernelEvents:Array;
        public var shortcutsEvents:Array;
        public var constants:Array;
        public var className:String;
        public var useCache:Boolean = true;
        public var usePropertiesCache:Boolean = true;
        public var modal:Boolean = false;
        public var giveFocus:Boolean = true;
        public var transmitFocus:Boolean = true;
        public var scalable:Boolean = true;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function UiDefinition()
        {
            this.graphicTree = new Array();
            this.kernelEvents = new Array();
            this.shortcutsEvents = new Array();
            this.constants = new Array();
            MEMORY_LOG[this] = 1;
            return;
        }// end function

    }
}

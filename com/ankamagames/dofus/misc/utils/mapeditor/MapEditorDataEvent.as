package com.ankamagames.dofus.misc.utils.mapeditor
{
    import flash.events.*;

    public class MapEditorDataEvent extends Event
    {
        public var data:MapEditorMessage;
        public static const NEW_DATA:String = "MapEditorDataEvent_NEW_DATA";

        public function MapEditorDataEvent(param1:String, param2:MapEditorMessage)
        {
            super(param1, false, false);
            this.data = param2;
            return;
        }// end function

    }
}

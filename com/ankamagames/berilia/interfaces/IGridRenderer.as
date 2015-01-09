package com.ankamagames.berilia.interfaces
{
    import com.ankamagames.berilia.components.Grid;
    import flash.display.DisplayObject;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.UIComponent;

    public interface IGridRenderer 
    {

        function set grid(_arg_1:Grid):void;
        function render(_arg_1:*, _arg_2:uint, _arg_3:Boolean, _arg_4:uint=0):DisplayObject;
        function update(_arg_1:*, _arg_2:uint, _arg_3:DisplayObject, _arg_4:Boolean, _arg_5:uint=0):void;
        function remove(_arg_1:DisplayObject):void;
        function destroy():void;
        function renderModificator(_arg_1:Array):Array;
        function eventModificator(_arg_1:Message, _arg_2:String, _arg_3:Array, _arg_4:UIComponent):String;
        function getDataLength(_arg_1:*, _arg_2:Boolean):uint;

    }
}//package com.ankamagames.berilia.interfaces


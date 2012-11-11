package com.ankamagames.berilia.interfaces
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.display.*;

    public interface IGridRenderer
    {

        public function IGridRenderer();

        function set grid(param1:Grid) : void;

        function render(param1, param2:uint, param3:Boolean, param4:Boolean = true) : DisplayObject;

        function update(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:Boolean = true) : void;

        function remove(param1:DisplayObject) : void;

        function destroy() : void;

        function renderModificator(param1:Array) : Array;

        function eventModificator(param1:Message, param2:String, param3:Array, param4:UIComponent) : String;

    }
}

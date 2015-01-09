package com.ankamagames.dofus.logic.game.common.misc
{
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;

    public interface IInventoryView 
    {

        function initialize(_arg_1:Vector.<ItemWrapper>):void;
        function get name():String;
        function get content():Vector.<ItemWrapper>;
        function addItem(_arg_1:ItemWrapper, _arg_2:int, _arg_3:Boolean=true):void;
        function removeItem(_arg_1:ItemWrapper, _arg_2:int):void;
        function modifyItem(_arg_1:ItemWrapper, _arg_2:ItemWrapper, _arg_3:int):void;
        function isListening(_arg_1:ItemWrapper):Boolean;
        function updateView():void;
        function empty():void;

    }
}//package com.ankamagames.dofus.logic.game.common.misc


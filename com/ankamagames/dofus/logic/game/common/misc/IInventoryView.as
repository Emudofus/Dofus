package com.ankamagames.dofus.logic.game.common.misc
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;

    public interface IInventoryView
    {

        public function IInventoryView();

        function initialize(param1:Vector.<ItemWrapper>) : void;

        function get name() : String;

        function get content() : Vector.<ItemWrapper>;

        function addItem(param1:ItemWrapper, param2:int) : void;

        function removeItem(param1:ItemWrapper, param2:int) : void;

        function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void;

        function isListening(param1:ItemWrapper) : Boolean;

        function updateView() : void;

        function empty() : void;

    }
}
